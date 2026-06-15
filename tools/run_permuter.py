#!/usr/bin/env python3
"""Launch decomp-permuter on Windows for this project.

Two environment fix-ups are applied before handing control to the permuter:

  * compile.sh shim — the permuter hardcodes `compile.sh` as the compile command
    and runs it via CreateProcess, which cannot execute a shell script on
    Windows. We intercept those argv[0]==*.sh calls and re-route them to
    `python tools/permute.py compile ...` (what compile.sh would have done).

The other half of the fix — teaching the permuter's vendored pycparser to accept
cfront `(...)`-only prototypes — lives in tools/patch_permuter.py (a one-time
grammar edit + parse-table rebuild of C:/Temp/decomp-permuter/perm_pycparser),
because that parser is used out-of-process-safe and must persist on disk.

Usage:  python tools/run_permuter.py <permuter_work/<sym>/ dir> [permuter args...]
"""
import os
import subprocess
import sys
from pathlib import Path

PERMUTER_DIR = os.environ.get("DECOMP_PERMUTER", r"C:/Temp/decomp-permuter")
PERMUTE_PY = str(Path(__file__).resolve().parent / "permute.py")


def shim_compile_sh():
    """Make CreateProcess([*.sh, ...]) work on Windows by routing it through
    our own python compile driver."""
    _orig = subprocess.check_call

    def check_call(args, *a, **kw):
        if isinstance(args, (list, tuple)) and str(args[0]).endswith(".sh"):
            args = [sys.executable, PERMUTE_PY, "compile", *list(args)[1:]]
        return _orig(args, *a, **kw)

    subprocess.check_call = check_call


def main():
    shim_compile_sh()
    # Inherited by spawned -J workers (Windows spawn copies the environment);
    # the patched src/compiler.py routes compile.sh through this driver so
    # parallel jobs work too.
    import json
    os.environ["NFS4_COMPILE_DRIVER"] = json.dumps(
        [sys.executable, PERMUTE_PY, "compile"])
    sys.path.insert(0, PERMUTER_DIR)
    sys.argv = [os.path.join(PERMUTER_DIR, "permuter.py")] + sys.argv[1:]
    from src.main import main as permuter_main
    permuter_main()


if __name__ == "__main__":
    main()
