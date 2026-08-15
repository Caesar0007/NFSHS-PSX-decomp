#!/usr/bin/env python3
"""W65-A7 -- prove a candidate nfs4.ld is BYTE-NEUTRAL for the build.py link.

tools/build.py link_and_verify() passes NO object list: every input comes from
the filenames named inside linkers/nfs4.ld.  This harness replays exactly that
link for two scripts and byte-compares the flattened images.

usage: python scratchpad/w65a7/ldneutral.py <ld-a> <ld-b>
"""
import hashlib
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
LD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-ld.exe"
OBJCOPY = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objcopy.exe"


def link(script, tag):
    script = Path(script)
    if not script.is_absolute():
        script = ROOT / script
    cmd = [LD]
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if p.exists():
            cmd += ["-T", str(p)]
    elf = HERE / f"neutral_{tag}.elf"
    binf = HERE / f"neutral_{tag}.bin"
    cmd += ["-T", str(script), "-Map", str(HERE / f"neutral_{tag}.map"),
            "--no-check-sections", "--noinhibit-exec", "-o", str(elf)]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    errs = [l for l in r.stderr.replace("\r\n", "\n").split("\n") if l.strip()]
    if not elf.exists():
        print(f"[{tag}] NO ELF, rc={r.returncode}; last stderr lines:")
        for e in errs[-8:]:
            print("   ", e)
        raise SystemExit(1)
    subprocess.run([OBJCOPY, "-O", "binary", str(elf), str(binf)], check=True)
    b = binf.read_bytes()
    print(f"[{tag}] rc={r.returncode} stderr={len(errs)} bytes={len(b)} "
          f"sha1={hashlib.sha1(b).hexdigest()}")
    return b, errs


a, ea = link(sys.argv[1], "a")
b, eb = link(sys.argv[2], "b")
# build/** churns under peer agents; re-link A afterwards and require it to
# reproduce, otherwise the A/B comparison sampled two different object sets.
a2, ea2 = link(sys.argv[1], "a2")
if a != a2:
    print("INVALID: build/ changed mid-probe (A != A'); re-run")
    raise SystemExit(2)
print("BYTE-IDENTICAL" if a == b else
      f"DIFFER: {sum(1 for x, y in zip(a, b) if x != y)} bytes, "
      f"len {len(a)} vs {len(b)}")
print("stderr identical" if ea == eb else f"stderr differs {len(ea)} vs {len(eb)}")
