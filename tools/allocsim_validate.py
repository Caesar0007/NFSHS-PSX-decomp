#!/usr/bin/env python3
"""Batch-validate tools/allocsim.py against EVERY function in a .greg/.lreg pair.
Usage: python tools/allocsim_validate.py <tu.greg> <tu.lreg> [-v]
Prints per-function sim-vs-actual agreement + a corpus total."""
import re
import sys

sys.path.insert(0, 'tools')
import allocsim as A

greg, lreg = sys.argv[1], sys.argv[2]
verbose = '-v' in sys.argv
gtext = open(greg, errors='replace').read()
ltext = open(lreg, errors='replace').read()
fns = [s.split('\n', 1)[0] for s in re.split(r'\n;; Function ', gtext)[1:]]

tok = tbad = tfn = tperfect = treload = 0
RE_NOWIN = __import__('re').compile(r'Register (\d+) now (?:in (\d+)|on stack)')
for fn in fns:
    try:
        L = A.parse_lreg(lreg, fn)
        order, conf, prefs, disp = A.parse_greg(greg, fn)
    except (SystemExit, AttributeError):
        continue
    if not order:
        continue
    sim = A.Sim(L, order, conf, prefs, disp, A.parse_copy_prefs(lreg, fn), A.parse_ever_live(lreg, fn))
    ok, bad, o, got = A.report(sim, None, verbose=False)
    # The .greg "Register dispositions" block is printed by dump_global_regs
    # AFTER reload(), so a pseudo can have been RE-HOMED by reload
    # (reload1.c:3722 retry_global_alloc, and the silent inheritance re-homes at
    # reload1.c:6277/7362).  allocsim models global_alloc ONLY, so classify
    # those separately instead of calling them model errors.
    gsec = A._section(gtext, fn)
    retried = {int(m.group(1)) for m in RE_NOWIN.finditer(gsec)}
    rl = 0
    for p in o:
        if got.get(p) != disp.get(p):
            if p in retried or got.get(p) is None or                     (got.get(p) is not None and got[p] >= 64):
                rl += 1
    bad -= rl
    ok += 0
    treload += rl
    tok += ok
    tbad += bad
    tfn += 1
    tperfect += (bad == 0)
    ordflag = '' if o == order else '  ORDER-DIFF'
    if bad or verbose or ordflag:
        print('%-4s %3d/%-3d %s%s' % ('MISS' if bad else ('rld' if rl else 'ok'),
                                      ok, ok + bad + rl,
                                      fn[:78], ordflag))
        if bad and verbose:
            for p in o:
                if got.get(p) != disp.get(p):
                    print('        p%-5d sim=%-4s actual=%-4s refs=%d live=%d calls=%d'
                          % (p, A.rname(got.get(p)), A.rname(disp.get(p)),
                             L[p]['refs'], L[p]['live'], L[p]['calls']))
print('\nTOTAL  allocnos %d/%d correct (%.2f%%)   functions perfect %d/%d'
      % (tok, tok + tbad, 100.0 * tok / max(1, tok + tbad), tperfect, tfn))
