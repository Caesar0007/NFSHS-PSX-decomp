"""strip_headtail.py -- settle the UNKNOWN verdicts of strip_candidates.py (unlabelled functions at the HEAD or TAIL of an SDK
member, where there is no anchor on one side) with the honest link map: the text of the recon object that holds the member's
first / last labelled function.  HEAD functions are stripped when that object's text starts exactly at the first labelled
function; TAIL functions are stripped when its text ends exactly at the end of the last labelled one."""
import csv
import re
from collections import defaultdict

R = 'C:/Temp/nfs4-decomp/'
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
secs = []
for m in re.finditer(r'^ \.text\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+\.o)$', open(R + 'build/gen_ld/recon_multdef-ok.map', errors='replace').read(), re.M):
    a, n = int(m.group(1), 16), int(m.group(2), 16)
    if n:
        secs.append((a, a + n, m.group(3)))
fns = defaultdict(list)
for r in list(csv.reader(open(IDX), delimiter='\t'))[1:]:
    if r[3] == 'func' and r[5] == '.text':
        fns[(r[0].upper(), r[1].upper())].append((int(r[6]), int(r[7]), r[4]))
for k in members:
    seq = sorted(fns.get(k, []))
    have = [i for i, (o, s, n) in enumerate(seq) if n in lab]
    if not have or len(have) == len(seq):
        continue
    first, last = have[0], have[-1]
    head = [n for o, s, n in seq[:first]]
    tail = [n for o, s, n in seq[last + 1:]]
    if not head and not tail:
        continue
    fa = lab[seq[first][2]]
    la_end = lab[seq[last][2]] + seq[last][1]
    obj = next(((a, e, o) for a, e, o in secs if a <= fa < e), None)
    if not obj:
        print('%-8s %-9s no recon text holds %s' % (k[0], k[1], seq[first][2])); continue
    out = []
    if head:
        out.append('HEAD %s: %s' % (','.join(head), 'STRIPPED (object text starts at %s)' % seq[first][2] if obj[0] == fa else
                                    'present? object starts %d B before %s (SDK head is %d B)' % (fa - obj[0], seq[first][2], seq[first][0])))
    if tail:
        gap = obj[1] - la_end
        out.append('TAIL %s: %s' % (','.join(tail)[:60], 'STRIPPED (object text ends with %s)' % seq[last][2] if gap in (0, 4) and gap < 8 else
                                    'object has %d B after %s (SDK tail is %d B incl. statics)' % (gap, seq[last][2], sum(s for o, s, n in seq[last + 1:]))))
    print('%-8s %-9s %s' % (k[0], k[1], ' | '.join(out)))
