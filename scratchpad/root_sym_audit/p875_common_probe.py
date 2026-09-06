"""Compile P875 typed public-header references with the real legacy compiler.

This diagnostic only creates ordinary build artifacts for checked-in scratch
probes. It never rewrites production source, instructions, or expected symbols.
Legacy header copies demonstrate the former linkage defects. Fixed probes use
actual definition signatures as pointer types, so return drift is also checked.
"""
from pathlib import Path
import argparse
import importlib.util
import json
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools"))
spec = importlib.util.spec_from_file_location("p875_build", ROOT / "tools/build.py")
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=["legacy", "fixed"])
    parser.add_argument("units", nargs="*")
    args = parser.parse_args()
    rows = json.loads((HERE / "p875_common_prototypes.json").read_text())
    # Revalidate the reviewed expected-linkage/return receipts against native
    # input each run. The snapshot is evidence, not an alternative symbol oracle.
    native_lines = set(Path(r"C:/Temp/nfs4-clean/nfs4-f-v3.txt").read_text(
        encoding="utf-8", errors="replace").splitlines())
    for row in rows:
        native = row["native"]
        prefix = native["record"] + ": $" + native["va"]
        if not any(line.startswith(prefix) and "class EXT type FCN " in line
                   and line.endswith(" name " + row["symbol"])
                   and "type FCN " + native["type"] + " name " in line
                   for line in native_lines):
            raise ValueError("Native EXT receipt changed: " + row["symbol"])
        if not set(row["parameter_records"]).issubset(native_lines):
            raise ValueError("Native parameter receipt changed: " + row["symbol"])
    units = args.units or list(dict.fromkeys(r["unit"] for r in rows))
    failures = 0
    for unit in units:
        selected = [r for r in rows if r["unit"] == unit]
        source = HERE / f"p875_common_{args.mode}_{unit}.cpp"
        obj = bld.compile_cpp(source)
        relocs = subprocess.run([OBJDUMP, "-r", str(obj)], check=True,
                                capture_output=True, text=True).stdout
        symbols = re.findall(r"R_MIPS_32\s+(\S+)", relocs)
        expected = [r["symbol"] for r in selected]
        defining = ROOT / f"build/recon/game/common/{unit}.cpp.o"
        exports_text = subprocess.run([OBJDUMP, "-t", str(defining)], check=True,
                                      capture_output=True, text=True).stdout
        exports = {line.split()[-1] for line in exports_text.splitlines()
                   if "*UND*" not in line and re.match(r"[0-9a-f]{8}\s", line)}
        missing_exports = sorted(set(expected) - exports)
        if args.mode == "legacy":
            good = (len(symbols) == len(expected)
                    and all(symbol not in exports for symbol in symbols)
                    and not set(symbols).intersection(expected))
        else:
            good = len(symbols) == len(expected) and set(symbols) == set(expected)
        good = good and not missing_exports
        print(json.dumps({"unit": unit, "mode": args.mode,
                          "expected_count": len(expected), "reference_count": len(symbols),
                          "good": good, "missing_exports": missing_exports,
                          "references": symbols}, sort_keys=True))
        failures += not good
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
