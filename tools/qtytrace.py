#!/usr/bin/env python3
"""qtytrace.py -- read the LOCAL-ALLOC (block-local QTY) decisions straight out of
the instrumented gcc-2.8.1 cc1/cc1plus trace, and do the ref-step boundary math.

WHY THIS EXISTS
  `tools/allocsim.py` replicates global.c (global allocnos).  A pseudo that the
  `.lreg` tags "in block N", or that is absent from `;; N regs to allocate:`, is a
  **local_alloc QTY** -- global.c never sees it.  Per w45 §A0 the qty priority
  function `QTY_CMP_PRI` (local-alloc.c:1727) is the SAME floor_log2 formula as
  `allocno_compare`, so the REF-STEP dial applies -- but the *pool/preference*
  machinery is different (two ordering groups + a per-window availability scan).
  This tool exposes all of it.

SOURCE OF TRUTH (gcc-2.8.1/local-alloc.c, read not guessed)
  1727  QTY_CMP_PRI(q) = (int)((double)(floor_log2(refs)*refs*size)
                               / (qty_death[q]-qty_birth[q]) * 10000)
  1767  qty_sugg_compare  = QTY_CMP_SUGG(q1)-QTY_CMP_SUGG(q2), then QTY_CMP_PRI desc
        QTY_CMP_SUGG(q)  = ncopy_sugg ? ncopy_sugg : nsugg*FIRST_PSEUDO_REGISTER
  1612  GROUP 1: sort by qty_sugg_compare; every qty WITH a suggestion gets
        find_free_reg(..., just_try_suggested=1)
  1661  GROUP 2: re-sort by qty_compare (pure QTY_CMP_PRI, ties -> lower qty no.);
        every still-unassigned qty gets find_free_reg(min_class) then alt_class
  2176  find_free_reg: used = fixed_reg_set (calls==0) | call_used_reg_set (calls!=0)
                            | call_fixed_reg_set (accept_call_clobbered)
                            | regs_live_at[ins] for ins in [born,dead)
                            | ~reg_class_contents[class] | eliminables
        then a NUMERIC 0..75 scan (MIPS defines no REG_ALLOC_ORDER); on success
        post_mark_life() marks the reg busy over that window for LATER qtys.
  2407  caller-save retry iff !accept_call_clobbered && flag_caller_saves
        && !just_try_suggested && calls!=0 && CALLER_SAVE_PROFITABLE(refs,calls)
  1825  combine_regs: a qty's refs/calls are the SUM over every pseudo merged into
        it (a `(set (reg S) (reg U))` where U dies at that insn and S has no qty).

INPUT = a trace from the instrumented cc1 (scratch/gccbuild*/cc1{,plus}.exe):
    GCC_TRACE_ALLOC=1 cc1plus -quiet -O2 -G4 -mgas -msplit-addresses \
        -funsigned-char [-fno-exceptions -fno-rtti] tu.i -o tu.s 2> trace.txt
  ⚠️ VERIFY FIDELITY FIRST (scratch/instr/cmp_cc1.sh): the trace is a RECEIPT only
     for functions the instrumented cc1 reproduces byte-identically vs CC1PSX.

USAGE
  python tools/qtytrace.py trace.txt                    # list traced functions
  python tools/qtytrace.py trace.txt <fn-substring>     # the qty table
  python tools/qtytrace.py trace.txt <fn> --steps       # + ref-step boundary math
  python tools/qtytrace.py trace.txt <fn> --blocked     # + find_free_reg windows
  python tools/qtytrace.py trace.txt <fn> --want q=reg[,q=reg]
        -> the ORDER permutation that handout implies, and per swapped pair the
           minimal refs/live change on either side that crosses the boundary.
"""
import re
import sys

NAME = {0: 'zero', 1: 'at', 2: 'v0', 3: 'v1', 4: 'a0', 5: 'a1', 6: 'a2', 7: 'a3',
        8: 't0', 9: 't1', 10: 't2', 11: 't3', 12: 't4', 13: 't5', 14: 't6',
        15: 't7', 16: 's0', 17: 's1', 18: 's2', 19: 's3', 20: 's4', 21: 's5',
        22: 's6', 23: 's7', 24: 't8', 25: 't9', 26: 'k0', 27: 'k1', 28: 'gp',
        29: 'sp', 30: 'fp', 31: 'ra', 64: 'hi', 65: 'lo', 66: 'hilo'}
INV = {v: k for k, v in NAME.items()}


def rname(r):
    return NAME.get(r, str(r)) if r is not None else '--'


def floor_log2(n):
    return n.bit_length() - 1 if n > 0 else -1


def pri(refs, life, size=1):
    """local-alloc.c:1727 QTY_CMP_PRI, verbatim (double then int truncation)."""
    if life == 0:
        return 0
    return int((float(floor_log2(refs) * refs * size) / life) * 10000)


RE_FN = re.compile(r'^===== FUNCTION (.*) =====$')
RE_ORDER = re.compile(r'^\[(qty_order\s*|qty_sugg_order)\] \(qty/reg1:'
                      r'refs/life/calls/sg/csg=pri\):(.*)$')
RE_ENT = re.compile(r'(\d+)/(-?\d+):(\d+)/(-?\d+)/(\d+)/(\d+)/(\d+)=(-?\d+)')
RE_GOT = re.compile(r'^\[find_free_reg\]\s+qty (\d+) -> reg (\d+)$')
RE_BLK = re.compile(r'^\[find_free_reg\]\s+qty (\d+) reg1 (-?\d+) class (\d+) '
                    r'calls (\d+) acc (\d+) sugg (\d+) win \[(\d+),(\d+)\) blocked:(.*)$')
RE_COMB = re.compile(r'^\[qty_combine\]\s+pseudo (\d+) \(refs (\d+) calls (\d+)\) '
                     r'merged into qty (\d+) of pseudo (\d+) -> qty refs (\d+) calls (\d+)$')


def split_functions(path):
    out, cur, name = {}, [], None
    for line in open(path, errors='replace'):
        line = line.rstrip('\n')
        m = RE_FN.match(line)
        if m:
            if name is not None:
                out.setdefault(name, []).extend(cur)
            name, cur = m.group(1), []
            continue
        cur.append(line)
    if name is not None:
        out.setdefault(name, []).extend(cur)
    return out


def parse_fn(lines):
    """Returns list of blocks; each block = dict(order=[qty rows], sugg=[...],
    got={qty:reg}, blocked=[...], combines=[...])."""
    blocks, cur = [], None
    for line in lines:
        m = RE_ORDER.match(line)
        if m:
            tag = m.group(1).strip()
            rows = [dict(qty=int(a), reg1=int(b), refs=int(c), life=int(d),
                         calls=int(e), sugg=int(f), csugg=int(g), pri=int(h))
                    for a, b, c, d, e, f, g, h in RE_ENT.findall(m.group(2))]
            if tag == 'qty_sugg_order':
                cur = dict(sugg_order=rows, order=[], got={}, blocked=[], comb=[])
                blocks.append(cur)
            else:
                if cur is None:
                    cur = dict(sugg_order=[], order=[], got={}, blocked=[], comb=[])
                    blocks.append(cur)
                cur['order'] = rows
            continue
        if cur is None:
            m = RE_COMB.match(line)
            if m:
                blocks.append(dict(sugg_order=[], order=[], got={}, blocked=[],
                                   comb=[m.groups()]))
                cur = blocks[-1]
            continue
        m = RE_GOT.match(line)
        if m:
            cur['got'][int(m.group(1))] = int(m.group(2))
            continue
        m = RE_BLK.match(line)
        if m:
            cur['blocked'].append(dict(
                qty=int(m.group(1)), reg1=int(m.group(2)), cls=int(m.group(3)),
                calls=int(m.group(4)), acc=int(m.group(5)), sugg=int(m.group(6)),
                born=int(m.group(7)), dead=int(m.group(8)),
                why=m.group(9).strip()))
            continue
        m = RE_COMB.match(line)
        if m:
            cur['comb'].append(m.groups())
    return blocks


def show(blocks, steps=False, blocked=False):
    for bi, b in enumerate(blocks):
        rows = b['order'] or b['sugg_order']
        if not rows:
            continue
        print('\n--- block %d : %d qtys ---' % (bi, len(rows)))
        if b['comb']:
            print('  qty formation (combine_regs merges; a qty\'s refs = SUM):')
            for s, r, c, q, u, R, C in b['comb']:
                print('    pseudo %-5s (refs %-3s calls %s) + qty %-3s (head pseudo %-5s)'
                      '  ->  qty refs %-3s calls %s' % (s, r, c, q, u, R, C))
        print('   #  qty  head-pseudo  reg   refs life calls sugg/csugg     PRI')
        for i, r in enumerate(rows):
            print('  %2d  q%-3d  p%-8s  %-5s %4d %4d %5d   %d/%d      %8.4f'
                  % (i, r['qty'], r['reg1'] if r['reg1'] >= 0 else '?',
                     rname(b['got'].get(r['qty'])), r['refs'], r['life'],
                     r['calls'], r['sugg'], r['csugg'], r['pri'] / 10000.0))
        if steps:
            print('\n   REF-STEP boundary math (pri at refs-1 / refs / refs+1 / 2*refs)')
            print('   -- floor_log2 STEPS at every power of two; one reference can')
            print('      out-rank a neighbour that no live-length dial reaches.')
            for r in rows:
                f = r['refs']
                l = r['life'] or 1
                print('   q%-3d p%-6s refs %-3d life %-4d : %8.4f | %8.4f | %8.4f | %8.4f'
                      % (r['qty'], r['reg1'], f, l,
                         pri(max(1, f - 1), l) / 1e4, pri(f, l) / 1e4,
                         pri(f + 1, l) / 1e4, pri(2 * f, l) / 1e4))
        if blocked:
            print('\n   find_free_reg per-window availability (why a reg was refused)')
            for w in b['blocked']:
                print('   q%-3d p%-6s win [%d,%d) calls %d sugg %d : %s'
                      % (w['qty'], w['reg1'], w['born'], w['dead'], w['calls'],
                         w['sugg'], w['why'] or '(nothing blocked)'))


def want(blocks, spec):
    tgt = {}
    for t in spec.split(','):
        q, r = t.split('=')
        tgt[int(q)] = int(r) if r.isdigit() else INV[r]
    for bi, b in enumerate(blocks):
        rows = b['order']
        if not rows or not (set(tgt) & {r['qty'] for r in rows}):
            continue
        by = {r['qty']: r for r in rows}
        print('\n=== block %d — required-delta analysis ===' % bi)
        # which qty currently holds each wanted register?
        cur = {q: b['got'].get(q) for q in tgt}
        print('  now :', {('q%d' % q): rname(v) for q, v in cur.items()})
        print('  want:', {('q%d' % q): rname(v) for q, v in tgt.items()})
        # a qty gets a LOWER-numbered register by being allocated EARLIER, i.e.
        # by having a HIGHER QTY_CMP_PRI.  Derive the pairwise requirement.
        for q, r in sorted(tgt.items(), key=lambda kv: kv[1]):
            if q not in by:
                print('  q%d not in this block' % q)
                continue
            me = by[q]
            rivals = [x for x in rows
                      if b['got'].get(x['qty']) == r and x['qty'] != q]
            for rv in rivals:
                need = rv['pri'] + 1
                print('\n  q%d (p%s, refs %d life %d, pri %.4f) must OUT-RANK '
                      'q%d (p%s, refs %d life %d, pri %.4f) to take %s'
                      % (q, me['reg1'], me['refs'], me['life'], me['pri'] / 1e4,
                         rv['qty'], rv['reg1'], rv['refs'], rv['life'],
                         rv['pri'] / 1e4, rname(r)))
                # minimal +refs
                for d in range(1, 40):
                    if pri(me['refs'] + d, me['life']) > rv['pri']:
                        print('     refs %d -> %d  (+%d)   gives %.4f'
                              % (me['refs'], me['refs'] + d, d,
                                 pri(me['refs'] + d, me['life']) / 1e4))
                        break
                else:
                    print('     +refs: unreachable within +40')
                # minimal -life
                for l in range(me['life'] - 1, 0, -1):
                    if pri(me['refs'], l) > rv['pri']:
                        print('     life %d -> %d  (-%d)   gives %.4f'
                              % (me['life'], l, me['life'] - l,
                                 pri(me['refs'], l) / 1e4))
                        break
                else:
                    print('     -life: unreachable')
                # rival side: minimal -refs / +life
                for d in range(1, 40):
                    if rv['refs'] - d >= 1 and pri(rv['refs'] - d, rv['life']) < me['pri']:
                        print('     RIVAL q%d refs %d -> %d  (-%d)  gives %.4f'
                              % (rv['qty'], rv['refs'], rv['refs'] - d, d,
                                 pri(rv['refs'] - d, rv['life']) / 1e4))
                        break
                for l in range(rv['life'] + 1, rv['life'] + 400):
                    if pri(rv['refs'], l) < me['pri']:
                        print('     RIVAL q%d life %d -> %d  (+%d)  gives %.4f'
                              % (rv['qty'], rv['life'], l, l - rv['life'],
                                 pri(rv['refs'], l) / 1e4))
                        break
        print('\n  ⚠️ ORDER is necessary but not sufficient: find_free_reg hands out the '
              'lowest reg FREE OVER THAT QTY\'S OWN [born,dead) WINDOW, and each '
              'allocation marks its reg busy for later qtys (post_mark_life).  Re-run '
              'the instrumented cc1 after the source edit to confirm.')


def main():
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    path = sys.argv[1]
    fns = split_functions(path)
    if len(sys.argv) < 3:
        for k in fns:
            print(k)
        return
    key = sys.argv[2]
    hits = [k for k in fns if key in k]
    if not hits:
        raise SystemExit('no traced function matching %r' % key)
    for k in hits:
        print('=' * 78)
        print(k)
        blocks = parse_fn(fns[k])
        if '--want' in sys.argv:
            want(blocks, sys.argv[sys.argv.index('--want') + 1])
        else:
            show(blocks, '--steps' in sys.argv, '--blocked' in sys.argv)


if __name__ == '__main__':
    main()
