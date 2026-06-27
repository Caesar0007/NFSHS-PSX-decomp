# Query the pattern DB: paste a near-miss's ORACLE asm (or verify_asm '+' lines) on stdin
# -> ranked SEALED functions whose oracle has that shape, with their source (= the idiom that produces it).
# Usage:  echo '<asm lines>' | python tools/pattern_query.py        (or: python tools/pattern_query.py < file.s)
import json, re, sys, math
from pathlib import Path
from collections import Counter
ROOT=Path(__file__).resolve().parent.parent
db=json.loads((ROOT/'tools'/'pattern_db.json').read_text())
records=db['records']; index=db['index']

def norm(t):
    t=re.sub(r'\s+',' ',t.strip()).replace('$','');t=re.sub(r',\s+',',',t)
    t=re.sub(r'0x([0-9a-fA-F]+)',lambda m:str(int(m.group(1),16)),t)
    m=re.match(r'^break\b(.*)$',t)
    if m:
        ops=[o for o in re.split(r'[ ,]+',m.group(1).strip()) if o and o!='0']
        t='break'+((' '+','.join(ops)) if ops else '')
    t=re.sub(r'\((\d+) ?>> ?(\d+)\)',lambda m:str(int(m.group(1))>>int(m.group(2))),t)  # eval (N>>M) — parity w/ verify_asm (else `lui r,(65536 >> 16)` != `lui r,1` = phantom diff)
    t=re.sub(r'\((\d+) ?& ?(\d+)\)',lambda m:str(int(m.group(1))&int(m.group(2))),t)     # eval (N&M)
    t=re.sub(r'%hi\([^)]*\)','0',t);t=re.sub(r'%lo\([^)]*\)','0',t);t=re.sub(r'%gp_rel\([^)]*\)','0',t)
    t=re.sub(r'^move (\w+),(\w+)$',r'addu \1,\2,zero',t)
    t=re.sub(r'^(?:addiu|ori) (\w+),zero,(\-?\d+)$',r'li \1,\2',t)
    m=re.match(r'(beq|bne)\s+(\w+,\w+),',t)
    if m:return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),',t)
    if m:return f"{m.group(1)} {m.group(2)},T"
    m=re.match(r'(j|jal|b)\s+',t)
    if m:return f"{m.group(1)} T"
    return t
SPECIAL={'zero','at','sp','ra','gp','fp','k0','k1','hi','lo'}
def canon(insns):
    regmap={}
    def repl(m):
        r=m.group(1)
        if r in SPECIAL: return r
        if r not in regmap: regmap[r]=f'R{len(regmap)}'
        return regmap[r]
    return [re.sub(r'\b(zero|at|v[01]|a[0-3]|t\d|s[0-7]|k[01]|gp|sp|fp|ra|hi|lo)\b', repl, ins) for ins in insns]

qn=[]
for l in sys.stdin.read().splitlines():
    l=re.sub(r'/\*.*?\*/','',l)
    l=re.sub(r'^\s*[0-9a-f]{6,8}:\s+[0-9a-f]{8}\s+','',l)   # objdump addr+word prefix
    l=re.sub(r'^\s*[+\-]\s*','',l)                          # verify_asm diff +/- prefix
    s=l.strip()
    if not s or s.endswith(':') or s.startswith(('.','glabel','/*','endlabel','nonmatching')): continue
    qn.append(norm(s))
if not qn: sys.exit("no asm lines parsed from stdin")
DF_CAP=max(40,len(records)//20)      # skip shapes in >5% of records (structural boilerplate, no discriminating power)
hits=Counter(); shapes={}
for n in (5,4,3,2):
    for i in range(len(qn)-n+1):
        key=' | '.join(canon(qn[i:i+n]))
        df=len(index.get(key,()))
        if not df or df>DF_CAP: continue
        wt=(n*n)/math.log2(1+df)     # IDF: rare + long shapes dominate; ubiquitous 2-grams ~0
        for rid in index[key]:
            hits[rid]+=wt; shapes.setdefault(rid,set()).add(key)
print(f"query: {len(qn)} insns -> {qn}\n")
if not hits: sys.exit("no discriminating sealed shapes found (only generic/ubiquitous shapes, if any).")
for rid,score in hits.most_common(6):
    r=records[rid]
    best=sorted(shapes[rid], key=lambda k:-k.count('|'))[:2]
    print(f"=== {r['func']}  [{r['file']}]  score={score:.1f}  ({r['n']} insns) ===")
    for b in best: print(f"   shape: {b}")
    if r['src']:
        body=[ln for ln in r['src'].splitlines()]
        # show signature + first ~22 body lines
        print('\n'.join('   '+ln for ln in body[:24]))
    else:
        print("   (no source marker found)")
    print()
