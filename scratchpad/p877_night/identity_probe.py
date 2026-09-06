"""Isolated whole-TU Night compiler identity comparison (P877).

Production source, tool/configuration files and binary inputs are read-only.
One fixed scratch source path is reused so entire object hashes can be compared.
Only compiler inputs/diagnostic aliases change in memory. The legacy mixed lane
is a comparison baseline; candidate 2.8.1 uses the strict source-only policy.
"""
from pathlib import Path
from contextlib import redirect_stdout, redirect_stderr
import copy
import hashlib
import io
import json
import os
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools"))
import build as b

SOURCE = ROOT / "recon/game/psx/night.cpp"
ISOLATED = HERE / "night.cpp"
EXPECTED_281_SHA = "70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c"
EXPECTED_280_SHA = "61781c2f67b8486281720fdabb1fd7b549cce7f92918cb7b505db1fce54742b7"
COMPILER_281 = b._resolve_cc1plus_rung("2.8.1-sn")
assert COMPILER_281 and hashlib.sha256(COMPILER_281.read_bytes()).hexdigest() == EXPECTED_281_SHA
assert hashlib.sha256(b.CC1PL.read_bytes()).hexdigest() == EXPECTED_280_SHA
before_source_hash = hashlib.sha256(SOURCE.read_bytes()).hexdigest()

def semantic_source(text):
    # Only include paths differ to keep the copy outside production directories.
    return re.sub(r'^#include "[^"]*/(night_(?:types|externs)\.h)"$',
                  r'#include "\1"', text.replace("\r\n", "\n"), flags=re.M).strip()

assert semantic_source(SOURCE.read_text()) == semantic_source(ISOLATED.read_text())
functions = re.findall(r'/\* ---- (Night_\S+)\s+\[', SOURCE.read_text())
assert len(functions) == 19 and len(set(functions)) == 19
verifier = (ROOT / "tools/verify_asm.py").read_text()
hook = "bld.OUT = bld.BUILD"
assert verifier.count(hook) == 1
branch_tool = (ROOT / "tools/brdist.py").read_text()
branch_defs = branch_tool[branch_tool.index("def ours_branches"):
                          branch_tool.index("fns = sorted")]
old_obj = ROOT / "build/recon/game/psx/night.cpp.o"
old_object_hash = hashlib.sha256(old_obj.read_bytes()).hexdigest() if old_obj.exists() else None
results = []

for mode in ("normal_mixed", "strict_280", "strict_whole_281"):
    if mode == "normal_mixed":
        os.environ.pop("NFS4_SOURCE_ONLY", None)
    else:
        os.environ["NFS4_SOURCE_ONLY"] = "1"
    # Freeze the measured pre-P877 configuration. Production Night now selects
    # 2.8.1 for the entire TU; reading its live table here would silently turn
    # the historical mixed/default baselines into whole-2.8.1 tests.
    injected = "\n"
    injected += "_copy_rel = cpp.relative_to(ROOT).as_posix()\n"
    injected += "bld.PER_TU_FLAGS[_copy_rel] = {'g_value': '8'}\n"
    if mode == "normal_mixed":
        injected += ("bld.PER_FN_CC1PLUS_VER_SPLICE[_copy_rel] = "
                     "{'2.8.1-sn': {'Night_CreateNightTableElement__FiliPUc'}}\n")
    if mode == "strict_whole_281":
        injected += "bld.PER_TU_FLAGS[_copy_rel]['cc1plus_ver'] = '2.8.1-sn'\n"
    ns = {"__name__": "p877_night_verify", "__file__": str(ROOT / "tools/verify_asm.py")}
    sys.argv = ["verify_asm.py", ISOLATED.relative_to(ROOT).as_posix(), ",".join(functions)]
    output, errors = io.StringIO(), io.StringIO()
    with redirect_stdout(output), redirect_stderr(errors):
        try:
            exec(compile(verifier.replace(hook, injected + hook), "p877_night_verify", "exec"), ns)
            rc = 0
        except SystemExit as exc:
            rc = exc.code
    if "obj" not in ns:
        raise RuntimeError(output.getvalue() + errors.getvalue())
    branch_ns = dict(g=ns, dis=ns["dis"], re=re, BR=re.compile(r'^\s*(b\w*|j)\b'))
    exec(compile(branch_defs, "p877_night_branches", "exec"), branch_ns)
    branch_diffs = []
    for fn in functions:
        ours, oracle = branch_ns["ours_branches"](fn), branch_ns["oracle_branches"](fn)
        if ours != oracle:
            branch_diffs.append({"function": fn, "ours": ours, "oracle": oracle})
    object_bytes = ns["obj"].read_bytes()
    # Keep separate generated-artifact copies; never rewrite instructions.
    (HERE / (mode + ".o")).write_bytes(object_bytes)
    nm = subprocess.run([ns["OBJD"], "-t", str(ns["obj"])], capture_output=True,
                        text=True, check=True).stdout
    exports = {line.split()[-1] for line in nm.splitlines()
               if re.match(r'[0-9a-f]{8}\s+g\s', line) and "*UND*" not in line}
    row = {"mode": mode, "compiler": str(ns["bld"].cpp_compiler(ISOLATED)),
           "compiler_sha256": hashlib.sha256(ns["bld"].cpp_compiler(ISOLATED).read_bytes()).hexdigest(),
           "tu_flags": ns["bld"].per_tu_flags(ISOLATED),
           "source_only": mode != "normal_mixed", "returncode": rc,
           "stdout": output.getvalue(), "stderr": errors.getvalue(),
           "passed": output.getvalue().count(": PASS"), "functions": len(functions),
           "object_sha256": hashlib.sha256(object_bytes).hexdigest(),
           "missing_exports": sorted(set(functions) - exports), "branches": branch_diffs}
    results.append(row)
    print(mode, str(row["passed"]) + "/19 PASS", "branch residuals", len(branch_diffs), flush=True)
    print(row["stdout"], flush=True)

assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == before_source_hash
report = {"retail_281_compiler": str(COMPILER_281), "retail_281_sha256": EXPECTED_281_SHA,
          "production_source_sha256": before_source_hash,
          "existing_production_object_sha256": old_object_hash, "results": results,
          "whole_281_equals_normal_mixed": results[2]["object_sha256"] == results[0]["object_sha256"]}
(HERE / "identity_results.json").write_text(json.dumps(report, indent=2) + "\n")
print("whole_281_equals_normal_mixed", report["whole_281_equals_normal_mixed"], flush=True)
