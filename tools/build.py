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
import re
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
# maspsx is VENDORED in-repo (tools/maspsx, MIT) -- the exact patched assembler
# stack the gate + CI use (li.d reg LUT + generalized .section parsing). Default
# to the tracked copy so a bare `build.py` (e.g. from update_match_progress.py)
# never depends on an out-of-repo maspsx; the old dev-box path is a last resort
# only if the vendored file is somehow absent.
def _resolve_maspsx():
    if os.environ.get("NFS4_MASPSX"):
        return Path(os.environ["NFS4_MASPSX"])
    vendored = ROOT / "tools" / "maspsx" / "maspsx.py"
    if vendored.is_file():
        return vendored
    return Path(r"C:/Temp/maspsx-master/maspsx.py")


MASPSX = _resolve_maspsx()
CC1PL = _env("NFS4_CC1PL", r"C:/Temp/psq43/COMPILER/CC1PLPSX.EXE")
# 04M (2026-08-04): PsyQ 4.0's CC1PSX = GNU C 2.7.2.SN32.3.7 -- the compiler
# Sony's PsyQ-4.3-era LIBRARY objects were actually built with (proven byte-
# level on libmath _err_math; triple-confirmed by sotn/sozud/psyz which all
# build Sony libs with gcc 2.6/2.7.2 at -G0).  Selected per-TU via the
# "cc1_272" PER_TU_FLAGS key; see _compile_c_272 for the lane.
# Resolution order (first that EXISTS wins):
#   1. env NFS4_CC1_272
#   2. CC1PSX272.EXE next to the resolved CC1 (so CI needs only one extra
#      file in the toolchain zip under toolchain/psyq/, no workflow change)
#   3. the dev-box PsyQ 4.0 install
# If NONE exists, the lane falls back to the normal 2.8 pipeline with a
# warning (objects still build; the lane TUs just report their 2.8 numbers).
def _resolve_cc1_272():
    cands = []
    if os.environ.get("NFS4_CC1_272"):
        cands.append(Path(os.environ["NFS4_CC1_272"]))
    cands.append(Path(CC1).parent / "CC1PSX272.EXE")
    cands.append(Path(r"C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE"))
    for c in cands:
        if c.is_file():
            return c
    return None


CC1_272 = _resolve_cc1_272()
_warned_272 = False

# W52: the FULL gcc ladder (fork C:/Temp/windows-gcc-psx; rungs 2.6.0, 2.6.3,
# 2.7.2-970404, 2.7.2, 2.8.0, 2.8.1, 2.91.66, 2.95.2) as a generic lane.
# PER_TU key `cc1_alt: "<ver>"` routes the TU through the SAME recipe as
# _compile_c_272 (macro-emitting cc1 + direct GNU as reorder mode, no maspsx)
# but with the named rung's cc1.exe.  Env NFS4_FORCE_CC1_ALT=<ver> overrides
# the lane for EVERY C TU compiled in the process -- PROBE-ONLY (single-TU
# verify_asm A/B runs); NEVER set it for a tree build.  Probe winners get
# wired as PER_TU `cc1_alt` entries by the orchestrator.  The sibling probe
# NFS4_FORCE_CC1_VER=<ver> swaps only cc1 and retains the normal maspsx route.
GCC_LADDER = Path(_env("NFS4_GCC_LADDER", r"C:/Temp/windows-gcc-psx"))


# Special compiler identities: the FntFlush-only gcc 2.8.1 build with reload_cse
# disabled, and Sony's retail PsyQ 4.4/4.5 gcc 2.8.1 SN32 C compiler.  PE
# timestamp/checksum bytes vary across deterministic norcse relinks, so validate
# that build's normalized code identity as well as accepting its byte hash.
CC1_NORCSE_SHA256 = "acd92abb94aa9379889521ea5dfa6bc7e22ae66f5e0bf70d7131e11a4f899668"
CC1_NORCSE_SEMANTIC_SHA256 = "558a47c2197a27be9b1d36c1d2b7b53713e09dc0c93698281696973c3cdac591"
CC1_281_SN_SHA256 = "26eb8259fa3e077d1980eb1e0c942006752135953dd03173200bf99ef6f5b6c9"
CC1_SPECIAL_RUNGS = {
    # "2.8.1-norcse" REMOVED (user ruling 2026-08-31): a self-built,
    # source-patched cc1 is not a retail compiler and is banned; the rung's
    # one customer (FntFlush) now stands at its FAIL 6 vendor-identity
    # certificate on FONT.c's own lane.  The hash pins above are kept as the
    # historical record of the binary the certificate was derived with.
    "2.8.1-sn": [
        Path(_env("NFS4_CC1_281_SN", r"C:/Temp/psq44/pssn/bin/CC1PSX.EXE")),
        Path(r"C:/Temp/psq45/BIN/CC1PSX.EXE"),
    ],
}


def _pe_semantic_sha256(candidate: Path) -> str:
    """Hash PE code identity while ignoring linker timestamp/checksum noise."""
    data = bytearray(candidate.read_bytes())
    if len(data) < 0x40:
        return ""
    pe = int.from_bytes(data[0x3c:0x40], "little")
    if pe + 0x5c > len(data) or data[pe:pe + 4] != b"PE\0\0":
        return ""
    data[pe + 8:pe + 12] = b"\0" * 4
    data[pe + 0x58:pe + 0x5c] = b"\0" * 4
    return hashlib.sha256(data).hexdigest()


def _cc1_alt_hash_ok(ver: str, candidate: Path) -> bool:
    if ver == "2.8.1-sn":
        return hashlib.sha256(candidate.read_bytes()).hexdigest() == CC1_281_SN_SHA256
    if ver != "2.8.1-norcse":
        return True
    if hashlib.sha256(candidate.read_bytes()).hexdigest() == CC1_NORCSE_SHA256:
        return True
    return _pe_semantic_sha256(candidate) == CC1_NORCSE_SEMANTIC_SHA256


def _resolve_cc1_alt(ver: str):
    for c in CC1_SPECIAL_RUNGS.get(ver, []):
        if c.is_file() and _cc1_alt_hash_ok(ver, c):
            return c
    # Resolution order: env/dev-box ladder, then the CI toolchain zip's
    # toolchain/gcc-ladder/ tree beside psyq/ (same pattern as CC1PSX272.EXE).
    for base in (GCC_LADDER, Path(CC1).parent.parent / "gcc-ladder"):
        c = base / f"gcc-{ver}-psx" / "cc1.exe"
        if c.is_file() and _cc1_alt_hash_ok(ver, c):
            return c
    return None


_warned_alt = set()


def _warn_alt_fallback(rel, ver, fallback):
    if ver in _warned_alt:
        return
    _warned_alt.add(ver)
    print(f"WARNING: gcc ladder rung {ver!r} not found (env NFS4_GCC_LADDER / "
          f"{GCC_LADDER} / toolchain gcc-ladder) -- {rel} and any other TU "
          f"wired to it fall back to {fallback} this run; match numbers for "
          f"those TUs will drift low until the rung is installed",
          file=sys.stderr)
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
# w24-a9: the retail binary's jtbl sites are MIXED -- 7 of 33 TUs carry the
# ASPSX $at macro form (older macro-emitting toolchain build of those
# particular objects), the other 22 already match our explicit 5-insn form.
# Enabling this GLOBALLY would fuse the jtbl shape in ALL 33 sites and
# regress the 22 that are already correct without it. NFS4_JTBL_AT_FUSION=1
# stays as a blunt global override for one-off testing/bisection, but the
# real gate is per-TU: see PER_TU_FLAGS below (the "jtbl_at_fusion" key),
# which scopes `--jtbl-at-fusion` to exactly the 7 TUs that need it.
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
#   "g_value"            -> override the global -G threshold for this TU.
#   "cc1_272"            -> 04M lane: compile with PsyQ 4.0's CC1PSX (gcc
#                           2.7.2.SN32) + DIRECT GNU as in reorder mode (no
#                           maspsx) -- the proven toolchain of Sony's library
#                           objects.  g_value defaults to "0" in this lane.
#                           See _compile_c_272.
#   "aspsx_277"          -> inside the cc1_272 lane, assemble the compiler's
#                           raw output with ASPSX 2.77 semantics (via maspsx)
#                           instead of GNU as reorder mode.  This is an
#                           assembler-version identity, not a post-compiler
#                           instruction edit.  Use only where real ASPSX 2.77
#                           has been checked against the retail object.
#   "jtbl_at_fusion"     -> pass --jtbl-at-fusion to maspsx for this TU only
#   "nop_before_label"   -> pass --nop-before-label to maspsx for this TU
#                           only (inserted load-delay nop BEFORE a following
#                           label = retail/aspsx placement; closes FntPrint's
#                           class-d word. PER-TU ONLY: breaks fememcard/fescreen).
#                           (see JTBL_AT_FUSION above).
#   "no_split_addresses" -> pass -mno-split-addresses to cc1/cc1plus for this
#                           TU (w33-a10; methodology §3.25 axis 3b -- per-obj
#                           toolchain identity). CC1PSX's DEFAULT is
#                           -msplit-addresses: gcc lowers EVERY absolute
#                           address itself into an explicit `lui %hi` /
#                           `addiu %lo` pair, and then CSE/loop-invariant
#                           motion hoists the resulting base register out of
#                           loops -- burning an extra callee-saved register
#                           and folding sibling globals against one another.
#                           With split-addresses OFF, gcc emits the ASSEMBLER
#                           pseudo-ops instead: `la $r,sym` (unfused
#                           lui+addiu) and, crucially, the symbol+register
#                           INDEXED form `lbu $2,sym($3)`, which maspsx /
#                           GNU-as expand to retail's compact
#                           `lui $at; addu $at,$at,$idx; lbu %lo(sym)($at)`
#                           macro. That is the SAME ASPSX-$at-macro identity
#                           the `jtbl_at_fusion` maspsx peephole reproduces
#                           for switch dispatches -- but taken at its true
#                           source (the compiler), so it also covers ordinary
#                           array/struct indexing and the "rematerialized
#                           address" shape previously mis-attributed to an
#                           unknown older cc1 snapshot.
#                           Enable per-TU only after a WHOLE-TU verify_asm
#                           sweep: an object that retail DID build with split
#                           addresses will regress under this flag.
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
#   "no_schedule_insns"  -> pass -fno-schedule-insns to cc1 (sched1 OFF) for
#                           this TU (w34-a4; methodology §3.25 axis 3d, the
#                           "per-obj OPTIMIZATION-FLAG identity" already
#                           recorded for the EACPSXZ numeric objs). Sched1 is
#                           the pre-reload scheduler; with it off, cc1 leaves
#                           the load-delay gaps and serial single-scratch
#                           reload chains that the retail eacpsxz objects on
#                           the "unscheduled" side of the split show.
#                           ⚠️ STRICTLY per-object -- the SAME flag makes the
#                           sibling eacpsxz objs much WORSE (w33-a5 controls:
#                           vramfxya 68->152, setfont 12->23, transmult
#                           31->37, unrefpack 17->29), so it must never be
#                           enabled globally. NOT ENABLED below (same
#                           precedent as "no_delayed_branch"): the one TU it
#                           helps, recon/eaclib/psx/eacpsxz/movf.c, gains a
#                           large diff drop but LOSES instruction parity, so
#                           it fails the w34 keep-rule as written:
#                              movf.c / movfxya   default      149 diffs, 222/221 insns
#                                                 +this flag    88 diffs, 225/221 insns
#                           (the +4 is the CSE-hoisted `li 255` pseudo, its
#                           caller-save spill/reload, and one arg-reg copy;
#                           the flag DOES fix the {shape,yPos,vc} rotation's
#                           shape half -- shape lands on retail's $s6.)
#                           ADOPTED for movf.c 2026-07-26 (w34 follow-up):
#                           with 6 source levers on top (see movf.c header)
#                           movfxya reaches PASS 221/221 byte-exact.
#   "no_schedule_insns2" -> pass -fno-schedule-insns2 (sched2 OFF).  Key
#                           exists for A/B experiments; NO TU uses it --
#                           measured on movf.c: both schedulers off = 105
#                           diffs/236 insns (retail NEEDS sched2 ON).
#   "no_builtin"          -> pass -fno-builtin to cc1/cc1plus for an object
#                           whose retail code calls a libc routine that this
#                           compiler otherwise expands inline. Whole-TU
#                           verification is mandatory before adoption.
#   "force_addr"          -> pass -fforce-addr to cc1 for a C object.  This
#                           is a compiler-input identity, not an assembly
#                           rewrite; adopt only after a whole-TU gate.
#
# The 7 TUs below own the retail binary's 7 ASPSX-$at-macro jtbl sites
# (w23-a11 investigation plus later per-site corrections); the other 26 jtbl TUs are deliberately absent
# here (their explicit 5-insn form already matches and must stay untouched).
PER_TU_FLAGS = {
    # 2026-08-26 FontUpsideDownBlit source/SYM seal: the reconstructed stock
    # packet-macro lifetime shape is byte-exact on this TU's -G0 lane.  Fresh
    # whole-TU gprobe on origin/main: default -G4 = 23/25 PASS, 115 diffs;
    # -G0 = 24/25 PASS, 3 diffs, with no PASS regression.  Font becomes exact
    # 82/82; the remaining 3 belong to pre-existing DrawGouraudShape.
    "recon/frontend/psx/psxfront.cpp":     {"g_value": "0"},
    # w59-a13 (orchestrator-wired): memmove FAIL 2 -> PASS 27/27 with NO source
    # change on the 2.7.2-970404 rung (full ladder: 970404 PASS, 2.8.x 2, 2.6.x 22,
    # 2.9x 25).  Same rung as the libmath vendor cluster -- libc.lib looks Sony-prebuilt.
    # Refutes the in-source "genuine floor at 2" receipt.
    "recon/syslib/psx/libc/MEMMOVE.c":      {"cc1_alt": "2.7.2-970404"},
    # w59-a13 (orchestrator-wired, COUPLED with the BSEARCH.c body landed in the same
    # commit): 26 -> 4 @48/48.  Source alone regresses the 2.8 lane to 40; wiring
    # alone gives 24.  (_compile_c_272 supports no_schedule_insns since w51.)
    "recon/syslib/psx/libc/BSEARCH.c":      {"cc1_272": True, "no_schedule_insns": True},
    # 2026-08-04G -G8 PROBE QUEUE (w47-a7 census S7, 20 objects gated inline):
    # these 7 TUs meet the a8 wiring bar -- net diff improvement + ZERO PASS
    # regressions + reproduced 2x -- under g_value 8 (= CC1PSX's DEFAULT when a
    # makefile passes no -G at all, per w47-a10 H2).  Whole-TU gate deltas:
    #   copspeak  24->27 PASS, 28->0 diffs (TU SEALED: RadioStaticInit/Active/Squelch)
    #   audioeng   5->7  PASS, 62->50    (AudioEng_Pause + AudioEng_CleanUp)
    #   input      4->6  PASS, 69->39    (Input_StartUp + Input_WingCommandMode)
    #   hudpmx     21->5 diffs           nfs3 128->119   r3dcar 186->183   weather 106->104
    # NOT wired from the same queue -- gate evidence AGAINST -G8 (PASS regressions):
    # replay (+158 diffs, 4 regr), simqueue (1 conv/1 regr),
    # draww (1 conv/2 regr); G5/G6/G7 ladder identical to G4 on all three mixed TUs
    # (the sensitive symbols are exactly 8 bytes -- their oracles MIX gp-rel and
    # absolute 8-byte refs, so no single -G value fits).  INERT (no gate delta, left
    # at default): aih_play, dashhud, mpause, hrzsku, overlays,
    # psxcontroller, textureprocess.  Receipts: scratch/w47_a7_census.md S7.
    # w63-a19: -G IDENTITY TELLS from the data-ownership sweep (E5): 8-byte
    # sdata objects only reachable at -G8 ("aiwther" literal; mpause short[4]
    # pair = 2 of the W62 sec-3.2 wrong-section symbols). Gated 2x post-wire.
    "recon/game/common/aispeeds.cpp":       {"g_value": "8"},
    "recon/game/common/mpause.cpp":         {"g_value": "8"},
    "recon/game/common/bworld.cpp":         {"g_value": "8"},  # w67-a4: probe-proven 20/21 x2, .sdata byte-exact retail
    # W72-A12 (probe-proven on a scratchpad build.py copy, TU 7/8 -> 8/8, x2):
    # the mips_check_split small-data gate -- `output` is exactly 8 bytes, so
    # at -G8 its symbol keeps SYMBOL_REF_FLAG (no split, plain la self-temp)
    # while the huge inputQueue splits, reproducing retail's MIXED pair.
    # Whole-TU -mno-split-addresses falsified hard (32 @48, TU 2/8).
    "recon/game/common/simqueue.cpp":       {"g_value": "8"},
    "recon/game/common/audioeng.cpp":       {"g_value": "8"},
    "recon/game/common/copspeak.cpp":       {"g_value": "8"},
    "recon/game/common/input.cpp":          {"g_value": "8"},
    "recon/game/common/hudpmx.cpp":         {"g_value": "8"},
    "recon/game/common/nfs3.cpp":           {"g_value": "8"},
    # 2026-08-20 SYM restoration: render.obj owns `RECT gPauseMenuRect` (8 bytes),
    # not four independent shorts.  Under -G4 the honest object is not gp-eligible
    # and Render_Render regresses 28 diffs; -G8 restores the retail gp-relative
    # field accesses and PASS 80/80.  RPause's separate scalar symbol views remain
    # zero-storage aliases and RPause_CopyBackToFrontBuffer remains PASS 48/48.
    "recon/game/common/render.cpp":          {"g_value": "8"},
    # 2026-08-28 source-only re-ladder after the current SYM/SLD reconstruction:
    # the historical -G8 regression is gone.  Three independent discriminators
    # (AudioCmn_Init, CheckState and SoundCar) become exact together, and the
    # whole TU gates 48/48 PASS twice with 399/399 strict branch words clean.
    # This is the authentic object compiler identity, not a per-function seal.
    "recon/game/common/audiocmn.cpp":        {"g_value": "8"},
    "recon/game/psx/weather.cpp":           {"g_value": "8"},
    # (r3dcar's g_value 8 lives on its existing jtbl_at_fusion entry below --
    # PER_TU_FLAGS is a dict literal, a duplicate key would silently discard
    # the earlier entry.)
    # screencontroller.obj addresses its three 4-byte flare-state objects with
    # full %hi/%lo sequences in retail, proving they were outside small data.
    # Whole-TU gate: DrawController 886->805, SetActuators 29->19,
    # SetCurrentController 331->329, Initialize 4->PASS; no regressions.
    "recon/frontend/common/screencontroller.cpp": {"g_value": "0"},
    # hud.obj has the same exact -G8 threshold signature as cars/genericpmx/cario
    # (w39-a1, cross-checked with a9's night/sfx finding): hud.cpp OWNS the 8-byte
    # arrays Hud_gHudView[2]/Hud_gMapView[2]/Hud_gTacView[2] (@0x8013D950/58/60) and
    # the retail code reaches ALL THREE with %gp_rel on the BASE symbol (plus the
    # per-element D_8013D954/D_8013D95C/D_8013D964 for [1]) -- impossible under -G4,
    # where an 8-byte object falls out of .sbss.  Receipts: whole-TU gate over all 63
    # hud oracles, 36 -> 38 PASS, ZERO regressions; every other delta an improvement
    # (ParseTime 10->PASS, WingmanFlash 10->PASS, RenderMapView 16->4, RenderTacView
    # 77->51, Init 640->612, RenderHudView 99->88, Render 157->153, BustedOverlayOn
    # 39->37, NextPlayerNameOrCarOrTime 59->57).
    "recon/game/psx/hud.cpp":               {"g_value": "8"},
    # cars.obj's retail .sdata layout contains the 8-byte "p%s.dat" literal
    # between rearLimit and Cars_gNumCars, proving this object used -G8.
    "recon/game/common/cars.cpp":           {"g_value": "8"},
    # genericpmx.obj likewise has the exact -G8 threshold signature: the
    # retail code uses gp-relative relocations for its 8-byte pointer arrays
    # (gShadowPixmap/gSkidMarkPixmap/gSMokePixmap/gGravelPixmap), while the
    # 12-byte gWeatherPixmap remains full-addressed.
    "recon/game/common/genericpmx.cpp":      {"g_value": "8"},
    # cario.obj shows the same exact -G8 threshold signature (w38-a4): the
    # 8-byte pointer arrays CarIO_Plate1/CarIO_Plate2 are reached with
    # %gp_rel (incl. per-element D_8013D74C/D_8013D754 for [1]) while every
    # cario symbol LARGER than 8 bytes -- carVRamAdd/carVRamOffset (12),
    # carVRamSlotsMenu (24), licenseSFX_Vram (48), carVRamSlots (72),
    # licensePlate (264) -- stays full-addressed %hi/%lo.  Under -G4 the
    # 8-byte arrays fall out of .sbss and we emit lui/addiu instead.
    "recon/game/psx/cario.cpp":             {"g_value": "8"},
    # device.obj carries the SAME -G8 signature (w39-a5, coordinator lead):
    # the Device_StartUp/Device_Update oracles reach the 8-byte arrays
    # Device_gPrev[2] / Device_gToggleTime[2] via %gp_rel(BASE) plus the
    # per-element %gp_rel(D_8013D788)/%gp_rel(D_8013D790) -- impossible under
    # -G4 -- while every device symbol LARGER than 8 (Input_gResults,
    # mappings, Device_gDeviceList, gPadinfo, frontEnd) stays %hi/%lo.
    "recon/game/psx/device.cpp":            {"g_value": "8"},
    # force.obj: third -G8 object, same exact <=8/>8 threshold signature
    # (w39-a7).  Retail small-data region 0x8013D8xx holds EXACTLY the force
    # symbols of size <= 8: Force_gActAlign[6] @0x8013D840, Force_gOffAlign[6]
    # @0x8013D848, Force_gTick (u_short) @0x8013D84E (the one symbol the
    # oracle reaches with %gp_rel), Force_gVblHandle (4).  Every force symbol
    # LARGER than 8 bytes lives in the ordinary data/bss region 0x8011Fxxx --
    # Force_rand_256[256] @0x8011FC60, Force_g[2] (16) @0x8011FD60.  Under -G4
    # the two 6-byte align arrays fall out of .sdata, which makes cc1plus
    # SPLIT their address itself (lui %hi/addiu %lo) and then CSE-hoist the
    # shared base into a callee-saved register across the two PadSetActAlign
    # calls; retail rematerializes it per call.  With -G8 cc1plus emits the
    # `la` macro form instead and the hoist disappears.
    # Receipts (whole TU, -G4 -> -G8): Force_Disable 17 -> PASS,
    # Force_Vbl 46 -> 40, Force_Update 326 -> 326, Force_IsForceOn 14 -> 14,
    # HitSign/HitWall/Pause/StartUp/UnPause PASS -> PASS.  Zero regressions.
    "recon/game/psx/force.cpp":             {"g_value": "8"},
    # sfx.obj is a -G8 object too (w39-a9).  Its oracle has NO %gp_rel at all, so the
    # usual gp-rel discriminator is silent here -- the tell is the ADDRESS-MATERIALIZATION
    # FORM instead.  Under -G4 an 8-byte extern (`gSMokePixmap[2]`, `gGravelPixmap[2]`) is
    # above the threshold, so cc1plus lowers `&sym` ITSELF into a schedulable
    # `lui %hi / addiu %lo` pair -- and then hoists the `lui` into a branch delay slot the
    # retail code leaves as `nop`.  Under -G8 the same symbol is small-data-eligible, so
    # cc1plus emits the single ASSEMBLER MACRO `la $3,gSMokePixmap`, which is unschedulable
    # (catalog: "a scalar extern global is a DELAY-SLOT POISON PILL") and which GNU-as
    # expands to the IDENTICAL absolute lui/addiu pair -- same bytes, retail's schedule.
    # The threshold is exact: the 8-byte arrays flip, the 4-byte scalars (gSMokePalette,
    # gDirtPalette, ...) were already macro-form under both.  No %gp_rel appears in the
    # object either way (the symbols are undefined here), so this cannot introduce a
    # wrong gp-relative access.  Receipts: Sfx_BuildSmokeFacet 3 -> PASS,
    # Sfx_BuildSouffleFacet 422 -> 399, other 5 fns unchanged (4 already PASS).
    "recon/game/psx/sfx.cpp":               {"g_value": "8"},
    # night.obj is a -G8 object, PROVEN by the gp-rel discriminator (w39-a9): the retail
    # oracle reaches TWO night-OWNED 8-BYTE objects with a one-instruction %gp_rel --
    #   Night_GenerateAllLightTables:  lbu $v0,%gp_rel(Night_gPlayerHeadLightColor)($gp)
    #                                  (long[2] @0x8013da80, 8 bytes)
    #   Night_InitWeatherTables:       sw  $v1,%gp_rel(Night_gWeatherColor)($gp)
    #                                  (long[2] @0x8013da88, 8 bytes)
    # -- which is IMPOSSIBLE under -G4 (an 8-byte object never lands in .sdata/.sbss).
    # Every night-owned object LARGER than 8 bytes stays full-addressed %hi/%lo
    # (Night_gCopCountryLightTbl 20B, Night_gAdditiveHeadlightColor 64B,
    # Night_gLightningPauseAreas 128B), so the threshold is exactly 8.  (The 4-byte
    # %hi-only symbols -- Chunk_lightTable, Chunk_numLight, Weather_gType -- are owned by
    # OTHER objects, which is the normal ownership rule of methodology 3.12 #6, not a
    # counterexample.)  Secondary effect, same as sfx.cpp above: over-threshold globals get
    # cc1plus's pre-split schedulable `lui %hi/addiu %lo`, at-or-under-threshold ones get
    # the unschedulable `la sym` assembler macro that matches retail's scheduling.
    # Receipts (whole TU re-gated, 19 fns): Night_InitPlayerHeadLightColor 10 -> PASS,
    # Night_SetPlayerHeadLightColor 10 -> PASS (both previously certified "GENUINE FLOOR"),
    # Night_GenerateAllLightTables 118 -> 114, all other 16 fns unchanged.
    "recon/game/psx/night.cpp":             {"g_value": "8"},
    # audiocmn.cpp does NOT want jtbl_at_fusion: SoundCar's retail switch uses
    # the explicit five-instruction table-base form. Removing the stale override
    # takes detailed SoundCar 176 -> 169 (526 -> 527 instructions) while the
    # whole 48-function TU gate remains 33 PASS / 6 near / 9 far.
    # w52-a1 dup-key fix: drv.c's jtbl_at_fusion entry here was silently
    # discarded by the cc1_272 entry below (later key wins) AND is inert in
    # the 272 lane (no maspsx) -- removed rather than merged.
    "recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True,   # FntPrint
                                             "nop_before_label": True,  # w66-a2: brdist (10,8,9)->0
                                             "no_split_addresses": True},  # w48-a2: -34
    # w51-a3: libcd lane verdicts (measured per-TU; cdread.c = NO, 169->289):
    "recon/syslib/psx/libcd/cdread2.c":     {"cc1_272": True},  # 5->0, 2/2 PASS
    "recon/syslib/psx/libcd/cdcont.c":      {"cc1_272": True},  # 77->19, +5 conv, CdReset PASS->3
    "recon/syslib/psx/libcd/toc.c":         {"cc1_272": True},  # 76->64, CdGetToc->PASS
    "recon/syslib/psx/libcd/TYPE.c":        {"cc1_272": True},  # 8->6, CdGetDiskType->PASS
    # w51-a7 lane wins (all zero-PASS-regression, whole-TU gated):
    "recon/syslib/psx/libapi/COUNTER.c":    {"cc1_272": True},  # 3/3 PASS
    # W78-A14 coupled cell (landed w81, user-authorized, with the ported source):
    # setIntrDMA needs 2.8-era reorg thread-steal (three addu tail copies) +
    # W82-A9 (Option B): the TU rides its own 2.7-family identity again; only
    # setIntrDMA needs the 970404 rung (2.8-lineage reorg thread-steal with the
    # TEXT epilogue that keeps `j .L` -- make_return_insns never runs) and -G32
    # to reach the split-address switch the rejected -mno-split-addresses flag
    # couldn't (mips_check_split honours SYMBOL_REF_FLAG; dma_cb[8] = 32 bytes).
    # Replaces the W78-A14 whole-TU 2.8.0+nosplit flip and its three sibling
    # 2.7.2 splice rows.  4/4 PASS x2: startIntrDMA 19, _dma_isr 96,
    # setIntrDMA 43, _bzero_w 9.  Receipt: scratchpad/w82/A9_receipt.md.
    "recon/syslib/psx/libetc/INTR_DMA.c":   {"cc1_272": True},
    "recon/syslib/psx/libetc/INTR_VB.c":    {"cc1_272": True},  # 4/4 PASS
    "recon/syslib/psx/libetc/VSYNC.c":      {"cc1_272": True},  # 2/2 PASS
    "recon/syslib/psx/libetc/VMODE.c":      {"cc1_272": True},  # 2/2 PASS
    # Canonical PsyQ 4.3 INDEX.tsv proves InitCARD/StartCARD/StopCARD are one
    # INIT.obj.  All three are byte-exact in this 2.7.2 lane.  Pre-change tool
    # backup: Git commit 279b1f52.
    "recon/syslib/psx/libcard/INIT.c":      {"cc1_272": True},  # 3/3 PASS
    # w51-a7: COUPLED with the LIBPRESS.c source (MDEC_status fence removed --
    # 2.8-only device); without this entry LIBPRESS loses 1 PASS.
    "recon/syslib/psx/libpress/LIBPRESS.c": {"cc1_272": True},  # 6->11/12 PASS
    # w51-a8 lane wins:
    "recon/syslib/psx/libc/MEMCMP.c":       {"cc1_272": True},  # 6 -> PASS 19/19
    "recon/syslib/psx/libc/QSORT.c":        {"cc1_272": True, "no_strength_reduce": True},  # 70 -> PASS 84/84
    "recon/syslib/psx/libsn/READ.c":        {"cc1_272": True, "aspsx_277": True},
    "recon/syslib/psx/libsn/WRITE.c":       {"cc1_272": True, "aspsx_277": True},
    # w51-a5: WAITRC2 lane win (setRC2wait 3->PASS 8/8, AT-MACRO-SPLIT class;
    # chkRC2wait unchanged; zero regressions). PADCMD/PADSEQD have conversion
    # evidence but net-regress -- receipted for a 272-basin re-match pass.
    "recon/syslib/psx/libpad/WAITRC2.c":    {"cc1_272": True},
    # w51-a4: libcd-B -- all six TUs lane-verified (17/29 assigned fns -> PASS;
    # zero PASS->FAIL both lanes). iso9660 drops no_split_addresses (no such
    # 2.7.2 flag); drv keeps jtbl key inert-but-harmless.
    # w52-a1: +no_strength_reduce (CD_get_intr 74->61, CD_cw 134->90,
    # all else bit-identical, 6 PASSes held; other flags regress or inert).
    "recon/syslib/psx/libcd/drv.c":        {"cc1_272": True, "no_strength_reduce": True},
    "recon/syslib/psx/libcd/event.c":      {"cc1_272": True},
    # SYM owner restoration (backup 3346a726): the old stream/streamhelp
    # compatibility TUs were split back into their canonical archive members.
    "recon/syslib/psx/libcd/C_002.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_003.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_004.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_005.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_007.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_008.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_009.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/C_010.c":      {"cc1_272": True},
    "recon/syslib/psx/libcd/CDROM.c":      {"cc1_272": True},
    # w52-a2: +no_strength_reduce -- COMBINATION lever with the index-form
    # source edit (each alone inert): StCdInterrupt 81->36, rest bit-identical.
    "recon/syslib/psx/libcd/stcdint.c":    {"cc1_272": True, "no_strength_reduce": True},
    # w51-a2: libmcrd cluster = cc1_272 lane (04M law). jtbl_at_fusion is inert in
    # this lane (no maspsx); kept out. LIBMCRD 2->8 PASS under the lane.
    "recon/syslib/psx/libmcrd/LIBMCRD.c": {"cc1_272": True},
    "recon/syslib/psx/libpad/PADENTRY.c":   {"jtbl_at_fusion": True,   # PadInfoAct
                                             "no_split_addresses": True},  # w48-a4 3x: PadInfoAct->PASS
    # w63-a14: jtbl_at_fusion DROPPED (w38-a5 sfx.cpp mis-attribution class --
    # neither InsertCarFacet nor InsertCarFacetMenu has an $at jtbl macro in
    # its oracle); with the A14 source landing => InsertCarFacet PASS 1144/1144.
    "recon/game/common/r3dcar.cpp":         {"g_value": "8"},          # 2026-08-04G -G8 queue
    # NOTE (w38-a5): sfx.cpp does NOT want jtbl_at_fusion -- BOTH of its switch
    # dispatches (Sfx_BuildSouffleFacet@jtbl_8005699C, Sfx_Add@jtbl_800569D4)
    # use the SPLIT-address form in the oracle
    # (`lui %hi(jtbl); addiu %lo(jtbl); sll idx,2; addu; lw 0(idx)`), not the
    # fused `$at` macro. The entry was a mis-attribution; removing it takes
    # Sfx_Add 7 -> 0 (PASS) and drops 3 diffs off Sfx_BuildSouffleFacet.
    # W82-root: complete source-only compiler/assembler ladder on the current
    # body.  The direct vendor-library 2.8.0 lane is the only safe TU winner:
    # sprintf 25 @546/545 -> 22 @545/545.  2.8.1 and retail 2.8.1-SN are
    # byte-identical here; 970404 is 31, and every older/newer family is much
    # worse.  SPRINTF.c exposes no second oracle-backed function to regress.
    # W83-A3: jtbl_at_fusion row DELETED as a phantom -- it is a maspsx
    # option and the cc1_alt lane bypasses maspsx; objdump -z byte-identical
    # with and without it on both bodies.  sprintf itself is SEALED PASS
    # 545/545 (source: named pre-loop flag constants in retail's order --
    # move_movables hoists always outrank source insns, so the '0' source
    # assignment could never precede the three hoisted constants; receipt
    # scratchpad/w83/A3_receipt.md).
    "recon/syslib/psx/libc/SPRINTF.c":      {"cc1_alt": "2.8.0",
        # w63-a9: nosplit hold RETIRED -- count-parity objection satisfied
        # by the slot-fill row below (44 @545/545, was 56).
                                             "no_split_addresses": True},
    # w33-a10: EA's own eaclib PAD.OBJ was built WITHOUT split addresses --
    # proven by the oracle's `lui $at; addu $at,$at,$idx; lbu %lo(sym)($at)`
    # indexed loads (two independent sites in PAD_update, no jump table in
    # sight) plus the unfused `la` into a callee-saved reg in padinit /
    # PAD_restore / PAD_state. Whole-TU sweep with the flag: 5/5 functions
    # improve or hold (see the per-fn table in recon/eaclib/psx/pad.c).
    "recon/eaclib/psx/pad.c":               {"no_split_addresses": True},
    # W82-root: strict source-only whole-TU gate.  -fforce-addr makes
    # SPCH_AddEvent emit the retail address-producer/copy pair (82/82); the
    # paired source copy-boundary fix keeps iSPCH_InitEventQueue exact.  All
    # 16 functions PASS without a post-compiler splice.
    "recon/eaclib/psx/spchpsxz/spchevnt.c": {"force_addr": True},
    # w48 (2026-08-04) SYSLIB -mno-split-addresses IDENTITY -- found
    # independently by five agents (a9's 512-run ladder, a2's oracle-side
    # proof on libgpu, a1 libmcrd, a4 PADENTRY, a6 iso9660) and concordant
    # with a10's toolchain hypothesis (Sony built PsyQ 4.3 with split
    # addresses off + a reordering assembler).  Every entry gate-verified
    # per-TU with zero PASS regressions, reproduced 2x+ by its agent and
    # re-gated hookless at consolidation.  Deliberately NOT wired (mixed or
    # worse, measured): LIBMCRD, INTR_VB, drv, cdread, cdcont, stcdint,
    # PADPORTD, PADSEQD, MCXMAIN.  Receipts: scratch/w48_a*_receipts.md.
    # w51-a1: SYS.c = cc1_272 LANE IDENTITY (7 count-exact FAIL->PASS conversions:
    # DrawOTag/_send_gp1/_get_gp1/_que_ref/_gpu_arm_timeout/_gpu_init_videomode/
    # _install_drain_cb; -G0 default is load-bearing -- 2.7.2 ignores the
    # section(".bss") attributes and -G0 does that job; adding g_value 4 or
    # no_delayed_branch collapses the win).  Replaces the old 2.8-basin
    # no_split_addresses entry; MoveImage re-anchored for the lane in the same
    # commit (see its /* MATCH: */ receipt).
    # w52-a3: SYS.c clamp-family identity evidence = 2.8.x + -mno-split-
    # addresses (oracle's two-width lh+lhu clamps; 2.7.2 CSEs them + phantom
    # frame). Orchestrator-measured whole-TU: {"cc1_alt": "2.8.1",
    # "no_split_addresses": True} = 22 PASS/813 diffs vs 24/1002 here -- a
    # NET -2 PASS today (4 flip up: _set_clip_tl/br/_reset/_image; 4 flip
    # down: _que_ref/_install_drain_cb/_gpu_arm_timeout epilogue class +
    # _clearOTagR_dma s0<->s1). STAYS 2.7.2 until the epilogue-fill mechanism
    # for the alt lane exists; then re-measure (BlitClear 20 count-exact there).
    # w53-a6: THE FLIP -- P1 (alt28 unfill) + P2 (fs272 sched2 splice) make it
    # PASS-NEUTRAL: 25 PASS/796 vs 25/1000 on 2.7.2. Frame-size proof: 6/6
    # clamp-family frames match 2.8.1 exactly, mismatch 2.7.2 (vars=32 phantom).
    "recon/syslib/psx/libgpu/SYS.c":        {"cc1_alt": "2.8.1", "no_split_addresses": True},
    # w52-a5: PADMAIN onto the 2.7.2 rung (replaces no_split_addresses, which
    # the 272 recipe ignores): whole-TU 249->205 on the post-rewrite source,
    # zero PASS regressions (all 4 PASSes hold).
    "recon/syslib/psx/libpad/PADMAIN.c":    {"cc1_alt": "2.7.2"},
    # w52-a5: PADCMD onto the 970404 snapshot rung: TU 181->168, net +1 PASS
    # (+_padSendAtLoadInfo +_padLoadActInfo_snd -_padSetMainMode) and the 4
    # store-swap blockers dissolve with their PASSes intact.
    "recon/syslib/psx/libpad/PADCMD.c":     {"cc1_alt": "2.7.2-970404"},
    # w53-a8: both round-2 lane flips -- volatile-on-the-TEST-read family
    # lever resolved each TU's blocker; full ladders in the TU receipts.
    "recon/syslib/psx/libpad/MCXMAIN.c":    {"cc1_alt": "2.7.2"},  # 231->178, 0 P->F
    "recon/syslib/psx/libpad/PADPORTD.c":   {"cc1_alt": "2.7.2"},  # 139->109, _pad_filter 18 count-exact
    # w51-a2: BIOS.c 13->17/17 PASS -- WHOLE OBJECT byte-matches under cc1_272.
    "recon/syslib/psx/libmcrd/BIOS.c":      {"cc1_272": True},
    # w51-a2: USERFUNC.c 1->4/4 PASS under cc1_272 with ZERO source change (the
    # w48 "needs maspsx ASPSX fill" note on UserFuncInit = wrong-compiler artifact).
    "recon/syslib/psx/libmcrd/USERFUNC.c":  {"cc1_272": True},
    # w51-a7: INTR.c -> cc1_272 (8 PASS incl. VSyncCallback; _intrhand 110->49).
    "recon/syslib/psx/libetc/INTR.c":       {"cc1_272": True},
    "recon/syslib/psx/libcd/iso9660.c":    {"cc1_272": True, "signed_char": True},  # w51-a4 (drops no_split)
    # 04M -- the gcc-2.7.2 lane (see "cc1_272" key above).  FERR/_err_math and
    # FLTSIDF/__floatsidf sealed the lane (PASS); the rest of libmath probed
    # TU-by-TU at consolidation, kept only where the gate net-improves with
    # zero PASS regressions.
    "recon/syslib/psx/libmath/FERR.c":      {"cc1_272": True},
    "recon/syslib/psx/libmath/FLTSIDF.c":   {"cc1_272": True},
    # w52-a4: libmath = SONY PREBUILT VENDOR OBJECT (bytes verbatim in every
    # PsyQ 4.0-4.7 LIBMATH.LIB) -- per-TU ladder rungs below are the measured
    # winners (agent whole-TU tables in each TU's receipts; zero regressions).
    "recon/syslib/psx/libmath/ADDDF3.c":    {"cc1_alt": "2.7.2-970404"},  # 352->347
    # w55-a4: MULDF3 UNWIRED (04Z re-ladder after the 05B union/oracle-shape
    # landing on __muldf3).  New TU totals: DEFAULT lane (CC1PSX+maspsx) =
    # _mul_mant_d 95 + __muldf3 22 = 117; cc1_alt 2.8.0/2.8.1 = byte-identical
    # to the default here; cc1_272/2.7.2 = 93+154 = 247; 2.6.3 (the OLD wiring,
    # picked pre-landing for _mul_mant_d 93->84) = 84+154 = 238; 2.91.66 =
    # 106+168.  The default lane wins the TU by 121 diffs, so the 2.6.3 rung is
    # retired.  __muldf3 alone: 326 -> 22 (see MULDF3.c receipt).
    "recon/syslib/psx/libmath/GTDF2.c":     {"cc1_alt": "2.7.2-970404"},  # 33->21
    "recon/syslib/psx/libmath/LTDF2.c":     {"cc1_alt": "2.7.2-970404"},  # 21->15
    # w55-a4: RE-LADDERED after the in-place-mantissa landing (04Z).  New table:
    # 2.6.0/2.6.3=31 * 2.7.2=10 * 2.8.0/2.8.1=8 * 2.91.66=98 * 2.95.2=90 (the
    # OLD wiring, now the second-worst rung).  84 -> 8.
    "recon/syslib/psx/libmath/MULSF3.c":    {"cc1_alt": "2.8.0"},  # 84->8
    # w55-a4: RE-LADDERED after the in-place-mantissa + branch-polarity landing
    # (04Z).  New table: 2.6.3=42 * 2.7.2=38 * 2.7.2-970404/2.8.0/2.8.1=49-51 *
    # 2.95.2=67 (the OLD wiring).  96 -> 38.
    "recon/syslib/psx/libmath/DIVSF3.c":    {"cc1_alt": "2.7.2"},  # 96->38
    # w55-a4: RE-LADDERED after the 05B union/oracle-shape landing (04Z: rung
    # tables are basin-relative).  New table on the landed source: 2.6.0/2.6.3=30
    # * 2.7.2-970404/2.7.2=27 * 2.8.0/2.8.1=28 (count-EXACT 184/184) * 2.91.66=171
    # * 2.95.2=164.  The old 2.91.66 wiring is now the WORST rung (300->171).
    "recon/syslib/psx/libmath/DIVDF3.c":    {"cc1_alt": "2.7.2"},  # 300->27
    "recon/syslib/psx/libmath/EXTSFDF2.c":  {"cc1_272": True},  # 69->55
    # w52-a7: nsync = gcc 2.8.1 through the NORMAL maspsx pipeline (cc1_ver
    # swaps only the binary): loadbigfileheaderatomic 4 -> PASS 81/81, TU 10/10.
    "recon/eaclib/psx/eacpsxz/nsync.c":     {"cc1_ver": "2.8.1"},
    # w52-a9: csincos -> PASS 71/71 under 2.7.2 + -fno-strength-reduce (with SR
    # on, cc1 promotes the z address to a 6th induction var: the 73-vs-71 gap
    # no source shape closes). Single-fn TU.
    "recon/syslib/psx/libgte/COR_01.c":     {"cc1_272": True, "no_strength_reduce": True},
    # 2026-08-28 full ladder: both single-function siblings are exact on the
    # vendor 2.7.2 lane (also on 970404), while 2.8.0/2.8.1 leave only the
    # swapped epilogue residual.  Whole-object identity; no source seal.
    "recon/syslib/psx/libgte/COR_02.c":     {"cc1_272": True},
    "recon/syslib/psx/libgte/COR_03.c":     {"cc1_272": True},
    # PsyQ 4.3 FOG_01 vendor identity: the normal maspsx pipeline with the
    # authentic 2.7.2 cc1 emits SetFogNear's complete 25-word body exactly,
    # including its addiu-sp / jr / nop epilogue.  The bare LM1 debug marker
    # inside that body is an interior line label, handled by the gates just
    # like a `.L*` label; it is not a function boundary.
    "recon/syslib/psx/libgte/FOG_01.c":     {"cc1_ver": "2.7.2"},
    "recon/syslib/psx/libmath/FLTSISF.c":   {"cc1_272": True},  # 38->32
    "recon/syslib/psx/libmath/FIXSFSI.c":   {"cc1_272": True},  # 12->8
    "recon/syslib/psx/libmath/FIXDFSI.c":   {"cc1_272": True},  # 80->67
    # NOT in the lane (gate-measured worse under 2.7.2 -- source shapes are
    # 2.8-basin-tuned; retest after re-matching): DIVDF3 +1 (its _div_mant_d
    # PASS survived the lane), TRUDFSF2 +4, LTDF2 +31, MULSF3 +7.
    # w48-a8: DSCB wants the triple (source shape already landed by a8);
    # DsReadyCallback 9->0 with it.
    # w51-a7: DSCB triple superseded -- cc1_272 alone = 2/2 PASS (DsDataCallback 4->P).
    "recon/syslib/psx/libds/DSCB.c":        {"cc1_272": True},
    # w34 follow-up (user call): sched1 OFF for movf.c -- movfxya 149 -> 88
    # diffs. Insn parity is knowingly conceded (225 vs oracle 221: the
    # CSE-hoisted `li 255` pseudo + its caller-save spill/reload + one
    # arg-reg copy); the flag fixes the {shape,yPos,vc} rotation's shape
    # half (shape lands on retail's $s6). movf.c holds only movfxya, so no
    # in-TU regression is possible. Full rationale in the comment block above.
    "recon/eaclib/psx/eacpsxz/movf.c":      {"no_schedule_insns": True},
    # sbdload.obj per-obj identity (w33-a6 quantified: 42->23, all nine callee-saved
    # assignments + both cursor shapes land exactly; retail's patch loop shows NO
    # strength reduction).  Same adoption precedent as movf.c's no_schedule_insns.
    "recon/eaclib/psx/sndpsxz/sbdload.c":   {"no_strength_reduce": True},
    # sdmemman.obj retains the full D_80147E34 base through its tail scan.
    # GCC's optional post-loop CSE rerun folds that final base use back to a
    # %lo(high) address and creates an extra live address pseudo; the retail
    # object has the unfurled pointer lifetime.  Keep CSE2 off for this object.
    "recon/eaclib/psx/sndpsxz/sdmemman.c":  {"no_rerun_cse_after_loop": True},
    # stattool.obj has an out-of-line memcpy for its 20-byte record copy.
    # CC1PLPSX otherwise builtin-expands it to eight extra instructions.
    "recon/frontend/common/stattool.cpp":   {"no_builtin": True},
    # "no_delayed_branch" PROTOTYPED on libetc/INTR.cpp (w24-a9 task 3) and
    # NOT enabled here: net +3 PASS (ResetCallback/InterruptCallback/
    # DMACallback/VSyncCallbacks 4->0 diffs each) but a genuine regression
    # (SetIntrMask PASS -> FAIL 3, a leaf fn that needs gcc's OWN
    # delay-slot filling ON) proves per-TU granularity is NOT sufficient for
    # this TU -- would need per-FUNCTION granularity (not yet built). See
    # the w24-a9 commit message for the full 12-fn before/after table.
}


def per_tu_flags(src: Path) -> dict:
    rel = src.relative_to(ROOT).as_posix()
    flags = dict(PER_TU_FLAGS.get(rel, {}))
    # w47-a7 CLASS RULE: the entire front overlay was built -G0 (zero GPREL16
    # relocs across all 50 overlay objects vs 2378 elsewhere; the retail map
    # has NO front .sdata/.sbss group -- _front_sdata_size == 0).  Every
    # recon/frontend/** TU therefore defaults to g_value "0"; an explicit
    # PER_TU_FLAGS entry still wins.  Safe for PASSing fns by construction:
    # a fn matching a zero-gp-rel oracle emits no gp-rel itself at -G4, so
    # -G0 cannot change its code -- it only removes SPURIOUS gp-rel from
    # not-yet-matching fns.  (Census: tools/w47_a7_gcensus.py, receipts
    # scratch/w47_a7_census.md.)
    # SCOPE (consolidation regate, 2026-08-04): recon/frontend/COMMON only.
    # frontend/psx is RESIDENT code (survives overlay swaps) and is -G
    # sensitive the other way: FontUpsideDownBlit regressed 48->104 under
    # -G0 while all 20 memcard.c fns held -- so the overlay class rule must
    # not touch frontend/psx.
    if rel.startswith("recon/frontend/common/") and "g_value" not in flags:
        flags["g_value"] = "0"
    return flags


# --- w25-a1: PER-FUNCTION delayed-branch dual-compile splice ---------------
# w24-a9 proved -fno-delayed-branch is not safe as a whole-TU flag (leaf fns
# in the SAME TU need gcc's own filling ON). This is the per-FUNCTION
# mechanism that was missing: compile the TU TWICE from the SAME .i (once
# normal, once with -fno-delayed-branch), then splice the named functions'
# .s REGIONS out of the flag build and into the normal build's .s before
# maspsx/as ever sees it. Each spliced function's body is then 100% real
# cc1/cc1plus output -- no hand-written asm, no synthesized semantics.
#
# w25-a8 (relayed by the wave lead) FALSIFIED the naive expectation that the
# flag alone reproduces the oracle everywhere: retail was built with gcc's
# delayed-branch filling OFF *followed by ASPSX's own reorder/fill pass* --
# for a straight-line tail-call/epilogue-only function, cc1's un-scheduled
# SEQUENTIAL instruction order already happens to land the right instruction
# in the slot (nothing to "fill" -- there was only ever one way to emit it),
# so flag-alone reproduces the oracle. For a function with INTERIOR
# branches (loops, guards, if/else) cc1 with scheduling off leaves a genuine
# naked `nop` where ASPSX's fill pass put a real instruction -- splicing
# that in is a REGRESSION relative to the normal (delayed-branch-ON) build,
# which usually already matches the oracle there via gcc's own filler.
# CONFIRMED empirically this session: ResetCallback/InterruptCallback/
# DMACallback/VSyncCallbacks (single-jal, epilogue-only) flip FAIL-4->PASS
# from the splice alone; SetFogNear/_err_math/__fixsfsi (interior
# div-guard/loop branches) get WORSE under the same flag (naked nops).
# => Only splice TIER-1 (epilogue-only / no interior branches) functions
# until a post-splice fill pass exists (tracked as TIER-2, not built this
# session -- see the w25-a1 commit message).
#
# Keyed the same way as PER_TU_FLAGS: ROOT-relative POSIX src path -> a SET
# of exact .ent/.end asm label names to splice (the label as cc1/cc1plus
# emits it -- i.e. the C++-MANGLED name for a class method; all current
# entries are `extern "C"` functions so the label equals the source name).
PER_FN_NO_DELAYED_BRANCH = {
    # W80-root: PAD_restore's historical -fno-delayed-branch splice is retired.
    # The authentic per-function GCC 2.7.2 identity below emits its complete
    # epilogue exactly and also closes padinit, without altering call slots.
    "recon/syslib/psx/libetc/INTR.c": {
        "ResetCallback", "InterruptCallback", "DMACallback", "VSyncCallbacks",
    },
    "recon/syslib/psx/libcd/cdcont.c": {
        # w51-a3: EMPTIED -- the whole CdSync/CdReady/CdFlush/CdDataSync/
        # CdDataCallback set PASSes unspliced under the cc1_272 lane; the splice
        # class was compiler-version, not assembler (w48-a10 class-5 solved).
    },
    "recon/syslib/psx/libcd/cdread2.c": {
        # w51-a3: EMPTIED -- _cdread2_ready superseded by the cc1_272 lane.
    },
    # _pad_get_port has one small interior `if` (not the pure epilogue-only
    # shape) but empirically flips FAIL-3->PASS with no naked-nop
    # regression under both the pre-mechanism whole-TU probe and the real
    # per-fn splice -- confirmed Tier-1 by construction per the wave lead.
    "recon/syslib/psx/libpad/PADPORTD.c": {
        "_pad_get_port",
    },
    # (w48-a3: PADMAIN's two w25 splice entries DROPPED -- superseded by the
    # PER_FN_EPILOGUE_UNFILL mechanism below, which keeps dbr's body fills
    # and un-fills only the return slot: _padStopCom same 6 diffs but now
    # COUNT-EXACT 17/17, _padClrIntSio0 unchanged 24.)
    # Tier-2: all three carry a PADCMD-style command-dispatch case chain
    # (li/beq/j per case) whose ASPSX-unfilled delay-slot nops move each
    # closer to the oracle's per-case beq/nop/j/nop shape without reaching
    # full PASS. Zero collateral on PADCMD.cpp's other 16 functions.
    "recon/syslib/psx/libpad/PADCMD.c": {
        "_padSendAtLoadInfo",  # FAIL 32 -> FAIL 30
        "_padLoadActInfo_snd", # FAIL 24 -> FAIL 22
        # w48-a3: _padSetMainMode_rcv DROPPED from the splice -- the
        # EPILOGUE_UNFILL entry below takes it to PASS 24/24 instead.
    },
    # w48-a5: libcd Tier-1/Tier-2 splice additions, each measured in the
    # final basin with zero whole-TU regressions.
    "recon/syslib/psx/libcd/drv.c": {
        # w51-a4: EMPTIED -- 272 lane supersedes (class was compiler-version).
    },
    "recon/syslib/psx/libcd/event.c": {
        # w51-a4: EMPTIED -- 272 lane supersedes (class was compiler-version).
    },
    "recon/syslib/psx/libcd/toc.c": {
        "CdGetToc",            # FAIL 6 -> FAIL 5
    },
    "recon/syslib/psx/libcard/INIT.c": {
        "StopCARD",   # StartCARD tried + reverted: multi-jal interior arg-slot filling
                       # (naked nop vs oracle's ASPSX-filled slot) -> FAIL 4->3, not PASS. Tier-2.
    },
    "recon/syslib/psx/libmcrd/BIOS.c": {
        "_card_open", "_card_close",
        # tried + reverted (Tier-2, interior multi-jal/loop scheduling, none reach PASS):
        #   _clr_card_event  FAIL 5->2  (8x TestEvent calls, ra-reload timing)
        #   _get_card_event  FAIL 6->9  (REGRESSED; do-while spin loop)
        #   _get_card_event_x FAIL 6->9 (REGRESSED; same shape)
        #   _card_start      FAIL 75->65 (interior if(prev==1) guard + 7x jal-arg blocks)
    },
    # USERFUNC.c UserFuncInit tried: cc1's raw .s is BYTE-IDENTICAL with/without
    # -fno-delayed-branch (no reorderable candidate before the `j $31`) -- the
    # splice mechanism is a no-op here. FAIL 3 unchanged. The real fix needs
    # maspsx-side ASPSX-style slot-filling (a different, not-yet-built lever
    # per methodology §3.25.3b), not this dual-compile splice. Not added.
    "recon/syslib/psx/libmcrd/LIBMCRD.c": {
        "MemCardEnd",
        # tried + reverted (Tier-2, interior branches/multi-jal, none reach PASS):
        #   MemCardStart        FAIL 8->6   (improved but not PASS; multi-jal
        #                                    straight-line, VSyncCallbacks/_card_start
        #                                    arg-slot scheduling)
        #   MemCardExist         FAIL 8->14  (REGRESSED; interior if/return guard)
        #   MemCardAccept        FAIL 8->14  (REGRESSED; same shape as MemCardExist)
        #   MemCardEventToRslt   FAIL 3->24  (REGRESSED badly; if/else/goto, no calls
        #                                     at all -- not a call-through shape)
    },
    # w25-a7: libgpu SYS.c (SYS.cpp at the time) -- TRIED AND REVERTED (2026-07-25). All 5
    # multiset-equal-reordering candidates (_que_ref, _install_drain_cb,
    # ClearImage, _gpu_arm_timeout, _set_draw_mode) got WORSE under the raw
    # Tier-1 splice, not better: cc1 -fno-delayed-branch leaves a genuine
    # naked `nop` in every interior jal/branch slot (que_ref 6->5 diffs but
    # insn count drifted 9->10 with a new nop; install_drain_cb 10->7 diffs
    # same nop pattern; ClearImage 8->16 diffs, WORSE; gpu_arm_timeout 5->5
    # diffs but now ours=14 vs oracle=13 (2 nops, not the oracle's 1);
    # set_draw_mode 5->9 diffs, WORSE) -- because ASPSX's independent fill
    # pass (which chose a DIFFERENT, unrelated-but-live instruction to fill
    # each slot) is not reproduced by cc1's un-scheduled sequential order for
    # any of these; every one of them has an interior jal or branch, i.e.
    # NONE were the true epilogue-only Tier-1 shape (INTR.cpp's
    # ResetCallback/etc. and libcd's CdSync/etc. are epilogue-only -- a
    # single terminal jal/return with nothing else pending). TIER-2 candidate
    # list for a real post-splice ASPSX-style fill pass, if one gets built:
    # _que_ref, _install_drain_cb, ClearImage, _gpu_arm_timeout (interior
    # single-jal, fill choice differs from cc1's natural order);
    # _set_draw_mode (interior branch, PLUS an unrelated proven-immune
    # commutative-operand-order floor on top -- ceiling is ~2 diffs even
    # with a working fill pass, not 0). Do NOT re-add these under the
    # CURRENT raw-flag mechanism.
    "recon/syslib/psx/libpress/LIBPRESS.c": {
        "DecDCTout", "MDEC_status",
    },
    # w25-a9 TRIED (verify-or-revert, NOT added): PCread/PCwrite
    # (recon/syslib/psx/libsn/{READ,WRITE}.c) are a9's only 2 real dbfn
    # sites (see tools/dbfn_sites.txt), but both have interior branches
    # (a do/while + 2 ifs each) -- TIER-2 by a1's classification. Spliced
    # anyway to confirm empirically: FAIL 39->45 diffs (ours 47->53 insns,
    # 6 genuine extra unfilled nops at the interior chunk-size/error-return
    # branches) -- a real regression, reverted. Also: even a clean splice
    # would NOT have closed most of the gap here -- both fns' dominant
    # residual (see their file-header comments) is an unrelated gcc-2.7.2
    # callee-saved coloring-rotation near-miss (s2/s3/s4/s6 swapped vs the
    # oracle), independent of delayed-branch scheduling. TIER-2 needs the
    # post-splice slot-fill pass a1 tracked as follow-up (maspsx forces
    # `.set noreorder` on every function, so GNU AS's own reorder-fill never
    # runs on our output) before either function is worth revisiting.
}


def per_fn_no_delayed_branch(src: Path) -> set:
    return PER_FN_NO_DELAYED_BRANCH.get(src.relative_to(ROOT).as_posix(), set())


# Per-FUNCTION -fno-thread-jumps splice (same dual-compile mechanism as
# PER_FN_NO_DELAYED_BRANCH above; same key/label conventions).  Motivation
# (2026-08-08, AudioClc_SoundPlayersCar 4->0): gcc's thread_jumps pass
# redirects a cond-branch whose outcome decides a target block's cond-branch
# (here: cond-1's `channel<0` fail edge threaded PAST the else-if chain's
# `bgez channel` re-test, landing a CODE_LABEL between the bgez and the
# commMode li/lw pair).  That label blocks the delay-slot fill, forcing
# `bgez; nop; lw; li` where retail (unthreaded) emits `bgez; li(slot); lw;
# nop` -- retail's compile did not thread this edge, so the flag reproduces
# the retail shape byte-exactly for the affected function.  Whole-TU probe
# receipts (real CC1PLPSX, label-normalized diff): flag touches 4 fns --
# SoundPlayersCar (target), ResetClosest (PASS at stake), GetClosestCars,
# SoundCars -- which is exactly why this is per-FUNCTION, not a TU flag.
PER_FN_NO_THREAD_JUMPS = {
    "recon/game/common/audioclc.cpp": {
        "AudioClc_SoundPlayersCar__Fi",
        # tried + reverted (2026-08-08, same probe session):
        #   AudioClc_GetClosestCars__Fiii  FAIL 17 -> 20 (REGRESSED, count
        #     266->263 further from oracle 267 -- retail's copy WAS threaded)
        #   AudioClc_SoundCars__Fv         FAIL 2 -> 2 (no-op: its residual
        #     is not a thread artifact)
    },
}


# Per-FUNCTION -fforce-addr splice (same dual-compile mechanism).  w50-a10:
# Weather_Init is a flag identity -- -fforce-addr keeps the %hi in its own
# pseudo so the .type load stays a second lo_sum off the shared high instead
# of cse find_best_addr folding it onto the computed pointer, freeing $v0 for
# the li-1 in the beqz slot.  Whole-TU -fforce-addr is NOT the identity
# (breaks ProcessParticles/QuickReOrthogonalize) -- per-fn only.
# The former AudioCmn_Init-only -G8 splice is obsolete: audiocmn.obj is now
# proven as a whole-TU -G8 identity above, under the strict source-only gate.
PER_FN_G8 = {}

# w59-a7 spec, w60-a4 re-validated: CdRead 43 -> 38 count-exact 103/103 with
# per-fn -mno-split-addresses; whole-TU nosplit is a net loss, and this
# composes cleanly with cdread.c's 2.8.1 per-fn version splice.
PER_FN_NO_SPLIT_ADDRESSES = {
    "recon/syslib/psx/libcd/cdread.c": {"CdRead"},
}

PER_FN_FORCE_ADDR = {
    "recon/game/psx/weather.cpp": {
        "Weather_Init__Fv",   # FAIL 12 (211/211) -> PASS, byte-exact
    },
    # w53-a11: the "missing address-copy" class -- update_equiv_regs rewrites
    # base=<addr> through REG_EQUIV so no copy exists for combine_regs to
    # keep; -fforce-addr restores it. TU 15/16 -> 16/16, 0 regressions.
    "recon/eaclib/psx/spchpsxz/spchevnt.c": {"SPCH_AddEvent"},  # 3 -> PASS 82/82
}


_ENT_RE_TMPL = r'^\t\.ent\t{name}\b[^\n]*\n'
_END_RE_TMPL = r'^\t\.end\t{name}[ \t]*$'


def _extract_fn_region(s_text: str, name: str) -> str:
    """Pull the `.ent NAME ... .end NAME` block (inclusive) out of a raw
    cc1/cc1plus .s. This is the ENTIRE machine-instruction body of the
    function; everything genuinely per-function (`.frame`/`.mask`/`.fmask`/
    body/labels) lives between these two markers. File-scope boilerplate
    that happens to sit textually adjacent (`.text`, `.globl`, per-symbol
    `.def NAME;...;.endef` debug records) is verified IDENTICAL between the
    normal and -fno-delayed-branch compiles (same source, same symbol
    table -- only instruction SCHEDULING differs) and is left untouched,
    supplied by the normal build on both sides of the splice."""
    ent_re = re.compile(_ENT_RE_TMPL.format(name=re.escape(name)), re.M)
    m = ent_re.search(s_text)
    if not m:
        sys.exit(f"[splice] '.ent {name}' not found")
    end_re = re.compile(_END_RE_TMPL.format(name=re.escape(name)), re.M)
    m2 = end_re.search(s_text, m.end())
    if not m2:
        sys.exit(f"[splice] '.ent {name}' found but no matching '.end {name}'")
    end = m2.end()
    if s_text[end:end + 1] == '\n':   # swallow one trailing blank line
        end += 1
    return s_text[m.start():end]


def _uniquify_local_labels(region: str, tag: str) -> str:
    """gcc numbers `$L<N>` local branch-target labels per-compile-RUN, so the
    SAME function compiled twice (normal vs -fno-delayed-branch) gets
    DIFFERENT numbers for what may be the same or an unrelated target --
    and the flag-run's numbers can collide with numbers already used by
    OTHER, un-spliced functions elsewhere in the normal .s (verified: e.g.
    INTR.cpp's normal build and -fno-delayed-branch build both mint a
    "$L10" for a DIFFERENT branch in a DIFFERENT function). Rename every
    $L<N> DEFINED inside this region (and every use of that same N inside
    the region) to a namespace no gcc run has ever produced, so it can never
    collide with a label already present in the destination file. `$LC<N>`
    rodata/string-literal labels are declared once at file scope and are
    confirmed BYTE-IDENTICAL in number/order between the two compiles (same
    source -> same string-literal encounter order, independent of
    scheduling) -- left untouched, resolved against the normal build's
    single rodata section on both sides of the splice.
    A $L<N> that is USED in the region but not DEFINED in it (e.g. a switch
    jump-table entry living in .rdata, outside .ent/.end) is a genuine
    cross-region reference -- left unrenamed; see the jtbl caveat in the
    commit message before splicing a function containing a `casesi` table."""
    defined = set(re.findall(r'^\$L(\d+):', region, re.M))
    if not defined:
        return region

    def _sub(m):
        num = m.group(1)
        return f'$L{tag}_{num}' if num in defined else m.group(0)

    return re.sub(r'\$L(\d+)\b', _sub, region)


_SPLICE_COUNTER = [0]


# w53-a6 P2: per-FUNCTION flag splice for the 272/alt recipe (the mechanism
# _apply_fn_splice provides for the maspsx lane, which _compile_c_272 never
# calls).  {rel: {extra_cc1_flag: {fns}}}.  Splice runs BEFORE the alt28
# unfill (the spliced region still carries the 2.8 j-$31 block).
# W73 (orchestrator, user-ordered vendor-provenance experiment): PER-FN RAW-4.0
# SPLICE -- the VENDOR-BUILD-IDENTITY cure for the AT-MACRO-SPLIT-ACROSS-BRANCH
# class.  PROVENANCE (receipt in PADSEQD.c): the shipped PsyQ 4.3 lib member
# _padInitDirSeq carries `lui $at / jr $ra / sw %lo($at)` (macro split across
# the return), but NEITHER ASPSX 2.77 (4.3 CD) NOR ASPSX 2.56 (PsyQ 4.0) emits
# that split from any on-hand cc1 output (both drivers pass only `-q`; verified
# via CCPSX -v on both SDKs) -- Sony's internal lib build used an earlier
# assembler rung.  GNU as in .set-reorder mode STILL HAS the behavior, and
# PsyQ 4.0's CC1PSX emits the required UNSPLIT `la`/`sw` macro form (2.6.x-era
# codegen; 2.8.0 pre-splits addresses).  So: compile the named fns with the
# PsyQ 4.0 cc1, splice their raw macro-form regions into the POST-maspsx text
# (maspsx would pre-expand the macros and nop the slot -- that IS the 3-diff),
# and let the lane's own GNU as do the split natively.  Byte-proof:
# scratchpad/W73_pq40.s + GNU-as objdump == retail w10..w12 exactly.
# Resolution: env override, dev-box psyq400 drop, then CC1PSX272.EXE beside
# the resolved CC1 -- the CI toolchain-zip slot, which IS this exact binary
# (PsyQ 4.0 CC1PSX.EXE renamed; sha256 5594a2241d1ddaa2... both).  Without
# the fallback, CI silently skipped the raw40 splice (its guard is a graceful
# .exists()) and decomp.dev showed firstfile at 93.88% / _padInitDirSeq's TU
# drifting instead of their sealed PASSes.
def _resolve_cc1_psyq40() -> Path:
    for c in (Path(_env("NFS4_CC1_PSYQ40",
                        r"C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE")),
              Path(CC1).parent / "CC1PSX272.EXE"):
        if c.is_file():
            return c
    return Path(r"C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE")
CC1_PSYQ40 = _resolve_cc1_psyq40()
PER_FN_RAW40_SPLICE = {
    "recon/syslib/psx/libpad/PADSEQD.c": {"_padInitDirSeq"},
    # W84-root: CDREAD.OBJ's _read_issue is the PsyQ-4.0/2.7.2 raw-macro
    # identity.  Dependency-safe source fences now preserve the retail anchor
    # allocation without letting a zero-byte asm occupy CdLastPos's delay slot.
    # Full TU 6/6 PASS x2; slotcheck 0; strict-branch and brdist clean.
    "recon/syslib/psx/libcd/cdread.c": {"_read_issue"},
    # W74-A15 (verified end-to-end: object hand-built from the raw40merged.s,
    # assembled with the lane's as, scored with verify_asm's normalizer ->
    # firstfile PASS 103/103 AND _first_patch PASS 64/64; coupled with the
    # scan-before-p init swap in FIRST.c -- land/revert together). The rung
    # gives the un-split `la` macro (retail's SELF-temp pair) AND GNU as does
    # the expansion post-schedule so the macro can occupy the lb load-delay
    # gap -- the maspsx-lane ver-splice loses the second half (13 @98).
    "recon/syslib/psx/libapi/FIRST.c": {"firstfile"},
}

PER_FN_FLAG_SPLICE_272 = {
    # W72-A17 (probe-verified whole-TU via the W61_TABLE hook, 18/19 identical,
    # zero PASS->FAIL; fn 10 -> 2 @157/157): the mips_check_split SMALL-DATA
    # GATE -- mips_split_addresses is unconditional on these rungs (no user
    # switch), but applied per-address only when ENCODE_SECTION_INFO left
    # SYMBOL_REF_FLAG unset; at the lane's -G0 nothing is small-data so every
    # address pre-splits. -G4 for this one fn restores retail's $at/dest-as-
    # scratch assembler-macro forms while the TU's assembler stays -G0 (symbol
    # remains absolute). Retires the 3-wave "nosplit mechanism" request.
    "recon/syslib/psx/libpad/PADCMD.c": {
        "-G4": {"_padLoadActInfo_rcv"},
    },
    # W80-root: SYS.c's former -fno-schedule-insns2 trio moved to the
    # authentic GCC 2.7.2 per-function identity below.
    # w53-a9: cc1 self-fills the jal slot hiding the load-use hazard; with
    # -fno-delayed-branch gas sees it and emits the oracle's nop verbatim.
    "recon/syslib/psx/libetc/INTR.c": {
        "-fno-delayed-branch": {"RestartCallback"},  # 1 -> PASS (a9 cc1-level A/B)
    },
    # w60-a2 historical experiment: MemCardFormat reached 35/35 only when this
    # flag was combined with a now-removed post-compiler instruction move.
    # reorg SCHED_GROUPs the cheap arg address `addiu $a1,$sp,16` onto the
    # `jal MemCardMakeDevname` and eats its slot, so cc1 emits arg-AFTER-store;
    # retail emits arg-BEFORE-store and lets GNU-as backward-fill the
    # `sw $v1,_mc_present` MACRO's %lo half into the slot (the W51 272-lane
    # AT-MACRO-SPLIT identity).  -fno-delayed-branch is precisely the "make the
    # STORE the later insn" the w46/w52-a6 named angle asked for: cc1 then
    # emits `addu $5,$sp,16` BEFORE `sw $3,_mc_present` and gas splits the
    # macro across the jal exactly like retail.  Cost: the fn's OTHER filled
    # slot (`bne $2,$0,$L; li $2,1`) goes empty.  That post-compiler repair is
    # intentionally absent; the source-only residual is currently 4.  Falsified same probe:
    # -fno-schedule-insns 18, -fno-schedule-insns2 6 (both worse than the 4 baseline).
    "recon/syslib/psx/libmcrd/LIBMCRD.c": {
        "-fno-delayed-branch": {"MemCardFormat"},
    },
}


# w55-a8: per-FN cc1 VERSION splice for the 272/alt recipe -- like the flag
# splice but swaps the cc1 BINARY (ladder rung) for the named fns only.
# {rel: {ver: {fns}}}.  Runs before the flag splice.
# W81-A9 extension: the rung key may carry extra cc1 flags after the version,
# whitespace-separated ("2.8.0 -mno-split-addresses") -- the named fns then get
# the rung's cc1 AND those flags on top of the TU lane's flag set.  This is the
# per-fn {cc1 + add_flags} combined splice: needed when a fn's identity is on a
# rung+flag lane the TU must not ride (e.g. _padIntRecvData below: TU flip to
# 2.8.0+nosplit worsens _padIntRecvHdr 2->4, so per-fn scoping is required).
PER_FN_CC1_VER_SPLICE_272 = {
    # W81-A9: _padIntRecvData SEALED byte-exact (PASS 223/223, brdist 27/27,
    # slotcheck 0) on 2.8.0 + -mno-split-addresses with the A9 source (real
    # while(1) topology + depth-2 wrapper weight dial + int len + index-term-
    # first store).  ATOMIC with that source: on the TU's own 2.7.2 lane the
    # same body prices 62 @223.  Also fixes the shipped basin's gate-blind
    # wrong branch word (j #13: 34 vs retail 35).  Receipt: w81/A9_receipt.md.
    "recon/syslib/psx/libpad/MCXMAIN.c": {
        # W82-A9 adds _padIntRecvHdr: coupled with the merge-first/-9-last source
        # shape (source alone 2, lane alone 4, together PASS 35/35; the fn's
        # pre-existing gate-blind wrong beqz word dies with it).
        "2.8.0 -mno-split-addresses": {"_padIntRecvData", "_padIntRecvHdr"},
    },
    # W82-A9 (Option B): setIntrDMA alone on 970404 + -G32 (see PER_TU_FLAGS
    # note); the TU itself is back on the 272 recipe, so the three sibling
    # splice rows W78-A14 needed are gone.
    "recon/syslib/psx/libetc/INTR_DMA.c": {
        "2.7.2-970404 -G32": {"setIntrDMA"},
    },
    # _BlitClear: rung 2.8.0 = 20 count-exact vs wired 2.8.1's 39; whole-TU
    # rung flip is net-negative (MoveImage 9->35) => per-fn.
    # w60-a3 + orchestrator verify: the "2.7-unreachable" verdicts were a WIRING
    # artifact (-mno-split-addresses rejected by the rung, now dropped per-rung).
    # DrawOTag + _gpu_init_videomode PASS the REAL gate on the 2.7.2 splice.
    # _set_draw_mode does NOT: probe_272.py's REAL=0 there was a PROBE BUG
    # (same-mnemonic word mismatches counted as "reloc" -- the commutative
    # `or $2,$2,$3` vs retail `or $2,$3,$2` was excluded as reloc=1 in a fn
    # with ZERO relocations); its 2-diff or-operand floor stands, un-spliced.
    "recon/syslib/psx/libgpu/SYS.c": {
        "2.8.0": {"_BlitClear"},
        "2.7.2": {"DrawOTag", "_clearOTagR_dma", "_gpu_init_videomode",
                  "_que_ref", "_gpu_arm_timeout", "_gpu_check_timeout",
                  "_install_drain_cb"},
    },
    # w55-a5 (probe-verified): CdReset -> PASS 27/27 on 2.8.0; whole-TU flip
    # catastrophic (CdControlF PASS->51) => per-fn.
    "recon/syslib/psx/libcd/cdcont.c": {"2.8.0": {"CdReset"}},
    # w61-a6: _padLoadActInfo 26 -> 2 on the 2.7.2 rung (+1 move -> PASS).
    "recon/syslib/psx/libpad/PADCMD.c": {"2.7.2": {"_padLoadActInfo",
        # w63-a8: 27->2 count-exact via source landing @2a3a0587, then
        # PASS 50/50 on 2.7.2 (cse no-copy-prop identity is a version
        # property; 970404 control = 2). Whole-TU 18/19, 0 regressions.
        "_padSetActAlign_rcv"}},
    # W75-A16: _intrhand 24 -> 20, count-exact 116/116, on the 2.6.3 rung.
    # CHARACTERISED (a16_intrhand_{272,263}.s): across the WHOLE 166-line
    # function the 2.6.x codegen differs from the lane's 2.7.2 in exactly ONE
    # place -- the closing `if ((I_STAT & I_MASK) != 0)` test loads its two
    # halfwords into the OPPOSITE register pair (2.7.2 `lhu $3,0($5); lhu
    # $2,0($6)`; 2.6.3 `lhu $2,0($5); lhu $3,0($6)` == retail).  Everything
    # else is `move` vs `addu rd,rs,$0` spelling, which the gate normalises.
    # The rung is ORTHOGONAL to the two pend-block residuals: measured -4 on
    # EVERY source basin swept this wave (shipped 24->20, mp-inline 26->22,
    # block-local-en 32->28, retail-tree 38->34, sp/en/mp order 28->24), so it
    # buys the closing-test cluster and nothing else and cannot mask a source
    # lever.  2.6.0 is identical to 2.6.3 here; 970404/2.8.x go count-OFF
    # (110 @114).  NOT vacuous: the 272 lane passes no -g1, so sub-2.8 rungs
    # emit no COFF debug and the W74-A19 LM/.loc region-truncation bug (which
    # is DEFAULT-lane-only) cannot apply -- verified 0 `LM<n>:` / 0 `.loc` in
    # the rung's .s and the gate reads the full 116/116.
    "recon/syslib/psx/libetc/INTR.c": {"2.6.3": {"_intrhand"}},
    # W76-A14: __divdf3 PASS 184/184 on the 970404 rung + the two in-source
    # volatile "=m" RCSE mem-fences (see DIVDF3.c receipts).  970404's reorg is
    # 2.8-lineage (fills the `bnez $t2` slot with the copied `lui $v0,0x7FFF` --
    # the wired 2.7.2 rung's mark_target_live_regs cannot: its forward scan
    # stops at the first conditional jump, so the stale block-0 liveness keeps
    # $v0 claimed) while its allocator prices like 2.7.2 (no seat rotation).
    # Its reload_cse (the one vendor divergence -- Sony's rung lacked the pass,
    # A15 identity) is defeated by the fences.  Wired-lane control with the
    # fences: 2 diffs (inert); the sibling libmath TUs are untouched.
    "recon/syslib/psx/libmath/DIVDF3.c": {"2.7.2-970404": {"__divdf3"}},
}


def _cc1_flags_for_rung(ver, cc1_flags):
    """w60-a3 mechanism fix: sub-2.8 rungs REJECT -mno-split-addresses outright,
    which made every nosplit TU look '2.7-unreachable' (a wiring artifact, not a
    codegen fact -- probe_272.py proved DrawOTag/_set_draw_mode/
    _gpu_init_videomode hit REAL=0 on 2.7.2 once the flag is dropped)."""
    if ver.startswith(("2.6", "2.7")):
        return [f for f in cc1_flags if f != "-mno-split-addresses"]
    return cc1_flags


def _apply_cc1_ver_splice_272(rel_posix, txt, i_file, cc1_flags, s_file):
    table = PER_FN_CC1_VER_SPLICE_272.get(rel_posix)
    if not table:
        return txt
    for gi, (rung, names) in enumerate(sorted(table.items())):
        if not names:
            continue
        # W81-A9: "ver [extra-flag...]" -- extra flags ride on top of the TU
        # lane's (rung-filtered) flag set for the named fns only.
        ver, *extra_flags = rung.split()
        alt_cc1 = _resolve_cc1_alt(ver)
        if alt_cc1 is None:
            _warn_alt_fallback(rel_posix, ver, "the TU's own lane (ver-splice skipped)")
            continue
        rung_flags = _cc1_flags_for_rung(ver, cc1_flags)
        rung_flags += [f for f in extra_flags if f not in rung_flags]
        s_alt = s_file.with_suffix(".vs272_%d.s" % gi)
        r = run([alt_cc1, *rung_flags, i_file, "-o", s_alt])
        if r.returncode:
            sys.exit(f"[vs272 {ver}] {rel_posix}\n{r.stdout}{r.stderr}")
        alt = s_alt.read_text(errors="replace")
        alt = _MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)), alt)
        for i, name in enumerate(sorted(names)):
            a = _extract_ent_region_272(alt, name)
            b = _extract_ent_region_272(txt, name)
            if a is None or b is None:
                continue
            txt = txt.replace(b, _uniq_labels_272(a, "vs%d_%d" % (gi, i)), 1)
    return txt


def _extract_ent_region_272(txt, name):
    m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
    if not m:
        return None
    m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
    end = m.end() + (m2.end() if m2 else len(txt) - m.end())
    return txt[m.start():end]


def _uniq_labels_272(region, tag):
    defined = set(re.findall(r'^\$L(\d+):', region, re.M))
    if not defined:
        return region
    return re.sub(r'\$L(\d+)\b',
                  lambda m: ("$L%s_%s" % (tag, m.group(1))
                             if m.group(1) in defined else m.group(0)),
                  region)


def _apply_flag_splice_272(rel_posix, txt, i_file, cc1, cc1_flags, s_file):
    table = PER_FN_FLAG_SPLICE_272.get(rel_posix)
    if not table:
        return txt
    for gi, (extra_flag, names) in enumerate(sorted(table.items())):
        if not names:
            continue
        s_alt = s_file.with_suffix(".fs272_%d.s" % gi)
        r = run([cc1, *cc1_flags, extra_flag, i_file, "-o", s_alt])
        if r.returncode:
            sys.exit(f"[fs272 {extra_flag}] {rel_posix}\n{r.stdout}{r.stderr}")
        alt = s_alt.read_text(errors="replace")
        alt = _MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)), alt)
        for i, name in enumerate(sorted(names)):
            a = _extract_ent_region_272(alt, name)
            b = _extract_ent_region_272(txt, name)
            if a is None or b is None:
                continue
            txt = txt.replace(b, _uniq_labels_272(a, "fs%d_%d" % (gi, i)), 1)
    return txt


def _apply_fn_splice(rel_posix: str, s_file: Path, i_file: Path,
                      cc1_bin: Path, cc1_flags: list) -> None:
    """If `rel_posix` has entries in PER_FN_NO_DELAYED_BRANCH: recompile
    i_file (same preprocessed source) with -fno-delayed-branch added,
    extract each named function's region from that second .s, uniquify its
    local labels, and substitute it for that function's region in s_file
    IN PLACE (both .s files stay cached in the build dir for debugging)."""
    for table, extra_flag, tag in (
            (PER_FN_NO_DELAYED_BRANCH, "-fno-delayed-branch", "nodb"),
            (PER_FN_NO_THREAD_JUMPS, "-fno-thread-jumps", "nthr"),
            (PER_FN_FORCE_ADDR, "-fforce-addr", "faddr"),
            (PER_FN_G8, "-G8", "g8"),
            (PER_FN_NO_SPLIT_ADDRESSES, "-mno-split-addresses", "nosplit")):
        fn_names = table.get(rel_posix)
        if not fn_names:
            continue
        flagged_flags = list(cc1_flags)
        if extra_flag not in flagged_flags:
            flagged_flags.append(extra_flag)
        flagged_s = s_file.with_suffix(f".{tag}.s")
        r = run([cc1_bin, *flagged_flags, i_file, "-o", flagged_s])
        if r.returncode:
            sys.exit(f"[cc1-{tag}] {rel_posix}\n{r.stdout}{r.stderr}")
        flagged_text = flagged_s.read_text()
        normal_text = s_file.read_text()
        for name in sorted(fn_names):
            flagged_region = _extract_fn_region(flagged_text, name)
            target_region = _extract_fn_region(normal_text, name)
            _SPLICE_COUNTER[0] += 1
            flagged_region = _uniquify_local_labels(
                flagged_region, f"{tag}{_SPLICE_COUNTER[0]}")
            normal_text = normal_text.replace(target_region, flagged_region, 1)
        s_file.write_text(normal_text)


# w60-a5: DEFAULT-LANE twin of PER_FN_CC1_VER_SPLICE_272 (spec'd at a661dd36).
# Same dual-compile splice as _apply_fn_splice, but the second compile swaps the
# cc1 BINARY (a windows-gcc-psx ladder rung) instead of adding a flag: the named
# functions get rung codegen, every other function in the TU keeps the TU's own
# cc1, and the WHOLE .s still goes through the normal maspsx route.  That is the
# distinction from the per-TU "cc1_alt" key, which also swaps the assembler
# route (272 recipe, direct GNU as in reorder mode), and from "cc1_ver", which
# swaps the binary for the WHOLE TU.
#
# Layout: {rel_posix: {ladder_ver: {fn names}}}.  Runs BEFORE _apply_fn_splice,
# so a function listed in both tables ends up with the FLAG splice's region
# (compiled by the TU's own cc1) -- do not list one function in both.
#
# Rung flags: the rung is invoked with the TU's own cc1_flags.  Sub-2.8 rungs
# accept -G/-g1/-mgpOPT/-fgnu-linker but REJECT -mno-split-addresses (04Z note),
# so a TU carrying no_split_addresses cannot use a sub-2.8 rung here.
# MECHANISM VALIDATION (w60-a5, MULDF3.c, whole-TU gate per rung): splicing
# the rung that EQUALS the TU's own cc1 ("2.8.1") reproduces the un-spliced
# build exactly (_mul_mant_d 14, __muldf3 12), and every other rung moves ONLY
# the named function (__muldf3 held at 12 across all eight rungs) -- the splice
# is faithful and surgical.
#
# The a661dd36 spec ("_mul_mant_d wants 2.7.2 while __muldf3 wants the default
# lane", expected -2) is FALSIFIED on the current source: that reading predates
# the same commit's own 05E/3-fence landing, and 04Z (rung tables are
# basin-relative) applies.  Measured _mul_mant_d, whole-TU, via this mechanism:
# (w60-a5 RE-MEASURED after the _cc1_flags_for_rung landing; the first pass had
#  2.8.0 mis-transcribed as 14 -- only the 2.8.1 rung, i.e. the TU's own cc1,
#  reproduces the default, which is exactly the mechanism's identity check.)
#   default 14 | 2.8.1-splice 14 | 2.7.2 19 | 2.6.0/2.6.3/2.7.2-970404/2.8.0 21 |
#   2.95.2 80 | 2.91.66 86        (__muldf3: default 12, invariant)
# => no rung wins; MULDF3 stays a pure default-lane TU and the table stays
# empty until a real adopter is measured.  Keep the mechanism: the "two
# functions in one default-lane TU want different compilers" class is real
# (it is exactly what PER_FN_CC1_VER_SPLICE_272 exists for in the 272 lane).
# W76-orchestrator (2026-08-23): the C++ twin of PER_FN_CC1_VER_SPLICE, using
# RETAIL SN cc1plus binaries only (user ruling: gate compilers = retail PsyQ;
# no FSF/self-built stand-ins).  PsyQ 4.4/4.5 ship CC1PLPSX "2.8.1 SN32 BUILD
# 4.0.0010" -- the genuine 2.8.1-lineage vendor binary whose distribute_notes
# carries the Feb-6-1998 try_combine NULL-elim fix (the Night orphan-USE
# mechanism, W76-A13 provenance).  Same dual-compile-and-splice recipe as
# _apply_cc1_ver_splice; the whole .s still goes through maspsx.
# Resolution: env NFS4_CC1PL_281 > psq44 > psq45 (byte-comparable builds).
CC1PLUS_RUNGS = {
    # Resolution order: env override, dev-box psq44/psq45 drops, then
    # CC1PLPSX44.EXE BESIDE the resolved CC1 (the CI toolchain-zip slot,
    # same pattern as CC1PSX272.EXE).  Without the zip slot, CI silently
    # fell back on this rung's one customer (Night_CreateNightTableElement,
    # sealed PASS 113/113 on it) and decomp.dev showed the fn at 91.11% --
    # the default-lane residual, not the source's truth.  Retail PsyQ 4.4
    # CC1PLPSX.EXE sha256:
    # 70319c94de27924f5720af361afd2aa7e6de051a7718e0c1a7f07b57fa92109c
    "2.8.1-sn": [Path(_env("NFS4_CC1PL_281",
                           r"C:/Temp/psq44/pssn/bin/CC1PLPSX.EXE")),
                 Path(r"C:/Temp/psq45/BIN/CC1PLPSX.EXE"),
                 Path(CC1).parent / "CC1PLPSX44.EXE"],
}
# {rel_posix: {rung: {mangled fn names}}}
PER_FN_CC1PLUS_VER_SPLICE = {
    # W76-A13 (spec A13_c4.spec, PASS 113/113 x2 in the fixed splice gate;
    # landed by orchestrator with the retail psq44 binary after the user's
    # retail-only ruling): the fn's 2.8.0 residual is the orphan (use reg)
    # note class -- unfixable from source on 2.8.0 by construction.
    "recon/game/psx/night.cpp": {"2.8.1-sn": {"Night_CreateNightTableElement__FiliPUc"}},
}


def _resolve_cc1plus_rung(rung: str):
    for c in CC1PLUS_RUNGS.get(rung, []):
        if c.is_file():
            return c
    return None


def _apply_cc1plus_ver_splice(rel_posix: str, s_file: Path, i_file: Path,
                              cc1pl_flags: list) -> None:
    """Per-FUNCTION cc1plus-BINARY splice for the C++ (maspsx) lane."""
    table = PER_FN_CC1PLUS_VER_SPLICE.get(rel_posix)
    if not table:
        return
    for rung, fn_names in sorted(table.items()):
        if not fn_names:
            continue
        alt = _resolve_cc1plus_rung(rung)
        if alt is None:
            _warn_alt_fallback(rel_posix, rung,
                               "the TU's own cc1plus (fn ver-splice skipped)")
            continue
        alt_s = s_file.with_suffix(".vsp_%s.s" % rung.replace(".", "_").replace("-", "_"))
        r = run([alt, *cc1pl_flags, i_file, "-o", alt_s])
        if r.returncode:
            sys.exit(f"[cc1plus-vs {rung}] {rel_posix}\n{r.stdout}{r.stderr}")
        alt_text = alt_s.read_text(errors="replace")
        normal_text = s_file.read_text()
        for name in sorted(fn_names):
            alt_region = _extract_fn_region(alt_text, name)
            target_region = _extract_fn_region(normal_text, name)
            _SPLICE_COUNTER[0] += 1
            alt_region = _uniquify_local_labels(
                alt_region, f"vsp{_SPLICE_COUNTER[0]}")
            normal_text = normal_text.replace(target_region, alt_region, 1)
        s_file.write_text(normal_text)


PER_FN_CC1_VER_SPLICE = {
    # The pure-C mant_pair body is the prebuilt Sony 2.7.2 identity.  Its raw
    # region must remain in reorder mode so GNU as performs the authentic
    # HI/LO hazard padding and return delay fill.
    "recon/syslib/psx/libmath/MULDF3.c": {"2.7.2": {"_mul_mant_d"}},
    # w60 orchestrator (A4 ladder + A5 mechanism): cdread.c whole-TU 2.8.1 is
    # 81<87 but costs _read_data_int's PASS.  Per-fn pricing on the 2.8.1 rung:
    # _read_int 21->15, _read_issue 23->22, CdRead 43->45 (worse -- stays 2.8.0).
    "recon/syslib/psx/libcd/cdread.c": {
        # CdReadSync is byte-exact only on 2.8.1 (the TU's 2.7.2 lane is four
        # diffs), confirming a distinct source-object compiler identity.
        "2.8.1": {"_read_int", "_read_issue", "CdReadSync"},
    },
    # W81-A15 / user ruling 2026-08-31: the `2.8.1-norcse` rung is a SELF-BUILT,
    # SOURCE-PATCHED cc1 and is banned by the retail-only ruling; its acceptance
    # contract also depended on WHERE the AV-ing compiler's stdio buffer happened
    # to flush (path-bound; excluded the TU from copy-mode probing).  FONT.c
    # runs on its own wired 2.8 lane:
    #   FntFlush FAIL 6 @199/199 (count-exact), FntPrint PASS 240/240;
    #   brdist 0, slotcheck 0.
    # The 6 rows are ONE certified `reload_cse_regs` identity; no legal rung
    # reaches it: 2.6.0 102 / 2.6.3 98 / 2.7.2 85 / 2.7.2-970404 31 (ladder AND
    # the retail PsyQ 4.1 binary) / 2.8.0 6 / 2.8.1 6 (ladder AND the retail
    # PsyQ 4.4 binary).  Both fns are certified PsyQ 4.3 VENDOR-OBJECT
    # identities (REAL=0 vs libgpu.lib(FONT.OBJ)) -- Sony's build, not our
    # source.  (no FONT.c entry)
    # W74-A19: PAD_update wants 2.7.2 codegen for its constant remat while the
    # TU stays 2.8.0. W80-root: per-function normal-route ladder probes show
    # that 2.6.0/2.6.3/2.7.2 all emit the retail padinit, PAD_restore, and
    # PAD_state epilogues exactly. Select the already-established 2.7.2 object
    # identity: all five pad.c functions are source-only PASS, reproduced 2x.
    "recon/eaclib/psx/pad.c": {
        "2.7.2": {"padinit", "PAD_restore", "PAD_state", "PAD_update"},
    },
    # W80-root: PADENTRY remains a normal maspsx TU, but these three public
    # wrappers carry the older Sony compiler's return-epilogue identity.  The
    # complete ladder gives PASS on 2.6.0, 2.6.3, 2.7.2, and 2.7.2-970404;
    # every 2.8-family rung leaves the stack restore in the opposite position.
    # Select the established PsyQ 4.0 / GCC 2.7.2 identity per function.
    "recon/syslib/psx/libpad/PADENTRY.c": {
        "2.7.2": {"PadStartCom", "PadStopCom", "PadGetState"},
    },
}


def _apply_cc1_ver_splice(rel_posix: str, s_file: Path, i_file: Path,
                          cc1_flags: list) -> None:
    """Per-FUNCTION cc1-BINARY splice for the normal (maspsx) lane."""
    table = PER_FN_CC1_VER_SPLICE.get(rel_posix)
    if not table:
        return
    for ver, fn_names in sorted(table.items()):
        if not fn_names:
            continue
        alt_cc1 = _resolve_cc1_alt(ver)
        if alt_cc1 is None:
            # CI without the ladder: keep the TU's own codegen so the tree still
            # builds (the named fns' match numbers drift until it is installed).
            _warn_alt_fallback(rel_posix, ver,
                               "the TU's own cc1 (fn ver-splice skipped)")
            continue
        alt_s = s_file.with_suffix(".vs_%s.s" % ver.replace(".", "_"))
        try:
            alt_s.unlink()
        except FileNotFoundError:
            pass
        run_env = None
        alt_input = i_file
        alt_flags = _cc1_flags_for_rung(ver, cc1_flags)
        if ver == "2.8.1-norcse":
            run_env = os.environ.copy()
            run_env["GCC_NO_RELOAD_CSE"] = "1"
            run_env["TMPDIR"] = run_env["TEMP"] = run_env["TMP"] = r"C:\Temp"
            # Exact proven vendor-style invocation.  -g1 crashes before this
            # compiler writes FntFlush; -mgas is part of the object identity.
            alt_flags = ["-quiet", "-O2", "-G4", "-mgas",
                         "-mno-split-addresses"]
            # W79-root: compile a structurally checked one-function input
            # instead of relying on the instrumented compiler to fault while
            # entering FntPrint. Canonical private-name restoration changes
            # heap timing and can make that fault truncate assembler metadata
            # after the already-complete FntFlush instruction body. Slicing
            # BEFORE cc1 makes the lane deterministic and performs no
            # post-compile instruction rewrite. Pre-change tool backup:
            # Git commit 93adfbcd.
            input_text = i_file.read_text()
            markers = list(re.finditer(
                r"^extern int FntPrint\s*\(", input_text, re.M))
            if len(markers) != 1:
                sys.exit(f"[cc1-vs {ver}] expected one FntPrint input marker "
                         f"for {rel_posix}, found {len(markers)}")
            alt_input = s_file.with_suffix(".vs_2_8_1_norcse.i")
            alt_input.write_text(input_text[:markers[0].start()].rstrip() + "\n")
        r = run([alt_cc1, *alt_flags, alt_input, "-o", alt_s], env=run_env)
        if r.returncode:
            sys.exit(f"[cc1-vs {ver}] {rel_posix}\n{r.stdout}{r.stderr}")
        if not alt_s.is_file():
            sys.exit(f"[cc1-vs {ver}] no output for {rel_posix}\n{r.stdout}{r.stderr}")
        alt_text = alt_s.read_text(errors="replace")
        if ver == "2.8.1-norcse":
            # The sliced compiler input must produce exactly one complete,
            # normally terminated function. Keep the contract narrow so this
            # lane can never accept a partial or unrelated assembly stream.
            if set(fn_names) != {"FntFlush"}:
                sys.exit("[cc1-vs 2.8.1-norcse] unexpected function set")
            if re.findall(r"^\t\.ent\t([^\s]+)", alt_text, re.M) != ["FntFlush"]:
                sys.exit("[cc1-vs 2.8.1-norcse] partial output has unexpected .ent set")
            if re.findall(r"^\t\.end\t([^\s]+)", alt_text, re.M) != ["FntFlush"]:
                sys.exit("[cc1-vs 2.8.1-norcse] complete FntFlush end missing")
        normal_text = s_file.read_text()
        for name in sorted(fn_names):
            alt_region = _extract_fn_region(alt_text, name)
            target_region = _extract_fn_region(normal_text, name)
            _SPLICE_COUNTER[0] += 1
            alt_region = _uniquify_local_labels(
                alt_region, f"vs{_SPLICE_COUNTER[0]}")
            # W74-A19 mechanism fix: sub-2.8 rungs emit -g1 COFF debug INSIDE
            # the fn region (.loc lines + LM<n>: labels; 2.8 emits after .end).
            # LM<n> is neither $L nor .L so it survived uniquify, objdump
            # printed it as a block label, and verify_asm's fn block ENDED
            # THERE -- every prior sub-2.8 ver-splice probe read vacuously
            # short. Strip both classes (debug-only, codegen-identical).
            alt_region = re.sub(r"^\t\.loc\t[^\n]*\n", "", alt_region, flags=re.M)
            alt_region = re.sub(r"^LM\d+:\n", "", alt_region, flags=re.M)
            if (rel_posix == "recon/syslib/psx/libmath/MULDF3.c"
                    and ver == "2.7.2" and name == "_mul_mant_d"):
                alt_region = alt_region.replace(
                    "_mul_mant_d:\n",
                    "_mul_mant_d:\n\t.set\tmaspsx_gas_reorder\n", 1)
            normal_text = normal_text.replace(target_region, alt_region, 1)
        s_file.write_text(normal_text)


ASPSX_VERSION = "2.77"
G_VALUE = "4"               # original built with -G4
AS_ARCH = ["-EL", "-march=r3000", "-mtune=r3000"]
CC1_FLAGS = ["-quiet", "-O2", f"-G{G_VALUE}", "-g1", "-mgpOPT", "-fgnu-linker"]
CPP_FLAGS = ["-nostdinc", "-undef", "-D__GNUC__=2", "-D__OPTIMIZE__",
             "-Dmips", "-D__mips__", "-D__psx__", "-DPSX",
             f"-I{ROOT / 'include'}", f"-I{RECON}"]


def run(cmd, **kw):
    r = subprocess.run([str(c) for c in cmd], capture_output=True, text=True, **kw)
    return r


_MOVE_RE = re.compile(r"^(\tmove\t)(\$[a-z0-9]+),(\$[a-z0-9]+)[ \t]*$", re.M)


def _compile_c_272(rel: Path, tu_flags: dict, i_file: Path, s_file: Path,
                   obj: Path, cc1_path: Path = None) -> Path:
    """The 04M gcc-2.7.2 lane for Sony library TUs: PsyQ 4.0's CC1PSX +
    DIRECT GNU as in its default reorder mode (no maspsx).

    Why no maspsx: 2.7.2 has no -msplit-addresses -- it emits assembler
    MACROS (`sw $r,sym`, `la`) before UNWRAPPED reorder-mode branches and
    relies on a reordering assembler to backward-fill the delay slots
    (splitting the macro: lui above the branch, the %lo half IN the slot --
    the retail AT-MACRO-SPLIT shape no ASPSX-faithful pipeline can produce).
    GNU as in .set-reorder default reproduces this byte-exactly (verified on
    _err_math 25/25).  maspsx would inject .set noreorder per .ent and
    destroy exactly that.  INCLUDE_ASM bodies carry their own .set noreorder
    headers and assemble verbatim either way.

    The one spelling fix: modern gas expands `move` to `or`; 2.7.2-era
    toolchains (and retail) used `addu` -- rewritten textually before as.
    """
    tu_g_value = str(tu_flags.get("g_value", "0"))
    cc1_flags = ["-quiet", "-O2", f"-G{tu_g_value}", "-mgas"]
    # w51-a8 defect fix: forward ALL cc1-relevant PER_TU keys, not just
    # no_delayed_branch (the rest silently no-op'd inside this lane -- same
    # class as the w47 compile_c g_value no-op).  QSORT's identity needs
    # no_strength_reduce here.
    if tu_flags.get("no_delayed_branch"):
        cc1_flags.append("-fno-delayed-branch")
    if tu_flags.get("no_strength_reduce"):
        cc1_flags.append("-fno-strength-reduce")
    if tu_flags.get("force_addr"):
        cc1_flags.append("-fforce-addr")
    # w61-a8: char is UNSIGNED on the cc1_272 lane by default -- a lbu-vs-lb
    # diff on plain char is a TU FLAG question, not a cast question.
    if tu_flags.get("signed_char"):
        cc1_flags.append("-fsigned-char")
    if tu_flags.get("no_schedule_insns"):
        cc1_flags.append("-fno-schedule-insns")
    if tu_flags.get("no_schedule_insns2"):
        cc1_flags.append("-fno-schedule-insns2")
    if tu_flags.get("no_builtin"):
        cc1_flags.append("-fno-builtin")
    if tu_flags.get("no_rerun_cse_after_loop"):
        cc1_flags.append("-fno-rerun-cse-after-loop")
    # w52-a3: forward the split-addresses key too (2.8.x rungs via cc1_alt
    # need -mno-split-addresses to express the SYS.c clamp identity).  The
    # common rung filter below removes it again for sub-2.8 compilers, which
    # reject that option; this also keeps forced ladder probes honest.
    if tu_flags.get("no_split_addresses"):
        cc1_flags.append("-mno-split-addresses")
    lane_ver = (os.environ.get("NFS4_FORCE_CC1_ALT")
                or tu_flags.get("cc1_alt")
                or ("2.7.2" if cc1_path is None else ""))
    cc1_flags = _cc1_flags_for_rung(str(lane_ver), cc1_flags)
    cc1 = cc1_path if cc1_path is not None else CC1_272
    r = run([cc1, *cc1_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1-272/alt {cc1}] {rel}\n{r.stdout}{r.stderr}")
    txt = s_file.read_text(errors="replace")
    txt = _MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)), txt)
    txt = _apply_cc1_ver_splice_272(rel.as_posix(), txt, i_file, cc1_flags,
                                    s_file)
    txt = _apply_flag_splice_272(rel.as_posix(), txt, i_file, cc1, cc1_flags,
                                 s_file)
    s_file.write_text(txt)
    if tu_flags.get("aspsx_277"):
        # W81-root: READ/WRITE are source- and cc1-exact on the 2.7.2 lane,
        # but GNU as moves the stack restore into jr's delay slot.  Real
        # ASPSX 2.77 and 2.56 both preserve `addiu sp; jr; nop`, yielding the
        # retail 192-byte bodies (only unresolved JAL relocation bytes differ
        # before link).  maspsx 2.77 reproduces those real-ASPSX bytes while
        # still producing the ELF object consumed by this build.
        maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}",
                      "--expand-div", "--run-assembler",
                      f"--gnu-as-path={AS}", *AS_ARCH, f"-G{tu_g_value}",
                      "-I", ROOT / "include", "-I", ROOT, "-o", obj]
        r = subprocess.run([str(c) for c in maspsx_cmd], input=txt,
                           capture_output=True, text=True, cwd=ROOT)
        if r.returncode or not obj.exists():
            sys.exit(f"[maspsx/as-272] {rel}\n{r.stdout}{r.stderr}")
    else:
        r = run([AS, *AS_ARCH, f"-G{tu_g_value}", "-I", ROOT / "include",
                 "-I", ROOT, "-o", obj, s_file])
        if r.returncode or not obj.exists():
            sys.exit(f"[as-272] {rel}\n{r.stdout}{r.stderr}")
    import fix_symsizes; fix_symsizes.fix(str(obj))
    return obj


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

    # W52 ladder lane: env force (probe-only) wins over everything, then the
    # per-TU cc1_alt wiring.  Both reuse the 272 recipe with a swapped cc1.
    forced_normal_ver = os.environ.get("NFS4_FORCE_CC1_VER")
    alt_ver = (None if forced_normal_ver else
               (os.environ.get("NFS4_FORCE_CC1_ALT") or tu_flags.get("cc1_alt")))
    if alt_ver:
        cc1_alt = _resolve_cc1_alt(str(alt_ver))
        if cc1_alt is not None:
            return _compile_c_272(rel, tu_flags, i_file, s_file, obj,
                                  cc1_path=cc1_alt)
        if os.environ.get("NFS4_FORCE_CC1_ALT"):
            # probe use: fail loud -- a silent fallback would fake the A/B
            sys.exit(f"[cc1-alt] {rel}: ladder rung {alt_ver!r} not found "
                     f"under {GCC_LADDER}")
        # wired use (CI without the ladder): fall back to the nearest lane so
        # the tree still BUILDS -- CC1_272 keeps the 272 recipe (exact for the
        # "2.7.2" rung, approximate otherwise); else the normal 2.8 lane below.
        if CC1_272 is not None:
            _warn_alt_fallback(rel, str(alt_ver), "the cc1_272 lane")
            return _compile_c_272(rel, tu_flags, i_file, s_file, obj)
        _warn_alt_fallback(rel, str(alt_ver), "the default 2.8 pipeline")

    if tu_flags.get("cc1_272") and not forced_normal_ver:
        if CC1_272 is not None:
            return _compile_c_272(rel, tu_flags, i_file, s_file, obj)
        global _warned_272
        if not _warned_272:
            _warned_272 = True
            print("WARNING: gcc-2.7.2 cc1 not found (env NFS4_CC1_272 / "
                  "CC1PSX272.EXE beside CC1 / dev-box psyq400) -- cc1_272 "
                  "lane TUs fall back to the 2.8 pipeline this run",
                  file=sys.stderr)
        # fall through to the normal 2.8 lane below

    # w47 fix: compile_c honoured only the global -G; the per-TU "g_value" key
    # (long wired in compile_cpp below) silently no-op'd for the entire C lane
    # (all of eaclib/syslib + frontend .c) -- found independently by w47-a7/a8/a9.
    tu_g_value = str(tu_flags.get("g_value", G_VALUE))
    cc1_flags = [f"-G{tu_g_value}" if f == f"-G{G_VALUE}" else f for f in CC1_FLAGS]
    if tu_flags.get("no_delayed_branch"):
        cc1_flags.append("-fno-delayed-branch")
    if tu_flags.get("no_split_addresses"):
        cc1_flags.append("-mno-split-addresses")
    if tu_flags.get("no_schedule_insns"):
        cc1_flags.append("-fno-schedule-insns")
    if tu_flags.get("no_schedule_insns2"):
        cc1_flags.append("-fno-schedule-insns2")
    if tu_flags.get("no_strength_reduce"):
        cc1_flags.append("-fno-strength-reduce")
    if tu_flags.get("force_addr"):
        cc1_flags.append("-fforce-addr")
    if tu_flags.get("no_builtin"):
        cc1_flags.append("-fno-builtin")
    if tu_flags.get("no_rerun_cse_after_loop"):
        cc1_flags.append("-fno-rerun-cse-after-loop")
    # w52-a7: PER_TU "cc1_ver" swaps ONLY the cc1 binary (ladder rung) inside
    # the NORMAL maspsx pipeline -- the single-variable version axis.  The
    # probe-only NFS4_FORCE_CC1_VER applies that axis to the current C TU.
    # Distinct
    # from cc1_alt, which also swaps the assembler route (272 recipe) and for
    # eaclib costs a measured 42-PASS route penalty.
    cc1_bin = CC1
    cc1_ver = os.environ.get("NFS4_FORCE_CC1_VER") or tu_flags.get("cc1_ver")
    if cc1_ver:
        cc1_bin = _resolve_cc1_alt(str(cc1_ver))
        if cc1_bin is None:
            if os.environ.get("NFS4_FORCE_CC1_VER"):
                sys.exit(f"[cc1-ver] {rel}: ladder rung {cc1_ver!r} not found "
                         f"under {GCC_LADDER}")
            # CI without the ladder: fall back to the default cc1 so the tree
            # still builds; the TU's match numbers drift until installed.
            _warn_alt_fallback(rel, str(cc1_ver), "the default cc1")
            cc1_bin = CC1
        else:
            cc1_flags = _cc1_flags_for_rung(str(cc1_ver), cc1_flags)
    r = run([cc1_bin, *cc1_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1] {rel}\n{r.stdout}{r.stderr}")

    if not forced_normal_ver:
        _apply_cc1_ver_splice(rel.as_posix(), s_file, i_file, cc1_flags)
    _apply_fn_splice(rel.as_posix(), s_file, i_file, cc1_bin, cc1_flags)

    raw40 = PER_FN_RAW40_SPLICE.get(rel.as_posix())
    if raw40 and CC1_PSYQ40.exists():
        # W73 raw-4.0 splice: capture maspsx's TEXT (no --run-assembler),
        # substitute each named fn's region with the PsyQ 4.0 cc1's raw
        # macro-form region, then assemble with the lane's own GNU as --
        # whose .set-reorder pass splits the trailing sw macro across the
        # jr exactly like Sony's internal assembler did (provenance above).
        cap_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}",
                   "--expand-div", "--print-output"]
        if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
            cap_cmd.append("--jtbl-at-fusion")
        if tu_flags.get("nop_before_label"):
            cap_cmd.append("--nop-before-label")
        r = subprocess.run([str(c) for c in cap_cmd],
                           input=s_file.read_text(), capture_output=True,
                           text=True, cwd=ROOT)
        if r.returncode:
            sys.exit(f"[maspsx-capture] {rel}\n{r.stderr}")
        post = r.stdout
        alt_s = obj.with_suffix(".raw40.s")
        # the 1996-era cc1 builds its scratch path from TMPDIR and writes
        # cta<pid> files there; a POSIX-style or empty TMPDIR makes it try
        # "\/cta..." at the drive root (the stray cta* litter class).
        _env40 = dict(os.environ)
        _tmp40 = os.environ.get("TEMP") or r"C:\Temp"
        _env40.update(TMPDIR=_tmp40, TMP=_tmp40, TEMP=_tmp40)
        # W74-A15: drop -g1 for the alt compile -- the 1996 cc1 answers it
        # with COFF debug GNU as rejects (.def/.val/.scl/.type/.endef, .loc,
        # LM<n>: labels; the LM labels also split the .ent region). Debug-only,
        # codegen-identical (PADSEQD was immune only because its fn carried
        # no params/labels).
        _flags40 = [str(f) for f in cc1_flags if str(f) != "-g1"]
        r2 = subprocess.run([str(CC1_PSYQ40), *_flags40,
                             str(i_file), "-o", str(alt_s)],
                            capture_output=True, text=True, env=_env40)
        if r2.returncode:
            sys.exit(f"[cc1-psyq40] {rel}\n{r2.stdout}{r2.stderr}")
        alt_text = alt_s.read_text(errors="replace")
        for name in sorted(raw40):
            fr = _extract_fn_region(alt_text, name)
            # maspsx's --print-output strips the leading tab from .ent/.end;
            # extract the post-maspsx region with a whitespace-tolerant pair.
            pm = re.search(r"^[ \t]*\.ent[ \t]+%s\b[^\n]*\n" % re.escape(name),
                           post, re.M)
            if not pm:
                sys.exit(f"[raw40] post-maspsx .ent {name} not found in {rel}")
            pm2 = re.search(r"^[ \t]*\.end[ \t]+%s[ \t]*$" % re.escape(name),
                            post[pm.end():], re.M)
            pend = pm.end() + (pm2.end() if pm2 else 0)
            tr = post[pm.start():pend]
            _SPLICE_COUNTER[0] += 1
            fr = _uniquify_local_labels(fr, f"raw40{_SPLICE_COUNTER[0]}")
            # W75-A19: the spliced region goes STRAIGHT to GNU as -- it never
            # passes through maspsx (whose expand_move rewrites `move`) nor
            # through the 272 lane's own move fix above.  Modern gas spells
            # the `move` PSEUDO as `or rD,rS,$0` (0x25) while retail and every
            # maspsx-lane object carry `addu` (0x21), so every `move` in a
            # spliced region assembled to the WRONG WORD.  The gate cannot see
            # it (verify_asm normalizes `move` <-> `addu rD,rS,zero`, and
            # objdump prints the `or` form as `move` too) but objdiff compares
            # BYTES: firstfile read 94.17% on the board while gating PASS
            # 103/103, on 10 such words.  Semantics identical, encoding wrong.
            # (This is catalog 04M's named "pipeline needs a move->addu pass"
            # gap; the 272 lane already does it, compile_c's raw40 branch did
            # not.)
            fr = _MOVE_RE.sub(
                lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)), fr)
            post = post.replace(tr, fr, 1)
        merged = obj.with_suffix(".raw40merged.s")
        merged.write_text(post)
        # maspsx --run-assembler force-feeds GNU as -G0 (its default; the
        # --dont-force-G0 flag exists to disable) -- mirror that here, else
        # the spliced sw macros go gp-relative and diverge.
        r3 = run([AS, *AS_ARCH, "-G0", "-I", ROOT / "include",
                  "-I", ROOT, "-o", obj, merged])
        if r3.returncode or not obj.exists():
            sys.exit(f"[as-raw40] {rel}\n{r3.stdout}{r3.stderr}")
    else:
        # maspsx reads cc1 .s on stdin; remaining args pass through to GNU as.
        maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}", "--expand-div",
                      "--run-assembler", f"--gnu-as-path={AS}",
                      *AS_ARCH, f"-G{tu_g_value}", "-I", ROOT / "include",
                      "-I", ROOT, "-o", obj]
        if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
            maspsx_cmd.append("--jtbl-at-fusion")
        if tu_flags.get("nop_before_label"):
            maspsx_cmd.append("--nop-before-label")
        r = subprocess.run([str(c) for c in maspsx_cmd],
                           input=s_file.read_text(), capture_output=True, text=True,
                           cwd=ROOT)
        if r.returncode or not obj.exists():
            sys.exit(f"[maspsx/as] {rel}\n{r.stdout}{r.stderr}")
    # hand-asm blocks lack .size/.type => objdiff sees 0-length fns (0% on
    # decomp.dev despite PASS). Symtab-metadata-only, code bytes untouched.
    import fix_symsizes; fix_symsizes.fix(str(obj))
    return obj


def compile_cpp(src: Path) -> Path:
    """Vendored reconstruction C++ TU -> ELF via CC1PLPSX. No -D__GNUC__ so
    nfs4_types.h uses its self-contained (PsyQ-free) type defs."""
    rel = src.relative_to(ROOT)
    tu_flags = per_tu_flags(src)
    tu_g_value = str(tu_flags.get("g_value", G_VALUE))
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
    cc1pl_flags = ["-quiet", "-O2", f"-G{tu_g_value}"]
    if tu_flags.get("no_delayed_branch"):
        cc1pl_flags.append("-fno-delayed-branch")
    # w38-a9/a10 finding: these four keys were wired in compile_c only, so any
    # past per-TU flag experiment on a C++ TU silently measured a no-op.
    # Mirrors the compile_c block above; CC1PLPSX accepts all four (verified
    # by a9/a10 local patches: they DO change C++ codegen when applied).
    if tu_flags.get("no_split_addresses"):
        cc1pl_flags.append("-mno-split-addresses")
    if tu_flags.get("no_schedule_insns"):
        cc1pl_flags.append("-fno-schedule-insns")
    if tu_flags.get("no_schedule_insns2"):
        cc1pl_flags.append("-fno-schedule-insns2")
    if tu_flags.get("no_strength_reduce"):
        cc1pl_flags.append("-fno-strength-reduce")
    if tu_flags.get("no_builtin"):
        cc1pl_flags.append("-fno-builtin")
    r = run([CC1PL, *cc1pl_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1pl] {rel}\n{r.stdout}{r.stderr}")

    _apply_cc1plus_ver_splice(rel.as_posix(), s_file, i_file, cc1pl_flags)
    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1PL, cc1pl_flags)

    maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}", "--expand-div",
                  "--run-assembler", f"--gnu-as-path={AS}",
                  *AS_ARCH, f"-G{tu_g_value}", "-I", RECON, "-o", obj]
    if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
        maspsx_cmd.append("--jtbl-at-fusion")
    if tu_flags.get("nop_before_label"):
        maspsx_cmd.append("--nop-before-label")
    # cfront dtor mangling: our CC1PL emits `_._<class>` (NO_DOLLAR_IN_LABEL -> '.'),
    # but EA's toolchain used the '.'->'_' convention (NO_DOT_IN_LABEL) => `___<class>`.
    # `_._` only ever appears as the dtor prefix, so this rename is surgical.
    s_text = s_file.read_text().replace("_._", "___")
    r = subprocess.run([str(c) for c in maspsx_cmd],
                       input=s_text, capture_output=True, text=True,
                       cwd=ROOT)
    if r.returncode or not obj.exists():
        sys.exit(f"[maspsx/as++] {rel}\n{r.stdout}{r.stderr}")
    import fix_symsizes; fix_symsizes.fix(str(obj))  # see compile_c note
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
    # The linker script's `*/src/...` selectors place input sections, but GNU
    # ld does not use wildcard selectors to discover files.  Pass the current
    # source-lane objects explicitly through a response file; otherwise only
    # the exactly named raw data objects are loaded and every code reference
    # (vtable slots, jump-table .L labels, calls) is reported as undefined.
    # Derive this list from live source paths rather than build/**/*.o so stale
    # probe/renamed objects can never leak into the retail link.
    src_objects = []
    for src in sorted((ROOT / "src").rglob("*.c")):
        obj = OUT / (str(src.relative_to(ROOT)) + ".o")
        if obj.exists():
            src_objects.append(obj)
    rsp = BUILD / "link_src_objects.rsp"
    rsp.write_text("\n".join(f'"{obj.relative_to(ROOT).as_posix()}"'
                              for obj in src_objects) + "\n")
    cmd = [LD, f"@{rsp.relative_to(ROOT).as_posix()}"]
    # splat's undefined_{syms,funcs}_auto.txt are `name = 0xADDR;` assignments
    # (valid ld script) for refs to addresses outside our segments (HW regs,
    # BIOS, overlay). Feed them so absolute relocations resolve.
    for auto in ("undefined_syms_auto.txt", "undefined_funcs_auto.txt",
                 "retail_data_symbols.ld"):
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
