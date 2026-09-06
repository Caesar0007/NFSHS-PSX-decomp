"""Gate isolated Weather_Init source-shape probes without production changes."""
from pathlib import Path
import os
import sys

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "tools"))
os.environ["NFS4_SOURCE_ONLY"] = "1"
tool = (ROOT / "tools/verify_asm.py").read_text()
hook = "bld.OUT = bld.BUILD"
inject = "bld.PER_TU_FLAGS[cpp.relative_to(ROOT).as_posix()] = {'g_value': '8'}\n"
sys.argv = ["verify_asm.py", (HERE / "weather.cpp").relative_to(ROOT).as_posix(), "Weather_Init__Fv"]
ns = {"__name__": "p878_weather_shape", "__file__": str(ROOT / "tools/verify_asm.py")}
exec(compile(tool.replace(hook, inject + hook), "p878_weather_shape", "exec"), ns)
