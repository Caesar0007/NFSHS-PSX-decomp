"""Exhaustive record ledger for the decoded NFS4 PsyQ/SN SYM.

This companion deliberately does not call a record "source-valid" merely
because it can parse it.  It inventories every decoded raw record, assigns a
stable binary-offset identity, reconstructs function/block and SLD stream
structure, and exposes the record families that still need semantic comparison
with reconstructed C/C++.

The declaration audit historically consumed only selected 8c/8e and 94/96
records plus some compact symbols.  This ledger is the coverage authority used
to prevent another partial audit from being reported as whole-SYM proof.
"""

from __future__ import annotations

import argparse
import bisect
import collections
import json
import re
from dataclasses import asdict, dataclass, field
from pathlib import Path


DEFAULT_SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
DEFAULT_SYMBOLS = Path("configs/symbol_addrs.txt")
DEFAULT_LINKER_ALIASES = Path("linkers/retail_data_symbols.ld")
DEFAULT_DECLARATION_ROOTS = (Path("linkers"), Path("asm"))
DEFAULT_COMPACT_SOURCE_HOMES = Path(
    "scratchpad/root_sym_audit/compact_source_homes.json"
)

RECORD = re.compile(
    r"^([0-9a-fA-F]{6}): \$([0-9a-fA-F]{8}) ([0-9a-fA-F]+)(?:\s+(.*))?$"
)
DEF = re.compile(r"^Def2? class (\w+) type (.+?) size (\d+)(.*) name (\S+)\s*$")
SLD_FILE = re.compile(r"^Set SLD to line (\d+) of file (.+)$")
SLD_LINE = re.compile(r"(?:to|line)\s+(\d+)(?:\)|$)")
CONFIG_SYMBOL = re.compile(
    r"^(.+?)\s*=\s*0x([0-9a-fA-F]+);(?:\s*//\s*type:(\w+))?"
)
LINKER_SYMBOL = re.compile(r"^(?:PROVIDE\s*\()?\s*([A-Za-z_.$][\w.$]*)\s*=")
ASM_SYMBOL = re.compile(
    r"^\s*(?:glabel|dlabel|label)\s+([A-Za-z_.$][\w.$]*)\s*(?:[#;].*)?$"
)

KINDS = {
    "1": "linker_symbol",
    "2": "public_symbol",
    "6": "static_symbol",
    "80": "sld_inc_line",
    "82": "sld_inc_byte",
    "84": "sld_inc_word",
    "86": "sld_set_line",
    "88": "sld_start",
    "8a": "sld_end",
    "8c": "function_start",
    "8e": "function_end",
    "90": "block_start",
    "92": "block_end",
    "94": "definition",
    "96": "definition2",
}


@dataclass
class RawRecord:
    record_id: str
    file_offset: int
    va: int
    opcode: str
    kind: str
    text: str
    details: list[str] = field(default_factory=list)
    def_class: str = ""
    def_name: str = ""


@dataclass
class FunctionSpan:
    name: str
    source_file: str
    start_va: int
    end_va: int
    start_record: str
    end_record: str

    @property
    def header_owned(self) -> bool:
        return self.source_file.lower().endswith((".h", ".hpp"))


@dataclass
class SldStream:
    source_file: str
    start_record: str
    end_record: str = ""
    event_count: int = 0
    mapped_events: int = 0
    unmapped_events: int = 0


@dataclass
class SldEvent:
    record_id: str
    va: int
    source_file: str
    source_line: int
    function_name: str = ""
    function_start_va: int = 0


@dataclass(frozen=True)
class ConfigSymbol:
    name: str
    va: int
    symbol_type: str


def parse_config_symbols(path: Path) -> list[ConfigSymbol]:
    symbols: list[ConfigSymbol] = []
    if not path.exists():
        return symbols
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        match = CONFIG_SYMBOL.match(line)
        if match:
            symbols.append(
                ConfigSymbol(
                    name=match.group(1).strip(),
                    va=int(match.group(2), 16),
                    symbol_type=match.group(3) or "untyped",
                )
            )
    return symbols


def parse_linker_symbols(path: Path) -> set[str]:
    names: set[str] = set()
    if not path.exists():
        return names
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        match = LINKER_SYMBOL.match(line.strip())
        if match:
            names.add(match.group(1))
    return names


def parse_declaration_sources(roots: tuple[Path, ...]) -> dict[str, list[str]]:
    """Index explicit linker/assembly declarations, not incidental word hits.

    Opcode-1 records are linker-produced symbols, so a semantic home may be a
    linker assignment or an assembly data label rather than a C declaration.
    The old ledger checked only one alias script and therefore reported real
    labels such as `_front_dtors_orgend` as missing. Keep this deliberately
    narrow: linker assignments and glabel/dlabel/label directives are source
    declarations; comments, `nonmatching` markers and identifier uses are not.
    """
    declarations: dict[str, list[str]] = collections.defaultdict(list)
    for root in roots:
        if not root.exists():
            continue
        for path in sorted(candidate for candidate in root.rglob("*") if candidate.is_file()):
            if path.suffix.lower() not in {".ld", ".ldfrag", ".s", ".asm"}:
                continue
            for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
                stripped = line.strip()
                match = LINKER_SYMBOL.match(stripped) or ASM_SYMBOL.match(stripped)
                if match:
                    declarations[match.group(1)].append(path.as_posix())
    return dict(declarations)


def parse_compact_source_homes(path: Path) -> dict[tuple[int, str], dict]:
    """Load evidence-reviewed homes for compact-only symbols.

    Compact opcode-2/6 rows often have no Def/Def2 record, and compiler-local
    names can contain a generated numeric suffix that does not occur literally
    in source.  Do not infer these homes from incidental identifier hits.  The
    manifest is intentionally explicit and evidence-carrying so a row moves
    out of the backlog only after source scope, owner, and spelling have been
    reviewed.
    """
    if not path.exists():
        return {}
    entries = json.loads(path.read_text(encoding="utf-8"))
    homes: dict[tuple[int, str], dict] = {}
    for entry in entries:
        va = int(str(entry["va"]), 0)
        name = entry["name"]
        key = (va, name)
        if key in homes:
            raise ValueError(f"duplicate compact source-home entry: {key!r}")
        homes[key] = entry
    return homes


def parse_records(path: Path) -> tuple[list[RawRecord], list[str]]:
    records: list[RawRecord] = []
    preamble: list[str] = []
    current: RawRecord | None = None
    for raw in path.read_text(encoding="utf-8", errors="replace").splitlines():
        match = RECORD.match(raw)
        if match:
            if current is not None:
                records.append(current)
            offset_s, va_s, opcode, text = match.groups()
            opcode = opcode.lower()
            current = RawRecord(
                record_id=f"sym@0x{int(offset_s, 16):06x}",
                file_offset=int(offset_s, 16),
                va=int(va_s, 16),
                opcode=opcode,
                kind=KINDS.get(opcode, "unknown"),
                text=text or "",
            )
            if opcode in {"94", "96"}:
                def_match = DEF.match(current.text)
                if def_match:
                    current.def_class = def_match.group(1)
                    current.def_name = def_match.group(5)
            continue
        if current is not None and raw.startswith("    "):
            current.details.append(raw.strip())
        elif raw.strip():
            preamble.append(raw.strip())
    if current is not None:
        records.append(current)
    return records, preamble


def detail_value(record: RawRecord, key: str) -> str:
    prefix = key + " = "
    for detail in record.details:
        if detail.startswith(prefix):
            return detail[len(prefix) :]
    return ""


def function_spans(records: list[RawRecord]) -> tuple[list[FunctionSpan], list[str]]:
    spans: list[FunctionSpan] = []
    errors: list[str] = []
    active: RawRecord | None = None
    for record in records:
        if record.opcode == "8c":
            if active is not None:
                errors.append(
                    f"{record.record_id}: nested function start before {active.record_id} ended"
                )
            active = record
        elif record.opcode == "8e":
            if active is None:
                errors.append(f"{record.record_id}: function end without start")
                continue
            spans.append(
                FunctionSpan(
                    name=detail_value(active, "name"),
                    source_file=detail_value(active, "file"),
                    start_va=active.va,
                    end_va=record.va,
                    start_record=active.record_id,
                    end_record=record.record_id,
                )
            )
            active = None
    if active is not None:
        errors.append(f"{active.record_id}: unterminated function start")
    return spans, errors


def block_invariants(records: list[RawRecord]) -> tuple[int, list[str]]:
    depth = 0
    max_depth = 0
    errors: list[str] = []
    for record in records:
        if record.opcode == "90":
            depth += 1
            max_depth = max(max_depth, depth)
        elif record.opcode == "92":
            if depth == 0:
                errors.append(f"{record.record_id}: block end without start")
            else:
                depth -= 1
    if depth:
        errors.append(f"EOF: {depth} lexical block(s) remain open")
    return max_depth, errors


def containing_function(
    va: int, starts: list[int], spans: list[FunctionSpan]
) -> FunctionSpan | None:
    index = bisect.bisect_right(starts, va) - 1
    if index < 0:
        return None
    span = spans[index]
    return span if span.start_va <= va <= span.end_va else None


def sld_streams(
    records: list[RawRecord], spans: list[FunctionSpan]
) -> tuple[list[SldStream], list[str], collections.Counter[str]]:
    ordered_spans = sorted(spans, key=lambda span: span.start_va)
    starts = [span.start_va for span in ordered_spans]
    streams: list[SldStream] = []
    errors: list[str] = []
    file_events: collections.Counter[str] = collections.Counter()
    active: SldStream | None = None
    current_line = 0
    for record in records:
        if record.opcode == "88":
            if active is not None:
                errors.append(
                    f"{record.record_id}: SLD start before {active.start_record} ended"
                )
            match = SLD_FILE.match(record.text)
            source_file = match.group(2) if match else ""
            current_line = int(match.group(1)) if match else 0
            active = SldStream(source_file=source_file, start_record=record.record_id)
            streams.append(active)
            continue
        if record.opcode == "8a":
            if active is None:
                errors.append(f"{record.record_id}: SLD end without start")
            else:
                active.end_record = record.record_id
                active = None
            continue
        if record.opcode not in {"80", "82", "84", "86"}:
            continue
        if active is None:
            errors.append(f"{record.record_id}: SLD line event outside a stream")
            continue
        if record.opcode == "80":
            current_line += 1
        else:
            line_match = SLD_LINE.search(record.text)
            if line_match:
                current_line = int(line_match.group(1))
        active.event_count += 1
        file_events[active.source_file] += 1
        if containing_function(record.va, starts, ordered_spans) is None:
            active.unmapped_events += 1
        else:
            active.mapped_events += 1
    if active is not None:
        errors.append(f"{active.start_record}: unterminated SLD stream")
    return streams, errors, file_events


def reconstruct_sld_events(
    records: list[RawRecord], spans: list[FunctionSpan]
) -> list[SldEvent]:
    """Expand the compact SLD state machine into address/file/line events."""
    ordered_spans = sorted(spans, key=lambda span: span.start_va)
    starts = [span.start_va for span in ordered_spans]
    events: list[SldEvent] = []
    source_file = ""
    current_line = 0
    active = False
    for record in records:
        if record.opcode == "88":
            match = SLD_FILE.match(record.text)
            source_file = match.group(2) if match else ""
            current_line = int(match.group(1)) if match else 0
            active = True
        elif record.opcode == "8a":
            active = False
            continue
        elif record.opcode == "80" and active:
            current_line += 1
        elif record.opcode in {"82", "84", "86"} and active:
            line_match = SLD_LINE.search(record.text)
            if line_match:
                current_line = int(line_match.group(1))
        else:
            continue
        span = containing_function(record.va, starts, ordered_spans)
        events.append(
            SldEvent(
                record_id=record.record_id,
                va=record.va,
                source_file=source_file,
                source_line=current_line,
                function_name=span.name if span else "",
                function_start_va=span.start_va if span else 0,
            )
        )
    return events


def function_trace(
    records: list[RawRecord], function_name: str, function_va: int | None
) -> str:
    spans, errors = function_spans(records)
    if errors:
        return "\n".join(["Function structure is invalid:", *errors])
    candidates = [span for span in spans if span.name == function_name]
    if function_va is not None:
        candidates = [span for span in candidates if span.start_va == function_va]
    if not candidates:
        return f"No SYM function span found for {function_name!r}."
    if len(candidates) > 1:
        choices = ", ".join(f"0x{span.start_va:08x}" for span in candidates)
        return f"Function name is duplicated; select --va from: {choices}"
    span = candidates[0]
    events = [
        event
        for event in reconstruct_sld_events(records, spans)
        if event.function_start_va == span.start_va
    ]
    by_va: dict[int, list[SldEvent]] = collections.defaultdict(list)
    for event in events:
        by_va[event.va].append(event)
    lines = [
        f"# SLD trace for `{span.name}`",
        "",
        f"- Function range: `0x{span.start_va:08x}..0x{span.end_va:08x}`",
        f"- 8c source owner: `{span.source_file}`",
        f"- SLD events: {len(events)}",
        f"- Distinct instruction addresses with SLD state: {len(by_va)}",
        "- Effective state at a VA is the last transition recorded at that VA;",
        "  preceding same-VA transitions retain boundary/inline-return evidence.",
        "",
        "| Record | VA | Source | Line | Effective at VA |",
        "|---|---:|---|---:|---|",
    ]
    for event in events:
        effective = by_va[event.va][-1] is event
        lines.append(
            f"| `{event.record_id}` | `0x{event.va:08x}` | "
            f"`{event.source_file}` | {event.source_line} | "
            f"{'yes' if effective else 'no'} |"
        )
    return "\n".join(lines) + "\n"


def semantic_symbol_surface(
    records: list[RawRecord],
    spans: list[FunctionSpan],
    config_symbols: list[ConfigSymbol],
    linker_symbols: set[str],
    declaration_sources: dict[str, list[str]],
    compact_source_homes: dict[tuple[int, str], dict],
) -> tuple[list[str], dict]:
    """Cross-check record families the declaration audit historically skipped.

    Matching by VA is intentional here: C++ deleting destructors and a few
    reconstructed aliases use a legal assembler/config spelling that differs
    from the retail debug spelling. Exact-name coverage is reported
    separately so VA equivalence cannot hide a source-name backlog.
    """
    config_by_va: dict[int, list[ConfigSymbol]] = collections.defaultdict(list)
    config_keys: set[tuple[int, str]] = set()
    for symbol in config_symbols:
        config_by_va[symbol.va].append(symbol)
        config_keys.add((symbol.va, symbol.name))

    defs = [
        record
        for record in records
        if record.opcode in {"94", "96"} and record.def_class in {"EXT", "STAT"}
    ]
    def_keys = {(record.va, record.def_name) for record in defs}
    def_vas = {record.va for record in defs}
    compact = [record for record in records if record.opcode in {"2", "6"}]
    compact_vas = {record.va for record in compact}
    span_vas = {span.start_va for span in spans}

    linker_records = [record for record in records if record.opcode == "1"]
    linker_exact_config = [
        record for record in linker_records if (record.va, record.text) in config_keys
    ]
    linker_named_elsewhere = [
        record
        for record in linker_records
        if (record.va, record.text) not in config_keys
        and record.text in linker_symbols
    ]
    linker_explicit_source = [
        record
        for record in linker_records
        if (record.va, record.text) not in config_keys
        and record.text not in linker_symbols
        and record.text in declaration_sources
    ]
    linker_unrestored = [
        record
        for record in linker_records
        if (record.va, record.text) not in config_keys
        and record.text not in linker_symbols
        and record.text not in declaration_sources
    ]

    compact_stats: dict[str, dict[str, int]] = {}
    compact_alias_only: dict[str, list[RawRecord]] = {}
    compact_absent_config: list[RawRecord] = []
    for opcode in ("2", "6"):
        family = [record for record in compact if record.opcode == opcode]
        exact = [record for record in family if (record.va, record.text) in config_keys]
        va_only = [
            record
            for record in family
            if record.va in config_by_va and (record.va, record.text) not in config_keys
        ]
        absent = [record for record in family if record.va not in config_by_va]
        compact_alias_only[opcode] = va_only
        compact_absent_config.extend(absent)
        compact_stats[opcode] = {
            "records": len(family),
            "config_exact_name_va": len(exact),
            "config_va_alias_only": len(va_only),
            "absent_from_config_va": len(absent),
        }

    absent_classes: dict[str, list[RawRecord]] = collections.defaultdict(list)
    for record in compact_absent_config:
        category = (
            "typed-exact"
            if (record.va, record.text) in def_keys
            else "typed-va-alias"
            if record.va in def_vas
            else "debug-function"
            if record.va in span_vas
            else "source-restored"
            if (record.va, record.text) in compact_source_homes
            else "compact-only"
        )
        absent_classes[category].append(record)

    config_functions = [
        symbol for symbol in config_symbols if symbol.symbol_type == "func"
    ]
    function_classes: dict[str, list[ConfigSymbol]] = collections.defaultdict(list)
    for symbol in config_functions:
        category = (
            "debug-function"
            if symbol.va in span_vas
            else "compact-only-function"
            if symbol.va in compact_vas
            else "map-only-function"
        )
        function_classes[category].append(symbol)

    lines = [
        "## Semantic symbol surface",
        "",
        "This cross-check covers the compact/linker symbol families that are",
        "not equivalent to `8c/8e` debug functions or `Def/Def2` declarations.",
        "",
        "### Function provenance",
        "",
    ]
    for category in ("debug-function", "compact-only-function", "map-only-function"):
        lines.append(f"- {category}: {len(function_classes[category])}")
    lines.extend(
        [
            "",
            "### Compact symbols versus `configs/symbol_addrs.txt`",
            "",
            "| Opcode | Records | Exact name+VA | VA alias only | Absent VA |",
            "|---|---:|---:|---:|---:|",
        ]
    )
    for opcode in ("2", "6"):
        stats = compact_stats[opcode]
        lines.append(
            f"| `{opcode}` | {stats['records']} | "
            f"{stats['config_exact_name_va']} | {stats['config_va_alias_only']} | "
            f"{stats['absent_from_config_va']} |"
        )
    lines.extend(
        [
            "",
            "Compact records absent from the config by VA:",
            "",
        ]
    )
    for category in (
        "typed-exact",
        "typed-va-alias",
        "debug-function",
        "source-restored",
        "compact-only",
    ):
        lines.append(f"- {category}: {len(absent_classes[category])}")
    lines.extend(["", "Evidence-reviewed compact-only source homes:", ""])
    for record in absent_classes["source-restored"]:
        home = compact_source_homes[(record.va, record.text)]
        lines.append(
            f"- `{record.record_id}` `0x{record.va:08x}` `{record.text}` -> "
            f"`{home['source']}` (`{home['source_identifier']}`; {home['scope']})"
        )
    lines.extend(["", "Compact-only static/data backlog:", ""])
    for record in absent_classes["compact-only"]:
        lines.append(
            f"- `{record.record_id}` `0x{record.va:08x}` `{record.text}`"
        )
    lines.extend(
        [
            "",
            "Static compact records covered only by a different config name at",
            "the same VA (exact retail spelling still requires disposition):",
            "",
        ]
    )
    for record in compact_alias_only["6"]:
        aliases = ", ".join(symbol.name for symbol in config_by_va[record.va])
        lines.append(
            f"- `{record.record_id}` `0x{record.va:08x}` `{record.text}` -> "
            f"`{aliases}`"
        )
    lines.extend(
        [
            "",
            "### Linker/section symbols",
            "",
            f"- Opcode-1 records: {len(linker_records)}",
            f"- Exact name+VA in symbol config: {len(linker_exact_config)}",
            f"- Name declared by retail linker-alias script: {len(linker_named_elsewhere)}",
            f"- Name declared by a linker/assembly source unit: {len(linker_explicit_source)}",
            f"- No exact config, alias, linker, or assembly declaration: {len(linker_unrestored)}",
            "",
            "Unrestored linker/section names:",
            "",
        ]
    )
    for record in linker_unrestored:
        lines.append(
            f"- `{record.record_id}` `0x{record.va:08x}` `{record.text}`"
        )

    data = {
        "function_provenance": {
            key: len(value) for key, value in sorted(function_classes.items())
        },
        "compact_stats": compact_stats,
        "compact_absent_config_classes": {
            key: len(value) for key, value in sorted(absent_classes.items())
        },
        "compact_only_backlog": [asdict(record) for record in absent_classes["compact-only"]],
        "compact_source_restored": [
            {
                **asdict(record),
                "source_home": compact_source_homes[(record.va, record.text)],
            }
            for record in absent_classes["source-restored"]
        ],
        "compact_alias_only": {
            opcode: [asdict(record) for record in records_for_opcode]
            for opcode, records_for_opcode in compact_alias_only.items()
        },
        "linker_records": len(linker_records),
        "linker_exact_config": len(linker_exact_config),
        "linker_named_in_alias_script": len(linker_named_elsewhere),
        "linker_explicit_source": [
            {
                **asdict(record),
                "source_paths": declaration_sources[record.text],
            }
            for record in linker_explicit_source
        ],
        "linker_unrestored": [asdict(record) for record in linker_unrestored],
    }
    return lines, data


def make_report(
    path: Path,
    records: list[RawRecord],
    preamble: list[str],
    config_symbols: list[ConfigSymbol],
    linker_symbols: set[str],
    declaration_sources: dict[str, list[str]],
    compact_source_homes: dict[tuple[int, str], dict],
) -> tuple[str, dict]:
    opcode_counts = collections.Counter(record.opcode for record in records)
    kind_counts = collections.Counter(record.kind for record in records)
    class_counts = collections.Counter(
        record.def_class for record in records if record.def_class
    )
    unknown = [record for record in records if record.kind == "unknown"]
    malformed_defs = [
        record for record in records if record.opcode in {"94", "96"} and not record.def_class
    ]
    spans, function_errors = function_spans(records)
    max_block_depth, block_errors = block_invariants(records)
    streams, sld_errors, file_events = sld_streams(records, spans)
    header_functions = [span for span in spans if span.header_owned]
    sld_events = sum(
        opcode_counts[opcode] for opcode in ("80", "82", "84", "86")
    )
    mapped_sld = sum(stream.mapped_events for stream in streams)
    unmapped_sld = sum(stream.unmapped_events for stream in streams)

    lines = [
        "# Exhaustive raw SYM record ledger",
        "",
        f"Input: `{path}`",
        "",
        "Parsing a record is not source validation. `Parsed` below means the",
        "record has a stable identity and typed family; semantic source checks",
        "remain explicitly pending where listed.",
        "",
        "## Coverage summary",
        "",
        f"- Raw decoded records: {len(records)}",
        f"- Parsed into a known record family: {len(records) - len(unknown)}",
        f"- Unknown opcodes: {len(unknown)}",
        f"- Malformed Def/Def2 records: {len(malformed_defs)}",
        f"- Function spans paired: {len(spans)}",
        f"- Header-owned function spans: {len(header_functions)}",
        f"- Function structural errors: {len(function_errors)}",
        f"- Lexical block maximum nesting: {max_block_depth}",
        f"- Lexical block structural errors: {len(block_errors)}",
        f"- SLD streams paired: {len(streams)}",
        f"- SLD line events: {sld_events}",
        f"- SLD events mapped to a debug function address span: {mapped_sld}",
        f"- SLD events outside debug function address spans: {unmapped_sld}",
        f"- SLD structural errors: {len(sld_errors)}",
        "",
        "## Opcode ledger",
        "",
        "| Opcode | Family | Records | Semantic validation |",
        "|---|---|---:|---|",
    ]
    for opcode in sorted(opcode_counts, key=lambda value: int(value, 16)):
        kind = KINDS.get(opcode, "unknown")
        state = {
            "1": "pending linker/section ownership",
            "2": "pending exhaustive function/data classification",
            "6": "pending exhaustive static function/data classification",
            "80": "pending source statement-order comparison",
            "82": "pending source statement-order comparison",
            "84": "pending source statement-order comparison",
            "86": "pending source statement-order comparison",
            "88": "parsed stream ownership; source comparison pending",
            "8a": "parsed stream boundary; source comparison pending",
            "8c": "paired; header and declaration comparison pending",
            "8e": "paired; source range comparison pending",
            "90": "balanced; lexical source-scope comparison pending",
            "92": "balanced; lexical source-scope comparison pending",
            "94": "class parsed; complete source type graph pending",
            "96": "class parsed; complete source type graph pending",
        }.get(opcode, "unclassified")
        lines.append(f"| `{opcode}` | {kind} | {opcode_counts[opcode]} | {state} |")

    lines.extend(["", "## Def/Def2 class ledger", ""])
    lines.extend(
        f"- `{name}`: {count}"
        for name, count in class_counts.most_common()
    )
    lines.extend(["", "## Header-emitted function queue", ""])
    by_header: collections.Counter[str] = collections.Counter(
        span.source_file for span in header_functions
    )
    for source_file, count in sorted(by_header.items(), key=lambda item: item[0].lower()):
        lines.append(f"- `{source_file}`: {count}")
    lines.extend(["", "## SLD source streams", ""])
    for source_file, count in sorted(file_events.items(), key=lambda item: item[0].lower()):
        lines.append(f"- `{source_file}`: {count} line events")
    lines.extend(["", "## SLD events outside debug function spans", ""])
    unmapped_by_file: collections.Counter[str] = collections.Counter()
    for stream in streams:
        unmapped_by_file[stream.source_file] += stream.unmapped_events
    for source_file, count in sorted(
        (
            (source_file, count)
            for source_file, count in unmapped_by_file.items()
            if count
        ),
        key=lambda item: item[0].lower(),
    ):
        lines.append(f"- `{source_file}`: {count}")
    if not any(unmapped_by_file.values()):
        lines.append("- None.")
    lines.extend(["", "## Structural errors", ""])
    errors = [*function_errors, *block_errors, *sld_errors]
    if errors:
        lines.extend(f"- {error}" for error in errors)
    else:
        lines.append("- None; all parsed function, block, and SLD boundaries are balanced.")
    lines.extend(["", "## Unknown/malformed records", ""])
    for record in [*unknown, *malformed_defs]:
        lines.append(
            f"- `{record.record_id}` VA `0x{record.va:08x}` opcode `{record.opcode}`: "
            f"`{record.text}`"
        )
    if not unknown and not malformed_defs:
        lines.append("- None.")
    semantic_lines, semantic_data = semantic_symbol_surface(
        records,
        spans,
        config_symbols,
        linker_symbols,
        declaration_sources,
        compact_source_homes,
    )
    lines.extend(["", *semantic_lines])
    lines.extend(
        [
            "",
            "## Completion boundary",
            "",
            "This ledger proves exhaustive parsing and structural accounting only.",
            "The active restoration goal remains incomplete until every pending",
            "semantic state in the opcode table is validated against C/C++ source,",
            "all SLD line/block ownership is checked, and synthetic identifiers are",
            "eliminated or converted to evidenced semantic carriers.",
            "",
        ]
    )

    data = {
        "input": str(path),
        "record_count": len(records),
        "opcode_counts": dict(sorted(opcode_counts.items())),
        "kind_counts": dict(sorted(kind_counts.items())),
        "def_class_counts": dict(sorted(class_counts.items())),
        "unknown_records": [asdict(record) for record in unknown],
        "malformed_def_records": [asdict(record) for record in malformed_defs],
        "function_span_count": len(spans),
        "header_function_count": len(header_functions),
        "header_function_files": dict(sorted(by_header.items())),
        "function_errors": function_errors,
        "block_errors": block_errors,
        "max_block_depth": max_block_depth,
        "sld_stream_count": len(streams),
        "sld_event_count": sld_events,
        "sld_mapped_events": mapped_sld,
        "sld_unmapped_events": unmapped_sld,
        "sld_unmapped_by_file": dict(
            sorted(
                (source_file, count)
                for source_file, count in unmapped_by_file.items()
                if count
            )
        ),
        "sld_errors": sld_errors,
        "preamble": preamble,
        "semantic_symbol_surface": semantic_data,
    }
    return "\n".join(lines), data


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--sym", type=Path, default=DEFAULT_SYM)
    parser.add_argument("--symbols", type=Path, default=DEFAULT_SYMBOLS)
    parser.add_argument("--linker-aliases", type=Path, default=DEFAULT_LINKER_ALIASES)
    parser.add_argument(
        "--compact-source-homes",
        type=Path,
        default=DEFAULT_COMPACT_SOURCE_HOMES,
        help="reviewed compact-only symbol-to-source evidence manifest",
    )
    parser.add_argument(
        "--declaration-root",
        action="append",
        type=Path,
        dest="declaration_roots",
        help="root containing linker scripts or assembly labels (repeatable)",
    )
    parser.add_argument("--output", type=Path)
    parser.add_argument("--json", type=Path)
    parser.add_argument("--function")
    parser.add_argument("--va", type=lambda value: int(value, 0))
    args = parser.parse_args()

    records, preamble = parse_records(args.sym)
    if args.function:
        print(function_trace(records, args.function, args.va), end="")
        return
    config_symbols = parse_config_symbols(args.symbols)
    linker_symbols = parse_linker_symbols(args.linker_aliases)
    declaration_roots = tuple(args.declaration_roots or DEFAULT_DECLARATION_ROOTS)
    declaration_sources = parse_declaration_sources(declaration_roots)
    compact_source_homes = parse_compact_source_homes(args.compact_source_homes)
    report, data = make_report(
        args.sym,
        records,
        preamble,
        config_symbols,
        linker_symbols,
        declaration_sources,
        compact_source_homes,
    )
    if args.output:
        args.output.write_text(report.rstrip("\n") + "\n", encoding="utf-8")
    if args.json:
        args.json.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
