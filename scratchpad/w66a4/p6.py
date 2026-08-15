#!/usr/bin/env python3
"""W65-A5  P6 -- THE SPLAT-LANE CONTROL.

Link `linkers/nfs4.ld` twice:
  NEW  the script at HEAD-of-working-tree, i.e. the two rodata blobs replaced
       by their 94 `_rNN`/`_jNN` pieces;
  CTL  the pre-cut script (scratchpad/w65a5/nfs4_PRE_W65A5.ld) with the two
       UN-SPLIT control blob objects, assembled into this scratchpad.

The splat lane still links EVERY piece, so its diagnostics must be identical
once the object NAME and the section-relative OFFSET (which necessarily change
when one object becomes 94) are normalised away.  A non-empty diff means the
cut changed the splat lane -- the thing it must never do.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
AS = MIPS / "mipsel-none-elf-as.exe"
LD = MIPS / "mipsel-none-elf-ld.exe"
AS_ARCH = ["-EL", "-march=r3000", "-mtune=r3000", "-G0"]
STEMS = ["rdata_80010000", "rdata_80054548"]


def objs_for(extra):
    # the SPLAT lane links build/src/** + build/asm/** only -- never build/recon
    # (that is the recon lane) and never build/diffsrc (a per-fn probe tree).
    out = []
    for sub in ("src", "asm"):
        out += [str(p.relative_to(ROOT)).replace("\\", "/")
                for p in sorted((ROOT / "build" / sub).rglob("*.o"))
                if not any(f"/{s}_" in str(p).replace("\\", "/") for s in STEMS)]
    return out + extra


def link(script, extra, tag):
    o = objs_for(extra)
    assert o, "empty object list -- vacuous link refused"
    rsp = HERE / f"p6_{tag}.rsp"
    rsp.write_text("\n".join('"%s"' % x for x in o))
    cmd = [str(LD), "-T", str(script)]
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if p.exists():
            cmd += ["-T", str(p)]
    cmd += ["--no-check-sections", "--noinhibit-exec",
            "-o", str(HERE / f"p6_{tag}.elf"), "@" + str(rsp)]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    (HERE / f"p6_{tag}.err").write_text(r.stderr)
    return r


def norm(err):
    out = []
    for ln in err.splitlines():
        if not ln.strip():
            continue
        ln = re.sub(r"(rdata_800(?:10000|54548))(_[rj]\d\d)?\.rodata\.s\.o",
                    r"\1.rodata.s.o", ln)
        ln = re.sub(r"\(\.rodata\+0x[0-9a-f]+\)", "(.rodata+OFF)", ln)
        ln = re.sub(r"scratchpad/w65a5/", "build/asm/data/", ln)
        ln = ln.replace("\\", "/")
        out.append(ln)
    return out


def main():
    # assemble the two control blobs
    extra = []
    for s in STEMS:
        src = HERE / "ctl_blob" / f"{s}.rodata.s"
        obj = HERE / f"{s}.rodata.s.o"
        r = subprocess.run([str(AS), *AS_ARCH, "-I", str(ROOT / "include"),
                            "-I", str(ROOT), str(src), "-o", str(obj)],
                           capture_output=True, text=True, cwd=ROOT)
        assert r.returncode == 0, r.stderr
        extra.append(str(obj.relative_to(ROOT)).replace("\\", "/"))

    # 🔴 The control is derived from the LIVE `linkers/nfs4.ld` by reversing
    # ONLY this lane's edit (collapse each rdata piece group back to the one
    # whole-blob entry).  A snapshot taken at the start of the run goes STALE:
    # a peer belt re-ordered the sdata_8013C54C pieces in this same file
    # mid-run, and comparing against the snapshot attributed THAT to the cut
    # (a 96-byte phantom image diff).  Live-derived = the cut is the only
    # variable, every time this is re-run.
    ctlscript = HERE / "nfs4_ctlblob.ld"
    src = (ROOT / "linkers" / "nfs4.ld").read_text().split("\n")
    out, i, groups = [], 0, 0
    while i < len(src):
        m = re.match(r"^(\s*)build/asm/data/(rdata_800\w+)_[rj]\d\d\.\w+\.s\.o"
                     r"\((\.\w+)\);", src[i])
        if m:
            ind, stem, sec = m.groups()
            while i < len(src) and re.match(
                    rf"^\s*build/asm/data/{stem}_[rj]\d\d\.\w+\.s\.o"
                    rf"\({re.escape(sec)}\);", src[i]):
                i += 1
            out.append(f"{ind}scratchpad/w65a5/{stem}.rodata.s.o({sec});")
            groups += 1
            continue
        if "W65-A5:" in src[i] and "pieces (the .L localize" in src[i]:
            while i < len(src) and "*/" not in src[i]:
                i += 1
            i += 1
            continue
        out.append(src[i])
        i += 1
    assert groups == 3 * len(STEMS), \
        f"expected {3*len(STEMS)} piece groups (.rodata/.data/.bss per stem), " \
        f"found {groups} -- the control would not be the pre-cut script"
    ctlscript.write_text("\n".join(out), newline="")

    new = link(ROOT / "linkers" / "nfs4.ld", [], "new")
    ctl = link(ctlscript, extra, "ctl")

    # ---- the STRONG form: compare the produced .nfs4 IMAGE, not just the
    # diagnostics.  A diagnostic-only comparison is blind to alignment shifts
    # (which is exactly how the SUBALIGN(16) defect stayed latent).
    for tag in ("new", "ctl"):
        subprocess.run([str(MIPS / "mipsel-none-elf-objcopy.exe"), "-O",
                        "binary", "--only-section=.nfs4",
                        str(HERE / f"p6_{tag}.elf"),
                        str(HERE / f"p6_{tag}.nfs4.bin")], check=True)
    ia = (HERE / "p6_new.nfs4.bin").read_bytes()
    ib = (HERE / "p6_ctl.nfs4.bin").read_bytes()
    print(f"P6 image: NEW .nfs4 = {len(ia)} B   CTL .nfs4 = {len(ib)} B   "
          + ("IDENTICAL" if ia == ib else "DIFFER"))
    assert ia and ia == ib, "P6 IMAGE DIFFERS -- the cut moved the splat lane"

    a, b = norm(new.stderr), norm(ctl.stderr)
    sa, sb = sorted(a), sorted(b)
    diff = [f"- {x}" for x in sb if x not in sa] + \
           [f"+ {x}" for x in sa if x not in sb]
    (HERE / "p6_diff.txt").write_text("\n".join(diff) + "\n")
    print(f"NEW rc={new.returncode} stderr lines={len(a)}")
    print(f"CTL rc={ctl.returncode} stderr lines={len(b)}")
    print(f"P6 normalised diagnostic DIFF LINES: {len(diff)}")
    if diff:
        print("\n".join(diff[:20]))
    assert new.returncode == ctl.returncode, "rc differs -- the cut moved the splat lane"
    return 0 if not diff else 1


if __name__ == "__main__":
    sys.exit(main())
