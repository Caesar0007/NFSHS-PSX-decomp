"""w66-a2: re-compile the 4 TUs whose objects differed between the pre/post
full builds (all 4 had peer source edits mid-run) with the SAME source state,
once with the patched maspsx and once with the pristine backup -> proves the
default-off flag is byte-inert on them too."""
import hashlib
import os
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools"))

TUS = ["recon/frontend/common/screentrophyinfo.cpp",
       "recon/syslib/psx/libcd/event.c",
       "recon/syslib/psx/libetc/INTR_DMA.c",
       "recon/syslib/psx/libetc/VMODE.c"]

LIVE = [Path(r"C:/Temp/maspsx-master/maspsx/__init__.py"),
        Path(r"C:/Temp/maspsx-master/maspsx.py")]
BAKS = [HERE / "bak" / "C_Temp_maspsx-master_maspsx___init__.py.bak",
        HERE / "bak" / "C_Temp_maspsx-master_maspsx.py.bak"]


def build(tag):
    out = HERE / ("r4_" + tag)
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    env = dict(os.environ)
    code = (
        "import sys;sys.path.insert(0,r'%s');import build,pathlib\n"
        "build.OUT=pathlib.Path(r'%s');build.OUT.mkdir(parents=True,exist_ok=True)\n"
        "for t in %r:\n"
        "    p=pathlib.Path(r'%s')/t\n"
        "    (build.compile_cpp(p) if t.endswith('.cpp') else build.compile_c(p,True))\n"
        % (ROOT / "tools", out, TUS, ROOT))
    r = subprocess.run([sys.executable, "-c", code], capture_output=True,
                       text=True, cwd=str(ROOT), env=env)
    if r.returncode:
        print(r.stdout, r.stderr)
        sys.exit("build %s failed" % tag)
    h = {}
    for dp, dn, fn in os.walk(out):
        for f in fn:
            if f.endswith(".o"):
                p = Path(dp) / f
                h[str(p.relative_to(out)).replace("\\", "/")] = \
                    hashlib.sha1(p.read_bytes()).hexdigest()
    # clear the .pyc cache so the restored/patched module is re-read
    return h


patched = build("patched")
for live, bak in zip(LIVE, BAKS):
    shutil.copyfile(live, str(live) + ".w66a2patched")
    shutil.copyfile(bak, live)
try:
    pristine = build("pristine")
finally:
    for live in LIVE:
        shutil.copyfile(str(live) + ".w66a2patched", live)
        os.remove(str(live) + ".w66a2patched")

keys = sorted(set(patched) | set(pristine))
bad = [k for k in keys if patched.get(k) != pristine.get(k)]
print("%d objects compared" % len(keys))
print("DIFFERING: %d %s" % (len(bad), bad))
