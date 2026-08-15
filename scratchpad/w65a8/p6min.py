#!/usr/bin/env python3
"""W65-A8  P6-MIN -- the splat-lane control, ISOLATED from peer churn.

W64-A18's P6 linked the whole src lane and compared ld's *stderr*.  That test
is (a) blind to layout and (b) unusable this wave: a peer belt is rewriting
linkers/nfs4.ld and the rdata blobs while we run, so the whole-tree link is
noise (measured: 14 -> 1969 stderr lines inside one hour, none of it ours).

P6-MIN links ONLY the blob objects of one region, twice, with a private
throw-away script:

    A: the N cut pieces, in piece order
    B: the single un-split control object

and compares the emitted section image byte-for-byte.  Nothing else is in the
link, so the result depends on this lane alone.

It also parameterises SUBALIGN, because that is what decides whether a cut is
layout-neutral: linkers/nfs4.ld declares `.nfs4 ... SUBALIGN(16)`, which
overrides every input section's own 4-byte alignment and therefore pads EVERY
piece boundary the cut creates.

  python scratchpad/w65a8/p6min.py [--subalign N]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
LD, AS, OBJDUMP = (MIPS / "mipsel-none-elf-ld.exe",
                   MIPS / "mipsel-none-elf-as.exe",
                   MIPS / "mipsel-none-elf-objdump.exe")
AS_ARCH = ["-EL", "-march=r3000", "-mtune=r3000", "-G0"]

REGIONS = [
    ("data_8010CCD4", "data", 0x8010CCD4,
     ROOT / "scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s"),
    ("sdata_8013C54C", "sdata", 0x8013C54C,
     ROOT / "scratchpad/w63a19/ctl_blob/sdata_8013C54C.sdata.s"),
    ("front_data", "data", 0x8004C7A0,
     ROOT / "scratchpad/w64a18/ctl_blob/front_data.data.s"),
]


def run(cmd):
    return subprocess.run([str(c) for c in cmd], capture_output=True,
                          text=True, cwd=ROOT)


def secbytes(elf, sec=".out"):
    r = run([OBJDUMP, "-s", "-j", sec, elf])
    out = bytearray()
    for ln in r.stdout.splitlines():
        m = re.match(r"^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ){1,4})", ln)
        if m:
            out += bytes.fromhex(m.group(2).replace(" ", ""))
    return bytes(out)


def link(objs, sec, base, subalign, tag):
    body = "\n".join(f"        {o}({sec});" for o in objs)
    sa = f" SUBALIGN({subalign})" if subalign else ""
    script = HERE / f"{tag}.ld"
    script.write_text(
        "SECTIONS\n{\n"
        f"    .out {base:#x} :{sa}\n    {{\n{body}\n    }}\n"
        "    /DISCARD/ : { *(*) }\n}\n", newline="\n")
    elf = HERE / f"{tag}.elf"
    r = run([LD, "-T", script, "--no-check-sections", "--noinhibit-exec",
             "-o", elf, *objs])
    (HERE / f"{tag}.err").write_text(r.stderr)
    return r, elf


def main():
    sub = None
    for a in sys.argv[1:]:
        if a.startswith("--subalign"):
            sub = a.split("=")[1] if "=" in a else "4"
    fails = 0
    for stem, sec, base, ctl in REGIONS:
        order = (HERE / f"{stem}_pieces_order.txt")
        if not order.exists():
            order = ROOT / f"scratchpad/w64a18/{stem}_pieces_order.txt"
        names = [ln.strip() for ln in order.read_text().splitlines()
                 if ln.strip()]
        objs = [f"build/asm/data/{n}.o" for n in names]
        missing = [o for o in objs if not (ROOT / o).exists()]
        assert not missing, f"{stem}: missing piece objects {missing[:3]}"
        assert len(objs) > 1, f"vacuous: {stem} has {len(objs)} piece(s)"

        cobj = HERE / "ctl_obj" / f"{stem}.{sec}.s.o"
        cobj.parent.mkdir(exist_ok=True)
        r = run([AS, *AS_ARCH, "-I", ROOT / "include", "-I", ROOT, ctl,
                 "-o", cobj])
        assert r.returncode == 0, f"as {ctl}: {r.stderr}"

        ra, ea = link(objs, f".{sec}", base, sub, f"p6min_{stem}_cut")
        rb, eb = link([str(cobj.relative_to(ROOT)).replace("\\", "/")],
                      f".{sec}", base, sub, f"p6min_{stem}_ctl")
        A, B = secbytes(ea), secbytes(eb)
        assert B, f"vacuous: empty control image for {stem}"
        same = A == B
        fails += not same
        nd = sum(1 for x, y in zip(A, B) if x != y) + abs(len(A) - len(B))
        print(f"{stem:16s} pieces={len(objs):3d} cut={len(A):7d}B "
              f"ctl={len(B):7d}B  "
              f"{'IDENTICAL' if same else f'DIFFER by {nd} B'}"
              f"   (ld rc {ra.returncode}/{rb.returncode})")
    print(f"\nSUBALIGN={sub or 'default(input alignment)'}  ->  "
          + ("P6-MIN PASS: the cut is LAYOUT-NEUTRAL"
             if not fails else f"P6-MIN FAIL on {fails} region(s)"))
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main())
