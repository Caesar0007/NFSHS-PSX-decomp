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

/* Canonical PsyQ 4.3 and retail SYM assign both words to WAITRC2.obj. */
int _waitTime __attribute__((section(".bss"))) = 0;   /* @0x80148AAC */
int _startTime __attribute__((section(".bss"))) = 0;  /* @0x80148AB0 */

/* @0x8010BFE8 : setRC2wait -- begin a wait of `ticks` RC2 ticks.
 * w48-a3: 4 -> 3 diffs, and the BODY is now byte-identical to the oracle; the entire residual is
 * one assembler-side artifact (below).  Two corrections to the w23-a8 reconstruction:
 *   (a) IT IS VOID.  The oracle has NO return-value materialization -- $v0 merely still holds the
 *       `lhu` result because that is the value being stored.  Declaring it `unsigned` forces cc1 to
 *       produce a full SImode VALUE from the volatile HImode read, and combine will not merge a
 *       VOLATILE mem into the zero_extend, so it emits the extra `andi $v0,$v0,0xffff` the oracle
 *       lacks.  (Every non-void spelling probed -- u_short/u_int/int local, u_short return, direct
 *       `return _startTime` -- keeps the andi; void is the only shape that drops it.)  ⚠️ PADMAIN's
 *       and PADIF's `u = setRC2wait(...); ... if (u == 0)` call sites are therefore a
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
 *   here and 25 -> 40 on chkRC2wait.  HANDED TO THE w48-a10 REAL-ASPSX LANE as a named class.
 * >>> w51-a5 RESOLUTION -- THE cc1_272 LANE REACHES IT.  With `{"cc1_272": True}` on this TU
 *   (PsyQ 4.0 CC1PSX + direct GNU as in .set-reorder mode, the 04M law) setRC2wait is
 *   PASS 8/8 -- gas splits the store macro across the `jr` exactly as retail's assembler did.
 *   WHOLE-TU A/B, gate-measured, ZERO regressions: base 37 diffs / 0 PASS -> 272 lane 34 diffs
 *   / 1 PASS (chkRC2wait unchanged at 34).  WAITRC2.c is a wired-lane CANDIDATE (needs the
 *   build.py PER_TU_FLAGS entry; deliberately not wired by this agent). */
extern void setRC2wait(int ticks)
{
    _waitTime  = ticks;
    _startTime = T2_VALUE;
}

/* @0x8010C008 : chkRC2wait -- 1 once `_waitTime` ticks have elapsed since setRC2wait, else 0.
 * w48-a3: rebuilt from the oracle's CFG.  COUNT-EXACT 40/40 and every basic block now matches the
 * oracle 1:1 (the previous body was 41 insns with the wrong tail topology).  Three corrections:
 *   (a) the T2_MODE arm order was inverted -- the oracle's `bnez ...,.L8010C088` makes the /8
 *       (prescaled) arm the FALL-THROUGH, i.e. the `(T2_MODE & 0x200) == 0` case is the if-BODY;
 *   (b) the elapsed/return pair is written ONCE after the if/else (a shared `sltu; jr; xori 1`
 *       tail), not duplicated per arm -- the previous per-arm duplication never cross-jumped and
 *       emitted two whole copies of the tail;
 *   (c) both T2_TARGET reads stay (the oracle reads 0x1F801128 TWICE -- once for the `beqz`, once
 *       for the add), and the 0x10000 constant lives in that `beqz`'s delay slot.
 * 🔴 RESIDUAL (34 LCS diffs at EXACT 40/40 insns) = ONE 2-WAY REGISTER ROTATION, quantified:
 *   the oracle keeps `cur` in $a0 and the 0x1F801128 pointer in $v1; ours has them swapped.
 *   -dl/-dg receipts (this body): p80 = `cur`, 8 refs / 21 insns, `preferences: 3`, priority
 *   floor_log2(8)*8/21 = 1.14 -> allocated FIRST -> takes $3; p86 = the pointer, 3 refs / 5 insns,
 *   priority 1*3/5 = 0.60 -> allocated after, conflicts with p80's $3 -> takes $4.  REQUIRED DELTA
 *   (either one flips it): the POINTER to >= 4 refs at live 5 (2*4/5 = 1.60 > 1.14), or `cur` down
 *   to <= 4 refs at live 21 (2*4/21 = 0.38 < 0.60).  Zero-insn dials measured and FALSIFIED at this
 *   basin: naming the pointer in a block-local (34), an opacity fence on the pointer (34), a fence
 *   on `cur` (38, +2 insns), a block-local `tgt` temp (36), `cur = cur + x` vs `cur += x` (34),
 *   `T2_TARGET != 0` arm swap (33 but 41 insns).  The LCS number is NON-MONOTONE here -- the old
 *   25-diff body was structurally WRONG (41 insns, unmerged tails); do not "restore" it.  NEXT
 *   ANGLE: an inflator that reaches the ANONYMOUS cse temp holding the 0x1F801128 constant (it has
 *   no C name to hang refs on -- a second SOURCE-LEVEL use of the same address at a third site
 *   would, e.g. spelling the two reads through one named block-local read TWICE).
 *   w53-a8: four more falsified at this basin -- a named `volatile u_short *tgt` block-local
 *   PLUS a named `wrap` constant (38 @42, +2 insns), the T2_TARGET arm swap
 *   `if (T2_TARGET != 0)` (33 but @41, one insn OVER -- not an improvement), a two-read
 *   `t0`/`t1` split inside the wrap block (34 @40, identical), a use fence on `cur` before
 *   the wrap test (38 @42).  RUNG-INVARIANT: the ladder was A/B'd in w51 and the 272 lane
 *   (now wired) leaves chkRC2wait at 34.
 *   w55-a6: the w44 REF-STEP INFLATOR FAMILY is FALSIFIED here too -- a `do{}while(0)` DEPTH
 *   WRAPPER around the whole wrap-adjust `if/else` (the only construct that touches both the
 *   pointer's and `cur`'s in-block refs) is INERT at depth 2 AND depth 3 (34 @40/40, byte-
 *   identical output both times).  Combined with the w48/w53 receipts that means every zero-insn
 *   ref/live dial available in C has now been tried on this pair.  The pointer is an ANONYMOUS
 *   cse temp with NO C name and only TWO possible loads (both T2_TARGET reads are `volatile`, so
 *   a third source-level read is NOT free -- it emits a real `lhu`), which closes the "second
 *   source-level use" angle named above: there is no zero-cost way to give it a 4th ref.
 *   => STRUCTURALLY BOUNDED: reqdelta's required delta is unreachable from C at this basin.
 *   Remaining routes: the permuter (length-perturbing class), or an allocator-side instrument.
 * 🏆 w61-a6 -- **SOLVED, 32 -> PASS 40/40.**  Every verdict above (the "2-way register rotation",
 *   the "STRUCTURALLY BOUNDED" reqdelta certificate, the whole zero-insn-dial falsification
 *   ledger, and w48-a3 correction (b)) was reasoning about the WRONG BODY.  The rotation was a
 *   SYMPTOM of one structural miss, and (b) had it exactly backwards.  THREE edits, each
 *   gate-measured from the previous:
 *   (1) 🔑 **THE TAIL IS PER-ARM, NOT SHARED (32 -> 11).**  Read the oracle: BOTH mode arms carry
 *       their OWN `lui/lw %hi/%lo(_startTime)` AND `lui/lw %hi/%lo(_waitTime)` pair plus their own
 *       `subu $v0,$a0,$v0` (0x8010C06C..0x8010C07C and 0x8010C088..0x8010C098); the SHARED block
 *       is only `sltu $v0,$v0,$v1 / jr $ra / xori $v0,$v0,1`.  So retail's source computes the
 *       WHOLE comparison in each arm -- two full `return (...) < _waitTime ? 0 : 1;` statements --
 *       and cross_jump merges exactly three insns because scanning the tails backwards hits the
 *       prescale arm's `srl` against the other arm's `subu` and STOPS there.  Our shared-`elapsed`
 *       form hoisted the `_waitTime` load into the common tail, which cost two load-delay `nop`s
 *       and rotated the whole compare web -- that rotation is what every earlier receipt was
 *       measuring and trying to dial away.  (w48-a3 note (b) is hereby FALSIFIED: the per-arm
 *       duplication is retail's shape, it just has to be the FULL comparison, not the old
 *       partial per-arm tail that duplicated `sltu/jr/xori` too.)
 *   (2) **MODE-ARM ORDER (11 -> 5).**  The oracle's `bnez $v0,.L8010C088` makes the PRESCALED
 *       (`>>3`) arm the FALL-THROUGH, so the `!= 0` case must be written FIRST.  (w48-a3 note (a)
 *       said the opposite; it was reading the old shared-tail body.)
 *   (3) **WRAP-ARM ORDER (5 -> PASS).**  `if (T2_TARGET != 0) cur += T2_TARGET; else cur += 0x10000;`
 *       -- with the `!= 0` arm first the two `addu` stay UNMERGED (retail's 0x8010C048 delay-slot
 *       copy + 0x8010C04C copy) and both come out `addu $a0,$a0,$v0` (cur-first, the 12D
 *       qty_combine order); the `== 0`-first spelling cross-jumped them into one shared
 *       `addu $a0,$v0,$a0` plus a `nop` (one insn SHORT).  Note this exact arm swap is in the
 *       w53-a8 falsification list above as "33 but @41, one insn OVER" -- it was FALSE THERE and
 *       TRUE HERE: 04Z basin-relativity in its purest form, on a fn whose receipts explicitly
 *       declared the space exhausted.  Re-probe parked spellings after EVERY structural landing.
 *   The `elapsed` local stays: it is still the w59-a17 wrap-test carrier that seats `cur` in $a0. */
extern int chkRC2wait(void)
{
    unsigned cur = T2_VALUE & 0xffff;
    unsigned elapsed;

    elapsed = cur < (unsigned)_startTime;           /* w59-a17: wrap test through the dead-here
                                                       elapsed local -- flips cur onto $a0 (34->32) */
    if (elapsed) {                                    /* counter wrapped past _startTime */
        if (T2_TARGET != 0)
            cur += T2_TARGET;
        else
            cur += 0x10000;
    }
    if ((T2_MODE & 0x200) != 0)
        return (cur - (unsigned)_startTime) < (unsigned)_waitTime ? 0 : 1;
    return ((cur - (unsigned)_startTime) >> 3) < (unsigned)_waitTime ? 0 : 1;
}
