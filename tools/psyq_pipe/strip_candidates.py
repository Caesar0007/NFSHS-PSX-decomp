"""strip_candidates.py -- which SDK functions did retail's final link remove?
For every library member named by the retail SYM FILE records that PsyQ 4.3 also has: walk the member's functions in SDK
offset order; a function with a retail label anchors `retail_address - sdk_offset`.  A function WITHOUT a label is
  STRIPPED  when the anchor after it moved down by exactly the sizes of the unlabelled functions in between,
  PRESENT   when the anchor did not move (bytes there, label missing -- e.g. a function that is static in this SDK build),
  UNKNOWN   otherwise (different library version, or at the member's tail with no later anchor)."""
import csv
import re
from collections import defaultdict

SYM = __import__('retail_sym').txt()
IDX = 'C:/Temp/nfs4-clean/psyq43/extracted/INDEX.tsv'
lab, members = {}, []
for l in open(SYM, errors='replace'):
    m = re.search(r'Def class FILE type NULL size 0 name \S*?(\w+)\.lib\((\w+)\.obj\)', l)
    if m:
        k = (m.group(1).upper(), m.group(2).upper())
        if k not in members:
            members.append(k)
        continue
    m = re.match(r'^[0-9a-f]+: \$([0-9a-f]{8}) [26] (\S+)$', l)
    if m:
        lab.setdefault(m.group(2), int(m.group(1), 16))
fns = defaultdict(list)
for r in list(csv.reader(open(IDX), delimiter='\t'))[1:]:
    if r[3] == 'func' and r[5] == '.text':
        fns[(r[0].upper(), r[1].upper())].append((int(r[6]), int(r[7]), r[4]))
tot = defaultdict(int)
for k in members:
    if k not in fns:
        continue
    seq = sorted(fns[k])
    anchors = [(i, lab[n] - off) for i, (off, size, n) in enumerate(seq) if n in lab]
    if not anchors:
        verdicts = [(n, 'WHOLE MEMBER ABSENT (no label of it in retail)') for off, size, n in seq]
    else:
        verdicts = []
        for i, (off, size, n) in enumerate(seq):
            if n in lab:
                continue
            prev = max((a for a in anchors if a[0] < i), default=None)
            nxt = min((a for a in anchors if a[0] > i), default=None)
            if prev and nxt:
                gone = sum(s for j, (o, s, nn) in enumerate(seq) if prev[0] < j < nxt[0] and nn not in lab)
                v = 'STRIPPED' if prev[1] - nxt[1] == gone else 'PRESENT (no label)' if prev[1] == nxt[1] else 'UNKNOWN (anchor moved %d, unlabelled %d)' % (prev[1] - nxt[1], gone)
            elif nxt:
                v = 'STRIPPED' if True and (lab[seq[nxt[0]][2]] - seq[nxt[0]][0]) != 0 and False else 'UNKNOWN (head of member)'
            else:
                v = 'UNKNOWN (tail of member)'
            verdicts.append((n, v))
    if verdicts:
        print('%-8s %-9s %s' % (k[0], k[1], '; '.join('%s=%s' % (n, v.split(' ')[0]) for n, v in verdicts)[:230]))
        for n, v in verdicts:
            tot[v.split(' ')[0]] += 1
print(dict(tot))
