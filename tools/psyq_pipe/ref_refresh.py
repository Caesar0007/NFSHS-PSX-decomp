"""ref_refresh.py rel.cpp ... -- re-adopt a symloop byte reference that is stale ONLY because of the committed SimpleMem
rodata tag (12/16-byte prefix + LO16 addends) -- the honest link (0 diff) proves the fresh object.  Archives the old
reference, deletes it, runs symloop --ref-only."""
import importlib.util, re, shutil, subprocess, sys, struct
from pathlib import Path
R = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('m', R/'tools/source_section_owners.py'); m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
ARCH = R/'scratchpad/symloop_ref_archive_20260925'
PROVEN = '--proven' in sys.argv
for rel in [a for a in sys.argv[1:] if not a.startswith('--')]:
    ref = R/'build/symloop_ref'/(rel+'.text'); lay = ref.with_suffix(ref.suffix+'.json')
    if not ref.exists():
        print(rel, 'no ref -> creating'); subprocess.run([sys.executable, str(R/'tools/psyq_pipe/symloop.py'), rel, '--ref-only']); continue
    subprocess.run([sys.executable, str(R/'tools/build.py'), '--skip-asm', '--only', rel], capture_output=True)
    img = m.read_owner_image(R/'build'/(rel+'.o'))
    parts = re.split(rb'\|(\.text|\.rodata|\.data|\.sdata)\|', ref.read_bytes())
    old = {parts[i].decode(): parts[i+1] for i in range(1, len(parts), 2)}
    new = {n: (m.payload(img, n) if img['sections'].get(n) else b'') for n in ('.text', '.rodata', '.data', '.sdata')}
    if old == new:
        print(rel, 'reference already fresh'); continue
    ok = old['.data'] == new['.data'] and old['.sdata'] == new['.sdata']
    pre = len(new['.rodata']) - len(old['.rodata'])
    ok = ok and pre in (12, 16) and new['.rodata'][:9] == b'SimpleMem' and new['.rodata'][pre:] == old['.rodata']
    ta, tb = old['.text'], new['.text']; ok = ok and len(ta) == len(tb)
    bad = []
    if ok:
        for i in range(0, len(ta), 4):
            a, b = struct.unpack('<I', ta[i:i+4])[0], struct.unpack('<I', tb[i:i+4])[0]
            if a != b and not ((a >> 16) == (b >> 16) and ((b - a) & 0xffff) == pre):
                bad.append(i)
    if (not ok or bad) and not PROVEN:
        print(rel, 'STALE FOR ANOTHER REASON (prefix %d, data ok %s, odd words %s) -- not touched' % (pre, old['.data'] == new['.data'], [hex(x) for x in bad[:5]])); continue
    if not ok or bad:
        print(rel, 'drift beyond the SimpleMem tag (prefix %d, odd words %s); re-adopting on the fresh honest-link proof (0 diff at 4eff2f1a)' % (pre, [hex(x) for x in bad[:6]]))
    dst = ARCH/rel; dst.parent.mkdir(parents=True, exist_ok=True); shutil.move(str(ref), str(dst.with_suffix(dst.suffix+'.text')))
    if lay.exists(): shutil.move(str(lay), str(dst.with_suffix(dst.suffix+'.text.json')))
    r = subprocess.run([sys.executable, str(R/'tools/psyq_pipe/symloop.py'), rel, '--ref-only'], capture_output=True, text=True)
    print(rel, 'SimpleMem-only drift (prefix %d): archived + re-adopted ->' % pre, r.stdout.strip().splitlines()[-1])
