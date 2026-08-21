"""Classify every header-attributed SYM function without mistaking linkage text
for a C++ identifier.

The SYM records GCC-v2 linkage names, while original source uses demangled
class/member spelling.  This audit joins each record to Ctags function records,
VA breadcrumbs/config symbols, and the extracted oracle file.  Comments and
string literals are stripped before checking whether a raw mangled name leaked
into source code.
"""

from __future__ import annotations

from collections import Counter, defaultdict
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
import audit_sym_source as audit


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt")


def strip_comments_and_strings(text: str) -> str:
    pattern = re.compile(
        r"//[^\n]*|/\*.*?\*/|\"(?:\\.|[^\"\\])*\"|'(?:\\.|[^'\\])*'",
        re.S,
    )
    return pattern.sub(lambda m: "\n" * m.group(0).count("\n"), text)


def config_by_va() -> dict[int, list[str]]:
    result: dict[int, list[str]] = defaultdict(list)
    pattern = re.compile(r"^([A-Za-z_.$][\w.$]*)\s*=\s*0x([0-9a-fA-F]+)")
    for line in (ROOT / "configs/symbol_addrs.txt").read_text(
        encoding="utf-8", errors="replace"
    ).splitlines():
        match = pattern.match(line.strip())
        if match:
            result[int(match.group(2), 16)].append(match.group(1))
    return result


def signature_findings(sym: audit.SymFunction, src: audit.SourceFunction) -> list[str]:
    findings: list[str] = []
    if not audit.compatible_return_types(sym.return_type, src.typeref):
        findings.append(
            f"return {sym.return_type or '?'} != {src.typeref or '?'}"
        )

    sym_params = [
        decl for decl in sym.decls
        if decl.cls in {"REGPARM", "ARG"}
        and decl.name != "this"
        # GCC's deleting-destructor control argument is an ABI parameter, not
        # a parameter written in the C++ destructor declaration.
        and not (sym.name.startswith("_._") and decl.name == "__in_chrg")
    ]
    src_params = [decl for decl in src.decls if decl.get("kind") == "parameter"]
    sym_by_name: dict[str, list[audit.Decl]] = defaultdict(list)
    src_by_name: dict[str, list[dict]] = defaultdict(list)
    for decl in sym_params:
        sym_by_name[decl.name].append(decl)
    for decl in src_params:
        src_by_name[decl.get("name", "")].append(decl)

    missing = sorted(set(sym_by_name) - set(src_by_name))
    if missing:
        findings.append("missing params " + ",".join(missing))
    # A source parameter can be absent from the debug local list when optimized
    # away.  GCC-v2's linkage spelling still carries its type, so source-only
    # parameters are not a contradiction by themselves.
    for name in sorted(set(sym_by_name) & set(src_by_name)):
        compatible, _reason = audit.compatible_decl_types(
            sym_by_name[name], src_by_name[name]
        )
        if not compatible:
            findings.append(
                f"param {name}: "
                + "/".join(row.display_type for row in sym_by_name[name])
                + " != "
                + "/".join(audit.source_record_type(row) for row in src_by_name[name])
            )
    return findings


def main() -> None:
    functions = [
        fn for fn in audit.parse_sym(SYM)
        if audit.source_basename(fn.source_file).endswith((".h", ".hpp"))
    ]
    paths = sorted(
        path
        for suffix in ("*.c", "*.cpp", "*.h", "*.hpp")
        for path in (ROOT / "recon").rglob(suffix)
    )
    source_text = {
        path: path.read_text(encoding="utf-8", errors="replace") for path in paths
    }
    code_text = {path: strip_comments_and_strings(text) for path, text in source_text.items()}
    # Windows CreateProcess has a short command-line limit.  Preserve the same
    # Ctags semantics while feeding the 800+ files in bounded batches.
    ctag_rows = []
    for start in range(0, len(paths), 80):
        ctag_rows.extend(audit.ctags_records(paths[start : start + 80]))
    source_functions, _ = audit.source_functions(ctag_rows)
    by_demangled: dict[tuple[str, str], list[audit.SourceFunction]] = defaultdict(list)
    for fn in source_functions:
        by_demangled[(fn.name, fn.scope)].append(fn)

    config = config_by_va()
    asm_files = list((ROOT / "asm").rglob("*.s"))
    oracle_by_name: dict[str, list[Path]] = defaultdict(list)
    for path in asm_files:
        oracle_by_name[path.stem].append(path)

    rows = []
    counts: Counter[str] = Counter()
    for fn in functions:
        simple, scope = audit.decode_member(fn.name)
        demangled = by_demangled.get((simple, scope), [])
        va_text = fn.va.lower().removeprefix("0x")
        va_hits = []
        raw_code_hits = []
        for path, text in source_text.items():
            for line_no, line in enumerate(text.splitlines(), 1):
                if va_text in line.lower():
                    va_hits.append((path.relative_to(ROOT), line_no))
        for path, text in code_text.items():
            token = re.compile(rf"(?<![A-Za-z0-9_.$]){re.escape(fn.name)}(?![A-Za-z0-9_.$])")
            for match in token.finditer(text):
                raw_code_hits.append((path.relative_to(ROOT), text.count("\n", 0, match.start()) + 1))

        va = int(fn.va, 16)
        config_names = config.get(va, [])
        oracles = oracle_by_name.get(fn.name, [])
        if not oracles:
            # Some explicit ABI carriers append the VA to avoid duplicate C
            # identifiers while keeping the same raw function address.
            oracles = [
                path for name, paths_for_name in oracle_by_name.items()
                if name.startswith(fn.name.replace("_._", "___"))
                for path in paths_for_name
            ]

        signature_issues = []
        if demangled:
            candidate_results = [signature_findings(fn, item) for item in demangled]
            if candidate_results and all(candidate_results):
                signature_issues = min(candidate_results, key=len)

        if raw_code_hits:
            status = "RAW_IDENTIFIER_IN_CODE"
        elif demangled:
            status = "DEMANGLED_SOURCE"
        elif va_hits:
            status = "VA_CARRIER"
        elif oracles and config_names:
            status = "COMPILER_GENERATED_NO_EXPLICIT_BODY"
        else:
            status = "UNRESOLVED"
        counts[status] += 1
        rows.append(
            (fn, simple, scope, status, demangled, va_hits, raw_code_hits,
             config_names, oracles, signature_issues)
        )

    print("# Header-attributed SYM function coverage")
    print()
    print(f"- Records: {len(functions)}")
    print(f"- Records with a config symbol at the exact VA: {sum(bool(row[7]) for row in rows)}")
    print(f"- Records with an extracted oracle: {sum(bool(row[8]) for row in rows)}")
    print(f"- Raw GCC-v2 identifiers used as code identifiers: {sum(bool(row[6]) for row in rows)}")
    print(f"- Demangled records with signature findings: {sum(bool(row[9]) for row in rows)}")
    for status in (
        "DEMANGLED_SOURCE",
        "VA_CARRIER",
        "COMPILER_GENERATED_NO_EXPLICIT_BODY",
        "RAW_IDENTIFIER_IN_CODE",
        "UNRESOLVED",
    ):
        print(f"- {status}: {counts[status]}")
    print()
    print("## Per-record ledger")
    print()
    for (fn, simple, scope, status, demangled, va_hits, raw_code_hits,
         config_names, oracles, signature_issues) in rows:
        source_desc = ", ".join(
            f"{item.path}:{item.line} {item.qualified}" for item in demangled
        ) or "none"
        va_desc = ", ".join(f"{path}:{line}" for path, line in va_hits) or "none"
        raw_desc = ", ".join(f"{path}:{line}" for path, line in raw_code_hits) or "none"
        oracle_desc = ", ".join(str(path.relative_to(ROOT)) for path in oracles) or "none"
        print(f"### `{fn.name}` @ {fn.va} -- {status}")
        print()
        print(f"- SYM owner: `{fn.source_file}:{fn.source_line}`")
        print(f"- Demangled identity: `{scope + '::' if scope else ''}{simple}`")
        print(f"- Source definitions: {source_desc}")
        print(f"- VA breadcrumbs/carriers: {va_desc}")
        print(f"- Config symbols: {', '.join(config_names) or 'none'}")
        print(f"- Oracle files: {oracle_desc}")
        print(f"- Raw identifier in code (comments/strings excluded): {raw_desc}")
        print(f"- Signature findings: {', '.join(signature_issues) or 'none'}")
        print()


if __name__ == "__main__":
    main()
