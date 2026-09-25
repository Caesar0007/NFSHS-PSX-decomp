"""simplemem_inline.py [--apply] -- replace the in-function `if (0) sprintf((char *)0,"SimpleMem");` carrier with the
file-scope unused inline class-name form (proven byte-neutral in 59 TUs on 2026-09-22/23): removes the two empty debug
scopes the constant-false call leaves in the first function.  Prints the files it touches."""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
APPLY = '--apply' in sys.argv
CAR = re.compile(r'^[ \t]*if \(0\) sprintf\(\(char \*\)0,"SimpleMem"\);[ \t]*(/\*[^\n]*?\*/)?[ \t]*(\n|(?=\S))', re.M)
INL = 'static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }'
touched = []
for p in sorted(ROOT.glob('recon/**/*.cpp')):
    raw = p.read_bytes().decode('utf-8')
    if INL in raw or 'if (0) sprintf((char *)0,"SimpleMem")' not in raw:
        continue
    crlf = '\r\n' in raw
    t = raw.replace('\r\n', '\n')
    m = CAR.search(t)
    if not m or CAR.search(t, m.end()):
        print('SKIP (0 or >1 carriers):', p); continue
    start = m.start()
    # drop a directly preceding comment block that explains the carrier
    pre = t[:start]
    lines = pre.split('\n')
    k = len(lines) - 1          # lines[-1] is '' (start is at a line start)
    j = k - 1
    while j >= 0 and lines[j].strip() == '':
        j -= 1
    if j >= 0 and lines[j].rstrip().endswith('*/'):
        i = j
        while i >= 0 and '/*' not in lines[i]:
            i -= 1
        if i >= 0 and 'SimpleMem' in '\n'.join(lines[i:j + 1]) and lines[i].lstrip().startswith('/*'):
            pre = '\n'.join(lines[:i]) + '\n'
    body = t[m.end():]
    t2 = pre + body
    # collapse a blank line left right after `{`
    t2 = re.sub(r'\{\n\n\n', '{\n\n', t2, count=1)
    # insert the inline after the last leading #include
    # leading include block: the last #include before the first code line
    pos = None
    for mm in re.finditer(r'^[^\n]*\n', t2, re.M):
        line = mm.group(0)
        if line.startswith('#include'):
            pos = mm.end()
        elif re.match(r'[A-Za-z]', line) or line.startswith('#define'):
            break
    if pos is None:
        print('SKIP (no include):', p); continue
    obj = p.stem
    t2 = t2[:pos] + '\n/* Retail %s.obj opens .rodata with this unreferenced class tag. */\n%s\n' % (obj, INL) + t2[pos:]
    touched.append(p.relative_to(ROOT).as_posix())
    if APPLY:
        p.write_bytes((t2.replace('\n', '\r\n') if crlf else t2).encode('utf-8'))
print(('APPLIED' if APPLY else 'DRY RUN'), len(touched), 'files')
print(' '.join(touched))
