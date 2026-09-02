"""Audit every object-member span retained by the trusted NFS4 SYM.

The 0x94 FILE records occur in start/end pairs.  A pair can delimit a full
debug object, an assembly object carrying only SLD line records, or a stripped
data-only object whose names survive only in the compact top-level 0x2/0x6
tables.  Therefore "no Function start" is not evidence that the object is
empty.  This census deliberately keeps opaque members unresolved until MAP,
CPE/raw-image, link-order, or canonical-library evidence assigns their data.

This is a read-only evidence tool.  It does not infer a C type from compact
records and it does not rewrite reconstructed source.
"""

from __future__ import annotations

import argparse
from collections import Counter
from dataclasses import dataclass, field
from pathlib import Path
import re


DEFAULT_SYM = Path(r"C:/Temp/nfs4-clean/nfs4-f-v3.txt")

RECORD = re.compile(
    r"^(?P<pos>[0-9a-f]+): \$(?P<value>[0-9a-f]{8}) "
    r"(?P<tag>[0-9a-f]+)(?: (?P<body>.*))?$",
    re.IGNORECASE,
)
FILE = re.compile(
    r"^Def class FILE type NULL size 0 name (?P<name>\S+)$", re.IGNORECASE
)
DEF = re.compile(
    r"^Def2? class (?P<class>EXT|STAT) type (?P<type>.+?) size "
    r"(?P<size>\d+).* name (?P<name>\S+)$",
    re.IGNORECASE,
)
DECL_CLASS = re.compile(r"^Def2? class (?P<class>\S+)", re.IGNORECASE)
TYPE_GRAPH_CLASSES = {
    "STRTAG",
    "UNTAG",
    "ENTAG",
    "TPDEF",
    "MOS",
    "MOU",
    "MOE",
    "FIELD",
    "EOS",
}


@dataclass
class ObjectSpan:
    name: str
    first_line: int
    last_line: int = 0
    records: int = 0
    functions: int = 0
    sld_spans: int = 0
    type_records: int = 0
    other_records: int = 0
    data_defs: list[tuple[str, str, str, int]] = field(default_factory=list)
    function_defs: list[tuple[str, str, str, int]] = field(default_factory=list)

    @property
    def kind(self) -> str:
        if self.functions:
            return "debug code"
        if self.function_defs:
            return "code without function-debug spans"
        if self.sld_spans and self.data_defs:
            return "SLD assembly plus typed data"
        if self.sld_spans:
            return "SLD assembly/line-only"
        if self.data_defs:
            return "typed data-only"
        if self.records and self.type_records == self.records:
            return "metadata-only type graph"
        return "opaque/compact-only candidate"


def parse_spans(path: Path) -> tuple[list[ObjectSpan], list[ObjectSpan]]:
    """Return completed FILE pairs and malformed/unpaired spans."""
    completed: list[ObjectSpan] = []
    incomplete: list[ObjectSpan] = []
    active: ObjectSpan | None = None

    for line_number, line in enumerate(
        path.read_text(encoding="utf-8", errors="replace").splitlines(), 1
    ):
        match = RECORD.match(line)
        if not match:
            continue
        tag = match.group("tag").lower()
        body = match.group("body") or ""

        file_match = FILE.match(body) if tag == "94" else None
        if file_match and ".obj" in file_match.group("name").lower():
            name = file_match.group("name")
            if active is None:
                active = ObjectSpan(name=name, first_line=line_number)
            elif active.name.lower() == name.lower():
                active.last_line = line_number
                completed.append(active)
                active = None
            else:
                # Retain a malformed/non-paired member rather than silently
                # attributing its records to the following object.
                active.last_line = line_number - 1
                incomplete.append(active)
                active = ObjectSpan(name=name, first_line=line_number)
            continue

        if active is None:
            continue
        active.records += 1
        if tag == "8c":
            active.functions += 1
            active.other_records += 1
        elif tag == "88":
            active.sld_spans += 1
            active.other_records += 1
        elif tag in ("94", "96"):
            class_match = DECL_CLASS.match(body)
            if class_match and class_match.group("class").upper() in TYPE_GRAPH_CLASSES:
                active.type_records += 1
            else:
                active.other_records += 1
            def_match = DEF.match(body)
            if not def_match:
                continue
            row = (
                def_match.group("class").upper(),
                def_match.group("type"),
                def_match.group("name"),
                int(match.group("value"), 16),
            )
            if def_match.group("type").split()[0] == "FCN":
                active.function_defs.append(row)
            else:
                active.data_defs.append(row)
        else:
            active.other_records += 1

    if active is not None:
        active.last_line = line_number
        incomplete.append(active)
    return completed, incomplete


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--sym", type=Path, default=DEFAULT_SYM)
    parser.add_argument(
        "--all", action="store_true", help="include objects containing functions"
    )
    args = parser.parse_args()

    spans, incomplete = parse_spans(args.sym)
    kinds = Counter(span.kind for span in spans)
    visible = spans if args.all else [span for span in spans if not span.functions]

    print("# Trusted NFS4 SYM object-member census")
    print()
    print(f"- Source: `{args.sym}`")
    print(f"- Completed `.obj` FILE pairs: {len(spans)}")
    print(f"- Unpaired/malformed members: {len(incomplete)}")
    print(f"- Members with no Function-start record: {sum(not s.functions for s in spans)}")
    for kind, count in sorted(kinds.items()):
        print(f"- {kind}: {count}")
    print()
    print("A function count of zero does not mean an empty object.  Typed data")
    print("definitions are direct ownership evidence.  SLD-only objects retain")
    print("assembly line information.  Metadata-only members contain a declaration")
    print("environment but no emitted program entity.  Opaque members require compact-symbol and")
    print("link/image evidence before their source ownership can be closed.")
    print()
    print("## Per-member ledger")
    print()
    for span in visible:
        print(
            f"- `{span.name}` (SYM lines {span.first_line}-{span.last_line}): "
            f"{span.kind}; functions {span.functions}; function defs "
            f"{len(span.function_defs)}; typed data {len(span.data_defs)}; "
            f"SLD spans {span.sld_spans}; type records {span.type_records}; "
            f"other records {span.other_records}; interior records {span.records}"
        )
        for cls, typ, name, va in span.data_defs:
            print(f"  - `0x{va:08x}` `{name}`: `{cls} {typ}`")

    if incomplete:
        print()
        print("## Unpaired/malformed backlog")
        print()
        for span in incomplete:
            print(
                f"- `{span.name}` starting at SYM line {span.first_line}; "
                f"stopped at {span.last_line}"
            )


if __name__ == "__main__":
    main()
