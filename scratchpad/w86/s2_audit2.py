"""S2 audit v2: SYM blocks for exactly the mangled names of one TU, in VA order.

usage: s2_audit2.py <recon.cpp>   ->  writes scratchpad/w86/sym_<stem>.txt
"""
import sys, re, importlib.util
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp")
SYM = r"C:\Temp\nfs4-psx\nfs4-psx-sym.txt"
cpp = sys.argv[1]
stem = Path(cpp).stem

sys.path.insert(0, str(ROOT / 'tools'))
_argv = sys.argv[:]
sys.argv = [sys.argv[0], cpp, '__none__']
_sp = importlib.util.spec_from_file_location('va', ROOT / 'tools' / 'verify_asm.py')
V = importlib.util.module_from_spec(_sp)
try:
    _sp.loader.exec_module(V)
except SystemExit:
    pass
sys.argv = _argv
names = set()
for n in V._name2addr:
    if n and not n.startswith('.'):
        names.add(n)
        if n.startswith('___'):
            names.add('_._' + n[3:])

lines = open(SYM, encoding='latin-1').read().split('\n')
out = []
i = 0
while i < len(lines):
    if lines[i].endswith('8c Function start'):
        j = i + 1; blk = [lines[i]]
        while j < len(lines) and lines[j].startswith('    '):
            blk.append(lines[j]); j += 1
        while j < len(lines):
            if '8c Function start' in lines[j]: break
            blk.append(lines[j])
            if '8e Function end' in lines[j]:
                j += 1; break
            j += 1
        txt = '\n'.join(blk)
        m = re.search(r'name = (.*)', txt)
        fn = m.group(1).strip() if m else ''
        if fn in names:
            va = blk[0].split('$')[1].split()[0]
            recs = []
            for l in blk:
                mm = re.match(r'^[0-9a-f]+: \$([0-9a-f]+) 9[46] Def2? class (\w+) type (.*?)\s+name (\S+)\s*$', l)
                if mm:
                    recs.append((mm.group(2), mm.group(4), mm.group(3), int(mm.group(1), 16)))
            src = re.search(r'file = (.*)', txt).group(1).strip()
            ln = re.search(r'line = (\d+)', txt).group(1)
            body = [f"@{va} {fn}   [{Path(src).name}:{ln}]"]
            for cls, nm, rest, slot in recs:
                body.append(f"    {cls:8} ${slot:<8x} {nm:26} {rest}")
            out.append(('\n'.join(body), int(va, 16)))
        i = j
    else:
        i += 1
out.sort(key=lambda t: t[1])
dst = ROOT / 'scratchpad' / 'w86' / f'sym_{stem}.txt'
dst.write_text('\n\n'.join(b for b, _ in out), encoding='utf-8')
print(f"{dst}: {len(out)} blocks of {len(names)} names")
