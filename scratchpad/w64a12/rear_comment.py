import os
p = 'recon/game/common/aih_opp.cpp'
d = open(p, 'rb').read()
i = d.find(b'    /* NEAR-MISS 54 diffs')
j = d.find(b'==== */', i) + len(b'==== */')
assert i > 0 and j > i

CR = b"\r\n"
new = CR.join([
 b'    /* ==== W64-A12: SEALED, PASS 181/181 (was 50).  THE LEVER WAS THE ABS FORM AT',
 b'       THE *OTHER* SITE.  Retail defers the `mflo` of longDistance*direction PAST the',
 b'       latDistance sign test at BOTH sites (oracle idx 38 / 127), which no scheduler can',
 b'       do while the abs is a real branch: a hand-rolled `if (x<0) x = -x;` splits the',
 b'       region into three basic blocks, so the mult/mflo pair is pinned in the first one.',
 b'       `__builtin_abs` is ONE RTL insn (its bgez/nop/negu is an asm template, invisible to',
 b'       the CFG), so the whole region stays ONE basic block and sched2 places the mflo after',
 b'       it, exactly like retail -- and the two 32-bit range constants then fall into the',
 b'       roadPosition load-delay slots for free.',
 b'       ORDER OF LANDING IS LOAD-BEARING (measured, this basin): the IN-LOOP site (~line 352)',
 b'       first = 50 -> 24; site 1 alone = 60; BOTH at once from the 50-basin = 34.  Only after',
 b'       the in-loop site was landed did site 1 pay: 24 -> PASS.',
 b'       THE W63 FENCE SCAFFOLDING IS RETIRED BY THIS.  The named+opacity-fenced lo1/hi1',
 b'       constants (w63-a12, 54 -> 50) were a WORKAROUND for the constant-hoist that the',
 b'       branchy abs made necessary; with __builtin_abs they are actively harmful --',
 b'       re-measured on the post-site-2 basin: plain literals 24 -> PASS, named+fenced 34,',
 b'       named-unfenced PASS, fence order reversed 30, single fence 34.  Landed form = plain',
 b'       literal constants, zero asm, zero named temps (09L: __builtin_abs is the retail',
 b'       spelling; 04Z: the W59 "__builtin_abs makes it WORSE (58)" receipt was measured in a',
 b'       basin where the other site still had the branchy abs).  W59/W60/W61/W63 near-miss',
 b'       receipts for this fn (constant-hoist family, ~20 falsified spellings) are all',
 b'       superseded and deleted with this seal. ==== */',
])
d2 = d[:i] + new + d[j:]
assert d2.count(0) == 0 and len(d2) > 1000
open(p, 'wb').write(d2)
print('ok', len(d), '->', len(d2))
