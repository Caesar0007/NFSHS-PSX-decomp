"""Prove preserved real class APIs after removing false non-member redeclarations.

No member/type definition is edited. Constructors are exercised by compile-only
new-expressions; destructors by explicit calls; ordinary members by typed member
pointers (with casts for overloads). None of these probes is executed or linked
into the game. Existing toolchain destructor symbol spelling is recognized.
"""
from pathlib import Path
import json
import re
import subprocess
from p875_common_probe import ROOT, HERE, bld, OBJDUMP

rows = json.loads((HERE / "p875_common2_member_declarations.json").read_text())
native_lines = set(Path(r"C:/Temp/nfs4-clean/nfs4-f-v3.txt").read_text(
    encoding="utf-8", errors="replace").splitlines())
for row in rows:
    n = row["native"]
    assert any(line.startswith(n["record"] + ": $" + n["va"])
               and line.endswith(" name " + row["raw_symbol"])
               and "class EXT type FCN " + n["type"] + " name " in line
               for line in native_lines), row["symbol"]
    assert set(row["parameter_records"]).issubset(native_lines), row["symbol"]

failures = 0
for unit in ("anim", "mpause", "pausemenu"):
    selected = [r for r in rows if r["unit"] == unit]
    expected = {r["symbol"] for r in selected}
    if unit == "mpause":
        # This existing explicit C ABI bridge is deliberately retained.
        expected.add("___14tPauseMenuDefs")
        assert any(line.startswith("2a0a4f: $8009e234")
                   and line.endswith("name _._14tPauseMenuDefs")
                   for line in native_lines)
    obj = bld.compile_cpp(HERE / f"p875_common2_members_{unit}.cpp")
    relocs = subprocess.run([OBJDUMP, "-r", str(obj)], check=True,
                            capture_output=True, text=True).stdout
    references = set(re.findall(r"R_MIPS_(?:32|26)\s+(\S+)", relocs))
    symtab = subprocess.run([OBJDUMP, "-t", str(ROOT /
        f"build/recon/game/common/{unit}.cpp.o")], check=True,
        capture_output=True, text=True).stdout
    exports = {line.split()[-1] for line in symtab.splitlines()
               if re.match(r"[0-9a-f]{8}\s+g\s", line) and "*UND*" not in line}
    # Scratch new-expressions also reference the compiler allocator and their
    # own .text/.data sections; only evidence-listed member APIs are claimed.
    missing_references = sorted(expected - references)
    missing_exports = sorted(expected - exports)
    good = not missing_references and not missing_exports
    failures += not good
    print(json.dumps({"unit": unit, "members": len(selected),
                      "checked_apis": len(expected), "good": good,
                      "missing_references": missing_references,
                      "missing_exports": missing_exports,
                      "extra_probe_references": sorted(references - expected)}, sort_keys=True))
raise SystemExit(1 if failures else 0)
