"""Source-only whole-Weather and exact debug-twin diagnostics for P878."""
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
os.environ["NFS4_SOURCE_ONLY"] = "1"
source = HERE / "weather.cpp"
functions = re.findall(r'/\* ---- (Weather_\S+)\s+\[', source.read_text())
assert len(functions) == 25
hook = "bld.OUT = bld.BUILD"
inject = "bld.PER_TU_FLAGS[cpp.relative_to(ROOT).as_posix()] = {'g_value': '8'}\n"
tool = (ROOT / "tools/verify_asm.py").read_text().replace(hook, inject + hook)
ns = {"__name__": "p878_weather_final", "__file__": str(ROOT / "tools/verify_asm.py")}
sys.argv = ["verify_asm.py", source.relative_to(ROOT).as_posix(), ",".join(functions)]
out, err = io.StringIO(), io.StringIO()
with redirect_stdout(out), redirect_stderr(err):
    try:
        exec(compile(tool, "p878_weather_final", "exec"), ns)
        rc = 0
    except SystemExit as exc:
        rc = exc.code
print(out.getvalue(), flush=True)
branches = (ROOT / "tools/brdist.py").read_text()
defs = branches[branches.index("def ours_branches"):branches.index("fns = sorted")]
bns = dict(g=ns, dis=ns["dis"], re=re, BR=re.compile(r'^\s*(b\w*|j)\b'))
exec(compile(defs, "p878_weather_branches", "exec"), bns)
bad = [fn for fn in functions if bns["ours_branches"](fn) != bns["oracle_branches"](fn)]
body = ns["obj"].read_bytes()
(HERE / "source_corrected.o").write_bytes(body)

debug_tool = (ROOT / "tools/diffsrc.py").read_text()
marker = 'exec(compile(_va_src, "verify_asm.py", "exec"), ns)'
assert debug_tool.count(marker) == 1
debug_tool = debug_tool.replace(marker,
    "_va_src = _va_src.replace(" + repr(hook) + ", " + repr(inject + hook) + ")\n" + marker)
sys.argv = ["diffsrc.py", source.relative_to(ROOT).as_posix(), "Weather_Init__Fv"]
dns = {"__name__": "p878_weather_debug", "__file__": str(ROOT / "tools/diffsrc.py")}
dout = io.StringIO()
with redirect_stdout(dout):
    exec(compile(debug_tool, "p878_weather_debug", "exec"), dns)
print(dout.getvalue(), flush=True)
report = {"passed": out.getvalue().count(": PASS"), "functions": len(functions),
          "returncode": rc, "stdout": out.getvalue(), "stderr": err.getvalue(),
          "branches": bad, "object_sha256": hashlib.sha256(body).hexdigest(),
          "equals_old_normal_mixed": body == (HERE / "normal_mixed.o").read_bytes(),
          "debug_exact": dns["exact"], "debug_stdout": dout.getvalue(),
          "sld": [{"index": i, "va": dns["vas"][i], "retail_line": dns["sld_line"](dns["vas"][i]),
                   "source_line": dns["idx2line"].get(i),
                   "source": dns["src_text"](dns["idx2line"].get(i))}
                  for i in range(len(dns["o"]))]}
(HERE / "source_corrected_results.json").write_text(json.dumps(report, indent=2) + "\n")
print(json.dumps({k: report[k] for k in ("passed", "functions", "branches",
                                       "object_sha256", "equals_old_normal_mixed", "debug_exact")}), flush=True)
