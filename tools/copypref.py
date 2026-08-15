#!/usr/bin/env python3
"""copypref.py -- THE 12A COPY-PREFERENCE / AVAILABILITY INSTRUMENT (w64-a10).

WHAT IT ANSWERS (the 06E gap, local-alloc half)
  "pseudo P landed in hard reg H.  WHY, and what would it take to land in H'?"
  for the layer allocsim/reqdelta do NOT model: gcc-2.8's **local-alloc**
  (block-local QTYs, their copy/arith SUGGESTIONS, and the per-window
  AVAILABILITY scan in find_free_reg).

SOURCE OF TRUTH -- gcc-2.8.1/local-alloc.c, read not guessed
  470-478  ELIGIBILITY: a pseudo is local-alloc'd iff
             REG_BASIC_BLOCK(i) >= 0  &&  REG_N_DEATHS(i) == 1
           (and its alternate class is NO_REGS or its preferred class is not
           likely-spilled -- always true for GR_REGS on MIPS).
           => the .lreg header line prints BOTH facts: "in block N" and
              "dies in D places".  A pseudo missing "in block N", or carrying
              "dies in 2 places", is a GLOBAL allocno: local-alloc never sees
              it and NO copy suggestion is ever recorded for it.
  753-800  optimize_reg_copy_1: for `(set (reg D) (reg S))` where S does NOT
           die in that insn, scan forward inside the block; if S dies later,
           REPLACE every use of S up to there with D and MOVE S's death note
           back onto the copy.  On MIPS SMALL_REGISTER_CLASSES is 0, so this
           fires even when D is a HARD register -- that is how a hoisted
           arg-copy swallows a following store ("sw a3" instead of "sw v1").
  1444     block_alloc ties operand 0 with an input operand;
           may_save_copy = (the insn is a plain reg->reg move) or the operand
           is constrained to match operand 0.
  1876-1940 combine_regs: pseudo x hard reg does NOT tie -- it records the hard
           reg in qty_phys_copy_sugg[qty] (may_save_copy) else qty_phys_sugg[].
           It BAILS FIRST if reg_qty[pseudo] < 0 (i.e. not local-alloc eligible)
           -> no suggestion at all.
  1612-1626 GROUP 1 (the suggested pass): every qty WITH a suggestion is served
           first, ordered by qty_sugg_compare, via find_free_reg(...,
           just_try_suggested=1) -- which restricts the candidate set to the
           copy-suggested regs (else the arith-suggested ones).
  1640-1690 GROUP 2: the remaining qtys, ordered by QTY_CMP_PRI descending
           (ties -> lower qty number), get a plain ascending 0..75 scan.
  2176-2300 find_free_reg: used = fixed_reg_set (calls==0) | call_used_reg_set
           (calls!=0) | UNION regs_live_at[ins] for ins in [birth, death)
           | ~class | eliminables{$0,RAP,$fp}.  MIPS defines no REG_ALLOC_ORDER
           => plain ASCENDING numeric scan.  On success post_mark_life() marks
           the register busy over that window for every LATER qty.
  2130     qty_death = 2*insn_number (+1 if the reg is an unused output);
  2077     qty_birth = 2*insn_number (-1 for a CLOBBER).
           regs_live_at[2*n] == regs_live_at[2*n+1] == hard regs live AFTER
           insn n, so the window covers "live after insn birth .. insn death-1".

INPUT: the REAL compiler's own `-dl` dump (CC1PLPSX / CC1PSX both print it).
       It carries everything needed: the per-pseudo header (refs / live length /
       block / deaths / calls), `;; Start of basic block N.` + `;; Registers
       live:` (= basic_block_live_at_start, the liveness SEED), the full RTL,
       and `;; Register N in H.` = local-alloc's actual handout (the oracle we
       validate against).

USAGE
  python copypref.py <dumpfile.lreg> --list
  python copypref.py <dumpfile.lreg> <fn-substring>            # qty table
  python copypref.py <dumpfile.lreg> <fn-substring> --why P    # one pseudo
  python copypref.py <dumpfile.lreg> <fn-substring> --want P=reg
  python copypref.py <dumpfile.lreg> --validate                # whole TU
"""
import re
import sys

FIRST_PSEUDO = 76
NAME = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2',
        't3', 't4', 't5', 't6', 't7', 's0', 's1', 's2', 's3', 's4', 's5',
        's6', 's7', 't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']
NUM = {n: i for i, n in enumerate(NAME)}
FIXED = set([0, 1, 26, 27, 28, 29, 31, 75])
CALL_USED = set(range(0, 16)) | {24, 25, 26, 27, 28, 29, 31} | set(range(32, 52)) \
    | set(range(64, 76))
# ELIMINABLE_REGS from-registers: $0 (arg ptr), the return-address pointer
# (regno 76-1 fake), and $fp.
ELIMINABLE = {0, 30, 74, 75}
GR_REGS = set(range(0, 32))


def rname(r):
    return NAME[r] if r < 32 else ("p%d" % r if r >= FIRST_PSEUDO else "h%d" % r)


# ---------------------------------------------------------------- RTL parsing
TOKEN = re.compile(r'\(|\)|\[|\]|"(?:[^"\\]|\\.)*"|[^\s()\[\]]+')


def sexp(text, pos=0):
    """Parse one s-expression; returns (node, newpos).  Node = list | str."""
    toks = TOKEN.finditer(text, pos)
    stack = []
    cur = None
    for m in toks:
        t = m.group(0)
        if t in '([':
            new = []
            if cur is not None:
                cur.append(new)
                stack.append(cur)
            cur = new
        elif t in ')]':
            if not stack:
                return cur, m.end()
            cur = stack.pop()
        else:
            if cur is None:
                return t, m.end()
            cur.append(t)
    return cur, len(text)


def head(node):
    return node[0] if isinstance(node, list) and node and isinstance(node[0], str) else None


def regno_of(node):
    """(reg[/x]:MODE N [name]) -> N ; (subreg (reg..) k) -> N ; else None."""
    if not isinstance(node, list) or not node:
        return None
    h = head(node)
    if h and h.split(':')[0].split('/')[0] == 'reg':
        try:
            return int(node[1])
        except (ValueError, IndexError):
            return None
    if h and h.split(':')[0].split('/')[0] == 'subreg':
        return regno_of(node[1])
    return None


def find_regs(node, out):
    if isinstance(node, list):
        r = regno_of(node)
        if r is not None:
            out.append(r)
            return
        for c in node:
            find_regs(c, out)


def kids(node):
    """Real sub-rtxes of a PARALLEL.  The dump writes `(parallel[ A B ] )`, so
    the tokenizer nests the vector in an anonymous bracket group -- unwrap it."""
    out = []
    for c in node[1:]:
        if isinstance(c, list) and head(c) is None:
            out.extend(c)
        else:
            out.append(c)
    return out


def stores_of(pat, out):
    """note_stores: collect (regno, is_clobber) for every SET/CLOBBER dest."""
    if not isinstance(pat, list) or not pat:
        return
    h = head(pat)
    if h is None:
        return
    base = h.split(':')[0].split('/')[0]
    if base == 'set':
        d = pat[1]
        while isinstance(d, list) and head(d) and \
                head(d).split(':')[0].split('/')[0] in ('strict_low_part', 'zero_extract',
                                                        'sign_extract', 'subreg'):
            if head(d).split(':')[0].split('/')[0] == 'subreg':
                break
            d = d[1]
        r = regno_of(d)
        if r is not None:
            out.append((r, False))
    elif base == 'clobber':
        r = regno_of(pat[1])
        if r is not None:
            out.append((r, True))
    elif base in ('parallel', 'sequence'):
        for c in kids(pat):
            stores_of(c, out)


# --------------------------------------------------------------- dump reading
INSN_RE = re.compile(r'^\((insn|jump_insn|call_insn|note|code_label|barrier)\b')


class Insn(object):
    __slots__ = ('kind', 'uid', 'node', 'text', 'dead', 'unused', 'stores',
                 'setdest', 'setsrc', 'number', 'block')

    def __repr__(self):
        return "<%s %s>" % (self.kind, self.uid)


def parse_function(sec):
    """sec = text of one ';; Function ...' section of a .lreg dump."""
    fn = {'name': sec.splitlines()[0].strip(), 'regs': {}, 'handout': {},
          'blocks': [], 'insns': []}
    for m in re.finditer(r"Register (\d+) used (\d+) times across (\d+) insns"
                         r"([^\n]*)", sec):
        n, refs, live, rest = int(m.group(1)), int(m.group(2)), int(m.group(3)), m.group(4)
        blk = re.search(r"in block (\d+)", rest)
        dth = re.search(r"dies in (\d+) places", rest)
        cal = re.search(r"crosses (\d+) call", rest)
        fn['regs'][n] = {'refs': refs, 'live': live,
                         'block': int(blk.group(1)) if blk else None,
                         'deaths': int(dth.group(1)) if dth else 1,
                         'calls': int(cal.group(1)) if cal else 0,
                         'cls': rest}
    for m in re.finditer(r";; Register (\d+) in (-?\d+)\.", sec):
        fn['handout'][int(m.group(1))] = int(m.group(2))

    # -- RTL: split on top-level records
    body = sec
    i = body.find('\n(note')
    if i < 0:
        i = body.find('\n(insn')
    if i < 0:
        return fn
    pos = i
    cur_block = None
    lines = body[pos:].split('\n')
    buf = []
    recs = []
    for ln in lines:
        if ln.startswith(';; Start of basic block'):
            recs.append(('\n'.join(buf), cur_block))
            buf = []
            cur_block = int(re.search(r'block (\d+)', ln).group(1))
            fn['blocks'].append({'n': cur_block, 'live_in': set(), 'insns': []})
            continue
        if ln.startswith(';; Registers live:'):
            for rm in re.finditer(r'(\d+) \[', ln):
                fn['blocks'][-1]['live_in'].add(int(rm.group(1)))
            continue
        if ln.startswith(';; End of basic block'):
            continue
        if INSN_RE.match(ln):
            recs.append(('\n'.join(buf), cur_block))
            buf = [ln]
        else:
            buf.append(ln)
    recs.append(('\n'.join(buf), cur_block))

    for text, blk in recs:
        text = text.strip()
        if not INSN_RE.match(text):
            continue
        node, _ = sexp(text)
        ins = Insn()
        ins.kind = node[0]
        ins.uid = int(node[1]) if node[1].lstrip('-').isdigit() else -1
        ins.node = node
        ins.text = text
        ins.block = blk
        ins.dead, ins.unused, ins.stores = [], [], []
        ins.setdest = ins.setsrc = None
        if ins.kind in ('insn', 'jump_insn', 'call_insn'):
            pat = node[4]
            stores_of(pat, ins.stores)
            # block_alloc's tying uses recog_operand[0], i.e. the FIRST SET of a
            # PARALLEL too (mulsi3_internal = one SET + two scratch CLOBBERs).
            main = None
            b = head(pat).split(':')[0].split('/')[0] if head(pat) else None
            if b == 'set':
                main = pat
            elif b in ('parallel', 'sequence'):
                for c in kids(pat):
                    hb = head(c).split(':')[0].split('/')[0] if head(c) else None
                    if hb == 'set':
                        main = c
                        break
            if main is not None:
                ins.setdest, ins.setsrc = main[1], main[2]
            for dm in re.finditer(r'expr_list:REG_(DEAD|UNUSED)', text):
                pass
            # notes: walk the tail expr_list chain textually (robust enough)
            for m2 in re.finditer(r'\(expr_list:REG_(DEAD|UNUSED)\s+\(reg[^ ]*\s+(\d+)', text):
                (ins.dead if m2.group(1) == 'DEAD' else ins.unused).append(int(m2.group(2)))
        fn['insns'].append(ins)
        for b in fn['blocks']:
            if b['n'] == blk:
                b['insns'].append(ins)
                break
    return fn


def split_dump(path):
    txt = open(path, errors='replace').read()
    out = []
    for p in re.split(r"\n;; Function ", txt):
        if p.strip():
            out.append(p)
    return out[1:] if len(out) > 1 else out


# -------------------------------------------------------- local-alloc replica
class Qty(object):
    def __init__(self, q, regno, birth, info):
        self.q = q
        self.regs = [regno]
        self.birth = birth
        self.death = -1
        self.refs = info['refs']
        self.calls = info['calls']
        self.copy_sugg = set()
        self.sugg = set()
        self.reg = -1
        self.size = 1
        self.used0 = None      # find_free_reg's `used` AT THIS QTY'S TURN
        self.det0 = {}

    def pri(self):
        import math
        span = self.death - self.birth
        if span <= 0:
            return 0
        fl = 0
        n = self.refs
        while n > 1:
            n >>= 1
            fl += 1
        return int((float(fl * self.refs * self.size) / span) * 10000)

    def cmp_sugg(self):
        return len(self.copy_sugg) if self.copy_sugg else len(self.sugg) * FIRST_PSEUDO


ARITH = set('plus minus mult div udiv mod umod and ior xor not neg abs '
            'ashift ashiftrt lshiftrt rotate rotatert sign_extend zero_extend '
            'truncate compare ne eq lt gt le ge ltu gtu leu geu '
            'if_then_else'.split())


def operand_candidates(ins):
    """The (regno, may_save_copy) pairs block_alloc would hand combine_regs,
    in operand order.  Only REG/SUBREG operands qualify (see the comment at
    the call site)."""
    if ins.setdest is None or regno_of(ins.setdest) is None:
        return []
    src = ins.setsrc
    out = []
    r = regno_of(src)
    if r is not None:
        return [(r, True)]                       # plain move: may_save_copy=1
    h = head(src)
    base = h.split(':')[0].split('/')[0] if h else None
    if base == 'mem':
        return out            # 'm' constraint: the operand is the MEM itself
    if isinstance(src, list):
        for sub in src[1:]:
            rr = regno_of(sub)
            if rr is not None:
                out.append((rr, False))
    return out


def alloc_block(fn, blk, trace=None):
    """Replicate block_alloc for one basic block.  Returns (qtys, reg_qty,
    regs_live_at)."""
    eligible = {}
    for r, i in fn['regs'].items():
        eligible[r] = (i['block'] is not None and i['deaths'] == 1)
    reg_qty = {}          # pseudo -> qty index (or -1 ignore)
    qtys = []
    regs_live = set(blk['live_in'])
    live_at = {}
    n = 0

    def alloc_qty(regno, birth):
        q = Qty(len(qtys), regno, birth, fn['regs'].get(regno,
                {'refs': 1, 'calls': 0}))
        qtys.append(q)
        reg_qty[regno] = q.q
        return q

    for ins in blk['insns']:
        if ins.kind != 'note':
            n += 1
        combined = None
        if ins.kind in ('insn', 'jump_insn', 'call_insn'):
            # ---- combine_regs (block_alloc:1390-1450).  The operand loop only
            # ever hands combine_regs an operand that IS a REG/SUBREG (or, for a
            # 'p'-constrained address operand, a register inside it -- MIPS
            # load/store operand 1 is 'm', not 'p', so a MEM source yields NO
            # candidate: that is why `(set (reg P) (mem (plus (reg B) k)))` does
            # not tie P to B).
            r0 = regno_of(ins.setdest) if ins.setdest is not None else None
            for r1, may_copy in operand_candidates(ins):
                if r0 is None or r1 is None or r0 == r1:
                    continue
                ureg, sreg = r1, r0
                # combine_regs:1866 -- bail if the USED reg has no qty
                if ureg >= FIRST_PSEUDO and ureg not in reg_qty:
                    continue
                if sreg >= FIRST_PSEUDO and not eligible.get(sreg, False):
                    continue
                if ureg < FIRST_PSEUDO and sreg < FIRST_PSEUDO:
                    continue
                if ureg < FIRST_PSEUDO:              # hard reg feeds a pseudo
                    if sreg not in reg_qty:
                        alloc_qty(sreg, 2 * n)
                    q = qtys[reg_qty[sreg]]
                    (q.copy_sugg if may_copy else q.sugg).add(ureg)
                    continue                          # returns 0: keep looking
                if sreg < FIRST_PSEUDO:              # pseudo feeds a hard reg
                    q = qtys[reg_qty[ureg]]
                    (q.copy_sugg if may_copy else q.sugg).add(sreg)
                    continue
                if sreg in reg_qty or ureg not in ins.dead:
                    continue                          # already has a qty / lives on
                q = qtys[reg_qty[ureg]]               # TIE the two pseudos
                q.regs.append(sreg)
                q.refs += fn['regs'].get(sreg, {'refs': 0})['refs']
                q.calls += fn['regs'].get(sreg, {'calls': 0})['calls']
                reg_qty[sreg] = q.q
                q.death = -1
                combined = ureg
                break
            # ---- deaths
            for r in ins.dead:
                if r == combined:
                    continue
                if r < FIRST_PSEUDO:
                    regs_live.discard(r)
                elif r in reg_qty:
                    qtys[reg_qty[r]].death = 2 * n
            # ---- births
            for r, is_clobber in ins.stores:
                if r < FIRST_PSEUDO:
                    regs_live.add(r)
                else:
                    if eligible.get(r, False) and r not in reg_qty:
                        alloc_qty(r, 2 * n - (1 if is_clobber else 0))
                    if r in reg_qty:
                        qtys[reg_qty[r]].death = -1
            for r in ins.unused:
                if r < FIRST_PSEUDO:
                    regs_live.discard(r)
                elif r in reg_qty:
                    qtys[reg_qty[r]].death = 2 * n + 1
        live_at[2 * n] = set(regs_live)
        live_at[2 * n + 1] = set(regs_live)
    return qtys, reg_qty, live_at


def blocked_by(q, live_at, extra_marks):
    used = set(FIXED) if q.calls == 0 else set(CALL_USED)
    used |= ELIMINABLE
    used |= (set(range(0, 76)) - GR_REGS)
    detail = {}
    for ins in range(q.birth, q.death):
        for r in live_at.get(ins, ()):
            detail.setdefault(r, []).append(ins)
    for r in detail:
        used.add(r)
    for r, wins in extra_marks.items():
        for (a, b) in wins:
            if not (b <= q.birth or a >= q.death):
                used.add(r)
                detail.setdefault(r, []).append(-1)
    return used, detail


def run_alloc(fn, blk, verbose=False):
    qtys, reg_qty, live_at = alloc_block(fn, blk)
    marks = {}

    def take(q, cand):
        for r in sorted(cand):
            q.reg = r
            marks.setdefault(r, []).append((q.birth, q.death))
            return r
        return -1

    order = sorted([q for q in qtys if (q.copy_sugg or q.sugg)],
                   key=lambda q: (q.cmp_sugg(), -q.pri(), q.q))
    for q in order:
        if q.death < 0:
            continue
        used, det = blocked_by(q, live_at, marks)
        q.used0, q.det0 = set(used), det
        sugg = q.copy_sugg if q.copy_sugg else q.sugg
        cand = [r for r in sorted(sugg) if r not in used]
        if cand:
            take(q, cand)
        elif q.copy_sugg and q.sugg:
            cand = [r for r in sorted(q.sugg) if r not in used]
            if cand:
                take(q, cand)
    order2 = sorted([q for q in qtys if q.reg < 0],
                    key=lambda q: (-q.pri(), q.q))
    for q in order2:
        if q.death < 0:
            continue
        used, det = blocked_by(q, live_at, marks)
        q.used0, q.det0 = set(used), det
        cand = [r for r in range(0, 76) if r not in used]
        if cand:
            take(q, cand[:1])
    return qtys, reg_qty, live_at, marks


# ------------------------------------------------------------------ reporting
def report(fn, want=None, why=None, minrefs=0):
    print("== %s" % fn['name'])
    hand = fn['handout']
    for blk in fn['blocks']:
        qtys, reg_qty, live_at, marks = run_alloc(fn, blk)
        rows = []
        for q in qtys:
            for r in q.regs:
                pred, act = q.reg, hand.get(r, -1)
                rows.append((r, q, pred, act))
        if not rows:
            continue
        show = [t for t in rows if (why is None or t[0] == why)]
        if why is not None and not show:
            continue
        print("-- block %d  (live-in: %s)" % (
            blk['n'], " ".join(rname(r) for r in sorted(blk['live_in']))))
        for r, q, pred, act in show:
            if fn['regs'].get(r, {}).get('refs', 0) < minrefs and why is None:
                continue
            ok = "  " if pred == act else "!!"
            print("  %s p%-4d q%-3d refs=%-3d birth=%-4d death=%-4d pri=%-7d "
                  "copy_sugg=%-12s sugg=%-10s pred=%-4s actual=%-4s"
                  % (ok, r, q.q, q.refs, q.birth, q.death, q.pri(),
                     ",".join(rname(x) for x in sorted(q.copy_sugg)) or "-",
                     ",".join(rname(x) for x in sorted(q.sugg)) or "-",
                     rname(pred) if pred >= 0 else "SPILL",
                     rname(act) if act >= 0 else "global"))
            if why == r:
                used = q.used0 if q.used0 is not None else blocked_by(q, live_at, marks)[0]
                detail = q.det0 if q.used0 is not None else {}
                print("     window [%d,%d) covers 'live after' insn %d..%d"
                      % (q.birth, q.death, q.birth // 2, (q.death - 1) // 2))
                print("     BLOCKED: %s" % " ".join(
                    "%s@%s" % (rname(x), ",".join(str(i // 2) for i in sorted(set(detail[x]))[:4]))
                    for x in sorted(detail) if x < 32))
                free = [x for x in range(0, 32) if x not in used]
                print("     FREE   : %s" % " ".join(rname(x) for x in free))
                if want is not None:
                    tgt = NUM.get(want, None)
                    info = fn['regs'].get(r, {})
                    print("     --- REQUIREMENT to land p%d in %s ---" % (r, want))
                    if tgt is None:
                        print("     (unknown register name)")
                    elif q.copy_sugg or q.sugg:
                        sug = q.copy_sugg or q.sugg
                        if tgt in sug:
                            blk = sorted(x for x in sug if x < tgt and x not in used)
                            print("     %s IS suggested; the ascending scan takes "
                                  "the lowest FREE suggested reg -- block %s"
                                  % (want, " ".join(rname(x) for x in blk) or "(nothing: it should already win)"))
                        else:
                            print("     %s is NOT in the suggestion set %s." % (
                                want, ",".join(rname(x) for x in sorted(sug))))
                            print("     Kill the suggestion (then the ascending"
                                  " scan applies) by EITHER")
                            print("       (a) making p%d ineligible for local-alloc:"
                                  " REG_BASIC_BLOCK<0 (live across a block"
                                  " boundary) or REG_N_DEATHS>1 (dies on two"
                                  " paths).  Today: block=%s deaths=%d."
                                  % (r, info.get('block'), info.get('deaths', 1)))
                            print("       (b) occupying %s over [%d,%d) -- only a"
                                  " HARD reg counts here; a value held by a"
                                  " PSEUDO is invisible to local-alloc."
                                  % (",".join(rname(x) for x in sorted(sug)),
                                     q.birth, q.death))
                    else:
                        need = [rname(x) for x in range(0, tgt)
                                if x not in used and x in GR_REGS]
                        print("     no suggestion -> plain ascending scan; %s wins"
                              " only if ALL of {%s} are unavailable over [%d,%d)."
                              % (want, " ".join(need) or "-", q.birth, q.death))
                        print("     REMINDER: local-alloc's availability scan sees"
                              " HARD regs only.  A register that a PSEUDO will"
                              " occupy after global-alloc/reload does NOT block"
                              " it here, so no ref/live/priority dial can reach"
                              " those -- only a hard-reg clobber can.")
        # pseudos NOT eligible (global) -- report the reason
        if why is not None:
            info = fn['regs'].get(why)
            if info and (info['block'] is None or info['deaths'] != 1):
                print("  p%d is a GLOBAL allocno (block=%s deaths=%d) -- "
                      "local-alloc never sees it, no suggestion is recorded"
                      % (why, info['block'], info['deaths']))


def validate(secs, minrefs=0):
    tot = ok = 0
    bad = []
    for sec in secs:
        fn = parse_function(sec)
        if not fn['insns']:
            continue
        for blk in fn['blocks']:
            qtys, reg_qty, live_at, marks = run_alloc(fn, blk)
            for q in qtys:
                for r in q.regs:
                    act = fn['handout'].get(r, -1)
                    if act < 0:
                        continue
                    tot += 1
                    if q.reg == act:
                        ok += 1
                    else:
                        bad.append((fn['name'][:44], r, rname(q.reg) if q.reg >= 0 else 'X',
                                    rname(act)))
    print("validate: %d/%d = %.1f%%" % (ok, tot, 100.0 * ok / max(tot, 1)))
    for b in bad[:40]:
        print("   MISS %-46s p%-4d pred=%-4s actual=%s" % b)
    return ok, tot


if __name__ == '__main__':
    path = sys.argv[1]
    secs = split_dump(path)
    args = sys.argv[2:]
    if '--validate' in args:
        validate(secs)
        sys.exit()
    if not args or args[0] == '--list':
        for s in secs:
            print(s.splitlines()[0][:110])
        sys.exit()
    pat = args[0]
    why = None
    want = None
    if '--why' in args:
        why = int(args[args.index('--why') + 1])
    if '--want' in args:
        want = args[args.index('--want') + 1]
    for s in secs:
        if pat in s.splitlines()[0]:
            report(parse_function(s), want=want, why=why, minrefs=0)
