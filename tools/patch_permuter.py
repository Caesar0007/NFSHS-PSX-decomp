#!/usr/bin/env python3
"""Idempotently patch a local decomp-permuter clone for this project.

decomp-permuter vendors its own (PLY/yacc) pycparser in perm_pycparser/, and its
C grammar rejects a parameter list that is a lone `...`. EA's cfront
reconstruction relies on that form everywhere (variadic vtable dispatch casts
`(int (**)(...))`, PsyQ lib prototypes `int ClearImage(...);`), and the real
PsyQ C++ compiler requires it — so the permuter must learn to parse it.

This adds the `parameter_type_list : ELLIPSIS` production and rebuilds the yacc
tables. Run once after cloning decomp-permuter (or after it updates):

    python tools/patch_permuter.py            # uses $DECOMP_PERMUTER or C:/Temp/decomp-permuter

The compile.sh-on-Windows issue is handled at run time by tools/run_permuter.py.
"""
import os
import subprocess
import sys
from pathlib import Path

PERMUTER = Path(os.environ.get("DECOMP_PERMUTER", r"C:/Temp/decomp-permuter"))
GRAMMAR = PERMUTER / "perm_pycparser" / "c_parser.py"
COMPILER = PERMUTER / "src" / "compiler.py"

# Make `-j N` (parallel local workers) work on Windows: spawned workers re-import
# compiler.py but don't inherit the parent's compile.sh shim, so route compile.sh
# through the NFS4_COMPILE_DRIVER env var (set by run_permuter.py, inherited by
# children).
COMPILER_OLD = """        try:
            stderr = 2 if show_errors else subprocess.DEVNULL
            subprocess.check_call(
                [self.compile_cmd, c_name, "-o", o_name],
                stdout=stderr,"""
COMPILER_NEW = """        import json as _json, os as _os
        _drv = _os.environ.get("NFS4_COMPILE_DRIVER")
        if _drv and str(self.compile_cmd).endswith(".sh"):
            _cmd = _json.loads(_drv) + [c_name, "-o", o_name]
        else:
            _cmd = [self.compile_cmd, c_name, "-o", o_name]

        try:
            stderr = 2 if show_errors else subprocess.DEVNULL
            subprocess.check_call(
                _cmd,
                stdout=stderr,"""

OLD = '''    def p_parameter_type_list(self, p):
        """ parameter_type_list : parameter_list
                                | parameter_list COMMA ELLIPSIS
        """
        if len(p) > 2:'''

NEW = '''    def p_parameter_type_list(self, p):
        """ parameter_type_list : parameter_list
                                | parameter_list COMMA ELLIPSIS
                                | ELLIPSIS
        """
        # `| ELLIPSIS` accepts the cfront `(...)`-only prototype that EA's
        # reconstruction emits for vtable dispatch and PsyQ lib decls.
        if len(p) == 2 and not isinstance(p[1], c_ast.ParamList):
            p[0] = c_ast.ParamList(
                [c_ast.EllipsisParam(self._token_coord(p, 1))],
                self._token_coord(p, 1))
            return
        if len(p) > 2:'''


def main():
    if not GRAMMAR.is_file():
        sys.exit(f"perm_pycparser grammar not found at {GRAMMAR} "
                 f"(set $DECOMP_PERMUTER)")
    text = GRAMMAR.read_text()
    if "| ELLIPSIS\n" in text and "cfront `(...)`-only" in text:
        print("grammar already patched")
    elif OLD in text:
        GRAMMAR.write_text(text.replace(OLD, NEW))
        print(f"patched {GRAMMAR}")
    else:
        sys.exit("could not find p_parameter_type_list to patch "
                 "(grammar changed upstream?)")

    # Rebuild the yacc/lex tables so the new production takes effect. Deleting
    # yacctab.py forces PLY to regenerate from the edited grammar.
    pp = GRAMMAR.parent
    for stale in ("yacctab.py", "__pycache__"):
        p = pp / stale
        if p.is_file():
            p.unlink()
        elif p.is_dir():
            import shutil
            shutil.rmtree(p)
    r = subprocess.run([sys.executable, "_build_tables.py"], cwd=pp,
                       capture_output=True, text=True)
    if r.returncode:
        sys.exit(f"table rebuild failed:\n{r.stdout}{r.stderr}")
    print("rebuilt parse tables; perm_pycparser now accepts cfront (...)")

    # compiler.py: enable `-j N` parallel workers on Windows.
    ctext = COMPILER.read_text()
    if "NFS4_COMPILE_DRIVER" in ctext:
        print("compiler.py already patched")
    elif COMPILER_OLD in ctext:
        COMPILER.write_text(ctext.replace(COMPILER_OLD, COMPILER_NEW))
        print("patched compiler.py for -j parallel workers")
    else:
        print("WARN: could not patch compiler.py (changed upstream?) — "
              "-j parallel may not work, but -j1 still does")


if __name__ == "__main__":
    main()
