"""P875 follow-up public-header diagnostics; no production source writes.

Use the real legacy CPP/CC1PLPSX pipeline for typed references. Compare each
reference with independently reviewed native EXT/STAT records and the freshly
compiled defining object's global/local visibility. Private declarations are
removed from public APIs, not promoted to exports merely to satisfy a test.
"""
from pathlib import Path
import argparse
import json
import re
import subprocess
from p875_common_probe import ROOT, HERE, bld, OBJDUMP


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=["legacy", "fixed", "private"])
    parser.add_argument("units", nargs="*")
    args = parser.parse_args()
    rows = json.loads((HERE / "p875_common2_prototypes.json").read_text())
    native_lines = set(Path(r"C:/Temp/nfs4-clean/nfs4-f-v3.txt").read_text(
        encoding="utf-8", errors="replace").splitlines())
    for row in rows:
        native = row["native"]
        prefix = native["record"] + ": $" + native["va"]
        if not any(line.startswith(prefix)
                   and "class " + native["storage"] + " type FCN " in line
                   and line.endswith(" name " + row["symbol"])
                   and "type FCN " + native["type"] + " name " in line
                   for line in native_lines):
            raise ValueError("Native receipt changed: " + row["symbol"])
        if not set(row["parameter_records"]).issubset(native_lines):
            raise ValueError("Native parameter receipt changed: " + row["symbol"])
    units = args.units or list(dict.fromkeys(r["unit"] for r in rows))
    failures = 0
    for unit in units:
        selected = [r for r in rows if r["unit"] == unit]
        private = [r for r in selected if r["action"] == "remove_private"]
        if args.mode == "private":
            if not private:
                continue
            try:
                bld.compile_cpp(HERE / f"p875_common2_private_{unit}.cpp")
                good, error = False, "private name unexpectedly declared"
            except SystemExit as exc:
                error = str(exc)
                good = (all(r["name"] in error for r in private)
                        and ("undeclared" in error or "was not declared in this scope" in error))
            print(json.dumps({"unit": unit, "mode": args.mode,
                              "good": good, "diagnostic": error}, sort_keys=True))
            failures += not good
            continue
        try:
            obj = bld.compile_cpp(HERE / f"p875_common2_{args.mode}_{unit}.cpp")
        except SystemExit as exc:
            # These original full headers can fail even before linkage: stale
            # pseudo-free members collide with real included class declarations.
            # Record the actual failure; do not pretend references were emitted.
            error = str(exc)
            member_failure = (unit in ("anim", "mpause", "pausemenu")
                              and "redeclared as non-member function" in error)
            bool_failure = unit == "bworldsm" and "int BOOL(" in error
            if args.mode == "legacy" and (member_failure or bool_failure):
                print(json.dumps({"unit": unit, "mode": args.mode,
                                  "good": True, "reference_count": None,
                                  "original_header_compile_failure": error}, sort_keys=True))
                continue
            raise
        relocs = subprocess.run([OBJDUMP, "-r", str(obj)], check=True,
                                capture_output=True, text=True).stdout
        symbols = re.findall(r"R_MIPS_32\s+(\S+)", relocs)
        defining = ROOT / "build" / (selected[0]["source_path"] + ".o")
        symtab = subprocess.run([OBJDUMP, "-t", str(defining)], check=True,
                               capture_output=True, text=True).stdout
        visibility = {}
        for line in symtab.splitlines():
            if "*UND*" in line or not re.match(r"[0-9a-f]{8}\s", line):
                continue
            tokens = line.split()
            if len(tokens) > 2:
                visibility[tokens[-1]] = tokens[1]
        export_errors = [r["symbol"] for r in selected
                         if visibility.get(r["symbol"]) !=
                         ("l" if r["action"] == "remove_private" else "g")]
        expected = [r["symbol"] for r in selected if r["action"] == "correct"]
        if args.mode == "legacy":
            good = (len(symbols) == len(selected)
                    and all(symbol not in visibility for symbol in symbols))
        else:
            good = len(symbols) == len(expected) and set(symbols) == set(expected)
        good = good and not export_errors
        print(json.dumps({"unit": unit, "mode": args.mode,
                          "candidate_count": len(selected), "public_count": len(expected),
                          "reference_count": len(symbols), "good": good,
                          "visibility_errors": export_errors, "references": symbols}, sort_keys=True))
        failures += not good
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
