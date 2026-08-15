#!/usr/bin/env python3
"""W64-A19: quantify the `.L` jump-table axis of the recon-lane link.

PROVEN CLAIM (feapp.cpp, byte-checked below): a `jtbl_<VA>` region in the splat
rodata blob is the SAME jump table the recon TU already emits into its own
.rodata -- 8/8 words identical once the TU's implied base is added.  So in the
RECON lane those blob words are a duplicate, and their `.L<VA>` operands are
undefined only because the recon TU's switch labels have different names.

This probe isolates the axis WITHOUT touching the repo blobs (the splat lane
still needs them): it writes size-preserving copies of the two rodata blobs with
every `.word .L...` replaced by `.space 4`, assembles them into the scratchpad,
and relinks the recon lane with those objects substituted.  The delta in the
undefined-symbol count is the exact price of the axis.
"""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = ROOT / "scratchpad" / "w64a19"
BIN = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-"
LD = BIN + "ld.exe"
AS = BIN + "as.exe"
BLOBS = ["asm/data/rdata_80010000.rodata.s", "asm/data/rdata_80054548.rodata.s"]

(HERE / "jtbl").mkdir(exist_ok=True)
subs = {}
for b in BLOBS:
    src = (ROOT / b).read_text(errors="replace")
    out, n = re.subn(r"\.word\s+\.L[0-9A-Fa-f]+", ".space 4", src)
    assert n, b
    p = HERE / "jtbl" / Path(b).name
    p.write_text(out)
    obj = p.with_suffix(".s.o")
    r = subprocess.run([AS, "-EL", "-march=r3000", "-mabi=32", "-G0",
                        "-I", str(ROOT / "include"), "-I", str(ROOT / "asm"),
                        "-o", str(obj), str(p)],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode:
        sys.exit(f"as failed on {p}: {r.stderr[:600]}")
    orig = ROOT / "build" / (b + ".o")
    a = orig.stat().st_size
    subs[str(orig.relative_to(ROOT)).replace("\\", "/")] = str(obj).replace("\\", "/")
    print(f"{b}: {n} `.word .L..` -> `.space 4`   (orig obj {a} B)")

objdata = json.load(open(ROOT / "scratchpad/w63a19/objdata.json"))
objs = sorted(objdata) + [str(p.relative_to(ROOT)).replace("\\", "/")
                          for p in sorted((ROOT / "build/asm").rglob("*.o"))]
objs = [subs.get(o, o) for o in dict.fromkeys(objs)]
rsp = HERE / "jtbl_link.rsp"
rsp.write_text("\n".join('"%s"' % o for o in objs))

# the .ld itself names the blob object explicitly -- substitute there too
ldtxt = (ROOT / "linkers/nfs4_recon.ld").read_text()
for k, v in subs.items():
    ldtxt = ldtxt.replace(k, v)
ldp = HERE / "nfs4_recon_nojtbl.ld"
ldp.write_text(ldtxt)
cmd = [LD, "-T", str(ldp)]
for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
    p = ROOT / "linkers" / auto
    if p.exists():
        cmd += ["-T", str(p)]
cmd += ["--allow-multiple-definition", "--no-check-sections", "--noinhibit-exec",
        "-o", str(HERE / "recon_nojtbl.elf"), "@" + str(rsp)]
r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
und = sorted(set(re.findall(r"undefined reference to [`']([^'\"]+)'", r.stderr)))
(HERE / "recon_nojtbl.err").write_text(r.stderr)
(HERE / "recon_nojtbl_undef.txt").write_text("\n".join(und) + "\n")
dotL = [u for u in und if u.startswith(".L")]
print(f"[no-jtbl] undefined-names={len(und)}  of which .L={len(dotL)}")
print("remaining undefined (non-.L):")
for u in und:
    print("   ", u)
