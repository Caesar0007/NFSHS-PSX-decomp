"""P878 isolated whole-TU compiler/flag probe; no production tooling writes.

Loads the authoritative verify_asm implementation, injects only pre-compilation
whole-TU options and the original include directory, and checks every oracle
function plus branch distances.  Function-output splices remain disabled.
"""
import difflib
import hashlib
import json
import os
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
candidate = Path(sys.argv[1]).resolve()
mode = sys.argv[2]
assert candidate.is_relative_to(Path(__file__).resolve().parent) or candidate == ROOT / "recon/game/common/audioclc.cpp"
assert mode in ("280", "280nt", "281", "281nt", "mixed")
os.environ["NFS4_SOURCE_ONLY"] = "0" if mode == "mixed" else "1"
sys.argv = ["verify_asm.py", candidate.relative_to(ROOT).as_posix(), "__none__"]
head = (ROOT / "tools/verify_asm.py").read_text().split("allpass=True")[0]
hook = '''
_base = ROOT / "recon/game/common/audioclc.cpp"
_flags = dict(bld.per_tu_flags(_base))
# Freeze this checkpoint's compiler inputs so these diagnostic cases remain
# reproducible after the parent retires the production per-function splice.
_flags.pop("no_thread_jumps", None)
_flags["g_value"] = "4"
if _mode.startswith("281"):
    _flags["cc1plus_ver"] = "2.8.1-sn"
else:
    _flags.pop("cc1plus_ver", None)
bld.PER_TU_FLAGS[cpp.relative_to(ROOT).as_posix()] = _flags
if _mode == "mixed":
    bld.PER_FN_NO_THREAD_JUMPS[cpp.relative_to(ROOT).as_posix()] = {
        "AudioClc_SoundPlayersCar__Fi"}
bld.OUT = bld.BUILD / "p878" / _mode
_original_run = bld.run
_compiler = bld.cpp_compiler(cpp)
_compiler_commands = []
def _whole_tu_run(command, *args, **kwargs):
    command = list(command)
    if str(command[0]) == str(bld.CPP):
        command.insert(1, "-I" + str(_base.parent))
    elif str(command[0]) == str(_compiler):
        if _mode.endswith("nt"):
            command.insert(1, "-fno-thread-jumps")
        _compiler_commands.append([str(x) for x in command])
    return _original_run(command, *args, **kwargs)
bld.run = _whole_tu_run
'''
head = head.replace("bld.OUT = bld.BUILD", hook)
g = {"__name__": "p878_verify", "__file__": str(ROOT / "tools/verify_asm.py"),
     "_mode": mode}
exec(compile(head, "p878_verify_head", "exec"), g)

# Reuse branch parsing from the authoritative branch-distance checker.
br_source = (ROOT / "tools/brdist.py").read_text()
br_defs = br_source[br_source.index("def ours_branches"):br_source.index("fns = sorted")]
br = {"g": g, "dis": g["dis"], "re": re, "BR": re.compile(r"^\s*(b\w*|j)\b")}
exec(compile(br_defs, "p878_branch_helpers", "exec"), br)
rows = []
for name in sorted(g["_name2addr"]):
    expected = g["oracle"](name)
    if not expected:
        continue
    actual = g["ours"](name)
    differences = [line for line in difflib.unified_diff(actual, expected, lineterm="")
                   if line.startswith(("+", "-")) and not line.startswith(("+++", "---"))]
    ob, eb = br["ours_branches"](name), br["oracle_branches"](name)
    branch_differences = []
    if eb is not None:
        if len(ob) != len(eb):
            branch_differences.append(["count", len(ob), len(eb)])
        else:
            branch_differences = [[i, x, y] for i, ((_, x), (_, y)) in enumerate(zip(ob, eb))
                                  if x is not None and y is not None and x != y]
    rows.append({"name": name, "diffs": len(differences),
                 "ours": len(actual), "retail": len(expected),
                 "branch_differences": branch_differences,
                 "first_differences": differences[:20]})
print(json.dumps({"candidate": str(candidate), "mode": mode,
                  "compiler": str(g["_compiler"]), "object": str(g["obj"]),
                  "tu_flags": g["_flags"], "global_G": g["bld"].G_VALUE,
                  "compiler_commands": g["_compiler_commands"],
                  "source_sha256": hashlib.sha256(candidate.read_bytes()).hexdigest(),
                  "pass": sum(r["diffs"] == 0 for r in rows), "total": len(rows),
                  "rows": rows}))
