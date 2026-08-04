/* syslib/psx/libpad/WAITRC2.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 authoritative).
 *   obj libpad.lib(WAITRC2.OBJ): the root-counter-2 (Timer 2) busy-wait helpers used throughout the
 *   SIO0 controller protocol (PADMAIN/PADCMD).  setRC2wait arms a wait of N timer ticks; chkRC2wait
 *   reports whether that wait has elapsed yet, accounting for the 16-bit counter wrapping and the
 *   /8 prescale.  Ghidra decompiled chkRC2wait as an empty `void` -- it is NOT: it returns a BOOL
 *   (1 = expired, 0 = still waiting), confirmed by the `slt; xori 1` at its tail and by every caller
 *   doing `while (chkRC2wait() == 0)`. */

/* PSX Root Counter 2 (literal MMIO device registers). */
#define T2_VALUE  (*(volatile unsigned short *)0x1F801120)   /* current count */
#define T2_MODE   (*(volatile unsigned short *)0x1F801124)   /* mode/prescale (bit 0x200 = /1, else /8) */
#define T2_TARGET (*(volatile unsigned short *)0x1F801128)   /* reload target */

extern int _startTime;   /* RC2 count snapshot at the start of the wait */
extern int _waitTime;    /* wait length, in (prescaled) ticks */

/* @0x8010BFE8 : setRC2wait -- begin a wait of `ticks` RC2 ticks.
 * w48-a3: 4 -> 3 diffs, and the BODY is now byte-identical to the oracle; the entire residual is
 * one assembler-side artifact (below).  Two corrections to the w23-a8 reconstruction:
 *   (a) IT IS VOID.  The oracle has NO return-value materialization -- $v0 merely still holds the
 *       `lhu` result because that is the value being stored.  Declaring it `unsigned` forces cc1 to
 *       produce a full SImode VALUE from the volatile HImode read, and combine will not merge a
 *       VOLATILE mem into the zero_extend, so it emits the extra `andi $v0,$v0,0xffff` the oracle
 *       lacks.  (Every non-void spelling probed -- u_short/u_int/int local, u_short return, direct
 *       `return _startTime` -- keeps the andi; void is the only shape that drops it.)  ⚠️ PADMAIN's
 *       and MCXMAIN's `u = setRC2wait(...); ... if (u == 0)` call sites are therefore a
 *       RECONSTRUCTION SUSPECT (they still carry their own `extern unsigned` decl, which links fine
 *       under C linkage) -- re-derive them from those objs' oracles, not from this signature.
 *   (b) no local is needed at all: the read feeds the store directly, as the oracle shows.
 * 🔴 RESIDUAL (3 diffs) = the ASPSX STORE-MACRO SPLIT, assembler-side, NOT source-reachable:
 *   cc1 emits the assembler MACRO `sw $2,_startTime` and cannot place a macro in a delay slot, so
 *   its `.s` ends `sw $2,_startTime` + `j $31` with an EMPTY slot.  Retail's assembler expanded the
 *   macro ACROSS the branch -- `lui $at,%hi(_startTime)` BEFORE the `jr $ra`, `sw $v0,%lo(...)($at)`
 *   IN the delay slot; maspsx instead expands it entirely before the branch and nops the slot.  The
 *   `$at` base is the proof it is a macro expansion (cc1 never allocates $at).  Probed and rejected:
 *   the unsized asm-label view (`extern int _startTime_v[] asm("_startTime")`) DOES get the store
 *   into the jr slot, but as cc1's own split with a normal register ($v1, not $at) -- same 3-4 diffs
 *   here and 25 -> 40 on chkRC2wait.  HANDED TO THE w48-a10 REAL-ASPSX LANE as a named class. */
extern void setRC2wait(int ticks)
{
    _waitTime  = ticks;
    _startTime = T2_VALUE;
}

/* @0x8010C008 : chkRC2wait -- 1 once `_waitTime` ticks have elapsed since setRC2wait, else 0.
 * w23-a8: 34->25 diffs. `cur` is kept live in $a0 across the T2_TARGET/T2_MODE blocks in the
 * oracle (a caller-saved scratch reg, unused as an arg here) -- reproduced by DUPLICATING the
 * final `return elapsed < _waitTime` into BOTH branches (matches the oracle's per-branch reload
 * of _startTime/_waitTime) instead of a single post-merge return; branch polarity flipped to
 * `!=0` first so the /8-prescale arm stays in the fallthrough slot the oracle's `bnez` expects.
 * RESIDUAL FLOOR (25): oracle DUPLICATES the trailing `addu a0,a0,v0` (T2_TARGET add) and the
 * `subu/srl` prescale tail into EACH arm via an explicit `j` (no cross-jump merge); our build
 * cross-jumps them into one shared instruction reached by fallthrough. Compiler
 * cross-jump/tail-merge decision, not reachable from this source shape (same family as the
 * catalog's "gcc block-merge of identical arms" floor). */
extern int chkRC2wait(void)
{
    unsigned cur = T2_VALUE & 0xffff;
    unsigned elapsed;

    if (cur < (unsigned)_startTime) {                 /* counter wrapped past _startTime */
        if (T2_TARGET == 0)
            cur += 0x10000;
        else
            cur += T2_TARGET;
    }
    if ((T2_MODE & 0x200) != 0) {
        elapsed = cur - (unsigned)_startTime;
        return elapsed < (unsigned)_waitTime ? 0 : 1;
    } else {
        elapsed = (cur - (unsigned)_startTime) >> 3;  /* /8 prescale */
        return elapsed < (unsigned)_waitTime ? 0 : 1;
    }
}
