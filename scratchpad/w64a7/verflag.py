#!/usr/bin/env python3
"""W63-A8 probe: PER_FN_VERFLAG_SPLICE_272 -- the composed per-fn
(cc1 VERSION rung) x (extra cc1 FLAGS) splice for the 272/alt lane.

Runs verify_asm.py's OWN source (anti-drift, w60-12H) after monkey-patching
build.py's _apply_cc1_ver_splice_272 in memory.  build.py itself is NEVER
edited.

Spec under probe:
    PER_FN_VERFLAG_SPLICE_272 = {rel: {(ver, (extra_flag, ...)): {fns}}}
carried over env as
    W64A7_VERFLAG='{"recon/..../PADCMD.c": {"2.8.0|-mno-split-addresses": ["_padLoadActInfo_rcv"]}}'
(key = "<ver>|<flag>|<flag>...", "" flag list allowed = plain ver splice).

Usage: python w63a8_verflag.py <recon-rel-path> <Fn[,Fn...]>
"""
import importlib.util, json, os, re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))

spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)

VERFLAG = json.loads(os.environ.get('W64A7_VERFLAG', '{}'))

_orig_ver_splice = bld._apply_cc1_ver_splice_272


def _apply_verflag_splice(rel_posix, txt, i_file, cc1_flags, s_file):
    """Proposed mechanism.  Identical to _apply_cc1_ver_splice_272 except the
    table key carries EXTRA cc1 flags appended after _cc1_flags_for_rung()."""
    txt = _orig_ver_splice(rel_posix, txt, i_file, cc1_flags, s_file)
    table = VERFLAG.get(rel_posix)
    if not table:
        return txt
    for gi, (key, names) in enumerate(sorted(table.items())):
        if not names:
            continue
        parts = [p for p in key.split('|') if p]
        ver, extra = parts[0], parts[1:]
        alt_cc1 = bld._resolve_cc1_alt(ver)
        if alt_cc1 is None:
            sys.exit('[verflag] no such rung: %s' % ver)
        s_alt = s_file.with_suffix('.vf272_%d.s' % gi)
        flags = bld._cc1_flags_for_rung(ver, cc1_flags) + extra
        r = bld.run([alt_cc1, *flags, i_file, '-o', s_alt])
        if r.returncode:
            sys.exit('[verflag %s] %s\n%s%s' % (key, rel_posix, r.stdout, r.stderr))
        alt = s_alt.read_text(errors='replace')
        alt = bld._MOVE_RE.sub(
            lambda m: '\taddu\t%s,%s,$0' % (m.group(2), m.group(3)), alt)
        for i, name in enumerate(sorted(names)):
            a = bld._extract_ent_region_272(alt, name)
            b = bld._extract_ent_region_272(txt, name)
            if a is None or b is None:
                sys.exit('[verflag] region not found for %s (a=%s b=%s)'
                         % (name, a is not None, b is not None))
            txt = txt.replace(b, bld._uniq_labels_272(a, 'vf%d_%d' % (gi, i)), 1)
    return txt


bld._apply_cc1_ver_splice_272 = _apply_verflag_splice

# ---- now run verify_asm.py's own source, with our patched bld pre-loaded ----
sys.modules['bld'] = bld
va_src = (ROOT / 'tools' / 'verify_asm.py').read_text()
# verify_asm re-loads build.py itself; make it reuse OUR patched module.
va_src = va_src.replace(
    "spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')\n"
    "bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)",
    "import sys as _s; bld = _s.modules['bld']")
assert 'bld = _s.modules' in va_src, 'verify_asm build.py loader shape changed'
sys.argv = ['verify_asm.py'] + sys.argv[1:]
exec(compile(va_src, str(ROOT / 'tools' / 'verify_asm.py'), 'exec'),
     {'__name__': '__main__', '__file__': str(ROOT / 'tools' / 'verify_asm.py')})
