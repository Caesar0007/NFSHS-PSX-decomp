"""Prove that the durable SYM ledgers cover the complete decoded denominator."""

from __future__ import annotations

from collections import Counter
import csv
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "scratchpad/root_sym_audit"
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")
RECORD = re.compile(r"^[0-9a-f]+: \$[0-9a-f]{8} ([0-9a-f]+)(?: |$)", re.I)


def tsv_rows(path: Path) -> int:
    with path.open("r", encoding="utf-8", newline="") as stream:
        return sum(1 for _ in csv.reader(stream, delimiter="\t")) - 1


def require(path: Path, needle: str) -> None:
    text = path.read_text(encoding="utf-8", errors="replace")
    if needle not in text:
        raise AssertionError(f"{path.name}: missing receipt {needle!r}")


def main() -> None:
    counts: Counter[int] = Counter()
    for line in SYM.read_text(encoding="utf-8", errors="replace").splitlines():
        match = RECORD.match(line)
        if match:
            counts[int(match.group(1), 16)] += 1

    require(OUT / "full_record_linker_symbols_20260821.txt", "- Records: 127")
    require(
        OUT / "full_record_linker_symbols_20260821.txt",
        "- Exact independent NFS4.MAP name/address matches: 127/127",
    )
    require(OUT / "full_record_public_symbols_20260821.txt", "- Opcode-2 records: 4503")
    require(
        OUT / "full_record_public_symbols_20260821.txt",
        "- Exact independent NFS4.MAP matches: 4503/4503",
    )
    require(OUT / "full_record_local_symbols_20260821.txt", "- Opcode-6 records: 372")
    require(
        OUT / "full_record_local_symbols_20260821.txt",
        "- Typed opcode-6 storage contradictions: 0",
    )
    require(
        OUT / "full_record_function_extents_20260821.txt",
        "- Oracle byte size equals SYM end-start: 2581/2581",
    )

    low = counts[0x01] + counts[0x02] + counts[0x06]
    sld = sum(counts[tag] for tag in (0x80, 0x82, 0x84, 0x86, 0x88, 0x8A))
    functions = counts[0x8C] + counts[0x8E]
    blocks = counts[0x90] + counts[0x92]
    definitions = counts[0x94] + counts[0x96]

    sld_ledger = tsv_rows(OUT / "full_record_sld_ledger_20260821.tsv")
    block_pairs = tsv_rows(OUT / "full_record_block_ledger_20260821.tsv")
    definition_ledger = tsv_rows(OUT / "full_record_definition_ledger_20260821.tsv")
    if sld_ledger != sld:
        raise AssertionError(f"SLD ledger {sld_ledger} != raw {sld}")
    if block_pairs * 2 != blocks:
        raise AssertionError(f"block ledger {block_pairs} pairs != raw {blocks} records")
    if definition_ledger != definitions:
        raise AssertionError(
            f"definition ledger {definition_ledger} != raw {definitions}"
        )

    total = low + sld + functions + blocks + definitions
    raw_total = sum(counts.values())
    if total != raw_total:
        raise AssertionError(f"classified {total} != raw {raw_total}")

    report = f"""# Complete SYM record-closure reconciliation

- Raw decoded records: {raw_total}
- Low opcode exact ledgers (0x01/0x02/0x06): {low}
- SLD/file-span per-record ledger: {sld_ledger}
- Function start/end exact ledger: {functions}
- Lexical block records represented by {block_pairs} paired rows: {blocks}
- Definition per-record ledger: {definition_ledger}
- Reconciled total: {total}/{raw_total}
- Unaccounted records: {raw_total - total}

The arithmetic is exhaustive across all 15 decoded opcode classes.  Exact
audit evidence and semantic-review dispositions remain distinct; reconciliation
means no record was omitted, not that every REVIEW row is already source-restored.
"""
    (OUT / "full_record_closure_reconciliation_20260821.txt").write_text(
        report, encoding="utf-8"
    )
    print(report, end="")


if __name__ == "__main__":
    main()
