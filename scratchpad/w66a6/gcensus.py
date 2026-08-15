#!/usr/bin/env python3
"""W66-A6 -G CENSUS: every recon object whose own storage lands in the WRONG
section relative to retail's small-data window.

Method (the W64-16E tell, re-based on the w66-a6 finding that the CURE is the
section attribute, not -G):
  * a file-scope declaration carrying a `/* @0xVA */` breadcrumb with
    VA inside retail's .sdata run 0x8013C54C..0x8013DD7C was a SMALL-DATA object
    in retail;
  * look the symbol up in our built object's symbol table;
  * anything we emit in `.data`/`.bss` instead of `.sdata`/`.sbss` is a
    misplacement -- it punches a hole in the ownership map and cannot be cured
    by a per-fn -G8 splice (probe A/B/C: PER_FN_G8 moves TEXT only).

Also reports the inverse (ours .sdata / retail OUTSIDE the small-data window).

Usage: python scratchpad/w66a6/gcensus.py [--out FILE]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OBJD = str(Path(r"C:/Tools/mips-ps1/mips/bin") / "mipsel-none-elf-objdump.exe")
SD_LO, SD_HI = 0x8013C54C, 0x8013DD7C   # retail .sdata run (blob-decidable)
SB_HI = 0x8013DF00                      # end of the plausible retail .sbss band
GP_LO, GP_HI = 0x80134550, 0x8014454C   # gp +/- 32K reach around _gp=0x8013C54C
DECL_RE = re.compile(
    r"^\s*(?:static\s+|extern\s+\"C\"\s+)?"
    r"(?:const\s+)?[A-Za-z_]\w*\s+\*?\s*(\w+)\s*(?:\[[^\]]*\])*"
    r"[^;=]*(?:=[^;]*)?;\s*/\*\s*@?0x([0-9a-fA-F]{8})", re.M)
SMALL = (".sdata", ".sbss")
BIG = (".data", ".bss", ".rdata")


def sections(obj):
    out = subprocess.run([OBJD, "-t", str(obj)], capture_output=True,
                         text=True).stdout
    res = {}
    for ln in out.split("\n"):
        p = ln.split()
        if len(p) >= 5 and not p[-1].startswith("."):
            for tok in p:
                if tok.startswith(".") and tok not in (".text",):
                    res[p[-1]] = tok
                    break
    return res


def main():
    out_lines = []
    tot_bad = tot_inv = 0
    for src in sorted(ROOT.joinpath("recon").rglob("*.c")) + \
            sorted(ROOT.joinpath("recon").rglob("*.cpp")):
        rel = src.relative_to(ROOT).as_posix()
        obj = ROOT / "build" / (rel + ".o")
        if not obj.exists():
            continue
        text = src.read_text(encoding="utf-8", errors="replace")
        decls = {m.group(1): int(m.group(2), 16) for m in DECL_RE.finditer(text)}
        if not decls:
            continue
        secs = sections(obj)
        bad, inv = [], []
        for name, va in sorted(decls.items(), key=lambda kv: kv[1]):
            sec = secs.get(name)
            if sec is None:
                continue
            in_sdata = SD_LO <= va < SD_HI          # DECIDABLE: retail .sdata
            in_sbss = SD_HI <= va < SB_HI            # plausible retail .sbss
            if in_sdata and sec.startswith(BIG):
                bad.append((va, name, sec))
            elif not in_sdata and not in_sbss and sec.startswith(SMALL):
                inv.append((va, name, sec))
        if bad or inv:
            out_lines.append("%s" % rel)
            for va, n, s in bad:
                out_lines.append("   MISPLACED-BIG  0x%08x %-34s ours=%s" % (va, n, s))
            for va, n, s in inv:
                out_lines.append("   MISPLACED-SMALL 0x%08x %-34s ours=%s" % (va, n, s))
            tot_bad += len(bad)
            tot_inv += len(inv)
    out_lines.append("")
    out_lines.append("TOTAL: %d retail-small objects we emit BIG (the -G8 tell class), "
                     "%d objects we emit SMALL whose retail VA is OUTSIDE the small-data window (the movie.cpp section-attribute class)" % (tot_bad, tot_inv))
    txt = "\n".join(out_lines)
    print(txt)
    if "--out" in sys.argv:
        Path(sys.argv[sys.argv.index("--out") + 1]).write_bytes(
            txt.encode("utf-8", "replace"))


if __name__ == "__main__":
    main()
