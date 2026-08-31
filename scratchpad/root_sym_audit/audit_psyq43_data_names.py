#!/usr/bin/env python3
"""Compare reconstructed syslib data XDEF spellings with PsyQ 4.3 INDEX.tsv."""

from __future__ import annotations

import argparse
import csv
import json
from pathlib import Path
import re
import subprocess


ROOT = Path(__file__).resolve().parents[2]
PSYQ = Path(r"C:\Temp\nfs4-clean\psyq43\extracted")
NM = Path(r"C:\Tools\mips-ps1\mips\bin\mipsel-none-elf-nm.exe")
VA_SUFFIX_RE = re.compile(r"^(.*)_80[0-9A-Fa-f]{6}$")
RETAIL_SYM = Path(r"C:\Temp\nfs4-clean\nfs4-f-v3.txt")

OWNER_OVERRIDES = {
    "recon/syslib/psx/2mbyte/2mbyte.c": ("_STANDALONE", "2MBYTE"),
    "recon/syslib/psx/libcard/INIT.c": ("LIBCARD", "INIT"),
    "recon/syslib/psx/libcard/PATCH.c": ("LIBCARD", "PATCH"),
    "recon/syslib/psx/libcd/cdcont.c": ("LIBCD", "SYS"),
    "recon/syslib/psx/libcd/drv.c": ("LIBCD", "BIOS"),
    "recon/syslib/psx/libcd/stcdint.c": ("LIBCD", "C_011"),
    "recon/syslib/psx/libetc/VSYNC.c": ("LIBETC", "VSYNC"),
    "recon/syslib/psx/libgpu/SYS.c": ("LIBGPU", "SYS"),
    "recon/syslib/psx/libmcrd/BIOS.c": ("LIBMCRD", "BIOS"),
}


def owner(source: str) -> tuple[str, str]:
    if source in OWNER_OVERRIDES:
        return OWNER_OVERRIDES[source]
    path = Path(source)
    return path.parts[3].upper(), path.stem


def nm_data(path: Path):
    proc = subprocess.run(
        [str(NM), "-g", "--defined-only", "-n", str(path)],
        text=True,
        capture_output=True,
        check=False,
    )
    if proc.returncode != 0:
        return [], proc.stderr.strip() or f"nm rc={proc.returncode}"
    found = []
    for line in proc.stdout.splitlines():
        fields = line.split()
        if len(fields) < 3:
            continue
        address, kind, name = fields[0], fields[1], fields[2]
        if kind in "BCDGGRS":
            found.append((address, kind, name))
    return found, ""


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--output",
        default="scratchpad/root_sym_audit/psyq43_data_name_validation_p425_20260831.tsv",
        help="repository-relative or absolute TSV output path",
    )
    args = parser.parse_args()
    with (PSYQ / "INDEX.tsv").open(encoding="utf-8", newline="") as stream:
        index = list(csv.DictReader(stream, delimiter="\t"))
    sym_names = set(
        re.findall(
            r"[A-Za-z_$][A-Za-z0-9_.$]*",
            RETAIL_SYM.read_text(encoding="utf-8", errors="replace"),
        )
    )
    member_data: dict[tuple[str, str], set[str]] = {}
    global_data: set[str] = set()
    for row in index:
        if row["kind"] != "data":
            continue
        member_data.setdefault(
            (row["lib"].upper(), row["member"].casefold()), set()
        ).add(row["name"])
        global_data.add(row["name"])

    config = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
    objects: dict[str, str] = {}
    for unit in config["units"]:
        source = unit.get("metadata", {}).get("source_path", "")
        if source.startswith("recon/syslib/psx/"):
            objects[source] = unit["base_path"]

    rows = []
    failures = []
    for source, base_path in sorted(objects.items()):
        lib, member = owner(source)
        canonical = member_data.get((lib, member.casefold()), set())
        symbols, error = nm_data(ROOT / base_path)
        if error:
            failures.append(f"{source}: {error}")
            continue
        for address, kind, name in symbols:
            base = name if name.startswith("D_") else VA_SUFFIX_RE.sub(r"\1", name)
            if name in canonical:
                status = "SAME_MEMBER_NAME"
                canonical_name = name
            elif base != name and base in canonical:
                status = "ADDRESS_ALIAS_OF_SAME_MEMBER_NAME"
                canonical_name = base
            elif name in global_data:
                status = "SDK_NAME_OTHER_MEMBER"
                canonical_name = name
            elif base != name and base in global_data:
                status = "ADDRESS_ALIAS_OF_SDK_NAME"
                canonical_name = base
            elif re.fullmatch(r"D_80[0-9A-Fa-f]{6}", name):
                # Exact retail storage address is proven, but neither retail
                # SYM nor the canonical member retains a private spelling.
                # Keep this explicit rather than folding it into a generic
                # "unproven" review bucket.
                status = "ADDRESS_PLACEHOLDER_PRIVATE_NAME_UNRECOVERED"
                canonical_name = ""
            else:
                status = "NFS4_VARIANT_PRIVATE_OR_UNPROVEN"
                canonical_name = ""
            rows.append(
                {
                    "source": source,
                    "object": base_path,
                    "canonical_lib": lib,
                    "canonical_member": member,
                    "address": address,
                    "kind": kind,
                    "name": name,
                    "status": status,
                    "canonical_name": canonical_name,
                    "retail_sym_confirmation": "YES" if base in sym_names else "NO",
                }
            )

    path = Path(args.output)
    if not path.is_absolute():
        path = ROOT / path
    fields = [
        "source",
        "object",
        "canonical_lib",
        "canonical_member",
        "address",
        "kind",
        "name",
        "status",
        "canonical_name",
        "retail_sym_confirmation",
    ]
    with path.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.DictWriter(stream, fields, delimiter="\t")
        writer.writeheader()
        writer.writerows(rows)

    counts: dict[str, int] = {}
    for row in rows:
        counts[row["status"]] = counts.get(row["status"], 0) + 1
    print(f"syslib data symbols audited: {len(rows)}")
    for status, count in sorted(counts.items()):
        print(f"  {status}: {count}")
    print(f"object read failures: {len(failures)}")
    for failure in failures:
        print(f"  {failure}")
    print(f"report: {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
