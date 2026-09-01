"""Find canonical PsyQ 4.3 data-only members that are linked by NFS4."""

from __future__ import annotations

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/nfs4-clean/nfs4-f-v3.txt")
PSYQ = Path(r"C:/Temp/nfs4-clean/psyq43/extracted")
sys.path.insert(0, str(ROOT / "tools"))
import objtruth  # noqa: E402 -- the project parser for SN-LNK objects


def main() -> None:
    text = SYM.read_text(encoding="utf-8", errors="replace")
    linked = {
        (match.group(1).upper(), match.group(2).lower())
        for match in re.finditer(
            r"\\(lib[^\\(]+)\.lib\(([^)]+\.obj)\)", text, re.IGNORECASE
        )
    }
    rows = []
    parse_failures = []
    for path in PSYQ.rglob("*.obj"):
        key = (path.parents[1].name.upper(), path.name.lower())
        if key not in linked:
            continue
        try:
            obj = objtruth.parse_obj(path)
        except (Exception, SystemExit) as error:
            parse_failures.append((path, str(error)))
            continue
        section_sizes = {
            obj["sections"].get(index, str(index)): len(payload)
            for index, payload in obj["code"].items()
        }
        text_size = sum(
            size for name, size in section_sizes.items() if name.startswith(".text")
        )
        data_size = sum(
            size
            for name, size in section_sizes.items()
            if name in (".data", ".rdata", ".rodata", ".sdata")
        )
        bss_size = sum(symbol.get("bss", 0) for symbol in obj["xdefs"])
        if text_size == 0 and (data_size or bss_size):
            rows.append(
                (
                    key[0], path.name, data_size, bss_size,
                    [symbol["name"] for symbol in obj["xdefs"]],
                )
            )

    print("# Canonical PsyQ 4.3 data-only member intersection")
    print()
    print(f"- NFS4/PsyQ library-member intersections: {len(linked)}")
    print(f"- Canonical parse failures: {len(parse_failures)}")
    print(f"- Zero-text, nonzero-storage members: {len(rows)}")
    print()
    print("| library | member | initialized bytes | BSS bytes | exports |")
    print("|---|---|---:|---:|---|")
    for library, member, data_size, bss_size, exports in rows:
        print(
            f"| `{library}` | `{member}` | `0x{data_size:X}` | "
            f"`0x{bss_size:X}` | {', '.join(f'`{name}`' for name in exports)} |"
        )
    if parse_failures:
        print()
        print("## Parse failures")
        for path, error in parse_failures:
            print(f"- `{path}`: {error}")
    raise SystemExit(1 if parse_failures else 0)


if __name__ == "__main__":
    main()
