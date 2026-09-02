"""sweep.py FILE OLD  V1 V2 ...  -- try each replacement, gate, print result, always revert."""
import sys, subprocess, pathlib, shutil, os
f = pathlib.Path(sys.argv[1]); old = sys.argv[2]; variants = sys.argv[3:]
src = f.read_text(errors='replace')
assert src.count(old) > 0, "pattern not found"
bak = str(f)+'.w85sw'; shutil.copyfile(str(f), bak)
try:
    for v in variants:
        f.write_text(src.replace(old, v))
        r = subprocess.run([sys.executable,'tools/tugate.py',str(f)],capture_output=True,text=True)
        out=(r.stdout or '')+(r.stderr or '')
        head=[l for l in out.split('\n') if 'PASS' in l and ':' in l]
        fails=[l.strip() for l in out.split('\n') if l.startswith('  ') and 'NO ORACLE' not in l]
        print(f"--- {v[:90]!r}\n    {head[0] if head else out[:200]}   {' | '.join(fails[:4])}")
finally:
    shutil.copyfile(bak,str(f)); os.remove(bak)
