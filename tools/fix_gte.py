#!/usr/bin/env python3
"""Rewrite GTE (COP2 compute) mnemonics in splat asm to raw .word directives.

GNU `as` knows the COP2 *memory* ops (lwc2/swc2/mtc2/mfc2/ctc2/cfc2) but not
the GTE *compute* ops (rtps, rtpt, mvmva, nclip, ...). Rather than hand-encode
them (error-prone), we use the exact instruction bytes splat already prints in
each line's comment, guaranteeing a byte-perfect round-trip.

splat line format:
    /* <fileoff> <VA> <LE-bytes> */  <mnemonic> <operands>   # comment

We replace the instruction with `.word 0x<word>` (bytes reversed from LE) and
keep the original comment for readability. Run after every `splat split`.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ASM = ROOT / "asm"

# GTE compute ops unsupported by GNU as (cop2 mem ops are fine).
GTE_OPS = {
    "rtps", "rtpt", "nclip", "avsz3", "avsz4", "mvmva", "dpcs", "dpct",
    "intpl", "sqr", "op", "gpf", "gpl", "ncds", "nccs", "ncdt", "ncct",
    "cdp", "cc", "ncs", "nct", "dcpl",
}

LINE = re.compile(
    r"^(?P<indent>\s*)/\* (?P<off>[0-9A-Fa-f]+) (?P<va>[0-9A-Fa-f]+) "
    r"(?P<bytes>[0-9A-Fa-f]{8}) \*/\s+(?P<op>\w+)\b(?P<rest>.*)$"
)


def to_word(le_bytes: str) -> int:
    b = bytes.fromhex(le_bytes)
    return int.from_bytes(b, "little")


def fix_file(path: Path) -> int:
    changed = 0
    out = []
    for line in path.read_text().splitlines():
        m = LINE.match(line)
        if m and m.group("op").lower() in GTE_OPS:
            word = to_word(m.group("bytes"))
            out.append(
                f"{m.group('indent')}/* {m.group('off')} {m.group('va')} "
                f"{m.group('bytes')} */  .word 0x{word:08X}  /* "
                f"{m.group('op')}{m.group('rest')} */"
            )
            changed += 1
        else:
            out.append(line)
    if changed:
        path.write_text("\n".join(out) + "\n")
    return changed


def main():
    total = files = 0
    for s in ASM.rglob("*.s"):
        n = fix_file(s)
        if n:
            files += 1
            total += n
    print(f"fix_gte: rewrote {total} GTE ops across {files} files")


if __name__ == "__main__":
    main()
