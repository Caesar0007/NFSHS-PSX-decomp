#!/usr/bin/env python3
"""Regenerate MATCH_PROGRESS.txt from a fresh objdiff report.

Usage (from repo root):
    python tools/update_match_progress.py                # build + report + rewrite
    python tools/update_match_progress.py --skip-build   # reuse existing build/ objects
    python tools/update_match_progress.py --report R.json  # reuse an existing report

Output format matches the historical file: header, TOTAL line, then one row per
tracked function -- VA (from configs/symbol_addrs.txt), objdiff fuzzy%, unit,
function -- sorted by VA (rows with no known VA go last, sorted by name).

objdiff-cli: the vendored tools/objdiff/objdiff-cli.exe, and ONLY it -- the
committed binary is the version pin (local runs, CI and decomp.dev all measure
with the same exe; no env/PATH override to silently drift versions).
NOTE: fuzzy% is the objdiff metric; tools/verify_asm.py remains the sole seal
authority (fuzzy 100.00 and gate PASS almost always agree, but re-gate to seal).

REQUIRED FILES NOT IN THIS GIT REPO (provide out-of-band; all env-overridable):
  * PsyQ CC1PSX / CC1PLPSX      -- copyrighted, cannot be committed. $NFS4_CC1 /
                                  $NFS4_CC1PL; CI unzips them from a private
                                  TOOLCHAIN_ZIP_URL secret (see report.yml).
  * mipsel-none-elf binutils   -- $NFS4_MIPS_BIN (cpp/as/ld/objcopy).
  * (optional lanes) CC1PSX272, gcc-ladder rungs -- absent => that lane's TUs
                                  fall back with a warning; build still green.
maspsx is NOT in this list: it is VENDORED at tools/maspsx/maspsx.py and used by
default, so a bare `build.py` here needs no out-of-repo maspsx.
"""
import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "MATCH_PROGRESS.txt"


def find_objdiff():
    # The ONLY resolver is the vendored copy: the committed binary is the
    # version pin, and an env-var/PATH override would silently reintroduce
    # the cross-version metric drift the vendoring exists to prevent.
    cand = ROOT / "tools" / "objdiff" / "objdiff-cli.exe"
    if cand.is_file():
        return str(cand)
    sys.exit("tools/objdiff/objdiff-cli.exe missing -- it is committed; "
             "restore it (git checkout tools/objdiff)")


def load_vas():
    vas = {}
    pat = re.compile(r"^\s*([A-Za-z_$][\w$.]*)\s*=\s*(0x[0-9A-Fa-f]+)\s*;")
    with open(ROOT / "configs" / "symbol_addrs.txt", encoding="utf-8",
              errors="replace") as f:
        for line in f:
            m = pat.match(line)
            if m:
                vas.setdefault(m.group(1), int(m.group(2), 16))
    return vas


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--skip-build", action="store_true",
                    help="reuse existing build/ objects")
    ap.add_argument("--report", help="reuse an existing objdiff report JSON")
    args = ap.parse_args()

    os.chdir(ROOT)

    if args.report:
        report_path = Path(args.report)
    else:
        if not args.skip_build:
            # build.py may exit non-zero at the final link stage; per-TU objects
            # (all objdiff needs) are still produced, so tolerate that.
            r = subprocess.run([sys.executable, "tools/build.py"],
                               capture_output=True, text=True)
            if r.returncode != 0 and "undefined reference" not in (r.stdout + r.stderr):
                sys.exit(f"build failed:\n{r.stdout[-2000:]}\n{r.stderr[-2000:]}")
        report_path = Path(tempfile.gettempdir()) / "nfs4_match_report.json"
        r = subprocess.run([find_objdiff(), "report", "generate",
                            "-o", str(report_path)],
                           capture_output=True, text=True)
        if r.returncode != 0:
            sys.exit(f"objdiff-cli failed:\n{r.stdout[-1500:]}\n{r.stderr[-1500:]}")

    rep = json.load(open(report_path, encoding="utf-8"))
    vas = load_vas()

    # RETIRED 2026-08-30: the SUPERSEDED phantom-row suppression list (7 rows,
    # 2026-08-10 user-flagged + W60 dedups).  Six entries went stale as the
    # canonical reworks aligned each unit's exports; the last
    # (aih_btcperp ___15AIHigh_BTC_Perp) was cured at OBJECT level by
    # VA-suffixing the labels inside ___15AIHigh_BTC_Perp_80061348.s -- the
    # phantom class must be fixed in the objects (decomp.dev runs raw objdiff
    # and can never see a report-side filter), never masked here.
    SUPERSEDED = set()

    rows, total, matched = [], 0, 0
    for unit in rep.get("units", []):
        uname = unit["name"].replace("\\", "/")
        for fn in unit.get("functions", []):
            name = fn["name"]
            if name.startswith(".L"):
                continue
            if (uname, name) in SUPERSEDED:
                continue
            fm = float(fn.get("fuzzy_match_percent", 0.0))
            total += 1
            if fm >= 100.0:
                matched += 1
            rows.append((vas.get(name), fm, uname, name))

    # VA ascending; unknown VAs last, sorted by unit then name
    rows.sort(key=lambda r: (r[0] is None, r[0] if r[0] is not None else 0,
                             r[2], r[3]))

    pct = 100.0 * matched / total if total else 0.0
    lines = [
        "NFS4-PSX matching-decomp -- per-function match progress",
        "(objdiff fuzzy_match_percent; VA from configs/symbol_addrs.txt)",
        f"TOTAL: {total} functions, {matched} at 100% ({pct:.1f}%)",
        "=" * 82,
        f"{'VA':<13} {'%match':>7}  {'unit':<24} function",
        "-" * 82,
    ]
    for va, fm, uname, name in rows:
        va_s = f"0x{va:08X}" if va is not None else "    -    "
        lines.append(f"{va_s:<13} {fm:>6.2f}%  {uname:<24} {name}")

    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    print(f"wrote {OUT.name}: {total} functions, {matched} at 100% ({pct:.1f}%)")


if __name__ == "__main__":
    main()
