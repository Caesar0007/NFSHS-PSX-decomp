import json
import sys
from collections import Counter


def rows(p):
    rep = json.load(open(p, encoding='utf-8'))
    out = []
    for u in rep.get('units', []):
        for f in u.get('functions', []):
            if f['name'].startswith('.L'):
                continue
            out.append((u['name'].replace('\\', '/'), f['name'],
                        float(f.get('fuzzy_match_percent', 0.0))))
    return out


r1 = rows('scratchpad/w67a5/report_r1.json')
r2 = rows('scratchpad/w67a5/report_r2.json')
print("reproducible:", r1 == r2, "rows:", len(r1))
watch = ('PAD_convert', 'ReadInitPadFlag', 'VoxSentence_GetNumPhrases',
         'iSPCH_GetOffset8', 'iSPCH_GetOffset16', '_bzero_w',
         '___15AIHigh_BTC_Perp')
c = Counter(n for _, n, _ in r1 if n in watch)
for k in watch:
    print(k, c.get(k, 0), [(u, pct) for u, n, pct in r1 if n == k])
