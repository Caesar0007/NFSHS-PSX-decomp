"""Read-only prototype review inventory; not an automatic rename authority.

Find plain-looking GCC-v2 free-function names in public headers with a paired
C++ implementation. Explicit C-linkage headers require separate ABI review.
Literal include counts are a search aid, not a preprocessor dependency proof.
No compiler/binary/source/configuration is rewritten by this inventory.
"""

from collections import Counter
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[2]
SYM = Path(r"C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt")
OUT = Path(__file__).with_name("public_header_prototype_queue_p874_20260906.md")


def uncomment(text):
    # Keep strings/chars intact while removing comments; they can contain //.
    token = re.compile(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|/\*.*?\*/|//[^\n]*', re.S)
    return token.sub(lambda m: " " if m[0].startswith(("/*", "//")) else m[0], text)


def main(out=OUT, phase="P874", completion_note=None):
    # P875: allow a new dated snapshot without overwriting the P874 baseline.
    # The inventory scope and default invocation remain unchanged.
    native_ext = set(re.findall(
        r"Def(?:2)? class EXT type FCN .*? name (\S+)",
        SYM.read_text(encoding="utf-8", errors="replace")))
    files = sorted({p for tree in (ROOT / "recon", ROOT / "regiondiff/recon")
                    for p in tree.rglob("*") if p.suffix in (".h", ".cpp", ".c")})
    texts = {p: uncomment(p.read_text(encoding="utf-8", errors="replace")) for p in files}
    includes = Counter()
    for text in texts.values():
        for include in re.findall(r'^\s*#\s*include\s*[<"]([^">]+)[">]', text, re.M):
            includes[Path(include.replace("\\", "/")).name] += 1
    rows = []
    for header in sorted((ROOT / "recon").rglob("*.h")):
        source = header.with_suffix(".cpp")
        if source not in texts:
            continue
        header_text = texts[header]
        for line_no, line in enumerate(header.read_text(encoding="utf-8", errors="replace").splitlines(), 1):
            # Restrict to one-line prototype-shaped declarations. Multi-line,
            # member, operator and macro cases are deliberately outside scope.
            match = re.match(r"^\s*(?:extern\s+)?[\w:*& <>]+?\s+([A-Za-z]\w*?)__F(\w*)\s*\([^;{}]*\)\s*;", line)
            if not match:
                continue
            base, suffix = match.groups()
            symbol = base + "__F" + suffix
            if symbol not in header_text:
                continue
            paired = bool(re.search(r"\b" + re.escape(base) + r"\s*\([^;{}]*\)\s*\{", texts[source]))
            status = "REVIEW"
            if 'extern "C"' in header_text:
                status = "C-LINKAGE REVIEW"
            elif symbol in native_ext and paired:
                status = "NATIVE EXT + PAIRED DEFINITION"
            rows.append((header.relative_to(ROOT).as_posix(), line_no, symbol, base,
                         status, includes[header.name]))
    lines = [f"# {phase} public-header prototype review inventory", "",
             "This is an explicit remaining-work queue, not proof that every row can be renamed.",
             "The inventory covers one-line, free-function-shaped prototypes in headers with a",
             "paired .cpp. It does not validate full signatures, namespace/C-linkage context,",
             "macro expansion, overloads or all indirect include paths. Member ABI bridges and",
             "multi-line declarations need a separate pass. No source was changed by this scan.", "",
             f"Candidates: **{len(rows)}** across **{len({r[0] for r in rows})} headers**.", "",
             completion_note or (
                 "Completed separately: aiperson.h (8 prototypes, P872), audioeng.h and collide.h\n"
                 "(23 prototypes, P874). Isolated original-header probes emitted 23/23 double-mangled\n"
                 "references absent from the native map; corrected-header probes emitted all23 native\n"
                 "linkage symbols. Those completed prototypes no longer appear below."), "",
             "| Header:line | Encoded identifier | Source-name candidate | Evidence class | Literal include hits |",
             "| --- | --- | --- | --- | --- |"]
    for path, line, symbol, base, status, hits in rows:
        lines.append(f"| {path}:{line} | `{symbol}` | `{base}` | {status} | {hits} |")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"{len(rows)} candidates, {len({r[0] for r in rows})} headers")
    for status, count in sorted(Counter(r[4] for r in rows).items()):
        print(f"{status}: {count}")
    print(out)


if __name__ == "__main__":
    main()
