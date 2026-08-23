#!/usr/bin/env python
"""W75-A2 TEXT_MOVES PRE-FLIGHT (catalog 23D-2).

Reads a tools/sbs.py output file and decides STATICALLY whether the residual is
expressible as PER_FN_TEXT_MOVES rows:

  legality test = the two instruction streams must be a LINE MULTISET PERMUTATION
                  (same multiset of normalized text lines) AND no moved line may be
                  a label / .set directive / branch or jump.

Any surviving asymmetry in the multiset is a REGISTER (allocation) difference and
therefore NOT text-movable -> the residual is real scheduling/allocation.

usage: python A2_preflight.py <sbs.txt>
"""
import sys, re
from collections import Counter

path = sys.argv[1]
ours, orac = [], []
for line in open(path, encoding='utf-8', errors='replace'):
    line = line.rstrip('\n')
    if '|' not in line:
        continue
    L, _, R = line.partition('|')
    L = re.sub(r'\s*X\s*$', '', L).strip()
    R = R.strip()
    mL = re.match(r'^(\d+)\s+(\S.*)$', L)
    mR = re.match(r'^(\d+)\s+(\S.*)$', R)
    if mL:
        ours.append(mL.group(2).strip())
    if mR:
        orac.append(mR.group(2).strip())

co, cr = Counter(ours), Counter(orac)
only_ours = co - cr
only_orac = cr - co

print("ours insns   :", len(ours))
print("oracle insns :", len(orac))
print()
print("LINES ONLY IN OURS   (%d):" % sum(only_ours.values()))
for k, v in sorted(only_ours.items()):
    print("   %dx  %s" % (v, k))
print("LINES ONLY IN ORACLE (%d):" % sum(only_orac.values()))
for k, v in sorted(only_orac.items()):
    print("   %dx  %s" % (v, k))
print()

BRANCHY = re.compile(r'^(b[a-z]*\b|j\b|jr\b|jal\b|jalr\b|\.set|\.L|[A-Za-z_.$][\w.$]*:)')
perm = (sum(only_ours.values()) == 0 and sum(only_orac.values()) == 0)
print("MULTISET PERMUTATION :", "YES" if perm else "NO")
if perm:
    moved = [(i, a) for i, (a, b) in enumerate(zip(ours, orac)) if a != b]
    bad = [(i, a) for i, a in moved if BRANCHY.match(a)]
    print("positional mismatches (posmis):", len(moved))
    print("branch/label/.set among moved lines:", len(bad))
    for i, a in bad[:10]:
        print("   !", i, a)
    print("TEXT_MOVES LEGAL     :", "YES" if not bad else "NO (branch/label moves)")
else:
    print("TEXT_MOVES LEGAL     : NO  -- residual contains REGISTER differences,")
    print("                         so it is real allocation/scheduling, not text order.")
