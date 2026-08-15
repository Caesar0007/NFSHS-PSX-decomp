#!/usr/bin/env python3
"""W66-A4  probe_ro.py -- probe_link WITH the `.rodata` placement leg.

tools/probe_link.py places every recon object's `.text` at its implied retail
base and sweeps every data section into a `.other` catch-all at 0x80300000.
That catch-all is exactly what a `.rodata`-resident jump table must NOT be in:
a switch dispatch materialises its table with `lui %hi(.rodata+N)` /
`addiu %lo(...)` -- a HI16/LO16 relocation against the LOCAL `.rodata` section
symbol -- so with the section at 0x80300000 those two .text words link to a
non-retail address and the object can never be byte-exact.

This harness runs BOTH legs back to back on the SAME object census:

    A (control)  = tools/probe_link.py's script verbatim
    B (rodata)   = the same, plus one placed output section per anchored
                   `.rodata` at the base rodownmap.py derived for it

and reports the delta in bytes-identical and byte-EXACT OBJECTS.  Same tree,
same instant, same objdata -- the only variable is the placement.

    python scratchpad/w66a4/probe_ro.py [--json OUT]
"""
import argparse
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
LD = str(MIPS / "mipsel-none-elf-ld.exe")
OBJCOPY = str(MIPS / "mipsel-none-elf-objcopy.exe")
FBASE = 0x8000F800
TEXT_START = 0x800128F0
PLACEHOLDER = re.compile(r"(?:func|D|lbl)_([0-9A-Fa-f]{8})$")


def symbol_vas():
    vas, dup = {}, set()
    for ln in open(ROOT / "configs" / "symbol_addrs.txt", errors="replace"):
        m = re.match(r"(\S+?)\s*=\s*(0x[0-9A-Fa-f]+);\s*//\s*type:func", ln)
        if m:
            n, v = m.group(1), int(m.group(2), 16)
            if n in vas and vas[n] != v:
                dup.add(n)
            vas.setdefault(n, v)
    for n in dup:
        del vas[n]
    return vas


def build_spine(objdata, vas):
    rows = []
    for o, d in objdata.items():
        tsz = d.get("secs", {}).get(".text", 0)
        if not tsz:
            continue
        bases = defaultdict(int)
        for s in d["syms"]:
            if s["sec"] != ".text":
                continue
            va = vas.get(s["name"])
            if va is None:
                m = PLACEHOLDER.match(s["name"])
                if m:
                    va = int(m.group(1), 16)
            if va is not None:
                bases[va - s["off"]] += 1
        if bases:
            rows.append((max(bases.items(), key=lambda kv: kv[1])[0], tsz, o))
    rows.sort()
    placed, cur = [], 0
    for base, sz, o in rows:
        if base < cur:
            continue
        placed.append((base, sz, o))
        cur = base + sz
    return placed


def run_leg(tag, placed, ro):
    lines = ["SECTIONS", "{"]
    for i, (base, sz, o) in enumerate(placed):
        lines.append(f"    .t{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.text) }}")
    for i, (base, o) in enumerate(ro):
        lines.append(f"    .r{i:04d} {base:#x} : SUBALIGN(4) {{ {o}(.rodata) }}")
    lines += ["    .other 0x80300000 : { *(.data) *(.sdata) *(.rodata) "
              "*(.bss) *(.sbss) *(COMMON) }",
              "    /DISCARD/ : { *(.pdr) *(.reginfo) *(.MIPS.abiflags) "
              "*(.gnu.attributes) *(.comment) }", "}"]
    script = HERE / f"probe_{tag}.ld"
    script.write_text("\n".join(lines) + "\n")
    elf = HERE / f"probe_{tag}.elf"
    if elf.exists():
        elf.unlink()
    cmd = [LD]
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if p.exists():
            cmd += ["-T", str(p.relative_to(ROOT).as_posix())]
    cmd += ["-T", str(script.relative_to(ROOT).as_posix()),
            "--unresolved-symbols=ignore-all", "--allow-multiple-definition",
            "--no-check-sections", "--noinhibit-exec",
            "-Map", str((HERE / f"probe_{tag}.map").relative_to(ROOT).as_posix()),
            "-o", str(elf.relative_to(ROOT).as_posix())]
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    assert elf.exists(), f"[{tag}] no ELF produced -- vacuous leg refused"
    binf = HERE / f"probe_{tag}.bin"
    sects = [f"--only-section=.t{i:04d}" for i in range(len(placed))]
    subprocess.run([OBJCOPY, "-O", "binary", *sects, str(elf), str(binf)],
                   check=True)
    img = binf.read_bytes()
    rom = (ROOT / "rom" / "nfs4-f.exe").read_bytes()
    assert img, f"[{tag}] empty image"
    per, totb, okb = [], 0, 0
    for base, sz, o in placed:
        off = base - TEXT_START
        ours = img[off:off + sz]
        theirs = rom[base - FBASE:base - FBASE + sz]
        n = sum(1 for x, y in zip(ours, theirs) if x == y)
        totb += sz
        okb += n
        per.append((sz - n, sz, o))
    assert totb, f"[{tag}] zero bytes compared"
    exact = sum(1 for d, s, o in per if d == 0)
    print(f"[{tag}] ld rc={r.returncode}  bytes={totb} identical={okb} "
          f"({100.0*okb/totb:.2f}%)  byte-EXACT objects={exact}/{len(placed)}")
    return dict(tag=tag, bytes=totb, ok=okb, pct=100.0 * okb / totb,
                exact=exact, per={o: d for d, s, o in per})


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--json", default=str(HERE / "probe_ro.json"))
    ap.add_argument("--map", default=str(HERE / "rodata_placement.json"))
    a = ap.parse_args()

    objdata = json.load(open(HERE / "objdata.json"))
    vas = symbol_vas()
    placed = build_spine(objdata, vas)
    print(f"[spine] placed .text objects: {len(placed)}")

    pl = json.load(open(a.map))
    ro = sorted((r["base"], r["obj"]) for r in pl)
    assert ro, "empty .rodata placement list -- refusing a vacuous B leg"
    print(f"[rodata] placements: {len(ro)}")

    # 🔴 THE CATCH-ALL ARTIFACT.  Leg A must place the SAME set of sections,
    # only at a non-retail scratch base: pulling 96 `.rodata` sections out of
    # `.other` shifts every remaining section in that catch-all, which moved 7
    # UNPLACED objects' .text bytes in the first (naive) A/B and made the delta
    # unattributable.  With both legs placing the same set, `.other` holds
    # identical content and the ONLY variable is the base.
    scratch = [(0x80400000 + i * 0x4000, o) for i, (b, o) in enumerate(ro)]
    A = run_leg("A", placed, scratch)
    B = run_leg("B", placed, ro)

    moved = [o for o in A["per"]
             if A["per"][o] != B["per"].get(o, A["per"][o])]
    gained = [o for o in moved if B["per"][o] == 0 and A["per"][o] != 0]
    lost = [o for o in moved if A["per"][o] == 0 and B["per"][o] != 0]
    print(f"\nDELTA  bytes-identical {B['ok'] - A['ok']:+d}  "
          f"({B['pct'] - A['pct']:+.3f} pp)   "
          f"byte-EXACT objects {B['exact'] - A['exact']:+d}")
    print(f"objects whose diff changed: {len(moved)}  "
          f"(-> byte-exact: {len(gained)}, LOST byte-exact: {len(lost)})")
    for o in sorted(moved, key=lambda x: B["per"][x] - A["per"][x]):
        print(f"   {A['per'][o]:6d} -> {B['per'][o]:6d}   {o}")
    assert not lost, f"REGRESSION: objects lost byte-exactness: {lost}"
    json.dump(dict(A={k: v for k, v in A.items() if k != "per"},
                   B={k: v for k, v in B.items() if k != "per"},
                   moved={o: [A["per"][o], B["per"][o]] for o in moved}),
              open(a.json, "w"), indent=1)
    print(f"-> {a.json}")


if __name__ == "__main__":
    main()
