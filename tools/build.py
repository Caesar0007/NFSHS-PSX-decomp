#!/usr/bin/env python3
"""NFS4-PSX matching-decomp build driver.

Pipeline (matches the original PsyQ 4.3 toolchain byte-for-byte):

    src/*.c  --cpp-->  *.i  --CC1PSX(gcc2.8.0)-->  *.s
             --maspsx(aspsx 2.77)--> GNU as --> ELF .o
    asm/*.s  --GNU as--> ELF .o
    all .o   --GNU ld (linkers/nfs4.ld)--> nfs4.elf
             --objcopy--> nfs4.exe  (flat PS-EXE; compared to rom/nfs4-f.exe)

Usage:
    python tools/build.py            # full build + verify against original
    python tools/build.py --skip-asm # SKIP_ASM=1 (objdiff/decomp.me-style)
    python tools/build.py clean
"""
import hashlib
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MIPS = Path(r"C:/Tools/mips-ps1/mips/bin")
CC1 = Path(r"C:/Temp/psq43/COMPILER/CC1PSX.EXE")
CPP = MIPS / "mipsel-none-elf-cpp.exe"
AS = MIPS / "mipsel-none-elf-as.exe"
LD = MIPS / "mipsel-none-elf-ld.exe"
OBJCOPY = MIPS / "mipsel-none-elf-objcopy.exe"
MASPSX = Path(r"C:/Temp/maspsx-master/maspsx.py")
PY = sys.executable

TARGET = ROOT / "rom" / "nfs4-f.exe"
LDSCRIPT = ROOT / "linkers" / "nfs4.ld"
BUILD = ROOT / "build"
OUT = BUILD  # object output root; overridden by --out

ASPSX_VERSION = "2.77"
G_VALUE = "4"               # original built with -G4
AS_ARCH = ["-EL", "-march=r3000", "-mtune=r3000"]
CC1_FLAGS = ["-quiet", "-O2", f"-G{G_VALUE}", "-g1", "-mgpOPT", "-fgnu-linker"]
CPP_FLAGS = ["-nostdinc", "-undef", "-D__GNUC__=2", "-D__OPTIMIZE__",
             "-Dmips", "-D__mips__", "-D__psx__", "-DPSX",
             f"-I{ROOT / 'include'}"]


def run(cmd, **kw):
    r = subprocess.run([str(c) for c in cmd], capture_output=True, text=True, **kw)
    return r


def compile_c(src: Path, skip_asm: bool) -> Path:
    """cpp -> cc1 -> maspsx -> as => build/src/<rel>.c.o"""
    rel = src.relative_to(ROOT)
    obj = OUT / (str(rel) + ".o")
    obj.parent.mkdir(parents=True, exist_ok=True)
    i_file = obj.with_suffix(".i")
    s_file = obj.with_suffix(".s")

    cpp = [CPP, *CPP_FLAGS]
    if skip_asm:
        cpp.append("-DSKIP_ASM")
    cpp += [src, "-o", i_file]
    r = run(cpp)
    if r.returncode:
        sys.exit(f"[cpp] {rel}\n{r.stderr}")

    r = run([CC1, *CC1_FLAGS, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1] {rel}\n{r.stdout}{r.stderr}")

    # maspsx reads cc1 .s on stdin; remaining args pass through to GNU as.
    maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}",
                  "--run-assembler", f"--gnu-as-path={AS}",
                  *AS_ARCH, f"-G{G_VALUE}", "-I", ROOT / "include",
                  "-I", ROOT, "-o", obj]
    r = subprocess.run([str(c) for c in maspsx_cmd],
                       input=s_file.read_text(), capture_output=True, text=True,
                       cwd=ROOT)
    if r.returncode or not obj.exists():
        sys.exit(f"[maspsx/as] {rel}\n{r.stdout}{r.stderr}")
    return obj


def assemble_s(src: Path) -> Path:
    """GNU as on a splat-emitted data/header .s => build/<rel>.s.o"""
    rel = src.relative_to(ROOT)
    obj = OUT / (str(rel) + ".o")
    obj.parent.mkdir(parents=True, exist_ok=True)
    r = run([AS, *AS_ARCH, "-G0", "-I", ROOT / "include", "-I", ROOT,
             src, "-o", obj], cwd=ROOT)
    if r.returncode:
        sys.exit(f"[as] {rel}\n{r.stderr}")
    return obj


def link_and_verify():
    elf = BUILD / "nfs4.elf"
    out_exe = BUILD / "nfs4.exe"
    cmd = [LD]
    # splat's undefined_{syms,funcs}_auto.txt are `name = 0xADDR;` assignments
    # (valid ld script) for refs to addresses outside our segments (HW regs,
    # BIOS, overlay). Feed them so absolute relocations resolve.
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt"):
        p = ROOT / "linkers" / auto
        if p.exists():
            cmd += ["-T", p]
    cmd += ["-T", LDSCRIPT, "-Map", BUILD / "nfs4.map",
            "--no-check-sections", "-o", elf]
    r = run(cmd, cwd=ROOT)
    if r.returncode:
        sys.exit(f"[ld]\n{r.stderr}")
    # flatten loadable image to a raw PS-EXE body for comparison
    r = run([OBJCOPY, "-O", "binary", elf, out_exe])
    if r.returncode:
        sys.exit(f"[objcopy]\n{r.stderr}")

    built = out_exe.read_bytes()
    target = TARGET.read_bytes()
    got = hashlib.sha1(built).hexdigest()
    want = hashlib.sha1(target).hexdigest()
    print(f"\nbuilt : {out_exe.name}  {len(built)} bytes  sha1={got}")
    print(f"target: {TARGET.name}  {len(target)} bytes  sha1={want}")
    if got == want:
        print("MATCH (byte-identical)")
        return
    n = min(len(built), len(target))
    diffs = sum(1 for i in range(n) if built[i] != target[i])
    first = next((i for i in range(n) if built[i] != target[i]), -1)
    print(f"MISMATCH: {diffs}/{n} bytes differ ({100*(n-diffs)/n:.2f}% match); "
          f"first diff at 0x{first:X}; size delta {len(built)-len(target)}")


def clean():
    import shutil
    if BUILD.exists():
        shutil.rmtree(BUILD)
    print("cleaned build/")


def main():
    global OUT
    args = sys.argv[1:]
    if "clean" in args:
        clean(); return
    skip_asm = "--skip-asm" in args
    # objdiff base build can't link (all asm fns absent); also used to build
    # the `expected/` target objects (no link needed for objdiff either).
    no_link = "--no-link" in args or skip_asm
    if "--out" in args:
        OUT = ROOT / args[args.index("--out") + 1]
    OUT.mkdir(parents=True, exist_ok=True)
    print(f"== output -> {OUT.relative_to(ROOT)}  (skip_asm={skip_asm}) ==")

    print("== assembling data/header ==")
    for s in sorted((ROOT / "asm").glob("*.s")):
        assemble_s(s)
    for s in sorted((ROOT / "asm" / "data").glob("*.s")):
        assemble_s(s)

    print("== compiling C TUs ==")
    for c in sorted((ROOT / "src").rglob("*.c")):
        compile_c(c, skip_asm)

    if no_link:
        print("== objects only (no link) ==")
        return
    print("== linking ==")
    link_and_verify()


if __name__ == "__main__":
    main()
