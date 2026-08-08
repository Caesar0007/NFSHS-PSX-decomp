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
MASPSX = _env("NFS4_MASPSX", r"C:/Temp/maspsx-master/maspsx.py")
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
#   "jtbl_at_fusion"     -> pass --jtbl-at-fusion to maspsx for this TU only
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
#
# The 7 TUs below own the retail binary's 7 ASPSX-$at-macro jtbl sites
# (w23-a11 investigation plus later per-site corrections); the other 26 jtbl TUs are deliberately absent
# here (their explicit 5-insn form already matches and must stay untouched).
PER_TU_FLAGS = {
    # 2026-08-04G -G8 PROBE QUEUE (w47-a7 census S7, 20 objects gated inline):
    # these 7 TUs meet the a8 wiring bar -- net diff improvement + ZERO PASS
    # regressions + reproduced 2x -- under g_value 8 (= CC1PSX's DEFAULT when a
    # makefile passes no -G at all, per w47-a10 H2).  Whole-TU gate deltas:
    #   copspeak  24->27 PASS, 28->0 diffs (TU SEALED: RadioStaticInit/Active/Squelch)
    #   audioeng   5->7  PASS, 62->50    (AudioEng_Pause + AudioEng_CleanUp)
    #   input      4->6  PASS, 69->39    (Input_StartUp + Input_WingCommandMode)
    #   hudpmx     21->5 diffs           nfs3 128->119   r3dcar 186->183   weather 106->104
    # NOT wired from the same queue -- gate evidence AGAINST -G8 (PASS regressions):
    # replay (+158 diffs, 4 regr), audiocmn (-61 but 1 regr), simqueue (1 conv/1 regr),
    # draww (1 conv/2 regr); G5/G6/G7 ladder identical to G4 on all three mixed TUs
    # (the sensitive symbols are exactly 8 bytes -- their oracles MIX gp-rel and
    # absolute 8-byte refs, so no single -G value fits).  INERT (no gate delta, left
    # at default): aih_play, dashhud, mpause, render, hrzsku, overlays,
    # psxcontroller, textureprocess.  Receipts: scratch/w47_a7_census.md S7.
    "recon/game/common/audioeng.cpp":       {"g_value": "8"},
    "recon/game/common/copspeak.cpp":       {"g_value": "8"},
    "recon/game/common/input.cpp":          {"g_value": "8"},
    "recon/game/common/hudpmx.cpp":         {"g_value": "8"},
    "recon/game/common/nfs3.cpp":           {"g_value": "8"},
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
    "recon/syslib/psx/libcd/drv.c":       {"jtbl_at_fusion": True},  # CD_get_intr
    "recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True,   # FntPrint
                                             "no_split_addresses": True},  # w48-a2: -34
    # w51-a3: libcd lane verdicts (measured per-TU; cdread.c = NO, 169->289):
    "recon/syslib/psx/libcd/cdread2.c":     {"cc1_272": True},  # 5->0, 2/2 PASS
    "recon/syslib/psx/libcd/cdcont.c":      {"cc1_272": True},  # 77->19, +5 conv, CdReset PASS->3
    "recon/syslib/psx/libcd/toc.c":         {"cc1_272": True},  # 76->64, CdGetToc->PASS
    "recon/syslib/psx/libcd/TYPE.c":        {"cc1_272": True},  # 8->6, CdGetDiskType->PASS
    # w51-a7 lane wins (all zero-PASS-regression, whole-TU gated):
    "recon/syslib/psx/libapi/COUNTER.c":    {"cc1_272": True},  # 3/3 PASS
    "recon/syslib/psx/libetc/INTR_DMA.c":   {"cc1_272": True},  # 3/3 PASS
    "recon/syslib/psx/libetc/INTR_VB.c":    {"cc1_272": True},  # 4/4 PASS
    "recon/syslib/psx/libetc/VSYNC.c":      {"cc1_272": True},  # 2/2 PASS
    "recon/syslib/psx/libetc/VMODE.c":      {"cc1_272": True},  # 2/2 PASS
    "recon/syslib/psx/libcard/CARDINIT.c":  {"cc1_272": True},  # 2/2 PASS
    # w51-a7: COUPLED with the LIBPRESS.c source (MDEC_status fence removed --
    # 2.8-only device); without this entry LIBPRESS loses 1 PASS.
    "recon/syslib/psx/libpress/LIBPRESS.c": {"cc1_272": True},  # 6->11/12 PASS
    # w51-a8 lane wins:
    "recon/syslib/psx/libc/MEMCMP.c":       {"cc1_272": True},  # 6 -> PASS 19/19
    "recon/syslib/psx/libc/QSORT.c":        {"cc1_272": True, "no_strength_reduce": True},  # 70 -> PASS 84/84
    "recon/syslib/psx/libsn/READ.c":        {"cc1_272": True},  # + UNFILL_272 -> PASS
    "recon/syslib/psx/libsn/WRITE.c":       {"cc1_272": True},  # + UNFILL_272 -> PASS
    # w51-a5: WAITRC2 lane win (setRC2wait 3->PASS 8/8, AT-MACRO-SPLIT class;
    # chkRC2wait unchanged; zero regressions). PADCMD/PADSEQD have conversion
    # evidence but net-regress -- receipted for a 272-basin re-match pass.
    "recon/syslib/psx/libpad/WAITRC2.c":    {"cc1_272": True},
    # w51-a2: libmcrd cluster = cc1_272 lane (04M law). jtbl_at_fusion is inert in
    # this lane (no maspsx); kept out. LIBMCRD 2->8 PASS under the lane.
    "recon/syslib/psx/libmcrd/LIBMCRD.c": {"cc1_272": True},
    "recon/syslib/psx/libpad/PADENTRY.c":   {"jtbl_at_fusion": True,   # PadInfoAct
                                             "no_split_addresses": True},  # w48-a4 3x: PadInfoAct->PASS
    "recon/game/common/r3dcar.cpp":         {"jtbl_at_fusion": True,   # R3DCar_InsertCarFacet
                                             "g_value": "8"},          # 2026-08-04G -G8 queue
    # NOTE (w38-a5): sfx.cpp does NOT want jtbl_at_fusion -- BOTH of its switch
    # dispatches (Sfx_BuildSouffleFacet@jtbl_8005699C, Sfx_Add@jtbl_800569D4)
    # use the SPLIT-address form in the oracle
    # (`lui %hi(jtbl); addiu %lo(jtbl); sll idx,2; addu; lw 0(idx)`), not the
    # fused `$at` macro. The entry was a mis-attribution; removing it takes
    # Sfx_Add 7 -> 0 (PASS) and drops 3 diffs off Sfx_BuildSouffleFacet.
    "recon/syslib/psx/libc/SPRINTF.c":      {"jtbl_at_fusion": True},  # sprintf
    # w33-a10: EA's own eaclib PAD.OBJ was built WITHOUT split addresses --
    # proven by the oracle's `lui $at; addu $at,$at,$idx; lbu %lo(sym)($at)`
    # indexed loads (two independent sites in PAD_update, no jump table in
    # sight) plus the unfused `la` into a callee-saved reg in padinit /
    # PAD_restore / PAD_state. Whole-TU sweep with the flag: 5/5 functions
    # improve or hold (see the per-fn table in recon/eaclib/psx/pad.c).
    "recon/eaclib/psx/pad.c":               {"no_split_addresses": True},
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
    "recon/syslib/psx/libgpu/SYS.c":        {"cc1_272": True},
    "recon/syslib/psx/libpad/PADMAIN.c":    {"no_split_addresses": True},  # -51, _padSetVsyncParam basin (a9)
    # w51-a2: BIOS.c 13->17/17 PASS -- WHOLE OBJECT byte-matches under cc1_272.
    "recon/syslib/psx/libmcrd/BIOS.c":      {"cc1_272": True},
    # w51-a2: USERFUNC.c 1->4/4 PASS under cc1_272 with ZERO source change (the
    # w48 "needs maspsx ASPSX fill" note on UserFuncInit = wrong-compiler artifact).
    "recon/syslib/psx/libmcrd/USERFUNC.c":  {"cc1_272": True},
    # w51-a7: INTR.c -> cc1_272 (8 PASS incl. VSyncCallback; _intrhand 110->49).
    "recon/syslib/psx/libetc/INTR.c":       {"cc1_272": True},
    "recon/syslib/psx/libcd/iso9660.c":     {"no_split_addresses": True},  # -17 (a6)
    # 04M -- the gcc-2.7.2 lane (see "cc1_272" key above).  FERR/_err_math and
    # FLTSIDF/__floatsidf sealed the lane (PASS); the rest of libmath probed
    # TU-by-TU at consolidation, kept only where the gate net-improves with
    # zero PASS regressions.
    "recon/syslib/psx/libmath/FERR.c":      {"cc1_272": True},
    "recon/syslib/psx/libmath/FLTSIDF.c":   {"cc1_272": True},
    "recon/syslib/psx/libmath/ADDDF3.c":    {"cc1_272": True},  # 377->352
    "recon/syslib/psx/libmath/MULDF3.c":    {"cc1_272": True},  # -2
    "recon/syslib/psx/libmath/GTDF2.c":     {"cc1_272": True},  # 54->50
    "recon/syslib/psx/libmath/DIVSF3.c":    {"cc1_272": True},  # -1
    "recon/syslib/psx/libmath/EXTSFDF2.c":  {"cc1_272": True},  # 69->55
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
    # w33-a10: EA's own eaclib PAD.OBJ (see the "no_split_addresses" entry in
    # PER_TU_FLAGS). Once split addresses are off, PAD_restore's ONLY residual
    # was the canonical Tier-1 epilogue-fill signature (ours `jr ra; addiu sp`
    # vs the oracle's `addiu sp; jr ra; nop`) -- the splice takes it to a byte
    # PASS. Whole-TU probe: the flag is a NET LOSS on the other four
    # (padinit 3->9, PAD_state 4->8, PAD_convert PASS->3, PAD_update 30->40),
    # which is exactly why this is per-FUNCTION and not a TU flag.
    "recon/eaclib/psx/pad.c": {
        "PAD_restore",
    },
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
    # w25-a5: libpad Tier-1 (single-jal, epilogue-only shape, canonical per
    # the w25-a1 taxonomy above) -- confirmed byte-PASS by an independent
    # whole-TU -fno-delayed-branch probe run BEFORE this splice mechanism
    # landed, then re-confirmed against the real per-fn splice with a
    # zero-collateral whole-TU gate on both PADENTRY.c and PADPORTD.c.
    "recon/syslib/psx/libpad/PADENTRY.c": {
        "PadStartCom", "PadStopCom",
        # Tier-2: PadGetState has interior branches (the tail-duplicate-vs
        # -share if/else-if chain) so the splice does NOT reach full PASS
        # (no post-splice fill pass exists yet -- see w25-a1's taxonomy),
        # but it is a clean net-positive (FAIL 16 -> FAIL 10, diff pattern
        # moves closer to the oracle's shared-tail shape) with zero
        # collateral on the TU's other 7 functions under a whole-TU gate.
        "PadGetState",
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
        "CD_initintr",         # FAIL 15 -> FAIL 6
    },
    "recon/syslib/psx/libcd/event.c": {
        "_cd_event_init", "_cd_event_sync", "_cd_event_ready", "_cd_event_read",
    },
    "recon/syslib/psx/libcd/toc.c": {
        "CdGetToc",            # FAIL 6 -> FAIL 5
    },
    # w48-a6: stream cluster.
    "recon/syslib/psx/libcd/stream.c": {
        "StSetRing",           # FAIL 9 -> FAIL 3
    },
    "recon/syslib/psx/libcd/streamhelp.c": {
        "data_ready_callback", # FAIL 21 -> FAIL 18
    },
    "recon/syslib/psx/libcard/CARDINIT.c": {
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
PER_FN_FORCE_ADDR = {
    "recon/game/psx/weather.cpp": {
        "Weather_Init__Fv",   # FAIL 12 (211/211) -> PASS, byte-exact
    },
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


# --- w48-a3: per-FUNCTION EPILOGUE-ONLY delay-slot UN-FILL ------------------
# The "epilogue swap" residual (ours `jr ra; addiu sp` vs retail's
# `addiu sp; jr ra; nop`) appears iff $ra is the LAST callee-saved register
# restored: reorg steals the sp-adjust into the return slot and covers the
# resulting lw-$ra load-delay hazard with its own nop.  The w25 whole-function
# splice loses dbr's BODY fills; this instead post-processes the NORMAL
# (delayed-branch ON) cc1 .s and un-fills ONLY the named function's return
# slot -- textually what cc1 emits for that tail under -fno-delayed-branch,
# so the result is still 100% real cc1 output.  MUST stay per-function: on a
# function without the residual it costs +1 insn.  Proof + measurements:
# scratch/w48_a3_receipts.md section 2.
# 272-lane twin of PER_FN_EPILOGUE_UNFILL (see _compile_c_272): gas-reorder
# backward-fills the return slot with the sp-adjust; retail leaves it empty
# for these fns.  Applied on the .s text BEFORE `as` (the 2.8-lane unfill
# regex can't match -- 2.7.2 never emits the cc1-side noreorder/j block).
PER_FN_EPILOGUE_UNFILL_272 = {
    "recon/syslib/psx/libsn/READ.c":  {"PCread"},   # w51-a8: 23 -> PASS 48/48
    "recon/syslib/psx/libsn/WRITE.c": {"PCwrite"},  # w51-a8: 23 -> PASS 48/48
}


def _apply_epilogue_unfill_272(rel_posix, txt):
    names = PER_FN_EPILOGUE_UNFILL_272.get(rel_posix)
    if not names:
        return txt
    for name in names:
        m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
        if not m:
            continue
        m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
        end = m.end() + (m2.start() if m2 else len(txt) - m.end())
        region = txt[m.start():end]
        new = re.sub(r"\n(\t(?:addu|addiu)\t\$sp,\$sp,\d+\n)\tj\t\$31\n",
                     lambda mm: ("\n\t.set\tnoreorder\n" + mm.group(1)
                                 + "\tj\t$31\n\tnop\n\t.set\treorder\n"),
                     region)
        if new != region:
            txt = txt[:m.start()] + new + txt[end:]
    return txt


PER_FN_EPILOGUE_UNFILL = {
    # w51-a6: single-fn TUs, no in-TU regression possible.
    "recon/syslib/psx/libgte/FOG_01.c": {"SetFogNear"},  # 4 -> PASS 25/25
    "recon/syslib/psx/libgte/COR_02.c": {"ccos"},        # 4 -> PASS 49/49

    # w49-a9 (orchestrator-wired): padinit FAIL 3 (27/28) -> PASS 28/28 — pure
    # epilogue-swap class (retail's return slot empty, ours steals the addiu sp);
    # measured on the A9 receipts, whole-TU pad.c gate zero-regression.
    "recon/eaclib/psx/pad.c": {
        "padinit",
        "PAD_update",   # w50-a9: item-3 of its 9 diffs = the w48 epilogue-swap
                        # class (return slot); measured below by the orchestrator.
    },
    "recon/syslib/psx/libpad/PADMAIN.c": {
        "_padVbCallback1",   # FAIL 4  -> PASS 26/26
        "_padStopCom",       # FAIL 6 (19/17) -> FAIL 6 COUNT-EXACT 17/17
        "_padClrIntSio0",    # unchanged 24; releases its w25 splice entry
    },
    "recon/syslib/psx/libpad/PADCMD.c": {
        "_padSetMainMode_rcv",  # FAIL 11 -> PASS 24/24 (splice entry dropped)
    },
}

_EPI_UNFILL_RE = re.compile(
    r"\t\.set\tnoreorder\n\t\.set\tnomacro\n\tj\t\$31\n(\t[^\n]*\n)"
    r"\t\.set\tmacro\n\t\.set\treorder\n")


def _apply_epilogue_unfill(rel_posix: str, s_file: Path) -> None:
    names = PER_FN_EPILOGUE_UNFILL.get(rel_posix)
    if not names:
        return
    txt = s_file.read_text(errors="replace")
    for name in names:
        m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
        if not m:
            continue
        m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
        end = m.end() + (m2.start() if m2 else 0)
        region = txt[m.start():end]
        new = _EPI_UNFILL_RE.sub(lambda mm: mm.group(1) + "\tj\t$31\n", region)
        if new != region:
            txt = txt[:m.start()] + new + txt[end:]
    s_file.write_text(txt)


# Per-FUNCTION $ra-save SINK (w50-a6, CV_ColorTracks): retail schedules the
# prologue `sw $31,N($sp)` BELOW the first call's whole arg setup, immediately
# before the jal; ours emits it with the other prologue saves.  No cc1 flag
# reaches this shape (flag axis falsified: -fno-schedule-insns/-insns2,
# -mno-split-addresses, -fno-delayed-branch) -- it is a pure textual relocation
# on the .s, same lane family as PER_FN_EPILOGUE_UNFILL.
PER_FN_RA_SINK = {
    "recon/game/psx/textureprocess.cpp": {
        "CV_ColorTracks__Fiii",   # FAIL 2 (130/130) -> PASS per the a6 receipt
    },
}


def _apply_ra_sink(rel_posix: str, s_file: Path) -> None:
    names = PER_FN_RA_SINK.get(rel_posix)
    if not names:
        return
    txt = s_file.read_text(errors="replace")
    for name in names:
        m = re.search(r"^\t\.ent\t%s\b[^\n]*\n" % re.escape(name), txt, re.M)
        if not m:
            continue
        m2 = re.search(r"^\t\.end\t%s[ \t]*$" % re.escape(name), txt[m.end():], re.M)
        end = m.end() + (m2.start() if m2 else 0)
        region = txt[m.start():end]
        save = re.search(r"^\tsw\t\$31,\d+\(\$sp\)\n", region, re.M)
        if not save:
            continue
        # first jal after the save; insert before its .set noreorder block if
        # present, else directly before the jal line.
        tail = region[save.end():]
        jal = re.search(r"^\tjal\t", tail, re.M)
        if not jal:
            continue
        ins = jal.start()
        block = tail[:ins]
        nore = block.rfind("\t.set\tnoreorder\n")
        if nore != -1 and "\tjal\t" not in block[nore:]:
            ins = nore
        new = (region[:save.start()] + region[save.end():save.end() + ins]
               + save.group(0) + region[save.end() + ins:end - m.start()])
        txt = txt[:m.start()] + new + txt[end:]
    s_file.write_text(txt)


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
            (PER_FN_FORCE_ADDR, "-fforce-addr", "faddr")):
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
                   obj: Path) -> Path:
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
    if tu_flags.get("no_schedule_insns"):
        cc1_flags.append("-fno-schedule-insns")
    if tu_flags.get("no_schedule_insns2"):
        cc1_flags.append("-fno-schedule-insns2")
    if tu_flags.get("no_builtin"):
        cc1_flags.append("-fno-builtin")
    r = run([CC1_272, *cc1_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1-272] {rel}\n{r.stdout}{r.stderr}")
    txt = s_file.read_text(errors="replace")
    txt = _MOVE_RE.sub(lambda m: "\taddu\t%s,%s,$0" % (m.group(2), m.group(3)), txt)
    txt = _apply_epilogue_unfill_272(rel.as_posix(), txt)
    s_file.write_text(txt)
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

    if tu_flags.get("cc1_272"):
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
    if tu_flags.get("no_builtin"):
        cc1_flags.append("-fno-builtin")
    r = run([CC1, *cc1_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1] {rel}\n{r.stdout}{r.stderr}")

    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1, cc1_flags)
    _apply_epilogue_unfill(rel.as_posix(), s_file)
    _apply_ra_sink(rel.as_posix(), s_file)

    # maspsx reads cc1 .s on stdin; remaining args pass through to GNU as.
    maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}", "--expand-div",
                  "--run-assembler", f"--gnu-as-path={AS}",
                  *AS_ARCH, f"-G{tu_g_value}", "-I", ROOT / "include",
                  "-I", ROOT, "-o", obj]
    if JTBL_AT_FUSION or tu_flags.get("jtbl_at_fusion"):
        maspsx_cmd.append("--jtbl-at-fusion")
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

    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1PL, cc1pl_flags)
    _apply_epilogue_unfill(rel.as_posix(), s_file)
    _apply_ra_sink(rel.as_posix(), s_file)

    maspsx_cmd = [PY, MASPSX, f"--aspsx-version={ASPSX_VERSION}", "--expand-div",
                  "--run-assembler", f"--gnu-as-path={AS}",
                  *AS_ARCH, f"-G{tu_g_value}", "-I", RECON, "-o", obj]
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
