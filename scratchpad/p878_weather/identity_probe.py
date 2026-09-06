"""P878 isolated Weather whole-TU compiler/input-flag matrix.

No production source/configuration/tool is edited. The old normal lane is a
comparison baseline; candidates have every per-function intervention disabled
by the authoritative verifier's source-only policy. -fforce-addr is inserted
only into the diagnostic compiler invocation, never an assembly/object rewrite.
"""
from pathlib import Path
from contextlib import redirect_stdout, redirect_stderr
import hashlib
import io
import json
import os
import re
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools"))
import build as b
SOURCE = ROOT / "recon/game/psx/weather.cpp"
# Frozen pre-correction source. The winner stays in weather.cpp, and current
# production source is no longer the rejected matrix's historical input.
COPY = HERE / "baseline.cpp"
HASH_280 = "61781c2f67b8486281720fdabb1fd7b549cce7f92918cb7b505db1fce54742b7"
HASH_281 = "70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c"
assert hashlib.sha256(b.CC1PL.read_bytes()).hexdigest() == HASH_280
assert hashlib.sha256(b._resolve_cc1plus_rung("2.8.1-sn").read_bytes()).hexdigest() == HASH_281
source_hash = hashlib.sha256(SOURCE.read_bytes()).hexdigest()

def text_identity(s):
    return re.sub(r'^#include "[^"]*/(weather_(?:types|externs)\.h)"$',
                  r'#include "\1"', s, flags=re.M).strip()

baseline_hash = hashlib.sha256(COPY.read_bytes()).hexdigest()
functions = re.findall(r'/\* ---- (Weather_\S+)\s+\[', COPY.read_text())
assert len(functions) == len(set(functions)) == 25
tool = (ROOT / "tools/verify_asm.py").read_text()
hook = "bld.OUT = bld.BUILD"
assert tool.count(hook) == 1
branches = (ROOT / "tools/brdist.py").read_text()
branch_defs = branches[branches.index("def ours_branches"):branches.index("fns = sorted")]
results = []

for mode, rung, force in (("normal_mixed", None, False), ("strict_280", None, False),
                          ("strict_280_force", None, True), ("strict_281", "2.8.1-sn", False),
                          ("strict_281_force", "2.8.1-sn", True)):
    if mode == "normal_mixed":
        os.environ.pop("NFS4_SOURCE_ONLY", None)
    else:
        os.environ["NFS4_SOURCE_ONLY"] = "1"
    inject = "\n_p878_rel = cpp.relative_to(ROOT).as_posix()\n"
    inject += "bld.PER_TU_FLAGS[_p878_rel] = {'g_value': '8'}\n"
    if rung:
        inject += "bld.PER_TU_FLAGS[_p878_rel]['cc1plus_ver'] = '2.8.1-sn'\n"
    if mode == "normal_mixed":
        inject += "bld.PER_FN_FORCE_ADDR[_p878_rel] = {'Weather_Init__Fv'}\n"
    if force:
        inject += "_p878_run_original = bld.run\n"
        inject += "_p878_compiler = str(bld.cpp_compiler(cpp))\n"
        inject += ("def _p878_force_run(cmd, *args, **kwargs):\n"
                   "    if str(cmd[0]) == _p878_compiler and '-fforce-addr' not in cmd:\n"
                   "        cmd = [cmd[0], '-fforce-addr', *cmd[1:]]\n"
                   "    return _p878_run_original(cmd, *args, **kwargs)\n"
                   "bld.run = _p878_force_run\n")
    ns = {"__name__": "p878_weather_verify", "__file__": str(ROOT / "tools/verify_asm.py")}
    sys.argv = ["verify_asm.py", COPY.relative_to(ROOT).as_posix(), ",".join(functions)]
    stdout, stderr = io.StringIO(), io.StringIO()
    with redirect_stdout(stdout), redirect_stderr(stderr):
        try:
            exec(compile(tool.replace(hook, inject + hook), "p878_weather_verify", "exec"), ns)
            rc = 0
        except SystemExit as exc:
            rc = exc.code
    if "obj" not in ns:
        raise RuntimeError(stdout.getvalue() + stderr.getvalue())
    bns = dict(g=ns, dis=ns["dis"], re=re, BR=re.compile(r'^\s*(b\w*|j)\b'))
    exec(compile(branch_defs, "p878_weather_branches", "exec"), bns)
    deltas = []
    for fn in functions:
        ours, oracle = bns["ours_branches"](fn), bns["oracle_branches"](fn)
        if ours != oracle:
            deltas.append({"function": fn, "ours": ours, "oracle": oracle})
    data = ns["obj"].read_bytes()
    # Preserve original matrix objects used by final_probe.py's byte comparison.
    (HERE / ("rerun_" + mode + ".o")).write_bytes(data)
    row = {"mode": mode, "compiler": str(ns["bld"].cpp_compiler(COPY)),
           "compiler_sha256": hashlib.sha256(ns["bld"].cpp_compiler(COPY).read_bytes()).hexdigest(),
           "g_value": 8, "force_addr": force, "source_only": mode != "normal_mixed",
           "passed": stdout.getvalue().count(": PASS"), "functions": len(functions),
           "returncode": rc, "stdout": stdout.getvalue(), "stderr": stderr.getvalue(),
           "object_sha256": hashlib.sha256(data).hexdigest(), "branches": deltas}
    results.append(row)
    print(mode, str(row["passed"]) + "/25 PASS", "branch residuals", len(deltas), flush=True)
    print(row["stdout"], flush=True)

assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == source_hash
report = {"production_source_sha256": source_hash,
          "baseline_source_sha256": baseline_hash, "results": results,
          "identical_to_normal": [r["mode"] for r in results
                                  if r["object_sha256"] == results[0]["object_sha256"]]}
(HERE / "identity_results_rerun.json").write_text(json.dumps(report, indent=2) + "\n")
print("identical_to_normal", report["identical_to_normal"], flush=True)
