#!/usr/bin/env python3
"""W65-A8  P6 -- the SPLAT-LANE CONTROL, strengthened from stderr-equality to
IMAGE-EQUALITY.

W64-A18's P6 compared the two links' *diagnostics*.  Since W65-A7 fixed
linkers/nfs4.ld's /DISCARD/ rule the splat lane LINKS FOR REAL (rc=0), so the
control can now be the thing that actually matters:

    link the src lane with the CUT blob (N pieces, linkers/nfs4.ld)
    link the src lane with the WHOLE control blobs (one object per region)
    -> the emitted section images must be BYTE-IDENTICAL, and so must the
       diagnostics.

Anti-vacuity:
  * both links use the SAME object set except for the blob objects themselves
    (asserted: the piece objects are removed from the control's input list and
    the control objects are added; counts are printed);
  * the control .ld is derived from the LIVE linkers/nfs4.ld by replacing each
    stem's contiguous piece run with a single control entry (assert: the run is
    contiguous and non-empty, exactly as relink_ld.py asserts);
  * the compared images are pulled with objdump -s from the linked ELF, and a
    ZERO-length image aborts the proof (the classic vacuous-pass hole).

  python scratchpad/w65a8/p6.py
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
LD = MIPS / "mipsel-none-elf-ld.exe"
AS = MIPS / "mipsel-none-elf-as.exe"
OBJDUMP = MIPS / "mipsel-none-elf-objdump.exe"
AS_ARCH = ["-EL", "-march=r3000", "-mtune=r3000", "-G0"]

REGIONS = [
    ("data_8010CCD4", "data", ROOT / "scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s"),
    ("sdata_8013C54C", "sdata", ROOT / "scratchpad/w63a19/ctl_blob/sdata_8013C54C.sdata.s"),
    ("front_data", "data", ROOT / "scratchpad/w64a18/ctl_blob/front_data.data.s"),
]


def run(cmd, **kw):
    return subprocess.run([str(c) for c in cmd], capture_output=True,
                          text=True, cwd=ROOT, **kw)


def secbytes(elf, sec):
    r = run([OBJDUMP, "-s", "-j", sec, elf])
    out = bytearray()
    for ln in r.stdout.splitlines():
        m = re.match(r"^ ([0-9a-f]{8}) ((?:[0-9a-f]{2,8} ){1,4})", ln)
        if m:
            out += bytes.fromhex(m.group(2).replace(" ", ""))
    return bytes(out)


def link(script, objs, tag):
    rsp = HERE / f"{tag}.rsp"
    rsp.write_text("\n".join('"' + o.relative_to(ROOT).as_posix() + '"'
                             for o in objs))
    cmd = [LD]
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if p.exists():
            cmd += ["-T", str(p)]
    cmd += ["-T", str(script), "--no-check-sections", "--noinhibit-exec",
            "-Map", str(HERE / f"{tag}.map"), "-o", str(HERE / f"{tag}.elf"),
            "@" + str(rsp)]
    r = run(cmd)
    (HERE / f"{tag}.err").write_text(r.stderr)
    return r, HERE / f"{tag}.elf"


def main():
    # ---- object sets -----------------------------------------------------
    src = sorted((ROOT / "build" / "src").rglob("*.o"))
    asm = sorted((ROOT / "build" / "asm").rglob("*.o"))
    assert src and asm, "vacuous: empty object set"
    stems = {s for s, _, _ in REGIONS}
    piece_re = re.compile(r"^(" + "|".join(stems) + r")_[ro]\d+\.")
    pieces = [o for o in asm if piece_re.match(o.name)]
    rest = [o for o in asm if not piece_re.match(o.name)]
    assert pieces, "vacuous: no piece objects found"
    print(f"[objs] src={len(src)} asm={len(asm)} pieces={len(pieces)} "
          f"rest={len(rest)}")

    # ---- control blob objects -------------------------------------------
    cdir = HERE / "ctl_obj"
    cdir.mkdir(exist_ok=True)
    ctl_objs = []
    for stem, sec, s in REGIONS:
        assert s.exists(), s
        o = cdir / f"{stem}.{sec}.s.o"
        r = run([AS, *AS_ARCH, "-I", ROOT / "include", "-I", ROOT, s, "-o", o])
        assert r.returncode == 0, f"as {s}: {r.stderr}"
        ctl_objs.append(o)

    # ---- control .ld derived from a SNAPSHOT of nfs4.ld --------------------
    # 🔴 peers (A5's jump-table lane) rewrite linkers/nfs4.ld while this runs;
    # both links MUST read the same bytes or the comparison is noise.
    live = HERE / "nfs4_p6base.ld"
    txt = (ROOT / "linkers" / "nfs4.ld").read_text()
    if len(sys.argv) > 1 and sys.argv[1].startswith("--subalign="):
        n = sys.argv[1].split("=")[1]
        txt2 = txt.replace("SUBALIGN(16)", f"SUBALIGN({n})")
        assert txt2 != txt, "no SUBALIGN(16) to replace"
        txt = txt2
        print(f"[variant] SUBALIGN(16) -> SUBALIGN({n})")
    live.write_text(txt, newline="")
    nl = "\r\n" if "\r\n" in txt else "\n"
    lines = txt.split(nl)
    for (stem, sec, _), co in zip(REGIONS, ctl_objs):
        hit = [i for i, L in enumerate(lines)
               if re.search(rf"\b{stem}_[ro]\d+\.", L)]
        assert hit, f"no {stem} entries in nfs4.ld"
        assert hit[-1] - hit[0] + 1 == len(hit), f"{stem} entries not contiguous"
        rel = co.relative_to(ROOT).as_posix()
        lines[hit[0]:hit[-1] + 1] = [
            f"    {rel}(.{sec});   /* W65-A8 P6 CONTROL: the whole "
            f"un-split blob, {len(hit)} pieces collapsed */"]
        print(f"[ctl.ld] {stem}: {len(hit)} piece entries -> 1 control entry")
    (HERE / "nfs4_p6ctl.ld").write_text(nl.join(lines), newline="")

    # ---- the two links ---------------------------------------------------
    r_new, elf_new = link(live, src + asm, "p6_new")
    r_ctl, elf_ctl = link(HERE / "nfs4_p6ctl.ld", src + rest + ctl_objs,
                          "p6_ctl")
    print(f"[ld] cut   rc={r_new.returncode} stderr_lines="
          f"{len(r_new.stderr.splitlines())}")
    print(f"[ld] ctl   rc={r_ctl.returncode} stderr_lines="
          f"{len(r_ctl.stderr.splitlines())}")

    # ---- P6a  image equality --------------------------------------------
    ok = True
    # the linker script emits ONE big output section (.nfs4) plus .header and a
    # small .text tail -- comparing ".data"/".sdata" here would be VACUOUS
    # (they do not exist in the linked ELF).  Pull the real section list.
    seclist = [ln.split()[1] for ln in
               run([OBJDUMP, "-h", elf_new]).stdout.splitlines()
               if re.match(r"^\s+\d+ \S+\s+[0-9a-f]{8} ", ln)]
    assert ".nfs4" in seclist, f"vacuous: no .nfs4 payload section ({seclist})"
    print(f"[P6a] output sections: {seclist}")
    for sec in seclist:
        a, b = secbytes(elf_new, sec), secbytes(elf_ctl, sec)
        if not a and not b:
            print(f"  {sec:8s} ABSENT in both (skipped)")
            continue
        assert a, f"vacuous: empty {sec} image in the CUT link"
        same = a == b
        ok &= same
        d = sum(1 for x, y in zip(a, b) if x != y) + abs(len(a) - len(b))
        print(f"  {sec:8s} cut={len(a)}B ctl={len(b)}B "
              f"{'IDENTICAL' if same else f'{d} BYTES DIFFER'}")

    # ---- P6b  diagnostics equality --------------------------------------
    na = [L for L in r_new.stderr.splitlines() if L.strip()]
    nb = [L for L in r_ctl.stderr.splitlines() if L.strip()]

    def norm(ls):
        out = []
        for L in ls:
            L = re.sub(r"(data_8010CCD4|sdata_8013C54C|front_data)"
                       r"_[ro]\d+\.\w+\.s\.o", r"\1.BLOB.o", L)
            L = re.sub(r"scratchpad/w65a8/ctl_obj/", "build/asm/data/", L)
            L = re.sub(r"\(\.\w+\+0x[0-9a-f]+\)", "(SEC+OFF)", L)
            out.append(L)
        return sorted(out)
    dif = [x for x in norm(na) if x not in norm(nb)] + \
          [x for x in norm(nb) if x not in norm(na)]
    (HERE / "p6_diff.txt").write_text("\n".join(dif))
    print(f"[P6b] cut={len(na)} ctl={len(nb)} normalized DIFF LINES={len(dif)}")

    print("\nP6 " + ("PASS -- the cut is link-INVISIBLE" if ok and not dif
                     else "FAIL"))
    return 0 if (ok and not dif) else 1


if __name__ == "__main__":
    sys.exit(main())
