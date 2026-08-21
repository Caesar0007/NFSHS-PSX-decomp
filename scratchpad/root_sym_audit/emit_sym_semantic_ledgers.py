"""Emit per-record ledgers for the remaining high-volume SYM debug classes.

These ledgers deliberately distinguish structural decoding from semantic source
restoration.  A row marked REVIEW is not silently treated as corrected merely
because its enclosing function happens to compile or byte-match.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from pathlib import Path
from bisect import bisect_right
import csv
import re
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
import audit_sym_source as audit


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
OUT = ROOT / "scratchpad/root_sym_audit"

RECORD = re.compile(
    r"^(?P<pos>[0-9a-f]+): \$(?P<va>[0-9a-f]{8}) "
    r"(?P<tag>[0-9a-f]+)(?: (?P<body>.*))?$",
    re.I,
)
DEF = re.compile(
    r"^Def2? class (?P<class>\S+) type (?P<type>.+?) size (?P<size>\d+)"
    r"(?P<middle>.*?) name (?P<name>\S+)$"
)
FILE_DEF = re.compile(r"^Def class FILE type NULL size 0 name (?P<name>\S+)$")
CONFIG = re.compile(
    r"^(?P<name>[A-Za-z_.$][\w.$]*)\s*=\s*0x(?P<va>[0-9a-f]+)", re.I
)


def parse_match_statuses() -> tuple[dict[str, str], dict[int, list[str]]]:
    reports = (
        "bulkverify_frontend_common_final_sym_20260821.txt",
        "bulkverify_frontend_psx_final_sym_20260821.txt",
        "bulkverify_game_common_final_sym_20260821.txt",
        "bulkverify_game_psx_after_local_static_fix_20260821.txt",
        "bulkverify_eaclib_psx_final_sym_20260821.txt",
    )
    statuses: dict[str, str] = {}
    for report in reports:
        path = OUT / report
        mode = ""
        for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
            if line.startswith("=== "):
                if "near-misses" in line:
                    mode = "NEAR"
                elif "far residuals" in line:
                    mode = "FAR"
                else:
                    mode = ""
                continue
            match = re.match(r"^\s*\+\s+(\S+)", line)
            if match:
                statuses[match.group(1)] = "PASS"
                continue
            if mode:
                match = re.match(r"^\s*\d+\s+(\S+)", line)
                if match:
                    statuses[match.group(1)] = mode

    config_by_va: dict[int, list[str]] = defaultdict(list)
    for line in (ROOT / "configs/symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    ).splitlines():
        match = CONFIG.match(line.strip())
        if match:
            config_by_va[int(match.group("va"), 16)].append(match.group("name"))
    return statuses, config_by_va


def main() -> None:
    raw_lines = SYM.read_text(encoding="utf-8", errors="replace").splitlines()
    functions = audit.parse_sym(SYM)
    # SLD streams and function-debug blocks are separate regions of the SYM,
    # so record-order `active_function` cannot attribute line events.  Build
    # the authoritative address extents from the balanced 8c/8e stream and
    # perform a VA lookup instead.
    extent_rows = []
    extent_current = None
    extent_function_index = 0
    for raw in raw_lines:
        record = RECORD.match(raw)
        if not record:
            continue
        if record.group("tag").lower() == "8c":
            extent_current = (
                int(record.group("va"), 16), functions[extent_function_index]
            )
            extent_function_index += 1
        elif record.group("tag").lower() == "8e" and extent_current is not None:
            extent_rows.append(
                (extent_current[0], int(record.group("va"), 16), extent_current[1])
            )
            extent_current = None
    extent_rows.sort(key=lambda row: row[0])
    extent_starts = [row[0] for row in extent_rows]

    def function_at(va: int):
        index = bisect_right(extent_starts, va) - 1
        if index >= 0 and extent_rows[index][0] <= va < extent_rows[index][1]:
            return extent_rows[index][2]
        return None
    function_index = 0
    active_function = None
    current_sld_file = ""
    current_sld_line = 0
    current_object = ""
    block_stack = []

    statuses, config_by_va = parse_match_statuses()
    function_status: dict[tuple[int, str], str] = {}
    for function in functions:
        va = int(function.va, 16)
        candidates = [statuses[name] for name in config_by_va[va] if name in statuses]
        # bulkverify deliberately prints only the final 60 exact matches, while
        # its NEAR/FAR sections are complete for these zero-compile-failure
        # scopes.  Therefore every function absent from the residual sections
        # is PASS; do not mistake the abbreviated '+' list for full coverage.
        if "FAR" in candidates:
            status = "FAR"
        elif "NEAR" in candidates:
            status = "NEAR"
        else:
            status = "PASS"
        function_status[(va, function.name)] = status

    sld_rows = []
    block_rows = []
    def_rows = []
    block_issues = []
    def_statuses: Counter[str] = Counter()

    for raw in raw_lines:
        match = RECORD.match(raw)
        if not match:
            continue
        pos = int(match.group("pos"), 16)
        va = int(match.group("va"), 16)
        tag = match.group("tag").lower()
        body = match.group("body") or ""

        if tag == "8c":
            active_function = functions[function_index]
            function_index += 1

        if tag == "88":
            file_match = re.match(r"Set SLD to line (\d+) of file (.*)", body)
            if file_match:
                current_sld_line = int(file_match.group(1))
                current_sld_file = file_match.group(2)
        elif tag in {"80", "82", "84"}:
            line_match = re.search(r"\(to (\d+)\)$", body)
            if line_match:
                current_sld_line = int(line_match.group(1))
        elif tag == "86":
            line_match = re.search(r"to (\d+)$", body)
            if line_match:
                current_sld_line = int(line_match.group(1))

        if tag in {"80", "82", "84", "86", "88", "8a"}:
            sld_function = function_at(va)
            fn_name = sld_function.name if sld_function else ""
            fn_va = int(sld_function.va, 16) if sld_function else 0
            status = function_status.get((fn_va, fn_name), "OUTSIDE_FUNCTION")
            semantic = (
                "BINARY_ORDER_EXACT_SOURCE_SEMANTICS_REVIEW"
                if status == "PASS"
                else "RESIDUAL_SOURCE_SEMANTICS_REVIEW"
                if status in {"NEAR", "FAR"}
                else "NONFUNCTION_SLD_REVIEW"
            )
            sld_rows.append(
                (f"0x{pos:06x}", f"0x{va:08x}", f"0x{tag}", current_sld_file,
                 current_sld_line, fn_name, f"0x{fn_va:08x}" if fn_va else "",
                 status, semantic, body)
            )
            if tag == "8a":
                current_sld_file = ""
                current_sld_line = 0

        if tag == "90":
            line_match = re.search(r"line\s*=\s*(\d+)", body)
            source_line = int(line_match.group(1)) if line_match else -1
            block_stack.append((pos, va, source_line, active_function))
        elif tag == "92":
            line_match = re.search(r"line\s*=\s*(\d+)", body)
            end_source_line = int(line_match.group(1)) if line_match else -1
            if not block_stack:
                block_issues.append(f"orphan end at 0x{pos:x}")
            else:
                start_pos, start_va, start_source_line, start_fn = block_stack.pop()
                if start_fn is not active_function:
                    block_issues.append(f"cross-function block at 0x{start_pos:x}")
                fn_name = start_fn.name if start_fn else ""
                fn_va = int(start_fn.va, 16) if start_fn else 0
                match_status = function_status.get((fn_va, fn_name), "OUTSIDE_FUNCTION")
                block_rows.append(
                    (f"0x{start_pos:06x}", f"0x{pos:06x}",
                     f"0x{start_va:08x}", f"0x{va:08x}", start_source_line,
                     end_source_line, fn_name, f"0x{fn_va:08x}" if fn_va else "",
                     match_status, "STRUCTURE_PAIRED_SOURCE_BRACES_REVIEW")
                )

        if tag in {"94", "96"}:
            file_match = FILE_DEF.match(body)
            if file_match:
                current_object = file_match.group("name")
            def_match = DEF.match(body)
            if def_match:
                cls = def_match.group("class")
                typ = def_match.group("type")
                name = def_match.group("name")
                owner = (
                    active_function.source_file if active_function else current_object
                )
                fn_name = active_function.name if active_function else ""
                if cls in {"REGPARM", "ARG", "REG", "AUTO"} and active_function:
                    status = "FUNCTION_DECL_AUDITED"
                elif cls in {"EXT", "STAT"} and not active_function:
                    status = "OBJECT_DATA_OR_LINKAGE_AUDITED"
                elif cls == "FILE":
                    status = "OBJECT_BOUNDARY_DECODED"
                elif cls in {
                    "STRTAG", "UNTAG", "ENTAG", "MOS", "MOU", "FIELD",
                    "MOE", "TPDEF", "EOS",
                }:
                    status = "CANONICAL_TYPE_SOURCE_REVIEW"
                elif cls == "LABEL":
                    status = "LABEL_SOURCE_REVIEW"
                else:
                    status = "DEFINITION_SOURCE_REVIEW"
                def_statuses[status] += 1
                def_rows.append(
                    (f"0x{pos:06x}", f"0x{va:08x}", f"0x{tag}", cls, typ,
                     int(def_match.group("size")), name, owner, fn_name, status,
                     def_match.group("middle").strip())
                )

        if tag == "8e":
            if block_stack:
                # A legal compiler block must close before its function end.
                for start_pos, *_ in block_stack:
                    block_issues.append(f"unclosed block at 0x{start_pos:x}")
                block_stack.clear()
            active_function = None

    if block_stack:
        block_issues.extend(f"unclosed block at 0x{row[0]:x}" for row in block_stack)

    def write_tsv(name: str, header: tuple[str, ...], rows: list[tuple]) -> None:
        with (OUT / name).open("w", encoding="utf-8", newline="") as stream:
            writer = csv.writer(stream, delimiter="\t", lineterminator="\n")
            writer.writerow(header)
            writer.writerows(rows)

    write_tsv(
        "full_record_sld_ledger_20260821.tsv",
        ("record_offset", "va", "opcode", "sld_file", "sld_line", "function",
         "function_va", "match_status", "disposition", "decoded_body"),
        sld_rows,
    )
    write_tsv(
        "full_record_block_ledger_20260821.tsv",
        ("start_record", "end_record", "start_va", "end_va", "start_line",
         "end_line", "function", "function_va", "match_status", "disposition"),
        block_rows,
    )
    write_tsv(
        "full_record_definition_ledger_20260821.tsv",
        ("record_offset", "value", "opcode", "class", "type", "size", "name",
         "owner_context", "function", "disposition", "extra"),
        def_rows,
    )

    sld_counts = Counter(row[7] for row in sld_rows)
    summary = [
        "# High-volume SYM semantic-ledger summary",
        "",
        f"- SLD/file-span rows emitted: {len(sld_rows)}",
        f"- PASS-function SLD rows: {sld_counts['PASS']}",
        f"- NEAR-function SLD rows: {sld_counts['NEAR']}",
        f"- FAR-function SLD rows: {sld_counts['FAR']}",
        f"- Non-function SLD rows: {sld_counts['OUTSIDE_FUNCTION']}",
        f"- Unclassified SLD rows: {sld_counts['UNCLASSIFIED']}",
        f"- Lexical block pairs emitted: {len(block_rows)}",
        f"- Lexical block structural issues: {len(block_issues)}",
        f"- Definition rows emitted: {len(def_rows)}",
        "",
        "## Definition dispositions",
        "",
        *[f"- `{status}`: {count}" for status, count in def_statuses.items()],
        "",
        "The TSV ledgers preserve one row per decoded record (or one row per paired",
        "block) and explicitly retain semantic-review status.  Structural decoding or",
        "a byte-matched enclosing function is not presented as proof of original brace,",
        "typedef, tag, or member spelling.",
    ]
    if block_issues:
        summary.extend(["", "## Block issues", "", *[f"- {x}" for x in block_issues]])
    (OUT / "full_record_semantic_ledgers_summary_20260821.txt").write_text(
        "\n".join(summary) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
