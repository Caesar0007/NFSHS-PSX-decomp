#!/usr/bin/env python3
"""W64-A18  ANTI-VACUITY PROOFS for a blob cut (the W63-A19 P1-P5 battery,
re-run against the v2 cut which also SPLITS records).

  P1  the parser round-trips the control blob byte-identically
  P2  the emitted pieces' data LINES == the control's data lines, in order
  P3  assembling the pieces and concatenating their section bytes reproduces
      the assembled CONTROL blob object byte-for-byte
  P4  the pieces' relocations == the control object's relocations
      (same absolute offsets, same types, same targets)
  P5  piece bytes vs rom/nfs4-f.exe differ ONLY inside relocation words
      (checked byte-by-byte against the reloc coverage SET, never inferred
      from a count)

  python scratchpad/w64a18/proofs.py --ctl scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s \
      --end 0x8013C54C --sec .data --order scratchpad/w64a18/data_8010CCD4_pieces_order.txt
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import blobparse  # noqa: E402

ROOT = Path(__file__).resolve().parents[2]
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
AS = MIPS / "mipsel-none-elf-as.exe"
OBJDUMP = MIPS / "mipsel-none-elf-objdump.exe"
AS_ARCH = ["-EL", "-march=r3000", "-mtune=r3000", "-G0"]
FBASE = 0x8000F800
VA_RE = re.compile(r"/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s")


def asm(src, obj):
    r = subprocess.run([str(AS), *AS_ARCH, "-I", str(ROOT / "include"),
                        "-I", str(ROOT), str(src), "-o", str(obj)],
                       capture_output=True, text=True, cwd=ROOT)
    assert r.returncode == 0, f"as {src}: {r.stderr}"


def secbytes(obj, sec):
    r = subprocess.run([str(OBJDUMP), "-s", "-j", sec, str(obj)],
                       capture_output=True, text=True)
    out = bytearray()
    for ln in r.stdout.splitlines():
        m = re.match(r"^ ([0-9a-f]{4,8}) ((?:[0-9a-f]{2,8} ?){1,4})", ln)
        if m:
            out += bytes.fromhex(m.group(2).replace(" ", ""))
    return bytes(out)


def relocs(obj, sec):
    r = subprocess.run([str(OBJDUMP), "-r", str(obj)],
                       capture_output=True, text=True)
    cur, out = None, []
    for ln in r.stdout.splitlines():
        h = re.match(r"^RELOCATION RECORDS FOR \[(\S+)\]:", ln)
        if h:
            cur = h.group(1)
            continue
        g = re.match(r"^([0-9a-f]{8}) (\S+)\s+(.*)$", ln)
        if g and cur == sec:
            out.append((int(g.group(1), 16), g.group(2), g.group(3).strip()))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ctl", required=True)
    ap.add_argument("--end", required=True)
    ap.add_argument("--sec", required=True)
    ap.add_argument("--order", required=True)
    ap.add_argument("--dest", default="asm/data")
    a = ap.parse_args()

    work = ROOT / "scratchpad/w64a18/proofwork"
    work.mkdir(parents=True, exist_ok=True)
    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    ctl = ROOT / a.ctl

    # P1
    nl, header, recs = blobparse.load(ctl, int(a.end, 16))
    body = [l for r in recs for l in r["lines"]]
    assert nl.join(header + body) == ctl.read_text(errors="replace")
    lo, hi = recs[0]["va"], recs[-1]["end"]
    print(f"P1 parser round-trip BYTE-IDENTICAL  ({len(recs)} records, "
          f"{lo:#x}..{hi:#x} = {hi-lo} B)")

    order = [l.strip() for l in (ROOT / a.order).read_text().splitlines()
             if l.strip()]
    pieces = [ROOT / a.dest / n for n in order]
    for p in pieces:
        assert p.exists(), p

    # P2
    dl_ctl = [l for l in body if VA_RE.search(l)]
    dl_new = []
    for p in pieces:
        for l in p.read_text(errors="replace").split(nl):
            if VA_RE.search(l):
                dl_new.append(l)
    assert dl_ctl == dl_new, "P2 FAILED: data lines differ"
    print(f"P2 data lines identical and in order  ({len(dl_ctl)} lines)")

    # P3
    ctlobj = work / (ctl.name + ".ctl.o")
    asm(ctl, ctlobj)
    cb = secbytes(ctlobj, a.sec)
    cat = bytearray()
    offs = []
    for p in pieces:
        o = work / (p.name + ".o")
        asm(p, o)
        b = secbytes(o, a.sec)
        offs.append((p.name, len(cat), len(b), o))
        cat += b
    assert len(cat) == len(cb) == hi - lo, (len(cat), len(cb), hi - lo)
    assert bytes(cat) == cb, "P3 FAILED: concatenation != control object"
    print(f"P3 concatenated {len(pieces)} piece objects == control object: "
          f"{len(cb)} == {len(cat)}, IDENTICAL")

    # P4
    rc = sorted(relocs(ctlobj, a.sec))
    rp = []
    for name, off, n, o in offs:
        for (ro, typ, sym) in relocs(o, a.sec):
            rp.append((ro + off, typ, sym))
    rp.sort()
    assert rc == rp, ("P4 FAILED", len(rc), len(rp),
                      set(rc) ^ set(rp))
    print(f"P4 relocations identical: {len(rc)} records, same offsets/types/targets")

    # P5
    cov = set()
    for (ro, typ, sym) in rc:
        cov |= set(range(ro, ro + 4))
    bad = [i for i in range(len(cat))
           if cat[i] != rom[lo - FBASE + i] and i not in cov]
    ndiff = sum(1 for i in range(len(cat)) if cat[i] != rom[lo - FBASE + i])
    assert not bad, f"P5 FAILED: {len(bad)} non-reloc byte diffs, first {bad[:8]}"
    print(f"P5 piece bytes vs ROM: {ndiff} differing bytes, "
          f"{len(bad)} of them outside a relocation word -> ALL are reloc sites")
    print("\nALL PROOFS PASS")


if __name__ == "__main__":
    main()
