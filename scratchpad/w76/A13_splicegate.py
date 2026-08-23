#!/usr/bin/env python3
"""A13_splicegate.py <rel-src> <fn> [spec] -- per-fn cc1PLUS 2.8.1 splice probe with a
NON-VACUOUS gate.

FIXES scratchpad/W72_A14/cc1pl_splice_probe.py: that harness built the spliced object,
then exec'd tools/verify_asm.py, which re-imports build.py FRESH (module_from_spec does
not consult sys.modules) and RECOMPILES the TU -- compile_cpp has no mtime cache -- so
the gate always measured the UNSPLICED build (every W72 "SPLICE" cell = the no-splice
number).  Here verify_asm's compile line is text-substituted to use the pre-built
spliced object, and a SPLICE-NOOP guard asserts the .s region actually changed.

Alternate binary: env W72_CC1PL (default instrumented gcc-2.8.1 cc1plus).
Extra flags: env W72_CC1PL_FLAGS (default -funsigned-char).
ASCII only, byte mode, CRLF-preserving; TU restored on every exit path.
"""
import importlib.util, os, re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
SP = Path(__file__).resolve().parent
ALT = Path(os.environ.get('W72_CC1PL', r'C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe'))
ALT_FLAGS = os.environ.get('W72_CC1PL_FLAGS', '-funsigned-char').split()
TMPW = str(SP / 'A13_tmp').replace('/', '\\') + '\\'

rel, fn = sys.argv[1], sys.argv[2]
specf = sys.argv[3] if len(sys.argv) > 3 else None


def parse(spec):
    blocks, cur, mode = [], None, None
    for ln in spec.split('\n'):
        s = ln.rstrip('\r')
        if s == '<<<OLD':
            cur = ['', '']; mode = 0; continue
        if s == '===NEW':
            mode = 1; continue
        if s == '>>>':
            blocks.append(cur); cur = None; mode = None; continue
        if cur is not None:
            cur[mode] += s + '\n'
    return blocks


p = ROOT / rel
orig = p.read_bytes()
crlf = b'\r\n' in orig


def enc(t):
    t = t.replace('\r\n', '\n')
    return (t.replace('\n', '\r\n') if crlf else t).encode('latin-1')


data = orig
if specf:
    for o, n in parse(Path(specf).read_text()):
        # mixed line endings: match line-by-line with an \r?\n joiner
        pat = re.compile(b'\r?\n'.join(
            re.escape(ln.encode('latin-1'))
            for ln in o.replace('\r\n', '\n').split('\n')))
        hits = pat.findall(data)
        if len(hits) != 1:
            sys.exit('ANCHOR COUNT %d for %r' % (len(hits), o.split('\n')[0][:60]))
        data = data.replace(hits[0], enc(n), 1)

spliced = {'done': False}

try:
    p.write_bytes(data)
    spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
    bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
    bld.OUT = bld.BUILD

    _orig_apply = bld._apply_text_moves

    def patched(rel_posix, s_file):
        i_file = Path(str(s_file)[:-2] + '.i')
        tu = bld.per_tu_flags(ROOT / rel)
        g = str(tu.get('g_value', bld.G_VALUE))
        alt_s = Path(str(s_file) + '.alt.s')
        env = {**os.environ, 'TMPDIR': TMPW, 'TMP': TMPW, 'TEMP': TMPW}
        Path(TMPW).mkdir(parents=True, exist_ok=True)
        r = subprocess.run([str(ALT), '-quiet', '-O2', '-G' + g, *ALT_FLAGS,
                            str(i_file), '-o', str(alt_s)],
                           capture_output=True, text=True, env=env)
        if r.returncode:
            sys.exit('[alt cc1pl] ' + r.stderr[-2000:])
        alt_text = alt_s.read_text(errors='replace')
        normal = s_file.read_text()
        a = bld._extract_fn_region(alt_text, fn)
        t = bld._extract_fn_region(normal, fn)
        if not a or not t:
            sys.exit('SPLICE-EXTRACT-FAIL a=%r t=%r' % (bool(a), bool(t)))
        a = bld._uniquify_local_labels(a, 'w76alt')
        new = normal.replace(t, a, 1)
        if new == normal:
            sys.exit('SPLICE-REPLACE-FAIL')
        s_file.write_text(new)
        spliced['done'] = (a.strip() != t.strip())
        return _orig_apply(rel_posix, s_file)

    bld._apply_text_moves = patched
    obj = bld.compile_cpp(ROOT / rel)
    if not spliced['done']:
        print('NOTE: alt region == normal region (identical codegen)')

    # gate the PRE-BUILT object with verify_asm's own normalizers: substitute the
    # compile line so it cannot recompile/overwrite.
    va_src = (ROOT / 'tools' / 'verify_asm.py').read_text()
    needle = "obj = bld.compile_c(cpp, skip_asm=False) if cpp.suffix == '.c' else bld.compile_cpp(cpp)"
    if needle not in va_src:
        sys.exit('VERIFY_ASM SOURCE DRIFT: compile line not found')
    va_src = va_src.replace(needle, "obj = Path(r'%s')" % str(obj))
    sys.argv = ['verify_asm', rel, fn]
    g = {'__name__': 'va_spliced', '__file__': str(ROOT / 'tools' / 'verify_asm.py')}
    try:
        exec(compile(va_src, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'), g)
    except SystemExit:
        pass
finally:
    p.write_bytes(orig)
    assert p.read_bytes() == orig
