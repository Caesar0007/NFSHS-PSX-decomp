"""var_fn.py recon/x.cpp Mangled__Fn VARIANT.txt [--keep] -- splice VARIANT (a complete function definition text, from the
signature line to its closing `}`) over the existing definition of that function in the real TU, run sldprobe for it
(blocks + tags vs retail), and restore the file unless --keep.  Also reports whether the compiled function bytes moved
(verify_asm)."""
import re
import subprocess
import sys
from pathlib import Path

R = Path(__file__).resolve().parents[2]
src = R / sys.argv[1]; fn = sys.argv[2]; var = Path(sys.argv[3]).read_text()
keep = '--keep' in sys.argv
plain = fn.split('__')[0]
# a member function (`Name__<len>Class...`) must be matched as `Class::Name(` so twins in sibling classes are not confused
mcls = re.match(r'^' + re.escape(plain) + r'__(\d+)', fn)
mq = re.match(r'^' + re.escape(plain) + r'__Q(\d)', fn)
if mq:
    # qualified class: Q<count><len><name><len><name>...
    rest = fn[len(plain) + 3 + len(mq.group(1)):]
    parts = []
    for _ in range(int(mq.group(1))):
        m = re.match(r'(\d+)', rest)
        n = int(m.group(1)); parts.append(rest[len(m.group(1)):len(m.group(1)) + n]); rest = rest[len(m.group(1)) + n:]
    pat = r'::'.join(re.escape(x) for x in parts) + r'::' + re.escape(plain) + r'\s*\('
elif mcls:
    n = int(mcls.group(1)); cls = fn[len(plain) + 2 + len(mcls.group(1)):][:n]
    pat = re.escape(cls) + r'::' + re.escape(plain) + r'\s*\('
else:
    pat = r'\b' + re.escape(plain) + r'\s*\('
raw = src.read_bytes(); crlf = b'\r\n' in raw; t = raw.decode().replace('\r\n', '\n')
lines = t.split('\n')
start = None
for i, l in enumerate(lines):
    if re.search(pat, l) and not l.rstrip().endswith(';') and re.match(r'^[A-Za-z]', l) and not l.startswith(('/', '*')):
        start = i; break
assert start is not None, 'definition not found'
end = start
while not lines[end].startswith('}'):
    end += 1
new = lines[:start] + var.rstrip('\n').split('\n') + lines[end + 1:]
try:
    src.write_bytes(('\n'.join(new).replace('\n', '\r\n') if crlf else '\n'.join(new)).encode())
    r = subprocess.run([sys.executable, str(R / 'tools/verify_asm.py'), sys.argv[1], fn], capture_output=True, text=True)
    print('VERIFY:', [l for l in r.stdout.splitlines() if fn in l][-1:] or r.stdout[-300:])
    r = subprocess.run([sys.executable, str(R / 'tools/psyq_pipe/sldprobe.py'), sys.argv[1], fn], capture_output=True, text=True)
    out = r.stdout.splitlines()
    print('\n'.join(l for l in out if l.startswith(('==', '  blocks', '  tag diffs'))))
finally:
    if not keep:
        src.write_bytes(raw)
