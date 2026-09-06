"""P875 diagnostic only: compile typed public-header references with retail C++.

Uses the repository CPP/CC1PL/assembler paths.  No reconstructed source,
production tooling, compiler output, or object instructions are rewritten.
The extra original-header include directory lets verbatim .before.h snapshots
resolve their original relative includes without modifying the snapshots.
"""

import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
spec = importlib.util.spec_from_file_location("p875_build", ROOT / "tools/build.py")
bld = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bld)

source = Path(sys.argv[1]).resolve()
assert source.is_relative_to(Path(__file__).resolve().parent)
obj = bld.BUILD / source.relative_to(ROOT).with_suffix(".o")
obj.parent.mkdir(parents=True, exist_ok=True)
preprocessed = obj.with_suffix(".i")
assembly = obj.with_suffix(".s")
commands = [
    [bld.CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
     "-Dmips", "-D__mips__", "-D__psx__", f"-I{bld.RECON}",
     f"-I{ROOT / 'recon/game/common'}", source, "-o", preprocessed],
    [bld.CC1PL, "-quiet", "-O2", "-G4", preprocessed, "-o", assembly],
]
warnings = []
for command in commands:
    result = subprocess.run([str(x) for x in command], capture_output=True, text=True,
                            cwd=ROOT)
    warnings.extend(result.stderr.splitlines())
    if result.returncode:
        print(json.dumps({"source": str(source), "ok": False,
                          "stage": str(command[0]), "diagnostics": result.stderr}))
        sys.exit(1)

command = [bld.PY, bld.MASPSX, f"--aspsx-version={bld.ASPSX_VERSION}",
           "--expand-div", "--run-assembler", f"--gnu-as-path={bld.AS}",
           *bld.AS_ARCH, "-G4", "-I", bld.RECON, "-o", obj]
result = subprocess.run([str(x) for x in command], input=assembly.read_text(),
                        capture_output=True, text=True, cwd=ROOT)
if result.returncode:
    print(json.dumps({"source": str(source), "ok": False,
                      "stage": "assembler", "diagnostics": result.stderr}))
    sys.exit(1)
objdump = str(Path(bld.AS).with_name("mipsel-none-elf-objdump.exe"))
symbols = subprocess.run([objdump, "-t", str(obj)], capture_output=True,
                         text=True, check=True).stdout
undefined = sorted({line.split()[-1] for line in symbols.splitlines()
                    if "*UND*" in line})
relocs = subprocess.run([objdump, "-r", str(obj)], capture_output=True,
                        text=True, check=True).stdout
references = sorted({m[1] for m in re.finditer(r"R_MIPS_32\s+(\S+)", relocs)})
print(json.dumps({"source": str(source), "ok": True, "object": str(obj),
                  "object_sha256": hashlib.sha256(obj.read_bytes()).hexdigest(),
                  "undefined": undefined, "references": references,
                  "warnings": warnings}))
