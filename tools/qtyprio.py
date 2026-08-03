"""w46-a1: LOCAL-ALLOC QTY priority table (the §A0 companion to tools/prio.py).

`tools/prio.py` / `tools/allocsim.py` read the GLOBAL allocno table out of `-dg`.
A function with NO global allocnos (`.greg` jumps straight from the function
header to `;; Register dispositions:` -- e.g. psxfront's FontUpsideDownBlit) has
every pseudo decided by `local-alloc.c` instead, and w45 §A0 established that
gcc-2.8's `QTY_CMP_PRI` is the SAME formula as `allocno_compare`:

    pri = floor_log2(refs) * refs * size / (death - birth)

so the floor_log2 REF-STEP dial applies there too.  This tool prints that table
from the `.lreg` dump's own per-register lines
    `Register N used R times across L insns in block B; ...`
plus the `;; Register N in H.` disposition lines, sorted by priority.

⚠️ PROXY WARNING (from the a10 receipt): `qty_n_refs` / `qty_death-qty_birth` are
NOT printed; for a qty that is 1:1 with a pseudo (the common case) REG_N_REFS /
REG_LIVE_LENGTH are good proxies, but `local-alloc.c combine_regs` merges
copy-related pseudos into ONE qty whose refs are the SUM.  Use the instrumented
cc1's `[qty_compare]` trace when the exact number matters.

Usage:
  python tools/qtyprio.py <tu.i.lreg> "<function signature prefix>"
"""
import re
import sys

NAME = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3',
        't0', 't1', 't2', 't3', 't4', 't5', 't6', 't7',
        's0', 's1', 's2', 's3', 's4', 's5', 's6', 's7',
        't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']


def floor_log2(x):
    n = -1
    while x:
        x >>= 1
        n += 1
    return max(n, 0)


def main():
    text = open(sys.argv[1], encoding='utf-8', errors='replace').read()
    sig = sys.argv[2]
    i = text.index(';; Function ' + sig) if (';; Function ' + sig) in text \
        else text.index(sig)
    j = text.find(';; Function ', i + 10)
    blk = text[i:j if j > 0 else len(text)]

    regs = {}
    for m in re.finditer(r'Register (\d+) used (\d+) times across (\d+) insns'
                         r'(?: in block (\d+))?;([^\n]*)', blk):
        p, r, l, b, rest = m.groups()
        size = 1
        ms = re.search(r'(\d+) bytes', rest or '')
        if ms:                       # `N bytes` = QI/HI mode; gcc's qty_size
            size = 1                 # is in words for the priority formula
        regs[int(p)] = dict(refs=int(r), live=int(l), block=b, size=size,
                            note=(rest or '').strip())
    disp = {}
    for m in re.finditer(r';; Register (\d+) in (\d+)\.', blk):
        disp[int(m.group(1))] = int(m.group(2))

    rows = []
    for p, d in regs.items():
        pri = floor_log2(d['refs']) * d['refs'] * d['size'] / float(d['live'])
        rows.append((pri, p, d))
    rows.sort(reverse=True)

    print('%-3s %-7s %-6s %-5s %-6s %-8s %s' %
          ('#', 'pseudo', 'refs', 'live', 'reg', 'QTY_PRI', 'note'))
    for n, (pri, p, d) in enumerate(rows):
        h = disp.get(p)
        print('%-3d p%-6d %-6d %-5d %-6s %-8.4f %s' %
              (n, p, d['refs'], d['live'],
               (NAME[h] if h is not None and h < 32 else ('--' if h is None
                                                          else str(h))),
               pri, d['note'][:44]))
    print('\n%d quantities (proxy: REG_N_REFS / REG_LIVE_LENGTH; combine_regs '
          'merges copies)' % len(rows))


if __name__ == '__main__':
    main()
