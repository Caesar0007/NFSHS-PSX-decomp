#!/usr/bin/env python3
"""Compile reconstructed TUs with PsyQ full debug and compare to their SYM owner.

This is deliberately translation-unit scoped.  A monolithic comparison folds
together legitimate per-object type variants and can therefore report false
mismatches.  objdiff.json supplies the source/object mapping; the trusted SYM
definition ledger supplies each retail object's canonical records.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
import argparse
import csv
import json
from pathlib import Path
import subprocess
import sys
import tempfile


ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "scratchpad" / "root_sym_audit"
sys.path.insert(0, str(ROOT / "tools"))
sys.path.insert(0, str(OUT))

import build as bld  # noqa: E402
import audit_sym_canonical_types as canon  # noqa: E402


@dataclass
class Result:
    source: str
    owner: str
    status: str
    retail_named: int = 0
    named_exact: int = 0
    named_missing: int = 0
    named_mismatch: int = 0
    retail_anonymous: int = 0
    anonymous_covered: int = 0
    retail_typedefs: int = 0
    typedefs_covered: int = 0
    source_extra_named: int = 0
    retail_duplicate_named: int = 0
    source_extra_anonymous: int = 0
    source_extra_typedefs: int = 0
    retail_duplicate_typedefs: int = 0
    source_duplicate_typedefs: int = 0
    detail: str = ""


def owner_stem(owner: str) -> str:
    normalized = owner.replace("\\", "/")
    # Library members are recorded as ``path/library.lib(member.obj)`` in the
    # retail SYM.  The owning translation unit is the parenthesized member,
    # not the archive name.
    if normalized.endswith(")") and "(" in normalized:
        normalized = normalized.rsplit("(", 1)[1][:-1]
    return Path(normalized).stem.casefold()


def target_stem(target: str) -> str:
    name = Path(target).name
    for suffix in (".o", ".c", ".cpp"):
        if name.casefold().endswith(suffix):
            name = name[: -len(suffix)]
    return name.casefold()


def source_units(scope: str) -> list[tuple[Path, str, str]]:
    data = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
    by_source = {}
    for unit in data["units"]:
        source = unit.get("metadata", {}).get("source_path", "")
        if not source.startswith("recon/") or not source.startswith(scope):
            continue
        path = ROOT / source
        if path.suffix not in {".c", ".cpp"} or not path.is_file():
            continue
        by_source[source] = (path, unit["target_path"], unit["name"])
    return [by_source[key] for key in sorted(by_source)]


def cc_flags(src: Path) -> tuple[Path, list[str], list[str]]:
    flags = bld.per_tu_flags(src)
    g_value = str(flags.get("g_value", bld.G_VALUE))
    if src.suffix == ".cpp":
        cpp = [
            bld.CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
            "-Dmips", "-D__mips__", "-D__psx__", f"-I{bld.RECON}",
        ]
        compiler = bld.CC1PL
        cc = ["-quiet", "-O2", f"-G{g_value}"]
    else:
        cpp = [bld.CPP, *bld.CPP_FLAGS]
        compiler = bld.CC1
        if flags.get("cc1_ver"):
            resolved = bld._resolve_cc1_alt(str(flags["cc1_ver"]))
            if resolved is not None:
                compiler = resolved
        elif flags.get("cc1_alt"):
            resolved = bld._resolve_cc1_alt(str(flags["cc1_alt"]))
            if resolved is not None:
                compiler = resolved
        elif flags.get("cc1_272"):
            resolved = bld._resolve_cc1_272()
            if resolved is not None:
                compiler = resolved
        cc = [f"-G{g_value}" if value == f"-G{bld.G_VALUE}" else value
              for value in bld.CC1_FLAGS if value != "-g1"]
    for key, flag in (
        ("no_delayed_branch", "-fno-delayed-branch"),
        ("no_split_addresses", "-mno-split-addresses"),
        ("no_schedule_insns", "-fno-schedule-insns"),
        ("no_schedule_insns2", "-fno-schedule-insns2"),
        ("no_strength_reduce", "-fno-strength-reduce"),
        ("no_builtin", "-fno-builtin"),
    ):
        if flags.get(key):
            cc.append(flag)
    cc.append("-g")
    return Path(compiler), [str(x) for x in cpp], cc


def compile_debug(src: Path, work: Path) -> tuple[Path | None, str]:
    compiler, cpp, cc = cc_flags(src)
    i_file = work / "unit.i"
    s_file = work / "unit.s"
    proc = subprocess.run(
        [*cpp, str(src), "-o", str(i_file)], cwd=ROOT,
        capture_output=True, text=True,
    )
    if proc.returncode:
        return None, "cpp: " + (proc.stderr or proc.stdout).strip()[-1000:]
    proc = subprocess.run(
        [str(compiler), *cc, str(i_file), "-o", str(s_file)], cwd=ROOT,
        capture_output=True, text=True,
    )
    if proc.returncode:
        return None, "cc1: " + (proc.stderr or proc.stdout).strip()[-1000:]
    return s_file, ""


def compare(source: str, owner: str, retail_defs, source_defs) -> Result:
    retail_blocks, retail_typedefs, retail_issues = canon.blocks(retail_defs)
    source_blocks, source_typedefs, source_issues = canon.blocks(source_defs)
    result = Result(source, owner, "OK")
    if retail_issues or source_issues:
        result.status = "PARSE_ISSUE"
        result.detail = "; ".join([*retail_issues, *source_issues])[:1000]

    retail_named = [x for x in retail_blocks if not x.name.startswith("._")]
    source_named = [x for x in source_blocks if not x.name.startswith("._")]
    rb = canon.variants(retail_named, lambda x: (x.kind, canon.normalize_tag(x.name)))
    sb = canon.variants(source_named, lambda x: (x.kind, canon.normalize_tag(x.name)))
    result.retail_named = len(rb)
    missing_named_keys = []
    mismatch_named_keys = []
    for key, retail_variants in rb.items():
        source_variants = sb.get(key)
        if source_variants is None:
            result.named_missing += 1
            missing_named_keys.append(key)
        elif set(retail_variants) == set(source_variants):
            result.named_exact += 1
        else:
            result.named_mismatch += 1
            mismatch_named_keys.append(key)
    # SYS/TYPES.H defines the private one-word `_physadr` referent.  PsyQ's
    # retail SYM retains the pointer typedef (including referent size/tag) but
    # filters this private tag block in every object.  Do not classify that
    # header-proven body as a game-source extra.
    # GCC 2.7.2 also owns ``__vtbl_ptr_type`` as an internal 8-byte vtable
    # entry.  The retail compiler can materialize extern arrays of that built-in
    # without emitting a source tag; the reconstruction host compiler ICEs on
    # the same declaration, so nfs4_types/owner headers use the layout-identical
    # private ``__nfs4_vtbl_ptr_t`` carrier.  Neither spelling is original
    # application source, and both are filtered only at this compiler boundary.
    ignored_source_tags = {
        ("STRTAG", "_physadr"),
        ("STRTAG", "__vtbl_ptr_type"),
    }
    extra_named_keys = set(sb) - set(rb) - ignored_source_tags
    result.source_extra_named = len(extra_named_keys)

    retail_named_counter = Counter(x.semantic() for x in retail_named)
    # Preserve the duplicate-record count as evidence, but canonicalize exact
    # repeated tag bodies semantically.  memcard.obj's back-to-back identical
    # TCB blocks are the known example: demanding two C definitions would be
    # illegal source and would confuse a debug duplication with an include.
    retail_duplicate_named = Counter({
        semantic: count - 1
        for semantic, count in retail_named_counter.items() if count > 1
    })
    result.retail_duplicate_named = sum(retail_duplicate_named.values())

    retail_anon = Counter(x.semantic() for x in retail_blocks if x.name.startswith("._"))
    source_anon = Counter(x.semantic() for x in source_blocks if x.name.startswith("._"))
    result.retail_anonymous = sum(retail_anon.values())
    result.anonymous_covered = sum(
        min(count, source_anon.get(semantic, 0))
        for semantic, count in retail_anon.items()
    )
    result.source_extra_anonymous = sum((source_anon - retail_anon).values())

    retail_block_tags = {
        canon.normalize_tag(x.name) for x in retail_blocks
        if not x.name.startswith("._")
    }
    source_block_tags = {
        canon.normalize_tag(x.name) for x in source_blocks
        if not x.name.startswith("._")
    }
    # A linked PsyQ SYM resolves the referent size on opaque pointer typedefs
    # from the tag's defining object.  The original per-TU source can only emit
    # a forward tag (size 0), and neither owner graph contains the tag body.
    # Compare the source-visible pointer/tag identity in that specific case;
    # retain the linked size in the raw ledger as cross-object layout evidence.
    shared_opaque_tags = {
        canon.normalize_tag(x.tag) for x in retail_typedefs
        if x.typ == "PTR STRUCT" and x.tag
        and canon.normalize_tag(x.tag) not in retail_block_tags
        and canon.normalize_tag(x.tag) not in source_block_tags
    }

    def typedef_semantic(item):
        semantic = list(item.semantic())
        if (item.typ == "PTR STRUCT"
                and canon.normalize_tag(item.tag) in shared_opaque_tags):
            semantic[2] = 0
        return tuple(semantic)

    retail_td = Counter(typedef_semantic(x) for x in retail_typedefs)
    source_td = Counter(typedef_semantic(x) for x in source_typedefs)
    # C++ emits an implicit typedef record for the private PsyQ struct tag.
    # The retail SYM filters that record together with its `_physadr` tag body,
    # while retaining the public `physadr` pointer typedef.
    source_td = Counter({
        semantic: count for semantic, count in source_td.items()
        if not (
            (semantic[3] == "_physadr" and semantic[1] == "STRUCT")
            or (semantic[3] == "__nfs4_vtbl_ptr_t" and semantic[1] == "STRUCT")
        )
    })
    result.retail_typedefs = sum(retail_td.values())
    result.typedefs_covered = sum(
        min(count, source_td.get(semantic, 0))
        for semantic, count in retail_td.items()
    )
    extra_td_semantics = set(source_td) - set(retail_td)
    missing_td_semantics = set(retail_td) - set(source_td)
    result.source_extra_typedefs = len(extra_td_semantics)
    result.retail_duplicate_typedefs = sum(
        count - 1 for count in retail_td.values() if count > 1
    )
    result.source_duplicate_typedefs = sum(
        count - 1 for count in source_td.values() if count > 1
    )
    details = []
    if missing_named_keys:
        details.append("named_missing=" + ",".join(x[1] for x in missing_named_keys))
    if mismatch_named_keys:
        details.append("named_mismatch=" + ",".join(x[1] for x in mismatch_named_keys))
    if extra_named_keys:
        details.append("named_extra=" + ",".join(x[1] for x in sorted(extra_named_keys)[:32]))
    if retail_duplicate_named:
        details.append(
            "retail_duplicate_named=" + ",".join(
                f"{semantic[1]}x{count}"
                for semantic, count in list(retail_duplicate_named.items())[:16]
            )
        )
    missing_anon = retail_anon - source_anon
    if missing_anon:
        details.append(
            "anonymous=" + ",".join(
                f"{semantic[0]}:{semantic[2]}x{count}"
                for semantic, count in list(missing_anon.items())[:8]
            )
        )
    extra_anon = source_anon - retail_anon
    if extra_anon:
        details.append(
            "anonymous_extra=" + ",".join(
                f"{semantic[0]}:{semantic[2]}x{count}"
                for semantic, count in list(extra_anon.items())[:8]
            )
        )
    if missing_td_semantics:
        details.append(
            "typedefs=" + ",".join(
                f"{semantic[3]}:{semantic[1]}"
                for semantic in list(sorted(missing_td_semantics))[:32]
            )
        )
    if extra_td_semantics:
        details.append(
            "typedefs_extra=" + ",".join(
                f"{semantic[3]}:{semantic[1]}"
                for semantic in list(sorted(extra_td_semantics))[:32]
            )
        )
    if result.retail_duplicate_typedefs:
        details.append(f"retail_duplicate_typedefs={result.retail_duplicate_typedefs}")
    if result.source_duplicate_typedefs:
        details.append(f"source_duplicate_typedefs={result.source_duplicate_typedefs}")
    result.detail = "; ".join(details)
    if (result.named_missing or result.named_mismatch
            or result.source_extra_named
            or result.anonymous_covered != result.retail_anonymous
            or result.source_extra_anonymous
            or missing_td_semantics
            or result.source_extra_typedefs):
        result.status = "DIFF"
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--scope", default="recon/")
    parser.add_argument("--max", type=int, default=0)
    parser.add_argument("--output", type=Path,
                        default=OUT / "full_type_graph_sweep_20260821.tsv")
    args = parser.parse_args()

    retail = canon.parse_retail(canon.RETAIL_LEDGER)
    by_owner = defaultdict(list)
    for item in retail:
        by_owner[item.owner].append(item)
    # Some small library members have no canonical type rows at all.  Their
    # FILE boundary still proves ownership, and an empty retail type graph is
    # itself meaningful: the reconstructed TU must not invent debug types.
    with canon.RETAIL_LEDGER.open("r", encoding="utf-8", newline="") as stream:
        for row in csv.DictReader(stream, delimiter="\t"):
            owner = row["owner_context"]
            if owner:
                by_owner[owner]
    owners_by_stem = defaultdict(list)
    for owner in by_owner:
        lowered = owner.casefold()
        if lowered.endswith(".obj") or lowered.endswith(".obj)"):
            owners_by_stem[owner_stem(owner)].append(owner)

    units = source_units(args.scope)
    if args.max:
        units = units[: args.max]
    results = []
    for index, (src, target, _unit_name) in enumerate(units, 1):
        source = src.relative_to(ROOT).as_posix()
        candidates = owners_by_stem.get(target_stem(target), [])
        if len(candidates) != 1:
            results.append(Result(
                source, "|".join(candidates), "OWNER_MAP",
                detail=f"{len(candidates)} owner candidates",
            ))
            print(f"[{index}/{len(units)}] OWNER_MAP {source}: {candidates}")
            continue
        owner = candidates[0]
        with tempfile.TemporaryDirectory(prefix="nfs4_sym_type_") as tmp:
            asm, error = compile_debug(src, Path(tmp))
            if asm is None:
                results.append(Result(source, owner, "COMPILE_FAIL", detail=error))
                print(f"[{index}/{len(units)}] COMPILE_FAIL {source}")
                continue
            source_defs = canon.parse_asm(asm)
        result = compare(source, owner, by_owner[owner], source_defs)
        results.append(result)
        print(
            f"[{index}/{len(units)}] {result.status} {source}: "
            f"named {result.named_exact}/{result.retail_named}, "
            f"anon {result.anonymous_covered}/{result.retail_anonymous}, "
            f"typedef {result.typedefs_covered}/{result.retail_typedefs}"
        )

    args.output.parent.mkdir(parents=True, exist_ok=True)
    fields = list(Result.__dataclass_fields__)
    with args.output.open("w", encoding="utf-8", newline="") as stream:
        stream.write("\t".join(fields) + "\n")
        for item in results:
            # Empty final details are common for exact owners.  Omitting their
            # otherwise trailing tab keeps the durable receipts diff-clean.
            row = "\t".join(str(getattr(item, field)) for field in fields)
            stream.write(row.rstrip("\t") + "\n")

    counts = Counter(item.status for item in results)
    print("=== SYM TYPE GRAPH SWEEP ===")
    print(f"units: {len(results)}")
    for key in sorted(counts):
        print(f"  {key}: {counts[key]}")
    print(f"report: {args.output}")


if __name__ == "__main__":
    main()
