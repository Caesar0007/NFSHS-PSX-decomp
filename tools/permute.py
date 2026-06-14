#!/usr/bin/env python3
"""decomp-permuter glue for this project.

The permuter randomly mutates a near-matching C function and recompiles it
thousands of times, hunting for the byte-exact form. Ideal for the 90-99%
reconstruction near-misses (objdiff fuzzy_match_percent < 100).

Two subcommands:

  setup <recon_module.cpp> <symbol> <target.o>
        Creates permuter_work/<symbol>/ with base.c (the module, includes made
        -I-resolvable), compile.sh, settings.toml, and target.o. Then run:
            python C:/Temp/decomp-permuter/permuter.py permuter_work/<symbol>/ -j
        When it prints "found a match!", copy the matching function body back
        into the recon module and re-run the objdiff report.

  compile <args...>
        Compile wrapper invoked by compile.sh: parses the input .c and `-o out`
        from the permuter's argv and runs cpp(-x c -D__cplusplus) -> CC1PLPSX
        -> maspsx -> as, exactly like build.py's compile_cpp.
"""
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RECON = ROOT / "recon"
MIPS = Path(os.environ.get("NFS4_MIPS_BIN", r"C:/Tools/mips-ps1/mips/bin"))
CPP = MIPS / "mipsel-none-elf-cpp.exe"
AS = MIPS / "mipsel-none-elf-as.exe"
CC1PL = Path(os.environ.get("NFS4_CC1PL", r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE"))
MASPSX = Path(os.environ.get("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py"))


def do_compile(args):
    # permuter passes e.g.  -c <in.c> -o <out.o>  (plus PERMUTER defines)
    in_c = next(a for a in args if a.endswith(".c"))
    out_o = args[args.index("-o") + 1]
    i_file, s_file = out_o + ".i", out_o + ".s"
    subprocess.run([str(CPP), "-x", "c", "-D__cplusplus=1", "-DPERMUTER=1",
                    "-nostdinc", "-undef", "-Dmips", "-D__mips__", "-D__psx__",
                    f"-I{RECON}", in_c, "-o", i_file], check=True)
    subprocess.run([str(CC1PL), "-quiet", "-O2", "-G4", i_file, "-o", s_file], check=True)
    p = subprocess.run([sys.executable, str(MASPSX), "--aspsx-version=2.77",
                        "--run-assembler", f"--gnu-as-path={AS}", "-EL",
                        "-march=r3000", "-G4", "-I", str(RECON), "-o", out_o, s_file],
                       input="", text=True)
    sys.exit(p.returncode)


def do_setup(module, symbol, target_o):
    work = ROOT / "permuter_work" / symbol
    work.mkdir(parents=True, exist_ok=True)
    # base.c: the recon module with relative includes made -I<recon>-resolvable
    src = (RECON / module).read_text()
    src = src.replace('"../../nfs4_types.h"', '"nfs4_types.h"')
    src = src.replace('"aiinit_externs.h"', f'"{Path(module).parent.as_posix()}/aiinit_externs.h"')
    (work / "base.c").write_text(src)
    (work / "target.o").write_bytes((ROOT / target_o).read_bytes())
    (work / "compile.sh").write_text(
        "#!/bin/bash\n"
        f'"{sys.executable}" "{Path(__file__).as_posix()}" compile "$@"\n')
    (work / "settings.toml").write_text(
        f'func_name = "{symbol}"\ncompiler_type = "gcc"\n')
    print(f"created {work}")
    print(f"run: python C:/Temp/decomp-permuter/permuter.py {work.as_posix()} -j")


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    if sys.argv[1] == "compile":
        do_compile(sys.argv[2:])
    elif sys.argv[1] == "setup":
        do_setup(*sys.argv[2:5])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main()
