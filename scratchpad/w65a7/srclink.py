#!/usr/bin/env python3
"""W65-A7 -- src-lane link probe for linkers/nfs4.ld (or any candidate .ld).

Rebuilds the object list from the CURRENT build/ tree every run (the stale-
objdata hazard, 15E), links with GNU ld exactly the way tools/build.py's
link_and_verify() does (the two undefined_*_auto.txt scripts first, then the
-T script), and classifies stderr.

usage:  python scratchpad/w65a7/srclink.py [path-to-ld-script] [tag]
        default script = linkers/nfs4.ld, default tag = the script stem
"""
import re
import subprocess
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
LD = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-ld.exe"

script = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / "linkers" / "nfs4.ld"
if not script.is_absolute():
    script = ROOT / script
tag = sys.argv[2] if len(sys.argv) > 2 else script.stem

src = sorted((ROOT / "build" / "src").rglob("*.o"))
asm = sorted((ROOT / "build" / "asm").rglob("*.o"))
objs = src + asm
assert src, "no build/src objects -- refusing a vacuous link probe"
assert asm, "no build/asm objects -- refusing a vacuous link probe"
print(f"[objs] src={len(src)} asm={len(asm)} total={len(objs)}")

# 🔴 the paths MUST be ROOT-relative with forward slashes: linkers/nfs4.ld names
# its inputs as `build/asm/...`, and a SECTIONS filename that does not match an
# already-loaded input is opened by ld as an ADDITIONAL input file.  An absolute
# -path response file therefore loads every blob object TWICE and manufactures
# ~2900 phantom "multiple definition" lines (measured, W65-A7).
rsp = HERE / f"{tag}.rsp"
rsp.write_text("\n".join('"' + o.relative_to(ROOT).as_posix() + '"' for o in objs))

cmd = [LD]
for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
    p = ROOT / "linkers" / auto
    if p.exists():
        cmd += ["-T", str(p)]
cmd += ["-T", str(script), "--no-check-sections", "--noinhibit-exec",
        "-Map", str(HERE / f"{tag}.map"), "-o", str(HERE / f"{tag}.elf"),
        "@" + str(rsp)]
r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
err = r.stderr.replace("\r\n", "\n")
(HERE / f"{tag}.err").write_text(err)
lines = [l for l in err.split("\n") if l.strip()]

klass = Counter()
undef, trunc, disc = set(), Counter(), Counter()
for l in lines:
    if "defined in discarded section" in l or "referenced in section" in l:
        klass["discarded-section"] += 1
        m = re.search(r"of (build/\S+):?$", l.strip())
        if m:
            disc[m.group(1)] += 1
    elif "undefined reference to" in l or "undefined symbol" in l:
        klass["undefined"] += 1
        m = re.search(r"undefined reference to [`'](.+?)'", l)
        if m:
            undef.add(m.group(1))
    elif "relocation truncated to fit" in l:
        klass["reloc-truncated"] += 1
        m = re.search(r"(R_MIPS_\w+) against [`'](.+?)'", l)
        if m:
            trunc[(m.group(1), m.group(2))] += 1
    elif "small-data section too large" in l:
        klass["small-data-overflow"] += 1
    elif "multiple definition" in l:
        klass["multiple-definition"] += 1
    elif l.strip().startswith("build/") or l.strip().startswith("("):
        klass["context"] += 1
    else:
        klass["other"] += 1

print(f"[ld] rc={r.returncode}  stderr lines={len(lines)}")
for k, v in klass.most_common():
    print(f"    {k:22s} {v}")
print(f"    distinct undefined names   {len(undef)}")
print(f"    distinct GPREL16 symbols   {len({s for t, s in trunc if t == 'R_MIPS_GPREL16'})}")
if undef:
    print("    undefined:", ", ".join(sorted(undef)[:20]))
if trunc:
    print("    truncations by symbol:")
    for (t, s), n in trunc.most_common(25):
        print(f"        {n:4d}  {t}  {s}")
if disc:
    print("    top discarding objects:")
    for o, n in disc.most_common(10):
        print(f"        {n:5d}  {o}")
with open(HERE / f"{tag}.summary.txt", "w") as f:
    f.write(f"script={script}\nrc={r.returncode}\nstderr_lines={len(lines)}\n")
    for k, v in klass.most_common():
        f.write(f"{k}\t{v}\n")
    f.write(f"distinct_undefined\t{len(undef)}\n")
    for u in sorted(undef):
        f.write(f"UNDEF\t{u}\n")
    for (t, s), n in trunc.most_common():
        f.write(f"TRUNC\t{t}\t{s}\t{n}\n")
print(f"-> {tag}.err / {tag}.summary.txt / {tag}.map")
