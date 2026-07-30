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
#   "g_value"            -> override the global -G threshold for this TU.
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
#
# The 11 TUs below own the retail binary's 11 ASPSX-$at-macro jtbl sites
# (w23-a11 investigation); the other 22 jtbl TUs are deliberately absent
# here (their explicit 5-insn form already matches and must stay untouched).
PER_TU_FLAGS = {
    # cars.obj's retail .sdata layout contains the 8-byte "p%s.dat" literal
    # between rearLimit and Cars_gNumCars, proving this object used -G8.
    "recon/game/common/cars.cpp":           {"g_value": "8"},
    # genericpmx.obj likewise has the exact -G8 threshold signature: the
    # retail code uses gp-relative relocations for its 8-byte pointer arrays
    # (gShadowPixmap/gSkidMarkPixmap/gSMokePixmap/gGravelPixmap), while the
    # 12-byte gWeatherPixmap remains full-addressed.
    "recon/game/common/genericpmx.cpp":      {"g_value": "8"},
    "recon/game/common/audiocmn.cpp":       {"jtbl_at_fusion": True},  # AudioCmn_SoundCar
    "recon/syslib/psx/libcd/drv.c":       {"jtbl_at_fusion": True},  # CD_get_intr
    "recon/syslib/psx/libgpu/FONT.c":       {"jtbl_at_fusion": True},  # FntPrint
    "recon/game/common/aih_cop.cpp":        {"jtbl_at_fusion": True},  # HighExecute__10AIHigh_Cop
    "recon/syslib/psx/libmcrd/LIBMCRD.c": {"jtbl_at_fusion": True},  # MemCardCmd_cb
    "recon/syslib/psx/libpad/PADENTRY.c":   {"jtbl_at_fusion": True},  # PadInfoAct
    "recon/game/common/r3dcar.cpp":         {"jtbl_at_fusion": True},  # R3DCar_InsertCarFacet
    "recon/game/psx/sfx.cpp":               {"jtbl_at_fusion": True},  # Sfx_BuildSouffleFacet
    "recon/syslib/psx/libc/SPRINTF.c":      {"jtbl_at_fusion": True},  # sprintf
    # w33-a10: EA's own eaclib PAD.OBJ was built WITHOUT split addresses --
    # proven by the oracle's `lui $at; addu $at,$at,$idx; lbu %lo(sym)($at)`
    # indexed loads (two independent sites in PAD_update, no jump table in
    # sight) plus the unfused `la` into a callee-saved reg in padinit /
    # PAD_restore / PAD_state. Whole-TU sweep with the flag: 5/5 functions
    # improve or hold (see the per-fn table in recon/eaclib/psx/pad.c).
    "recon/eaclib/psx/pad.c":               {"no_split_addresses": True},
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
        "CdSync", "CdReady", "CdFlush", "CdDataSync",
        # w25-a3 TRIED and REVERTED: CdLastPos/CdSetDebug/CdSyncCallback/
        # CdReadyCallback looked textbook pure-signature (single `jr ra;nop`
        # vs oracle's slot-filled `addiu %lo(...)`), but empirically the
        # splice is a NO-OP for them: the .nodb.s (-fno-delayed-branch)
        # region is BYTE-IDENTICAL to the normal region at the cc1 level
        # (`la $2,SYM; j $31`, nothing after the jump either way) -- the
        # trailing nop is inserted downstream by maspsx/GNU-as, not by
        # gcc's delayed-branch filler, so this per-function cc1 FLAG cannot
        # reach this bug class at all (would need a maspsx-side fix, same
        # family as the methodology's documented "aspsx slot-filling"
        # follow-up work). FAIL 3 before, FAIL 3 after, 0 net change.
        # Same outcome class as a1's CdDataCallback revert. See
        # scratch/w25a3_state.md for full detail.
    },
    "recon/syslib/psx/libcd/cdread2.c": {
        "_cdread2_ready",
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
    # Tier-2: both have a jal-arg-setup section outside the epilogue (not
    # pure single-jal shape) so neither reaches full PASS, but both are
    # clean net-positives with zero collateral on PADMAIN.cpp's other 9
    # functions under a whole-TU gate.
    "recon/syslib/psx/libpad/PADMAIN.c": {
        "_padStopCom",     # FAIL 10 -> FAIL 6
        "_padClrIntSio0",  # FAIL 28 -> FAIL 24
    },
    # Tier-2: all three carry a PADCMD-style command-dispatch case chain
    # (li/beq/j per case) whose ASPSX-unfilled delay-slot nops move each
    # closer to the oracle's per-case beq/nop/j/nop shape without reaching
    # full PASS. Zero collateral on PADCMD.cpp's other 16 functions.
    "recon/syslib/psx/libpad/PADCMD.c": {
        "_padSendAtLoadInfo",  # FAIL 32 -> FAIL 30
        "_padLoadActInfo_snd", # FAIL 24 -> FAIL 22
        "_padSetMainMode_rcv", # FAIL 24 -> FAIL 19
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


def _apply_fn_splice(rel_posix: str, s_file: Path, i_file: Path,
                      cc1_bin: Path, cc1_flags: list) -> None:
    """If `rel_posix` has entries in PER_FN_NO_DELAYED_BRANCH: recompile
    i_file (same preprocessed source) with -fno-delayed-branch added,
    extract each named function's region from that second .s, uniquify its
    local labels, and substitute it for that function's region in s_file
    IN PLACE (both .s files stay cached in the build dir for debugging)."""
    fn_names = PER_FN_NO_DELAYED_BRANCH.get(rel_posix)
    if not fn_names:
        return
    nodb_flags = list(cc1_flags)
    if "-fno-delayed-branch" not in nodb_flags:
        nodb_flags.append("-fno-delayed-branch")
    nodb_s = s_file.with_suffix(".nodb.s")
    r = run([cc1_bin, *nodb_flags, i_file, "-o", nodb_s])
    if r.returncode:
        sys.exit(f"[cc1-nodb] {rel_posix}\n{r.stdout}{r.stderr}")
    nodb_text = nodb_s.read_text()
    normal_text = s_file.read_text()
    for name in sorted(fn_names):
        flagged_region = _extract_fn_region(nodb_text, name)
        target_region = _extract_fn_region(normal_text, name)
        _SPLICE_COUNTER[0] += 1
        flagged_region = _uniquify_local_labels(
            flagged_region, f"ndb{_SPLICE_COUNTER[0]}")
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
    if tu_flags.get("no_split_addresses"):
        cc1_flags.append("-mno-split-addresses")
    if tu_flags.get("no_schedule_insns"):
        cc1_flags.append("-fno-schedule-insns")
    if tu_flags.get("no_schedule_insns2"):
        cc1_flags.append("-fno-schedule-insns2")
    if tu_flags.get("no_strength_reduce"):
        cc1_flags.append("-fno-strength-reduce")
    r = run([CC1, *cc1_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1] {rel}\n{r.stdout}{r.stderr}")

    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1, cc1_flags)

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
    r = run([CC1PL, *cc1pl_flags, i_file, "-o", s_file])
    if r.returncode:
        sys.exit(f"[cc1pl] {rel}\n{r.stdout}{r.stderr}")

    _apply_fn_splice(rel.as_posix(), s_file, i_file, CC1PL, cc1pl_flags)

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
