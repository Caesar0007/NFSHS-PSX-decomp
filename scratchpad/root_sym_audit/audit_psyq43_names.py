#!/usr/bin/env python3
"""Validate reconstructed syslib names against canonical PsyQ 4.3 members.

The 4.3 archive is a naming authority only where object membership or an
instruction-identical body proves identity.  A name absent from 4.3 is not by
itself wrong: NFS4 contains older/newer and private Sony library variants.
"""

from __future__ import annotations

import csv
import importlib.util
from pathlib import Path
import re
import struct


ROOT = Path(__file__).resolve().parents[2]
PSYQ = Path(r"C:\Temp\nfs4-clean\psyq43\extracted")
INDEX = PSYQ / "INDEX.tsv"
ORACLE = ROOT / "asm" / "nonmatchings" / "main"
RETAIL_SYM = Path(r"C:\Temp\nfs4-clean\nfs4-f-v3.txt")

OWNER_OVERRIDES = {
    "syslib/psx/2mbyte/2mbyte": ("_STANDALONE", "2MBYTE"),
    "syslib/psx/libcard/CARDINIT": ("LIBCARD", "INIT"),
    "syslib/psx/libcard/PATCH": ("LIBCARD", "PATCH"),
    "syslib/psx/libcd/cdcont": ("LIBCD", "SYS"),
    "syslib/psx/libcd/drv": ("LIBCD", "BIOS"),
    "syslib/psx/libcd/stcdint": ("LIBCD", "C_011"),
    "syslib/psx/libetc/VSYNC": ("LIBETC", "VSYNC"),
    "syslib/psx/libgpu/SYS": ("LIBGPU", "SYS"),
    "syslib/psx/libmcrd/BIOS": ("LIBMCRD", "BIOS"),
}

PROGRESS_RE = re.compile(
    r"^(0x[0-9A-Fa-f]+)\s+([0-9.]+)%\s+(syslib/psx/\S+)\s+(\S+)\s*$"
)
VA_SUFFIX_RE = re.compile(r"^(.*)_80[0-9A-Fa-f]{6}$")


def load_objtruth():
    path = ROOT / "tools" / "objtruth.py"
    spec = importlib.util.spec_from_file_location("objtruth", path)
    assert spec and spec.loader
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


OBJTRUTH = load_objtruth()


def owner_for_unit(unit: str) -> tuple[str, str]:
    if unit in OWNER_OVERRIDES:
        return OWNER_OVERRIDES[unit]
    parts = unit.split("/")
    return parts[2].upper(), parts[-1]


def oracle_words(name: str):
    path = ORACLE / f"{name}.s"
    if not path.exists():
        return None
    return OBJTRUTH.oracle_words(path)


def exact_vendor_body(obj, row: dict[str, str], oracle) -> tuple[bool, str]:
    if oracle is None:
        return False, "oracle_missing"
    try:
        ts = OBJTRUTH.text_sect(obj)
        start = int(row["offset"])
        size = int(row["size"])
        code = obj["code"][ts][start : start + size]
    except (KeyError, ValueError):
        return False, "vendor_slice_error"
    if len(code) != size or size // 4 != len(oracle):
        return False, "length_mismatch"
    pidx = OBJTRUTH.patch_index(obj, ts)
    for i, (oracle_word, _text, _va) in enumerate(oracle):
        vendor_word = struct.unpack_from("<I", code, i * 4)[0]
        mask = 0xFFFFFFFF
        for patch in pidx.get(start + i * 4, []):
            mask &= ~OBJTRUTH.PATCH_MASKS.get(patch["type"], 0xFFFFFFFF)
        if (vendor_word & mask) != (oracle_word & mask):
            return False, "body_drift"
    return True, "exact_body"


def main() -> int:
    with INDEX.open(encoding="utf-8", newline="") as stream:
        rows = list(csv.DictReader(stream, delimiter="\t"))
    by_member: dict[tuple[str, str], list[dict[str, str]]] = {}
    global_funcs: set[str] = set()
    global_data: set[str] = set()
    for row in rows:
        key = (row["lib"].upper(), row["member"].casefold())
        by_member.setdefault(key, []).append(row)
        if row["kind"] == "func":
            global_funcs.add(row["name"])
        elif row["kind"] == "data":
            global_data.add(row["name"])

    retail: dict[str, list[dict[str, str]]] = {}
    for line in (ROOT / "MATCH_PROGRESS.txt").read_text(encoding="utf-8").splitlines():
        match = PROGRESS_RE.match(line)
        if not match:
            continue
        va, pct, unit, name = match.groups()
        retail.setdefault(unit, []).append(
            {"va": va, "percent": pct, "unit": unit, "name": name}
        )

    sym_names = set(
        re.findall(
            r"[A-Za-z_$][A-Za-z0-9_.$]*",
            RETAIL_SYM.read_text(encoding="utf-8", errors="replace"),
        )
    )
    output: list[dict[str, str]] = []
    exact_renames: list[dict[str, str]] = []
    unmapped_units: list[str] = []
    for unit, functions in sorted(retail.items()):
        lib, member = owner_for_unit(unit)
        canonical = by_member.get((lib, member.casefold()), [])
        if not canonical:
            unmapped_units.append(f"{unit}\t{lib}\t{member}")
            for function in functions:
                output.append(
                    function
                    | {
                        "canonical_lib": lib,
                        "canonical_member": member,
                        "status": "NO_CANONICAL_MEMBER",
                        "canonical_name": "",
                        "proof": "",
                    }
                )
            continue

        canonical_funcs = [row for row in canonical if row["kind"] == "func"]
        same_member_names = {row["name"] for row in canonical_funcs}
        obj_path = PSYQ / lib / "obj" / f"{canonical[0]['obj']}"
        obj = OBJTRUTH.parse_obj(obj_path) if obj_path.exists() else None

        for function in functions:
            name = function["name"]
            base = VA_SUFFIX_RE.sub(r"\1", name)
            status = "NFS4_VARIANT_OR_PRIVATE"
            canonical_name = ""
            proof = ""
            if name in same_member_names:
                status = "SAME_MEMBER_NAME"
                canonical_name = name
                proof = "PsyQ43 same archive member"
            elif base != name and base in same_member_names:
                status = "ORACLE_ADDRESS_ALIAS_OF_SAME_MEMBER_NAME"
                canonical_name = base
                proof = "address suffix is reconstruction/oracle disambiguator"
            elif name in global_funcs:
                status = "SDK_NAME_OTHER_MEMBER"
                canonical_name = name
                proof = "PsyQ43 global function catalog"
            elif base != name and base in global_funcs:
                status = "ORACLE_ADDRESS_ALIAS_OF_SDK_NAME"
                canonical_name = base
                proof = "address suffix is reconstruction/oracle disambiguator"

            if obj is not None and status == "NFS4_VARIANT_OR_PRIVATE":
                oracle = oracle_words(name)
                same_size = [
                    row
                    for row in canonical_funcs
                    if oracle is not None and int(row["size"]) // 4 == len(oracle)
                ]
                body_matches = []
                for row in same_size:
                    exact, why = exact_vendor_body(obj, row, oracle)
                    if exact:
                        body_matches.append(row["name"])
                if len(body_matches) == 1:
                    status = "EXACT_BODY_RENAME_CANDIDATE"
                    canonical_name = body_matches[0]
                    proof = "instruction-identical PsyQ43 member body"
                    exact_renames.append(
                        {
                            "unit": unit,
                            "retail_name": name,
                            "canonical_name": canonical_name,
                            "va": function["va"],
                        }
                    )
                elif len(body_matches) > 1:
                    status = "AMBIGUOUS_EXACT_BODY"
                    canonical_name = ",".join(body_matches)
                    proof = "multiple instruction-identical member bodies"

            output.append(
                function
                | {
                    "canonical_lib": lib,
                    "canonical_member": member,
                    "status": status,
                    "canonical_name": canonical_name,
                    "proof": proof,
                    "retail_sym_confirmation": "YES" if base in sym_names else "NO",
                }
            )

    out_dir = ROOT / "scratchpad" / "root_sym_audit"
    tsv = out_dir / "psyq43_function_name_validation_p425_20260831.tsv"
    fields = [
        "va",
        "percent",
        "unit",
        "name",
        "canonical_lib",
        "canonical_member",
        "status",
        "canonical_name",
        "proof",
        "retail_sym_confirmation",
    ]
    with tsv.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields, delimiter="\t")
        writer.writeheader()
        writer.writerows(output)

    counts: dict[str, int] = {}
    for row in output:
        counts[row["status"]] = counts.get(row["status"], 0) + 1
    print(f"canonical INDEX rows: {len(rows)}")
    print(f"retail syslib functions audited: {len(output)}")
    for status, count in sorted(counts.items()):
        print(f"  {status}: {count}")
    print(f"unmapped retail units: {len(unmapped_units)}")
    for item in unmapped_units:
        print(f"  {item}")
    print(f"exact-body rename candidates: {len(exact_renames)}")
    for item in exact_renames:
        print(
            f"  {item['va']} {item['unit']}: "
            f"{item['retail_name']} -> {item['canonical_name']}"
        )
    print(f"report: {tsv}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
