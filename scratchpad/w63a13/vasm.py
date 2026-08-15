"""vasm.py <probe-module> <variant> [lo] [hi] -- emit the cc1 .s region for the probe's
FN under one variant (the text TEXT_MOVES sees), then restore the source."""
import sys, os, re, subprocess, importlib.util, tempfile
ROOT = r'C:/Temp/nfs4-decomp'
sys.path.insert(0, ROOT + '/tools')
CPP = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-cpp.exe'
CC1PL = r'C:/Temp/psq43/COMPILER/CC1PLPSX.EXE'

mod_path, tag = sys.argv[1], sys.argv[2]
lo = int(sys.argv[3]) if len(sys.argv) > 3 else 0
hi = int(sys.argv[4]) if len(sys.argv) > 4 else 10 ** 9
spec = importlib.util.spec_from_file_location('probemod', mod_path)
m = importlib.util.module_from_spec(spec)
sys.argv = [mod_path, '__none__']
spec.loader.exec_module(m)
SRC, FN = m.SRC, m.FN
full = os.path.join(ROOT, SRC)
orig = open(full, 'rb').read()
crlf = orig.count(b'\r\n') > orig.count(b'\n') // 2
fx = (lambda b: b.replace(b'\n', b'\r\n')) if crlf else (lambda b: b)
work = os.path.join(tempfile.gettempdir(), 'vasm_%d' % os.getpid())
os.makedirs(work, exist_ok=True)
try:
    data = orig
    for old, new in m.VARIANTS.get(tag, []):
        old, new = fx(old) if b'\r\n' not in old else old, fx(new) if b'\r\n' not in new else new
        assert old in data, 'MISS %r' % old[:60]
        data = data.replace(old, new)
    open(full + '.vtmp', 'wb').write(data)
    os.replace(full + '.vtmp', full)
    i_file = os.path.join(work, 'v.i')
    subprocess.run([CPP, '-x', 'c', '-D__cplusplus=1', '-nostdinc', '-undef', '-Dmips',
                    '-D__mips__', '-D__psx__', '-I' + ROOT + '/recon', full, '-o', i_file],
                   capture_output=True, cwd=ROOT, check=True)
    s_file = os.path.join(work, 'v.s')
    subprocess.run([CC1PL, '-quiet', '-O2', '-G' + os.environ.get('GV','4'),
                    i_file, '-o', s_file], capture_output=True, cwd=work)
    txt = open(s_file, errors='replace').read()
    a = re.search(r'^\t\.ent\t%s\b[^\n]*\n' % re.escape(FN), txt, re.M)
    b = re.search(r'^\t\.end\t%s[ \t]*$' % re.escape(FN), txt[a.end():], re.M)
    region = txt[a.start():a.end() + b.start()]
    for i, ln in enumerate(region.splitlines()):
        if lo <= i < hi:
            print('%4d %s' % (i, ln))
finally:
    open(full + '.vtmp', 'wb').write(orig)
    os.replace(full + '.vtmp', full)
    assert open(full, 'rb').read() == orig
