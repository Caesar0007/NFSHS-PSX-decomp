"""Read-only evidence inventory for the bounded P875 common-header batch.

This is a pre-repair inventory, not an automatic rewrite authority. It prints
native EXT records and actual definition signatures for human review. Repaired
headers no longer appear; the reviewed snapshot is p875_common_prototypes.json.
Public headers are never edited by this diagnostic.
"""
from pathlib import Path
import re
import json

ROOT = Path(__file__).resolve().parents[2]
NATIVE = Path(r"C:/Temp/nfs4-clean/nfs4-f-v3.txt")
UNITS = ["audioclc", "audiocmn", "audiomus", "audiotrk", "clock",
         "fastrand", "mathnfs", "paths", "udff"]


def uncomment(text):
    token = re.compile(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|/\*.*?\*/|//[^\n]*', re.S)
    return token.sub(lambda m: " " if m[0].startswith(("/*", "//")) else m[0], text)


def records():
    native = {}
    native_lines = NATIVE.read_text(encoding="utf-8", errors="replace").splitlines()
    params = {}
    active = None
    for line in native_lines:
        m = re.match(r"(\w+): \$(\w+) (?:94|96) Def2? class EXT type FCN (.*?) name (\S+)$", line)
        if m:
            native[m[4]] = {"record": m[1], "va": m[2], "type": m[3]}
        m = re.match(r"\s+name = (\S+)$", line)
        if m:
            active = m[1]
            params[active] = []
        elif active and "90 Block start" in line:
            active = None
        elif active and re.search(r"class (?:REGPARM|ARG) ", line):
            params[active].append(line)
    rows = []
    for unit in UNITS:
        header = ROOT / "recon/game/common" / (unit + ".h")
        source = header.with_suffix(".cpp")
        text = uncomment(source.read_text(encoding="utf-8", errors="replace"))
        text = re.sub(r"^\s*#.*$", "", text, flags=re.M)
        for line in header.read_text(encoding="utf-8", errors="replace").splitlines():
            m = re.match(r"^\s*([\w:*& <>]+?)\s+([A-Za-z]\w*?)__F(\w*)\s*\(([^;{}]*)\)\s*;", line)
            if not m:
                continue
            ret, name, suffix, args = m.groups()
            symbol = name + "__F" + suffix
            defs = re.findall(r"(?:^|[;}])\s*([\w:*& <>\n]+?\b" + re.escape(name)
                              + r"\s*\([^;{}]*\))\s*\{", text, flags=re.M)
            defs = [re.sub(r"\s+", " ", s).strip() for s in defs]
            rows.append({"unit": unit, "symbol": symbol, "name": name,
                         "old_return": ret, "old_args": args,
                         "definition": defs, "native": native.get(symbol),
                         "parameter_records": params.get(symbol),
                         "line": line})
    return rows


if __name__ == "__main__":
    print(json.dumps(records(), indent=2))
