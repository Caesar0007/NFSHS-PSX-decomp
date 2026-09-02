"""try.py FILE OLD NEW [--keep]  -- swap OLD->NEW (exact, unique-or-all), gate the whole TU, revert unless --keep."""
import sys, subprocess, pathlib, shutil, os
f = pathlib.Path(sys.argv[1]); old = sys.argv[2]; new = sys.argv[3]
keep = '--keep' in sys.argv
src = f.read_text(errors='replace')
n = src.count(old)
if n == 0: sys.exit("PATTERN NOT FOUND")
bak = str(f)+'.w85bak'
shutil.copyfile(str(f), bak)
try:
    f.write_text(src.replace(old, new))
    r = subprocess.run([sys.executable, 'tools/tugate.py', str(f)], capture_output=True, text=True)
    out = (r.stdout or '') + (r.stderr or '')
    print(f"[{n} site(s) replaced]")
    print(out.strip()[:3000])
finally:
    if not keep:
        shutil.copyfile(bak, str(f)); os.remove(bak); print("(reverted)")
    else:
        os.remove(bak); print("(KEPT)")
