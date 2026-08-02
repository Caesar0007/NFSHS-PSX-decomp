#!/usr/bin/env python3
"""allocsim.py -- a faithful python replica of gcc-2.8's GLOBAL register
allocator (global.c: allocno_compare + find_reg + the caller-save retry),
driven by the compiler's own -dg (.greg) and -dl (.lreg) RTL dumps.

WHY: every "coloring coin-flip / allocator tie" residual in this project is a
decision made by three ~40-line routines in gcc-2.8/global.c.  Once the model is
validated against a real dump we can ask the INVERSE question: what is the
MINIMAL change to a pseudo's REG_N_REFS / REG_LIVE_LENGTH that flips the handout
to retail's?  That is the "required-delta receipt".

SOURCE OF TRUTH (read, not guessed) -- C:\\Temp\\gcc-2.8.1-src\\extracted\\:
  global.c:594   allocno_compare  pri = (int)((double)(floor_log2(refs)*refs)
                                              / live * 10000 * size)
                                  ties -> lower allocno index (== lower pseudo)
  global.c:899   find_reg         used1 = fixed_reg_set              (calls==0)
                                        | call_used_reg_set          (calls!=0)
                                        | call_fixed_reg_set         (retry)
                                  pass0 also excludes ~regs_used_so_far and
                                  regs_someone_prefers; pass1 drops both.
                                  scan is NUMERIC 0..FIRST_PSEUDO_REGISTER-1
                                  because MIPS defines no REG_ALLOC_ORDER.
  global.c:1075  caller-save retry iff  flag_caller_saves
                                  && allocno_calls_crossed != 0
                                  && CALLER_SAVE_PROFITABLE(refs, calls)
  regs.h:202     CALLER_SAVE_PROFITABLE(REFS,CALLS)  (4*(CALLS) < (REFS))
  config/mips.h:1378/1395  FIXED_REGISTERS / CALL_USED_REGISTERS (below)
  config/mips.h:1371       FIRST_PSEUDO_REGISTER 76

USAGE
  python tools/allocsim.py <tu.greg> <tu.lreg> "<fn signature prefix>"
      [--what-if pseudo:refs=N] [--what-if pseudo:live=N] [--target p=reg,...]
      [--solve p=reg,...]

  --what-if   re-runs the whole allocation with a pseudo's refs/live overridden
  --solve     searches the minimal (+-refs, +-live) delta on each named pseudo
              that makes the listed pseudos land on the listed hard regs
"""
import math
import re
import sys

FIRST_PSEUDO = 76
GP_LAST = 31

# config/mips.h FIXED_REGISTERS / CALL_USED_REGISTERS, GP half (0..31).
FIXED = [1, 1] + [0] * 24 + [1, 1, 1, 1, 0, 1]          # r0,r1,r26..r29,r31
CALL_USED = [1] * 16 + [0] * 8 + [1] * 6 + [0, 1]        # r16..r23,r30 callee-saved

# config/mips.h:1624 REG_CLASS_CONTENTS, as bitmasks over hard regs 0..75.
CLASS_CONTENTS = {
    'NO_REGS':   0,
    'GR_REGS':   (1 << 32) - 1,
    'FP_REGS':   ((1 << 32) - 1) << 32,
    'HI_REG':    1 << 64,
    'LO_REG':    1 << 65,
    'HILO_REG':  1 << 66,
    'MD_REGS':   (1 << 64) | (1 << 65),
    'ST_REGS':   0x7f8 << 64,
    'ALL_REGS':  ((1 << 64) - 1) | (0x7ff << 64),
}

NAME = {0: 'zero', 1: 'at', 2: 'v0', 3: 'v1', 4: 'a0', 5: 'a1', 6: 'a2', 7: 'a3',
        8: 't0', 9: 't1', 10: 't2', 11: 't3', 12: 't4', 13: 't5', 14: 't6',
        15: 't7', 16: 's0', 17: 's1', 18: 's2', 19: 's3', 20: 's4', 21: 's5',
        22: 's6', 23: 's7', 24: 't8', 25: 't9', 26: 'k0', 27: 'k1', 28: 'gp',
        29: 'sp', 30: 'fp', 31: 'ra', 64: 'hi', 65: 'lo', 66: 'hilo'}


def rname(r):
    return NAME.get(r, str(r)) if r is not None else '--'


def floor_log2(n):
    return n.bit_length() - 1 if n > 0 else -1


def priority(refs, live, size):
    """global.c:594 allocno_compare, verbatim (double math then int truncation)."""
    if live == 0:
        live = -1                      # global.c:546
    return int((float(floor_log2(refs) * refs) / live) * 10000 * size)


# --------------------------------------------------------------------------- #
# dump parsing
# --------------------------------------------------------------------------- #
def _section(text, fn):
    for s in re.split(r'\n;; Function ', text):
        if s.startswith(fn):
            return s
    raise SystemExit('function %r not found' % fn)


RE_LREG = re.compile(
    r'^Register (\d+) used (\d+) times across (-?\d+) insns'
    r'(?: in block (\d+))?(.*)$', re.M)


def parse_lreg(path, fn):
    sec = _section(open(path, errors='replace').read(), fn)
    sec = sec.split('\n(note', 1)[0]
    regs = {}
    for m in RE_LREG.finditer(sec):
        p, refs, live, blk, tail = m.groups()
        calls = re.search(r'crosses (\d+) call', tail)
        nbytes = re.search(r'; (\d+) bytes', tail)
        # flow.c dump_flow_info prints either "; C or none" (alternate class
        # NO_REGS) or "; pref C, else A" (a real alternate class).
        c1 = re.search(r'; ([A-Z_0-9]+) or none', tail)
        c2 = re.search(r'; pref ([A-Z_0-9]+), else ([A-Z_0-9]+)', tail)
        b = int(nbytes.group(1)) if nbytes else 4
        regs[int(p)] = dict(
            refs=int(refs), live=int(live),
            calls=int(calls.group(1)) if calls else 0,
            block=int(blk) if blk is not None else -1,
            size=(b + 3) // 4,
            cls=c1.group(1) if c1 else (c2.group(1) if c2 else 'GR_REGS'),
            altcls=c2.group(2) if c2 else 'NO_REGS')
    return regs


# global.c set_preference(): a top-level (set (reg X) (reg Y)) between a pseudo
# and a hard reg is a COPY preference; anything reached through XEXP(src,0) is a
# plain preference.  dump_conflicts prints only the UNION (hard_reg_preferences),
# but find_reg tries hard_reg_copy_preferences FIRST and then `goto no_prefs`.
# So we recover the copy subset straight from the .lreg RTL (still pseudo-form).
RE_COPY = re.compile(r'\(set \(reg([^()]*)\)\s*\(reg([^()]*)\)\)')
RE_REGBODY = re.compile(r'^[/\w]*:\w+ (\d+)')


RE_HARDREG = re.compile(r'\(reg[/\w]*:\w+ (\d+) ')


def parse_ever_live(path, fn):
    """regs_ever_live at global_alloc entry == hard regs that appear EXPLICITLY
    in the RTL (local_alloc does not touch regs_ever_live -- verified: no
    reference to it anywhere in local-alloc.c).  The .lreg RTL prints a hard reg
    as `(reg:SI 4 a0)` (number + name) and a pseudo as `(reg:SI 84)`, so the
    trailing name is the discriminator."""
    sec = _section(open(path, errors='replace').read(), fn)
    return {int(x) for x in RE_HARDREG.findall(sec) if int(x) < FIRST_PSEUDO}


def parse_copy_prefs(path, fn):
    sec = _section(open(path, errors='replace').read(), fn)
    out = {}
    for a, b in RE_COPY.findall(sec):
        ma, mb = RE_REGBODY.match(a.strip()), RE_REGBODY.match(b.strip())
        if not ma or not mb:
            continue
        x, y = int(ma.group(1)), int(mb.group(1))
        if x >= FIRST_PSEUDO and y < FIRST_PSEUDO:
            out.setdefault(x, set()).add(y)
        elif y >= FIRST_PSEUDO and x < FIRST_PSEUDO:
            out.setdefault(y, set()).add(x)
    return out


def parse_greg(path, fn):
    sec = _section(open(path, errors='replace').read(), fn)
    sec = sec.split('\n(note', 1)[0]
    order = [int(x) for x in
             re.search(r'regs to allocate:([\d +()]+)\n', sec).group(1).split()
             if x.isdigit()]
    conflicts, prefs = {}, {}
    for m in re.finditer(r'^;; (\d+) conflicts:([\d ]*)$', sec, re.M):
        p = int(m.group(1))
        nums = [int(x) for x in m.group(2).split()]
        conflicts[p] = dict(
            allocnos={n for n in nums if n >= FIRST_PSEUDO and n != p},
            hard={n for n in nums if n < FIRST_PSEUDO})
    for m in re.finditer(r'^;; (\d+) preferences:([\d ]*)$', sec, re.M):
        prefs[int(m.group(1))] = {int(x) for x in m.group(2).split()}
    disp = {}
    tail = sec[sec.find('Register dispositions'):]
    for m in re.finditer(r'(\d+) in (\d+)', tail):
        disp[int(m.group(1))] = int(m.group(2))
    return order, conflicts, prefs, disp


# --------------------------------------------------------------------------- #
# the model
# --------------------------------------------------------------------------- #
class Sim:
    def __init__(self, lreg, order, conflicts, prefs, disp,
                 copy=None, ever_live=None, flag_caller_saves=True):
        self.L = lreg
        self.copy = copy or {}
        self.order_dump = order
        self.conf = conflicts
        self.prefs = prefs
        self.disp = disp
        self.fcs = flag_caller_saves
        # pseudos allocated by LOCAL alloc == in dispositions but not allocnos
        self.local = {p: r for p, r in disp.items() if p not in set(order)}
        # global.c:428  local_reg_n_refs / local_reg_live_length, then zeroed
        # for any hard reg that is regs_ever_live (global.c:447).  A hard reg
        # that appears in ANY allocno's conflict list was live in the RTL, which
        # is exactly the regs_ever_live proxy we can read off the dump.
        ever_live = set() if ever_live is None else ever_live
        self.lrefs = {}
        self.llive = {}
        for q, r in self.local.items():
            d = lreg.get(q)
            if not d:
                continue
            for j in range(r, r + d['size']):
                self.lrefs[j] = self.lrefs.get(j, 0) + d['refs']
                self.llive[j] = self.llive.get(j, 0) + d['live']
        for j in list(self.lrefs):
            if j in ever_live:
                self.lrefs[j] = 0

    # ---- register sets (bitmask over 0..75) -------------------------------- #
    @staticmethod
    def _mask(pred):
        m = 0
        for r in range(FIRST_PSEUDO):
            if pred(r):
                m |= 1 << r
        return m

    def fixed_set(self):
        return self._mask(lambda r: FIXED[r] if r <= GP_LAST else False)

    def call_used_set(self):
        # config/mips.h CALL_USED_REGISTERS: rows 3-4 (regs 48..75) are all 1
        # except the FP callee-saved block 52..63; HI/LO/HILO (64..66) are 1.
        return self._mask(lambda r: (CALL_USED[r] or FIXED[r]) if r <= GP_LAST
                          else not (52 <= r <= 63))

    def gr_regs(self):
        return self._mask(lambda r: True)          # GP_REG_FIRST..GP_REG_LAST

    def regs_used_so_far_init(self):
        # global.c:352  regs_ever_live[i] || call_used_regs[i]
        m = self.call_used_set()
        for r in self.local.values():
            m |= 1 << r
        return m

    # ---- ordering ---------------------------------------------------------- #
    def priorities(self, override=None):
        out = {}
        for p in self.order_dump:
            d = self.L.get(p, dict(refs=0, live=1, size=1, calls=0))
            refs, live, size = d['refs'], d['live'], d['size']
            if override and p in override:
                refs = override[p].get('refs', refs)
                live = override[p].get('live', live)
            out[p] = (priority(refs, live, size), refs, live, size)
        return out

    def order(self, override=None):
        pri = self.priorities(override)
        # qsort key: descending pri, then ascending allocno index (== pseudo no.)
        return sorted(self.order_dump, key=lambda p: (-pri[p][0], p))

    # ---- find_reg ---------------------------------------------------------- #
    def _find_reg(self, p, hard_conf, used_so_far, losers,
                  accept_call_clobbered, override, alt=False):
        d = self.L.get(p, dict(refs=0, live=1, size=1, calls=0))
        refs = override.get(p, {}).get('refs', d['refs']) if override else d['refs']
        calls = d['calls']
        size = d['size']

        if accept_call_clobbered:
            used1 = self.fixed_set()            # call_fixed_reg_set == fixed on MIPS
        elif calls == 0:
            used1 = self.fixed_set()
        else:
            used1 = self.call_used_set()
        used1 |= losers
        cname = d.get('altcls', 'NO_REGS') if alt else d.get('cls', 'GR_REGS')
        cls = CLASS_CONTENTS.get(cname, CLASS_CONTENTS['GR_REGS'])
        used1 |= ~cls & ((1 << FIRST_PSEUDO) - 1)              # ~reg_class_contents
        used2 = used1
        used1 = used1 | hard_conf.get(p, 0)

        used = used1 | (~used_so_far & ((1 << FIRST_PSEUDO) - 1))
        used |= self.someone_prefers.get(p, 0)

        best = -1
        for ph in (0, 1):
            if ph == 1:
                used = used1
            for regno in range(FIRST_PSEUDO):          # NUMERIC: no REG_ALLOC_ORDER
                if used >> regno & 1:
                    continue
                if size > 1 and regno % 2:             # HARD_REGNO_MODE_OK, DImode
                    continue
                if all(not (used >> j & 1) for j in range(regno + 1, regno + size)):
                    best = regno
                    break
            if best >= 0:
                break

        # global.c:986-1057 -- copy-preference then preference refinement.
        # The .greg dump prints hard_reg_preferences (already pruned); it does
        # NOT print hard_reg_copy_preferences, but both blocks do the same
        # thing on MIPS (every GP reg is GR_REGS so the same-class test is
        # always true), so applying the printed set once is equivalent.
        if best >= 0:
            allp = set(self.prefs.get(p, ()))
            cpy = set(self.copy.get(p, ())) & allp
            for pset in (cpy, allp):            # copy prefs first, then all
                pref = 0
                for r in pset:
                    pref |= 1 << r
                pref &= ~used & ((1 << FIRST_PSEUDO) - 1)
                hit = False
                for regno in range(FIRST_PSEUDO):
                    if not (pref >> regno & 1):
                        continue
                    if size > 1 and regno % 2:
                        continue
                    if all(not (used >> j & 1)
                           for j in range(regno + 1, regno + size)):
                        best, hit = regno, True
                        break
                if hit:                         # global.c `goto no_prefs`
                    break

        if best < 0 and self.fcs and not accept_call_clobbered and calls != 0 \
                and 4 * calls < refs:                  # regs.h:202
            return self._find_reg(p, hard_conf, used_so_far, losers, True,
                                  override, alt)
        return best

    # ---- prune_preferences (global.c:828) ---------------------------------- #
    def _prune(self, order):
        self.someone_prefers = {}
        pos = {p: i for i, p in enumerate(order)}
        pruned = {}
        for p in order:
            bad = 0
            for r in self.conf.get(p, {}).get('hard', set()):
                bad |= 1 << r
            d = self.L.get(p, dict(calls=0))
            bad |= self.fixed_set() if d['calls'] == 0 else self.call_used_set()
            pr = 0
            for r in self.prefs.get(p, ()):
                pr |= 1 << r
            pruned[p] = pr & ~bad
        for p in order:
            m = 0
            for q in order[pos[p] + 1:]:
                if q in self.conf.get(p, {}).get('allocnos', ()) or \
                        p in self.conf.get(q, {}).get('allocnos', ()):
                    t = pruned.get(q, 0)
                    if self.L.get(q, {}).get('size', 1) <= self.L.get(p, {}).get('size', 1):
                        t &= ~pruned.get(p, 0)
                    m |= t
            self.someone_prefers[p] = m

    # ---- the driver (global.c:560) ----------------------------------------- #
    def run(self, override=None):
        order = self.order(override)
        self._prune(order)
        hard_conf = {p: sum(1 << r for r in self.conf.get(p, {}).get('hard', ()))
                     for p in order}
        used_so_far = self.regs_used_so_far_init()
        self.evicted = []
        out = {}
        for p in order:
            d = self.L.get(p, dict(live=1))
            if d['live'] < 0:
                continue                              # REG_LIVE_LENGTH == -2
            best = self._find_reg(p, hard_conf, used_so_far, 0, False, override,
                                  alt=False)
            if best < 0 and d.get('altcls', 'NO_REGS') != 'NO_REGS':
                best = self._find_reg(p, hard_conf, used_so_far, 0, False,
                                      override, alt=True)
            out[p] = best if best >= 0 else None
            if best >= 0:
                for j in range(best, best + d.get('size', 1)):
                    used_so_far |= 1 << j
                    self.lrefs[j] = 0          # global.c:1186
                for q in order:
                    if q in self.conf.get(p, {}).get('allocnos', ()) or \
                            p in self.conf.get(q, {}).get('allocnos', ()):
                        for j in range(best, best + d.get('size', 1)):
                            hard_conf[q] = hard_conf.get(q, 0) | (1 << j)
        return order, out


# --------------------------------------------------------------------------- #
def report(sim, override=None, verbose=True):
    order, got = sim.run(override)
    pri = sim.priorities(override)
    ok = bad = 0
    rows = []
    for i, p in enumerate(order):
        want = sim.disp.get(p)
        have = got.get(p)
        good = (want == have) or (want is None and have is None)
        ok += good
        bad += (not good)
        pr, refs, live, size = pri[p]
        rows.append((i, p, rname(have), rname(want), '' if good else ' <== MISS',
                     refs, live, pr / 10000.0))
    if verbose:
        print(' # pseudo   sim  actual        refs live      pri')
        for i, p, h, w, flag, refs, live, prv in rows:
            print('%2d: p%-5d %-4s (%-4s)%s  refs=%-4d live=%-5d %.4f'
                  % (i, p, h, w, flag, refs, live, prv))
        print('\nMATCH %d/%d  (order-vs-dump: %s)'
              % (ok, ok + bad,
                 'IDENTICAL' if order == sim.order_dump else 'DIFFERS'))
        if order != sim.order_dump:
            print('  sim  order:', ' '.join(map(str, order)))
            print('  dump order:', ' '.join(map(str, sim.order_dump)))
    return ok, bad, order, got


def main():
    greg, lreg, fn = sys.argv[1], sys.argv[2], sys.argv[3]
    args = sys.argv[4:]
    L = parse_lreg(lreg, fn)
    order, conf, prefs, disp = parse_greg(greg, fn)
    sim = Sim(L, order, conf, prefs, disp, parse_copy_prefs(lreg, fn),
              parse_ever_live(lreg, fn))

    override = {}
    targets = {}
    solve = None
    i = 0
    while i < len(args):
        if args[i] == '--what-if':
            spec = args[i + 1]
            p, kv = spec.split(':')
            k, v = kv.split('=')
            override.setdefault(int(p), {})[k] = int(v)
            i += 2
        elif args[i] == '--target':
            for t in args[i + 1].split(','):
                p, r = t.split('=')
                inv = {v: k for k, v in NAME.items()}
                targets[int(p)] = inv.get(r, None) if not r.isdigit() else int(r)
            i += 2
        elif args[i] == '--solve':
            solve = args[i + 1]
            i += 2
        else:
            i += 1

    if solve:
        solve_deltas(sim, solve)
        return
    report(sim, override or None)
    if targets:
        print('\nTARGET check:', {p: rname(r) for p, r in targets.items()})


def solve_deltas(sim, spec):
    """Search the MINIMAL single-pseudo (refs|live) delta that yields the
    requested handout.  spec = 'p1=reg,p2=reg,...' (reg by name or number)."""
    inv = {v: k for k, v in NAME.items()}
    want = {}
    for t in spec.split(','):
        p, r = t.split('=')
        want[int(p)] = int(r) if r.isdigit() else inv[r]
    base_order, base = sim.run()
    print('goal:', {p: rname(r) for p, r in want.items()})
    print('base:', {p: rname(base.get(p)) for p in want})
    hits = []
    cands = sim.order_dump
    for p in cands:
        d = sim.L.get(p)
        if not d:
            continue
        for k, rng in (('refs', range(max(1, d['refs'] - 12), d['refs'] + 25)),
                       ('live', range(max(1, d['live'] - 60), d['live'] + 61))):
            for v in rng:
                if v == d[k]:
                    continue
                o, got = sim.run({p: {k: v}})
                if all(got.get(q) == r for q, r in want.items()):
                    hits.append((abs(v - d[k]), p, k, d[k], v,
                                 {q: rname(got.get(q)) for q in sim.order_dump[:0]}))
                    break                       # smallest |delta| per direction
    hits.sort()
    if not hits:
        print('NO single-pseudo refs/live delta in the searched window reaches it.')
        return
    for dist, p, k, old, new, _ in hits[:25]:
        print('  p%-5d %-4s %4d -> %-4d   (|d|=%d)' % (p, k, old, new, dist))


if __name__ == '__main__':
    main()
