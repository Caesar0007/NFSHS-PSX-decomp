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

import os

ROOT = Path(__file__).resolve().parent.parent


def _env(name, default):
    return Path(os.environ.get(name, default))


# Tool locations — overridable via env so CI (or another machine) can point at
# its own copies; defaults are this dev box.
MIPS = _env("NFS4_MIPS_BIN", r"C:/Tools/mips-ps1/mips/bin")
CC1 = _env("NFS4_CC1", r"C:/Temp/psq43/COMPILER/CC1PSX.EXE")
CPP = _env("NFS4_CPP", MIPS / "mipsel-none-elf-cpp.exe")
AS = _env("NFS4_AS", MIPS / "mipsel-none-elf-as.exe")
LD = _env("NFS4_LD", MIPS / "mipsel-none-elf-ld.exe")
OBJCOPY = _env("NFS4_OBJCOPY", MIPS / "mipsel-none-elf-objcopy.exe")
MASPSX = _env("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py")
CC1PL = _env("NFS4_CC1PL", r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE")
PY = sys.executable
RECON = ROOT / "recon"   # vendored reconstruction modules (C++), self-contained types

TARGET = ROOT / "rom" / "nfs4-f.exe"
LDSCRIPT = ROOT / "linkers" / "nfs4.ld"
BUILD = ROOT / "build"
OUT = BUILD  # object output root; overridden by --out

# w23-a11 toolchain: opt-in jump-table $at-fusion peephole (default OFF).
# See maspsx's `fuse_jump_table_addressing` (maspsx-jtbl.patch) for the
# root-cause writeup: CC1PSX's casesi (switch-jump-table) lowering always
# manually expands the table-address computation into 5 explicit machine
# instructions using a normal GPR, never the assembler's symbol+register
# indexed-load macro -- so ASPSX 2.77's oracle (which used that macro, and
# so ends up in the compact 4-instruction $at form) can never be reached by
# maspsx/GNU-as's *existing* passthrough behavior. This flag re-fuses cc1's
# manual lowering back into the macro form maspsx already knows how to
# expand correctly.
#
# w24-a9: the retail binary's jtbl sites are MIXED -- 11 of 33 TUs carry the
# ASPSX $at macro form (older macro-emitting toolchain build of those
# particular objects), the other 22 already match our explicit 5-insn form.
# Enabling this GLOBALLY would fuse the jtbl shape in ALL 33 sites and
# regress the 22 that are already correct without it. NFS4_JTBL_AT_FUSION=1
# stays as a blunt global override for one-off testing/bisection, but the
# real gate is per-TU: see PER_TU_FLAGS below (the "jtbl_at_fusion" key),
# which scopes `--jtbl-at-fusion` to exactly the 11 TUs that need it.
JTBL_AT_FUSION = os.environ.get("NFS4_JTBL_AT_FUSION") == "1"

# --- w24-a9: per-TU build-flag overrides -----------------------------------
# Keyed by the source file's ROOT-relative POSIX path (forward slashes,
# matches `rel.as_posix()` regardless of host OS). Each value is a dict of
# flag-name -> truthy, consulted by compile_c/compile_cpp for exactly that
# translation unit. This is the general per-TU toolchain-identity mechanism
# (methodology §3.25 axis 3b/3d: different objects in the SAME retail image
# were built with different compiler/assembler flags) -- add new keys here
# as new per-TU levers are discovered/proven, do NOT grow more ad hoc global
# env vars.
#
# Recognised keys:
#   "jtbl_at_fusion"     -> pass --jtbl-at-fusion to maspsx for this TU only
#                           (see JTBL_AT_FUSION above).
#   "no_delayed_branch"  -> pass -fno-delayed-branch to cc1/cc1plus for this
#                           TU (methodology §3.25 axis 3b: PsyQ's syslib was
#                           built with gcc's delayed-branch filling OFF,
#                           aspsx filled slots itself). NOT yet proven safe
#                           at TU granularity -- see the w24-a9 prototype
#                           writeup in tools/build.py's git log; a TU with
#                           this key set may see a MIXED (some-better/
#                           some-worse) result, since leaf fns in the same
#                           TU can need gcc's own filling ON. Opt in per-TU
#                           only after verifying net-positive with
#                           verify_asm across the WHOLE TU's functions.
#
# The 11 TUs below own the retail binary's 11 ASPSX-$at-macro jtbl sites
# (w23-a11 investigation); the other 22 jtbl TUs are deliberately absent
# here (their explicit 5-insn form already matches and must stay untouched).
PER_TU_FLAGS = {
    "recon/game/common/audiocmn.cpp":       {"jtbl_at_fusion": True},  # AudioCmn_SoundCar
    "recon/syslib/psx/libcd/drv.cpp":       {"jtbl_at_fusion": True},  # CD_get_intr
    "recon/syslib/psx/libgpu/FONT.cpp":     {"jtbl_at_fusion": True},  # FntPrint
    "recon/game/common/aih_cop.cpp":        {"jtbl_at_fusion": True},  # HighExecute__10AIHigh_Cop
    "recon/game/common/aih_traf.cpp":       {"jtbl_at_fusion": True},  # HighExecute__14AIHigh_Traffic
    "recon/syslib/psx/libmcrd/LIBMCRD.cpp": {"jtbl_at_fusion": True},  # MemCardCmd_cb
    "recon/syslib/psx/libpad/PADENTRY.c":   {"jtbl_at_fusion": True},  # PadInfoAct
    "recon/game/common/r3dcar.cpp":         {"jtbl_at_fusion": True},  # R3DCar_InsertCarFacet
    "recon/game/common/replay.cpp":         {"jtbl_at_fusion": True},  # Replay_GetInterfaceKey
    "recon/game/psx/sfx.cpp":               {"jtbl_at_fusion": True},  # Sfx_BuildSouffleFacet
    "recon/syslib/psx/libc/SPRINTF.c":      {"jtbl_at_fusion": True},  # sprintf
    # "no_delayed_branch" PROTOTYPED on libetc/INTR.cpp (w24-a9 task 3) and
    # NOT enabled here: net +3 PASS (ResetCallback/InterruptCallback/
    # DMACallback/VSyncCallbacks 4->0 diffs each) but a genuine regression
    # (SetIntrMask PASS -> FAIL 3, a leaf fn that needs gcc's OWN
    # delay-slot filling ON) proves per-TU granularity is NOT sufficient for
    # this TU -- would need per-FUNCTION granularity (not yet built). See
    # the w24-a9 commit message for the full 12-fn before/after table.
}


def per_tu_flags(src: Path) -> dict:
    return PER_TU_FLAGS.get(src.relative_to(ROOT).as_posix(), {})

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
    tu_flags = per_tu_flags(src)
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

    cc1_flags = list(CC1_FLAGS)
    if tu_flags.get("no_delayed_branch"):
        cc1_flags.append("-fno-delayed-branch")
    r = run([CC1, *cc1_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1] {rel}\n{r.stdout}{r.stderr}")

    # maspsx reads cc1 .s on stdin; remaining args pass through to GNU as.
    maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}", "--expand-div",
                  "--run-assembler", f"--gnu-as-path={AS}",
                  *AS_ARCH, f"-G{G_VALUE}", "-I", ROOT / "include",
                  "-I", ROOT, "-o", obj]
    if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
        maspsx_cmd.append("--jtbl-at-fusion")
    r = subprocess.run([str(c) for c in maspsx_cmd],
                       input=s_file.read_text(), capture_output=True, text=True,
                       cwd=ROOT)
    if r.returncode or not obj.exists():
        sys.exit(f"[maspsx/as] {rel}\n{r.stdout}{r.stderr}")
    return obj


def compile_cpp(src: Path) -> Path:
    """Vendored reconstruction C++ TU -> ELF via CC1PLPSX. No -D__GNUC__ so
    nfs4_types.h uses its self-contained (PsyQ-free) type defs."""
    rel = src.relative_to(ROOT)
    tu_flags = per_tu_flags(src)
    obj = OUT / (str(rel) + ".o")
    obj.parent.mkdir(parents=True, exist_ok=True)
    i_file = obj.with_suffix(".i")
    s_file = obj.with_suffix(".s")
    # Preprocess in C mode (-x c) so the cpp driver uses cc1, not cc1plus
    # (the slim CI toolchain ships cc1 only). -D__cplusplus keeps the C++
    # branches of nfs4_types.h (e.g. no `bool` typedef) — verified byte-identical
    # to true cc1plus preprocessing. CC1PLPSX still compiles the result as C++.
    r = run([CPP, "-x", "c", "-D__cplusplus=1", "-nostdinc", "-undef",
             "-Dmips", "-D__mips__", "-D__psx__",
             f"-I{RECON}", src, "-o", i_file])
    if r.returncode:
        sys.exit(f"[cpp++] {rel}\n{r.stderr}")
    cc1pl_flags = ["-quiet", "-O2", f"-G{G_VALUE}"]
    if tu_flags.get("no_delayed_branch"):
        cc1pl_flags.append("-fno-delayed-branch")
    r = run([CC1PL, *cc1pl_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1pl] {rel}\n{r.stdout}{r.stderr}")
    maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}", "--expand-div",
                  "--run-assembler", f"--gnu-as-path={AS}",
                  *AS_ARCH, f"-G{G_VALUE}", "-I", RECON, "-o", obj]
    if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
        maspsx_cmd.append("--jtbl-at-fusion")
    # cfront dtor mangling: our CC1PL emits `_._<class>` (NO_DOLLAR_IN_LABEL -> '.'),
    # but EA's toolchain used the '.'->'_' convention (NO_DOT_IN_LABEL) => `___<class>`.
    # `_._` only ever appears as the dtor prefix, so this rename is surgical.
    s_text = s_file.read_text().replace("_._", "___")
    r = subprocess.run([str(c) for c in maspsx_cmd],
                       input=s_text, capture_output=True, text=True,
                       cwd=ROOT)
    if r.returncode or not obj.exists():
        sys.exit(f"[maspsx/as++] {rel}\n{r.stdout}{r.stderr}")
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

    # Tolerant build: a WIP decomp has hundreds of in-progress TUs; a single
    # compile/maspsx failure must NOT abort the whole objdiff/progress report.
    # Collect failures and keep going (verify_asm calls compile_cpp directly, so
    # its strict single-TU behaviour is unaffected). Set NFS4_STRICT=1 to abort.
    strict = os.environ.get("NFS4_STRICT") == "1"
    failures = []

    def _try(fn, src):
        try:
            fn(src)
        except SystemExit as e:
            if strict:
                raise
            msg = (str(e).strip().splitlines() or ["build error"])[-1][:120]
            failures.append((src.relative_to(ROOT), msg))
        except Exception as e:  # maspsx/as exceptions etc.
            if strict:
                raise
            failures.append((src.relative_to(ROOT), f"{type(e).__name__}: {str(e)[:100]}"))

    print("== compiling C TUs ==")
    for c in sorted((ROOT / "src").rglob("*.c")):
        _try(lambda s: compile_c(s, skip_asm), c)

    if RECON.exists():
        print("== compiling vendored reconstruction C++ TUs ==")
        for cpp in sorted(RECON.rglob("*.cpp")):
            _try(compile_cpp, cpp)
        # recon C TUs (modules the retail lib built with CC1PSX, e.g. eacpsxz unhuff.obj)
        for c in sorted(RECON.rglob("*.c")):
            _try(lambda s: compile_c(s, skip_asm), c)

    if failures:
        print(f"== {len(failures)} TU(s) FAILED to build (skipped; report covers the rest) ==")
        for rel, why in failures:
            print(f"   SKIP {rel}: {why}")

    if no_link:
        print("== objects only (no link) ==")
        return
    print("== linking ==")
    link_and_verify()


if __name__ == "__main__":
    main()
