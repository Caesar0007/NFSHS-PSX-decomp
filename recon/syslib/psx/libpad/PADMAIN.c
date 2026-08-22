/* syslib/psx/libpad/PADMAIN.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3 authoritative; Ghidra
 *   for the stable bodies).  obj libpad.lib(PADMAIN.OBJ): the SIO0 controller-port serial engine --
 *   the interrupt-driven core that actually talks to the pad hardware.  11 functions:
 *     _padSetVsyncParam  install the VSync interrupt-handler element (_padVbCallback0/1)
 *     _padVbCallback1    IRP verifier  (runs only on a VSync IRQ)
 *     _padVbCallback0    IRP handler   (pumps _padSioMain across the active channels each frame)
 *     _padStartCom/_padStopCom  enable/disable the handler + root-counter
 *     _padInitSioMode    bring SIO0 up for one port, fix auto-mode, prime the exchange
 *     _padSioMain        step the per-port SIO state-function table
 *     _padSioRW/_padSioRW2  exchange one byte over SIO0 (RW2 = timer-bounded)
 *     _padClrIntSio0     acknowledge the SIO0 IRQ
 *     _padWaitRXready    spin until the SIO0 RX FIFO has a byte
 *
 *   HARDWARE ACCESS: the original reaches the SIO0 register block and the interrupt registers through
 *   two cached base pointers (set at init) rather than literal MMIO -- _padSioRegs (-> 0x1F801040)
 *   and _padIntRegs (-> 0x1F801070).  Root-counter-2 (timer) is touched as literal MMIO.  Modeled
 *   faithfully below; on the host none of this runs (compiles, never executes off-PSX). */

/* ---- kernel / cross-obj helpers -------------------------------------------------------------- */
extern int  EnterCriticalSection(void);     /* A36 @0x8010698C */
extern void ExitCriticalSection(void);      /* A37 @0x8010696C */
extern void ChangeClearRCnt(int n, int m);  /* L10 @0x80106664 */
extern void SysDeqIntRP(int pri, void *rp); /* L03 @0x8010BFC8 */
extern void SysEnqIntRP(int pri, void *rp); /* L02 @0x8010BFD8 */
extern void setRC2wait(int ticks);          /* WAITRC2 @0x8010BFE8 (VOID -- see WAITRC2.c) */
extern int      chkRC2wait(void);           /* WAITRC2 @0x8010C008 */

/* ---- SIO0 + interrupt register blocks, reached via libpad's cached base pointers (PAD.OBJ) ----- */
extern unsigned char *_padSioRegs;   /* @0x80137CDC -> 0x1F801040 : SIO0 (JOY) block base */
extern unsigned char *_padIntRegs;   /* @0x80137CD8 -> 0x1F801070 : interrupt I_STAT/I_MASK */
#define JOY_DATA8 (*(volatile unsigned char  *)(_padSioRegs))
#define JOY_STAT  (*(volatile unsigned short *)(_padSioRegs + 0x04))
#define JOY_MODE  (*(volatile unsigned short *)(_padSioRegs + 0x08))
#define JOY_CTRL  (*(volatile unsigned short *)(_padSioRegs + 0x0a))
#define JOY_BAUD  (*(volatile unsigned short *)(_padSioRegs + 0x0e))
#define I_STAT    (*(volatile unsigned int   *)(_padIntRegs + 0x00))
#define I_MASK    (*(volatile unsigned int   *)(_padIntRegs + 0x04))
/* root counter 2 (literal MMIO) */
#define T2_VALUE  (*(volatile unsigned short *)0x1F801120)
#define T2_MODE   (*(volatile unsigned short *)0x1F801124)
#define T2_TARGET (*(volatile unsigned short *)0x1F801128)

/* ---- libpad state globals (defined in PAD.OBJ data) ------------------------------------------- */
extern int            _padIntExec;          /* engine-running flag */
extern int            _padSioState;         /* current SIO state-fn index */
extern int            _padSioChan;          /* channel being serviced (0..1) */
extern int            _padChanStart;        /* first active channel */
extern int            _padChanStop;         /* last active channel */
extern int            _padTotalCurr;        /* total actuator current draw */
extern unsigned char *_padInfoDir;          /* per-port info array base (0xF0 bytes/port) */
extern int            _padFixResult[2];     /* @0x80137CD0 : per-channel auto-mode retry count */
extern int            padIntFunc[];         /* SIO state-function pointer table */
extern int            _startTime;           /* RC2 timestamp at transfer start */
extern int            _waitTime;            /* RC2 timeout budget */
extern int            _padVbExec;           /* @0x80137CE0 : verifier-fired flag */

/* dispatch slots (set per pad mode; defined in PAD.OBJ) */
extern int  (*_padFuncNextPort)(int flag);
extern int  (*_padFuncRecvAuto)(unsigned char *info);
extern void (*_padFuncClrInfo)(unsigned char *info);
extern void (*_padFuncClrCmdNo)(unsigned char *info);
extern int  (*_padFuncIntGun)(void);

/* internal fns (forward) */
extern int  _padInitSioMode(unsigned char *info);
extern void _padSioMain(unsigned char *info);
extern int _padClrIntSio0(void);
extern void _padWaitRXready(void);

/* ---- the VSync interrupt-handler element (Interrupt Request Path) ----------------------------- */
struct _PadIntRP {
    struct _PadIntRP *next;        /* +0x00 */
    void     (*handler)();  /* +0x04 */
    int      (*verifier)(); /* +0x08 */
    int        _pad0c;      /* +0x0c */
};
typedef struct _PadIntRP _PadIntRP;
static _PadIntRP _padVbCb;              /* @0x8014857C */
/* MATCH (w51-a5): ONE 2-int ARRAY, not two scalars.  _padStartCom's oracle clears both through a
 * SINGLE base (`lui $v0; addiu $v0,%lo; sw $zero,4($v0); sw $zero,0($v0)`) -- only an array gives
 * that anchor; two independent statics emit two `lui $at; sw` macro pairs.  The 8-byte size also
 * keeps it out of .sdata under -G4, matching the oracle's absolute addressing (two 4-byte scalars
 * would be gp-relative).  [0] = frames since start @0x8014858C, [1] = since stop @0x80148590. */
static int       _padFrames[2];
#define _padFramesSinceStart _padFrames[0]
#define _padFramesSinceStop  _padFrames[1]

/* prototypes for the handler/verifier installed into the IRP */
extern int  _padVbCallback0(void);
extern int  _padVbCallback1(void);

/* @0x80104A1C : _padSetVsyncParam -- point the IRP at our handler/verifier.
 * w48-a3: PASS 11/11 (was FAIL 16, count-exact).  The residual was pure ADDRESS-ANCHOR shape:
 * retail materializes ONE base = `&_padVbCb.handler` (i.e. the symbol + 4) and reaches all four
 * words off it with displacements 0 / +4 / -4 / +8, INCLUDING the negative one for `.next`; our
 * field-name form made cc1 keep the %hi half in one register (fused-%lo store for `.next`) and the
 * full address in another -- 2 base materializations.  Writing the anchor as an explicit pointer
 * local at the +4 field reproduces it (catalog w42 "SYM-declared-but-unused pointer local = the
 * base anchor" / negative-displacement family), and the OPACITY FENCE completes the anchor's
 * `addiu %lo` BEFORE the first store, where cc1 otherwise sinks it past the store (the last 2
 * diffs).  A plain use-fence `__asm__("" : : "r"(p))` does NOT do it (16) -- the "=r"/"0" identity
 * form is required; reordering the stores does not either.  The four stores keep retail's order. */
extern void _padSetVsyncParam(void)
{
    void (**p)() = &_padVbCb.handler;         /* MATCH: retail's +4 base anchor */
    __asm__("" : "=r"(p) : "0"(p));           /* MATCH: 0 insns; completes the addiu %lo here */
    p[0] = (void (*)())_padVbCallback0;       /* +0x04 handler  */
    p[1] = (void (*)())_padVbCallback1;       /* +0x08 verifier */
    p[-1] = 0;                                /* +0x00 next     */
    p[2] = 0;                                 /* +0x0c _pad0c   */
}

/* @0x80104A48 : _padVbCallback1 -- IRP verifier: only accept the VSync (bit 0) interrupt. */
extern int _padVbCallback1(void)
{
    if ((I_MASK & 1) != 0 && (I_STAT & 1) != 0) {
        if (_padFuncIntGun != 0)
            _padFuncIntGun();
        return 1;
    }
    return 0;
}

/* @0x80104AB0 : _padVbCallback0 -- IRP handler: once armed, pump the SIO engine across the
 *   active channel range every VSync frame. */
extern int _padVbCallback0(void)
{
    _padVbExec = 1;                              /* MATCH (w51-a5): the oracle's store sits in the
                                                  * `beqz $v1,.L80104AF0` DELAY SLOT, so it is
                                                  * UNCONDITIONAL -- it was wrongly inside the
                                                  * `if` (a real runtime bug: the verifier flag
                                                  * never set when _padChanStart == 0). */
    if (_padChanStart != 0) {
        int *n = &_padFramesSinceStart;      /* MATCH: retail holds the counter's ADDRESS in one
                                              * reg (`lui;addiu` then `lw 0(a0)`/`sw 0(a0)`); a
                                              * bare global gives two fused `lui;lw`/`lui;sw` */
        if (*n < 0x96)
            *n = *n + 1;
    }
    if (_padChanStop == 0) {
        int *n = &_padFramesSinceStop;
        if (*n < 0x96)
            *n = *n + 1;
    }
    /* MATCH (w53-a8, 4 -> PASS 91/91): COMPARE-OPERAND ORDER IS LOAD ORDER.  The oracle loads
     * `_padChanStart` into $v1 BEFORE `_padChanStop` into $v0 and then tests `slt $v0,$v0,$v1`;
     * writing the guard as `_padChanStop >= _padChanStart` emits the two macro loads in the
     * opposite order (4 diffs, count-exact).  `!(_padChanStop < _padChanStart)` is canonicalized
     * back to the wrong order (4) -- only the left-operand spelling reaches it. */
    if (_padIntExec != 0 && _padChanStart <= _padChanStop) {
        _padSioState = 0;
        _padSioChan  = _padChanStart;
        if (_padInitSioMode(_padInfoDir + _padChanStart * 0xf0) == 0)
            _padFuncNextPort(0xffff);
        _padTotalCurr = 0;
        while (_padChanStop >= _padSioChan)
            _padSioMain(_padInfoDir + _padSioChan * 0xf0);
        JOY_BAUD = 0x88;
    }
    return 0;                                    /* MATCH: the oracle stages `addu $v0,$zero,$zero`
                                                  * in the epilogue -- it is an int IRP handler */
}

/* @0x80104C1C : _padStartCom -- arm the engine: chain in the VSync IRP, enable RCnt, clear info.
 * MATCH (w53-a8, 12 @53/51 -> PASS 51/51).  TWO BASE ANCHORS, both read off the oracle:
 *  (1) `_padIntRegs` is ONE local base serving BOTH the I_STAT store and the I_MASK RMW -- retail
 *      materializes `lui $v1; lw $v1` once and then does `sw $v0,0($v1) / lw $v0,4($v1) /
 *      sw $v0,4($v1)`.  The bare macros reload the pointer for the I_MASK access (+2 insns).
 *  (2) the two frame counters are cleared through an EXPLICIT, FENCED pointer into `_padFrames`
 *      (`lui $v0; addiu $v0,%lo; sw $zero,4($v0); sw $zero,0($v0)`), stop ([1]) before start ([0]).
 *      A plain `int *f = _padFrames;` decl-init is copy-propagated straight back into two
 *      `lui $at; sw $zero,0($at)` assembler macros (8 diffs, count-exact); the zero-insn opacity
 *      fence makes the address a real pseudo -- and it must sit AT THE USE SITE: the same fence on
 *      a top-of-function decl-init costs 20 (the address then lives across all five calls). */
extern void _padStartCom(void)
{
    unsigned char *ir;
    int *f;

    _padIntExec = 0;
    EnterCriticalSection();
    SysDeqIntRP(2, &_padVbCb);
    SysEnqIntRP(2, &_padVbCb);
    ir = _padIntRegs;
    *(volatile unsigned int *)(ir + 0x00) = 0xfffffffe;
    *(volatile unsigned int *)(ir + 0x04) = *(volatile unsigned int *)(ir + 0x04) | 1;
    ChangeClearRCnt(3, 0);
    ExitCriticalSection();
    _padFuncClrInfo(_padInfoDir);
    _padFuncClrInfo(_padInfoDir + 0xf0);
    f = _padFrames;
    __asm__("" : "=r"(f) : "0"(f));
    f[1] = 0;                                /* _padFramesSinceStop  */
    f[0] = 0;                                /* _padFramesSinceStart */
    _padIntExec = 1;
}

/* @0x80104CE8 : _padStopCom -- unchain the IRP. */
extern void _padStopCom(void)
{
    EnterCriticalSection();
    ChangeClearRCnt(3, 1);
    SysDeqIntRP(2, &_padVbCb);
    ExitCriticalSection();
}

/* @0x80104D2C : _padInitSioMode -- configure SIO0 for `info`'s port, run any pending auto-mode
 *   fix-ups, then exchange the 0x01/0x42/0x01 select+poll prologue.  Returns 1 on success. */
/* MATCH (w59-root, 54 -> 24 at 203/205; earlier w52-a5, 198 -> 94) -- the matched
 * Sled Storm Sony-lib body at `pc-beta/sotn-sled/_padInitSioMode.c` confirms this control flow.
 * The direct ternary JOY_CTRL store removes two excess instructions, and a short-lived initial
 * `fix` value gives retail's AT-indexed load into v0 plus the delayed s1 base materialization.
 * The remaining 24 are isolated to GCC's phantom `vars=8` frame and the two-insn folded final
 * byte test.  Per-function -G8 is byte-identical; compiler ladder: 2.6.3=40,
 * 2.7.2-970404=186, 2.8.0/2.8.1=177, confirming 2.7.2 as the correct basin.
 * w62-a5 -- THE FOLDED FINAL BYTE TEST IS SOURCE-REACHABLE (device found, NOT landed).
 *   `if (info[0x36] != 0) return 0; return 1;` is turned into `sltiu $v0,$v0,1` by jump.c's
 *   store-flag transform (both exits are constants).  LAUNDERING THE RESULT CONSTANT breaks it:
 *     if (info[0x36] != 0) return 0;
 *     { int one = 1; __asm__("" : "=r"(one) : "0"(one)); return one; }
 *   -> the oracle's exact tail returns (`bnez $v1; [slot] addu $v0,$zero,$zero; addiu $v0,1`)
 *   and the fn becomes COUNT-EXACT 205/205, residual = ONLY the phantom frame (4 lines) and one
 *   register ($v0 vs retail $v1 on the `lbu`/`bnez` pair).  LCS score is 26 vs the 24 baseline
 *   (09K non-monotonicity), so per the basin rule it is REPORTED, NOT LANDED -- adopt it
 *   together with a cure for the phantom frame.  Falsified around it (all re-gated w62-a5):
 *   laundering the TEST value instead of the constant (24 @203 -- the fold returns); the same
 *   launder moved ABOVE the test (32 @207); both ternaries rewritten as if/else (38 @207);
 *   dropping the `fix` local (42/44); hoisting `fix` to function scope (inert 26).
 *   PHANTOM FRAME, ISOLATED: the 8 `vars` bytes at $sp+16..23 are NEVER REFERENCED by any
 *   instruction in the body (grep the .s for `($sp)`: only the three reg saves/restores).  It is
 *   NOT `fix` (vars stays 8 with the local removed), NOT the three `(void)JOY_DATA8` discards
 *   (removed: still 8), NOT the ternaries, NOT block scope.  It is RUNG-SPECIFIC: 2.7.2 and
 *   2.6.3 emit vars=8/regs=3, while 2.7.2-970404 and 2.8.0 emit vars=0/regs=5 (and are far
 *   worse overall) -- i.e. a gcc-2.7.2 dangling-pseudo stack temp (13E class).  Next angle: a
 *   `-dl`/`-dg` dump on the wired rung to name the pseudo that owns the slot.
 * w63-a7 2026-08-15 -- baseline re-gated 24 @203/205 (the w62 numbers reproduce exactly).  The
 *   w62-a5 launder device was RE-APPLIED and its paired follow-ups completed per the hard-floor
 *   basin rule; the branch is UNWOUND because its final result (26) does not beat 24.  What the
 *   detour bought is a SHARP decomposition of the 26 -- with the device the instruction STREAM is
 *   identical to retail except TWO things: (i) the frame (`-40/24/32/28` vs `-32/16/24/20`,
 *   8 diff lines) and (ii) ONE register, `lbu $v0,54($s0)` vs retail `lbu $v1,54($s0)`, which
 *   mis-aligns the whole 8-insn tail block in the LCS and is what actually costs 18 of the 26.
 *   So the endgame is TWO named dials, not one, and (ii) is the cheaper of the pair.
 *   FALSIFIED for (ii) at the count-exact 205 basin (all five 26 @205, byte-identical output --
 *   the tail is canonicalized): a named `int b = info[0x36];` test temp, the same with an
 *   identity launder on it, an `unsigned char b` temp, and a read-only fence on `one` after the
 *   launder.  FALSIFIED for the phantom frame (all 26 @205, i.e. `vars=8` survives every one):
 *   naming the `JOY_CTRL` read-modify-write operand (`unsigned short c = JOY_CTRL; JOY_CTRL =
 *   c | 0x10;`), the `|=` spelling of the same store, and dropping the `!= 0` from BOTH
 *   `(JOY_STAT & 0x200)` tests -- i.e. the volatile-MMIO expressions are NOT the dangling-use
 *   owner (13E), which joins w62's list (`fix`, the JOY_DATA8 discards, the ternaries, block
 *   scope).  The `-dl`/`-dg` dump on the wired 2.7.2 rung remains the named next angle for the
 *   frame; for (ii) it is a local-alloc qty question at the tail (retail's byte pseudo must
 *   conflict with $v0, i.e. the return constant has to be live across the load -- the only form
 *   that does that today, the launder hoisted above the test, costs 2 insns: 32 @207).
 * w64-a7 2026-08-15 -- THE PHANTOM FRAME IS SOLVED AT THE MECHANISM LEVEL AND IS
 *   SOURCE-REACHABLE; what is left is one priced allocno tie.  Re-gated 24 @203/205.
 *   `tools/brdist.py` reports BRANCH COUNT 20 vs 21 for this fn -- i.e. the missing branch is
 *   the folded final byte test, so the w62 launder device (which restores it) is the
 *   STRUCTURALLY CORRECT form and the 26-vs-24 LCS reading is 09K non-monotonicity.
 *   (1) WHO OWNS `vars= 8`.  Bisected on the .i with the real rung binaries: the whole 8 bytes
 *       belong to the queued-recv FIX BLOCK, and inside it to the DO-WHILE -- minimal repro is
 *       13 lines, `if (g[ch] > 0) { do { fp(0); } while (g[ch] > 0); }` (a loop whose exit test
 *       reads a global ARRAY INDEXED BY A GLOBAL, with a call in the body).  A scalar global,
 *       a constant index, or the same loop without a call all give vars=0.
 *   (2) THE MECHANISM (read off the RTL dumps, not guessed).  Expanding
 *       `_padFixResult[_padSioChan]` creates TWO pseudos: 91 = `(set (reg) (symbol_ref))` (the
 *       `la`, which SURVIVES and is what the loop's `$s1` base comes from) and 94 =
 *       `(plus (reg 93) (reg 91))` (the address).  cse2 (`rerun-cse-after-loop`) then folds the
 *       address straight into the MEM as `(plus (reg) (symbol_ref))` and 94's insns disappear --
 *       but gcc-2.7.2 runs `flow_analysis` ONLY ONCE, before combine/cse2, so REG_N_REFS(94)
 *       stays 2.  regclass never sees 94 in an insn, all its class costs are 0, and the
 *       all-zero tie-break lands on the SMALLEST class -- the .lreg literally prints
 *       "Register 94 used 2 times across 1 insns in block 4; ST_REGS or none; pointer".
 *       ST_REGS is unallocatable for a pointer, global.c lists 94 in "regs to allocate" and
 *       leaves it with NO home, and reload's `alter_reg` gives it a 4-byte stack slot that
 *       MIPS_STACK_ALIGN rounds to 8.  This is exactly why 2.8.0/2.8.1 print vars=0 on the same
 *       source (2.8 added a reg-usage recomputation after combine) and 2.6.0/2.6.3/2.7.2 print
 *       vars=8.  PsyQ 4.0's own CC1PSX.EXE reproduces vars=8 byte-for-byte, so it is NOT a
 *       windows-gcc-psx artifact -- retail's source must simply not have created pseudo 94.
 *   (3) TWO DEVICES KILL IT, both giving retail's frame EXACTLY (`$sp,32 / vars=0 / regs=3`):
 *       spell the FIRST read as `*(int *)((_padSioChan << 2) + (int)_padFixResult)` (the 09I
 *       cast-int subscript -- expand builds the MEM address directly, no intermediate pseudo),
 *       or `*(volatile int *)&_padFixResult[_padSioChan]`.  `-fno-rerun-cse-after-loop` on the
 *       rung produces the IDENTICAL object (27 @204), which is the independent confirmation of
 *       (2); no build.py wiring is needed since the source device is equivalent.
 *       NEUTRAL (all still vars=8, i.e. the pseudo survives): `*(_padFixResult + _padSioChan)`,
 *       `_padSioChan * 4 + (int)_padFixResult` (the `*4` form goes through pointer_int_sum),
 *       `((int *)_padFixResult)[_padSioChan]`, `(unsigned)` index, `(char *)base + ch*4`,
 *       `&_padFixResult[_padSioChan]` into a pointer local, a `q` pointer in its own block,
 *       a split decl, a chan-local, a base-ptr local, dropping the `fix` local entirely, and
 *       identity/read-only fences on `fix`.  A pointer local WITH a use fence on it does kill it
 *       but turns the $at macro into a real 4-insn address chain (39 @204).
 *   (4) WHAT THE FRAME FIX COSTS, decomposed.  cast + launder = 25 @206 (vs 24 @203); the frame
 *       lines are GONE and the residual is exactly three clusters: [11 lines] a `$v1`<->`$a0`
 *       swap on the JOY_CTRL select, [6 lines] the `&_padFixResult` materialization (retail
 *       `lui $v1; addiu $v1; addu $s1,$v1,$zero`, ours two nops then `lui $s1; addiu $s1` = the
 *       +1 insn), [6 lines] the tail `lbu $v0` vs retail `lbu $v1`.  Clusters 1 and 2 are the
 *       SAME cause: killing pseudo 94 also removes pseudo 91, so the block-0 `la` the loop
 *       preheader reuses is gone and loop.c materializes into `$s1` directly.
 *   (5) CLUSTER 1 IS PRICED (qty272 on the rung, both basins).  It is a two-allocno tie:
 *       p86 = the HImode JOY_CTRL constant, p85 = the `_padSioRegs` value.  CONTROL basin:
 *       86 refs 3 / live 7 = .4285 (rank 4, $v1 = retail) vs 85 refs 2 / live 5 = .4000
 *       (rank 7, $a0 = retail) -- correct.  CAST basin: 86 refs 3 / live 6 = .5000 and
 *       85 refs 2 / live 4 = .5000 -- an EXACT TIE, broken by allocno NUMBER, so 85 allocates
 *       first and takes $v1.  Under the 272 rule `floor_log2(refs)*refs/live` the minimal dials
 *       are +1 REF on 86 (3->4 crosses the floor_log2 step: 2*4/6 = 1.333) or +1 LIVE on 85
 *       (2/5 = .400).  MEASURED: a named ctrl-constant local + a read-only fence DOES flip 86
 *       onto $v1 -- but the named local costs 2 insns (25 @208) and rotates chan/base instead.
 *       Falsified for the same tie: base-pointer-first spelling of the store, a `sio` base
 *       local, a read-only fence on `_padSioRegs` after the store (26 @207), `int` vs
 *       `unsigned short` carriers, if/else instead of the ternary (33 @214).
 *       => THE ONE OPEN QUESTION on this function is a ZERO-INSTRUCTION +1 ref on the HImode
 *       constant (or +1 live on the SIO base) in the cast basin; land that and the fn is ~4.
 *   Also falsified this wave (all in the cast+launder basin): a laundered `fb` base local
 *   carrying the loop accesses (44 @205), the same for the loop only (39 @206), an unlaundered
 *   `fb` (28 @203), and the volatile first-read instead of the cast (31 @206).
 * MATCH (w64-a7, 24 @203 -> 20 @207, LANDED) -- the three devices now in the body, in the order
 *   they must be read: (1) the CAST first-read kills the phantom `vars= 8` frame per (2)/(3)
 *   above; (2) the TAIL LAUNDER restores the folded final byte test, which is what
 *   `tools/brdist.py` was flagging (BRANCH COUNT 20 vs 21 -> the count divergence is GONE, only
 *   2 branch-OFFSET rows remain, both from the +2 insn count); (3) a `do { ... } while (0)`
 *   DEPTH WRAPPER around the JOY_CTRL select is the ZERO-INSTRUCTION +1-REF DIAL that (5) asked
 *   for, and it works for a reason worth recording: flow.c weights refs by loop depth, so
 *   wrapping a block scales EVERY pseudo in it MULTIPLICATIVELY while the loop notes lengthen
 *   every live range ADDITIVELY -- p86 (refs 3, live 6) goes to 2*6/8 = 1.500 and p85 (refs 2,
 *   live 4) to 2*4/6 = 1.333, so a wrapper breaks a tie that is invariant under any dial that
 *   scales both sides equally.  The $v1<->$a0 swap on the ctrl select (11 of the 25) is gone.
 *   MEASURED: cast+launder+wrapper 20 @207 | depth 2 and depth 3 identical (20 @207 -- one
 *   level is the whole dial) | cast+wrapper WITHOUT the launder 22 @205 (count-exact but the
 *   tail fold, and brdist's branch-count hit, come back -- rejected on structure) | wrapper
 *   alone 31 @204 | wrapper stretched over `setRC2wait` too 25 @206 | volatile first-read
 *   instead of the cast 24 @207 | + an `fb` base local plain 25 @206 / laundered 51 @206.
 *   RESIDUAL 20 @207, three named clusters and NO frame lines left:
 *     [4] two extra `nop`s -- the wrapper's LOOP_BEG/END notes are a scheduling barrier and the
 *         `lw _padSioChan` load-delay slot can no longer be filled across it.  This is the whole
 *         +2 count.  A non-barrier +1-ref device on the HImode ctrl constant would erase it.
 *     [6] cluster 2: the `&_padFixResult` materialization (retail `lui $v1; addiu $v1;
 *         addu $s1,$v1,$zero`, ours `lui $s1; addiu $s1` direct).  Retail's copy survives
 *         because its `la` pseudo spans two blocks (born with the first read in block 0, used in
 *         the loop preheader) so combine_regs refuses to tie it; the cast removes that pseudo,
 *         so loop.c mints its own single-block one.  The named angle is a two-block `la` that
 *         cse cannot const-propagate -- the `fb` probes above are the falsified first attempts.
 *     [6] cluster 3: the tail `lbu $v0,54($s0)` vs retail `lbu $v1` (the w63 item (ii)).
 * Five earlier ORACLE-READ corrections, three of them REAL BUGS:
 *  (1) setRC2wait is VOID (WAITRC2.c receipt) and it is _padClrIntSio0's RETURN that retail
 *      tests (`jal _padClrIntSio0; beqz $v0,<ret 0>`), not a setRC2wait result.  The old
 *      `u = setRC2wait(N); _padClrIntSio0(); if (u == 0)` shape tested the WRONG value.
 *  (2) BUG: the SIO reset store `JOY_CTRL = 0x40` before the `= 0` was missing entirely.
 *  (3) BUG: the queued-recv drain passed `info + n*0xF0`; retail indexes off the port-table
 *      pointer `*(u_char **)(info + 0xC) + n*0xF0` (`lw $v0,0xC($s0); addu $a0,$v0,$a0`).
 *  (4) ONE JOY_CTRL store fed by a selected constant (`chan ? 0x3003 : 0x1003`),
 *      not two stores -- retail's `beqz $v0 / addiu $v1,0x1003` + a single `sh $v1,0xA($a0)`.
 *  (5) each `_padWaitRXready()` is followed by a DISCARDED `JOY_DATA8` read (`lbu $v0,0($v0)`),
 *      and the I_STAT ack spins are top-tested `while ((I_STAT & 0x80) == 0) { if (chkRC2wait())
 *      return 0; }`, not do/while with the test in the body.
 * MATCH (A14/w71, 20 @207 -> 15 @206) -- residual cluster [4] (the w64 note's "two extra `nop`s,
 *   the wrapper's LOOP_BEG/END notes are a scheduling barrier ... a non-barrier +1-ref device on
 *   the HImode ctrl constant would erase it") is CLOSED, but the cure was not a fence: it is a
 *   NAMED CHANNEL LOCAL read BEFORE the depth wrapper (`int ch = _padSioChan;` outside, the
 *   ternary inside).  The wrapper's barrier is only a problem because the `lw _padSioChan` sits
 *   INSIDE it -- hoisting the load out of the wrapper is 13B's "hoist every load the fence must
 *   not block ABOVE it" applied to a do{}while(0), and it fixes BOTH halves at once: the two
 *   loads now issue in retail's order (`lw _padSioChan` then `lw _padSioRegs`, so the second pair
 *   fills the first's load-delay slot) and both surplus nops go.  20 -> 15, and the head is now
 *   byte-exact through the `li $v1,12291`.  MEASURED alternatives: no wrapper at all 25 @206;
 *   chan-local WITHOUT the wrapper 25 @206 (so the wrapper is still load-bearing -- keep BOTH);
 *   a named ctrl-constant local + identity launder 25 @208; wrapper + launder 25 @208; a $a0
 *   clobber-launder on `ch` 18 @209.
 *   RESIDUAL 15 @206/205, THREE clusters (the w64 decomposition, minus the head):
 *   [2] the `sll $v0,$v0,2` of the cast index lands AFTER the `sh $v1,0xA($a0)` in ours, before
 *       it in retail -- sched1 position, downstream of cluster 2.
 *   [7] cluster 2, the `&_padFixResult` materialization: retail `lui $v1; addiu $v1` split into
 *       the `lw`'s load-delay slot and the `bltz`'s branch slot, then `addu $s1,$v1,$zero`; ours
 *       two `nop`s then `lui $s1; addiu $s1` direct (the +1 net insn).  Cause is unchanged from
 *       w64 (4): the cast first-read that kills the phantom frame also kills the block-0 `la`
 *       pseudo the loop preheader reused, so loop.c mints its own single-block one and there is
 *       no copy for combine_regs to refuse.  RE-SWEPT at this basin (04Z) and all falsified:
 *       `int *fb = _padFixResult;` carrying the first read only / the loop only / both, each
 *       plain and identity-laundered and read-only-fenced (51 / 46 / 22 / 60 / 20 @203-205), and
 *       four first-read spellings -- `*(volatile int *)&_padFixResult[ch]` 19, `*(volatile int *)
 *       ((ch<<2)+(int)_padFixResult)` 15 (byte-identical to the cast), `*(volatile int *)
 *       (_padFixResult+ch)` 19, plain subscript 28 (the phantom frame returns).
 *   [6] cluster 3, the tail `lbu $v0,54($s0)` vs retail `lbu $v1` -- retail's `li $v0,1` from the
 *       first guard's delay slot stays LIVE across the second load, so the byte pseudo must take
 *       $v1.  RE-SWEPT: hoisting the laundered `one` above BOTH tests and returning it at both
 *       exits 22 @207; above both but with a literal `return 1` at the first exit 20 @207; a
 *       named byte temp with a `"$2"` clobber-launder 15 @208 (the 20B device DOES move the byte
 *       off $v0 but pays 2 insns); a read-only fence on the byte 25; `one` hoisted + byte temp
 *       22.  The 20B clobber is the right instrument and the open question is a spelling of it
 *       that does not cost the two insns.
 * MATCH (W72-A17, 15 @206 -> 7 @206/205) -- TWO of the three clusters closed, both at ZERO
 *   instructions.  The w71 note's own two open questions were both answered by the SAME reading
 *   of the fence: a fence's REF/OUTPUT side and its CLOBBER side are independent dials.
 *   [6] CLOSED.  §21A-1: a READ-ONLY fence `__asm__("" : : "r"(x) : "$N")` carries the 20B
 *       hard-register denial WITHOUT the launder's output operand, so it costs nothing where the
 *       launder cost 2 insns.  `__asm__("" : : "r"(info) : "$2");` between the two guards is the
 *       whole edit (15 -> 9).  MEASURED equivalents (all 9 @206): the same fence with a named
 *       `int b = info[0x36];` temp as the operand, the fence placed before the byte read, the
 *       fence inside a block with the temp.  NEGATIVE CONTROL: the identical fence WITHOUT the
 *       `"$2"` clobber = 15, i.e. the clobber is the entire mechanism and the +1 ref is inert.
 *   [2] CLOSED, and it was NOT a ready-list tie -- it was the WRAPPER'S OWN BARRIER.  The
 *       do{}while(0) ref dial plants NOTE_INSN_LOOP_BEG/END around the `sh $v1,0xA($a0)`; the
 *       cast index's `sll` is written after the wrapper, so sched1 can never lift it above the
 *       store, while retail issues `sll` FIRST.  Writing `ix = ch << 2;` INSIDE the wrapper (and
 *       reading `*(int *)(ix + (int)_padFixResult)`) puts both on the same side of the barrier:
 *       9 -> 7.  This is the w71 `ch`-hoist lesson applied in the OTHER direction -- the LOAD
 *       belongs outside the wrapper, the SHIFT inside.  MEASURED alternatives: the whole fix READ
 *       inside the wrapper (7, equivalent); `ix` computed BEFORE the wrapper (16 @207 -- outside
 *       is not enough, it must be on the store's side of the barrier).
 *   RESIDUAL 7 @206/205 = cluster [7] ALONE, and it is now the only thing between this function
 *   and a seal.  Retail: `lui $v1,%hi(_padFixResult)` in the `lw`'s LOAD-DELAY slot, `addiu $v1,
 *   $v1,%lo` in the `bltz`'s branch slot (i.e. a BLOCK-0 `la`, before both guards), then
 *   `addu $s1,$v1,$zero` in the loop preheader.  Ours: two `nop`s in those slots and loop.c's own
 *   `lui $s1; addiu $s1` in the preheader (the +1 net insn).  Every other word in the function is
 *   retail's.  RE-SWEPT AT THIS BASIN (04Z; all measured, none beats 7): `int *fb =
 *   _padFixResult;` before the fix read with the guard using `fb` (14 @205 -- count-exact and the
 *   `la` DOES move into block 0, but it goes straight to $s1 with no copy), after the fix read
 *   (12 @203), laundered (37/42), and every 2^4 combination of `fb`-vs-global across the four use
 *   sites (decrement / call arg / loop test / post-loop block): 7, 9, 12, 16, 21, 28, 30, 35, 36,
 *   47.  Also: a block-local `int *fp = fb;` copy in the loop scope plain (7), laundered (37) and
 *   forced through `asm("" : "=r"(fp) : "r"(fb))` (37); and the 16B ANCHOR-AS-PARAMETER device --
 *   a `static __inline__ _padDrainFix(int *fb, unsigned char *info)` helper called with
 *   `_padFixResult` (7, the inliner substitutes and cse folds it back).
 *   SHARPENED STATEMENT OF THE OPEN ANGLE: retail has TWO pseudos where we have one -- a block-0
 *   `la` that DIES into a preheader copy, plus the loop base.  cse cannot be made to keep them
 *   apart from C (it folds a pointer local straight back to the symbol inside the same extended
 *   basic block, and an opacity fence that stops the fold also stops loop.c from recognising the
 *   invariant).  The named instrument is loop.c's `m->match` path in move_movables (a movable
 *   that combine_movables matched to an earlier one is emitted as a REG-REG COPY at the
 *   preheader) -- the question to price is what source form puts TWO equal address movables in
 *   this loop, or, failing that, a PER_FN_POST_MASPSX/TEXT_MOVES row that relocates the two `la`
 *   halves into the two delay slots (the same mechanism _padInitDirSeq is already gated on). */
extern int _padInitSioMode(unsigned char *info)
{
    int ix;              /* MATCH (W72-A17): the fix-table BYTE index, computed INSIDE the
                          * do{}while(0) wrapper -- see the wrapper comment below. */

    JOY_CTRL = 0x40;
    JOY_CTRL = 0;
    JOY_MODE = 0xd;
    JOY_BAUD = 0x88;
    setRC2wait(info[0xe8] == 8 ? 0x50 : 0x91);
    /* MATCH (w64-a7): do{}while(0) DEPTH WRAPPER -- ZERO instructions (loop.c strips the
       phony loop) but flow.c weights refs by loop depth, which lifts the HImode ctrl
       constant's allocno over the _padSioRegs value's and hands it retail's $v1.  Both
       pseudos tie at pri .5000 without it and the tie is broken by allocno NUMBER.  DO NOT
       unwrap: it is worth 11 diff lines.  See the header note (5).
       MATCH (A14/w71): the channel read is HOISTED OUT of the wrapper into `ch`.  The wrapper is
       a sched barrier, so a `lw _padSioChan` inside it cannot pair with the `lw _padSioRegs`
       that follows; outside, the two loads issue in retail's order and fill each other's
       load-delay slots (13B "hoist every load the fence must not block above it").  Keep BOTH
       the wrapper and the hoist -- either alone measures 25. */
    /* MATCH (W72-A17): the fix-table index `ch << 2` is computed INSIDE the wrapper.  The
       wrapper's LOOP_BEG/END notes are a sched1 BARRIER, so a `sll` written after it can never
       rise above the `sh $v1,0xA($a0)` that sits inside -- retail issues the `sll` FIRST.  This
       is the same "hoist what the barrier must not block" move the w71 `ch` hoist made, in the
       other direction: the SHIFT belongs inside, the LOAD outside.  9 -> 7. */
    {
        int ch = _padSioChan;
        do {
            JOY_CTRL = (ch != 0) ? 0x3003 : 0x1003;
            ix = ch << 2;
        } while (0);
    }

    /* drain any queued auto-mode recv fix-ups for this channel */
    {
        /* MATCH (w64-a7): the `<< 2` CAST form, NOT `_padFixResult[_padSioChan]`.  The
           subscript form expands an address into its own pseudo that cse2 then folds into
           the MEM, orphaning it; gcc-2.7.2 never recomputes reg usage after combine, so the
           orphan keeps refs=2, regclass ties it to ST_REGS and reload gives it a 4-byte
           stack slot -> the phantom `vars= 8` frame (8 diff lines).  See header (2)/(3). */
        int fix = *(int *)(ix + (int)_padFixResult);
        if (fix >= 0) {
            if (fix > 0) {
                do {
                    --_padFixResult[_padSioChan];
                    _padFuncRecvAuto(*(unsigned char **)(info + 0xc) +
                                     _padFixResult[_padSioChan] * 0xf0);
                } while (_padFixResult[_padSioChan] > 0);
            }
            if (_padFixResult[_padSioChan] == 0) {
                _padFixResult[_padSioChan] = -1;
                _padFuncRecvAuto(info);
                _padFuncClrCmdNo(info);
            }
        }
    }

    if ((JOY_STAT & 0x200) != 0) {
        JOY_CTRL = JOY_CTRL | 0x10;
        if ((JOY_STAT & 0x200) != 0) {
            while (chkRC2wait() == 0)
                ;
            JOY_DATA8 = 1;                       /* 0x01 : select controller */
            setRC2wait(100);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)JOY_DATA8;
            setRC2wait(0x1ae);
            while ((I_STAT & 0x80) == 0) {
                if (chkRC2wait() != 0)
                    return 0;
            }
            JOY_DATA8 = 0x42;                    /* 0x42 : poll */
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)JOY_DATA8;
            setRC2wait(0x1ae);
            while ((I_STAT & 0x80) == 0) {
                if (chkRC2wait() != 0)
                    return 0;
            }
            JOY_DATA8 = 1;
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                return 0;
            _padWaitRXready();
            (void)JOY_DATA8;
            return 0;
        }
        I_STAT = 0xffffff7f;
    }
    if (info[0x50] == 0)
        return 1;
    /* MATCH (W72-A17): §21A-1 READ-ONLY FENCE + HARD-REG DENIAL, the ZERO-INSTRUCTION form of
       the 20B preference-killer.  Retail keeps the `li $v0,1` staged in the first guard's delay
       slot LIVE across the second load, so the byte pseudo must take $v1 (`lbu $v1,54($s0)`);
       ours took $v0.  The w71 receipt found the 20B identity LAUNDER on a named byte temp does
       move it but pays 2 insns (15 @208).  A read-only fence carries the same `regs_explicitly_
       used` denial of $2 with NO output operand to materialize, and `info` is already resident
       in $s0, so it costs nothing at all: 15 -> 9, count unchanged.  The operand is only a
       carrier -- a named byte temp as the operand measures the same 9. */
    __asm__("" : : "r"(info) : "$2");
    if (info[0x36] != 0)
        return 0;
    {
        /* MATCH (w62-a5 device, LANDED w64-a7): laundering the result constant breaks
           jump.c's store-flag transform, which otherwise folds both constant exits into
           `sltiu $v0,$v0,1` and DELETES a branch (brdist: BRANCH COUNT 20 vs 21). */
        int one = 1;
        __asm__("" : "=r"(one) : "0"(one));
        return one;
    }
}

/* @0x80105060 : _padSioMain -- run the next SIO state function; advance / retire on its result. */
/* MATCH (w53-a8, 34 -> 14, COUNT-EXACT 50/50).  Two facts:
 *  (1) ARM POLARITY: the oracle's `bltz $a0,<tail>` sends the r<0 case OUT-OF-LINE and falls
 *      through into the success path -- so the source tests `r >= 0` with the `_padFuncNextPort(r)`
 *      call as the `else`.  Writing `if (r < 0)` first inlines the error arm and inverts the
 *      branch (34 diffs).  Worth 15 on its own.
 *  (2) `_padSioState` is reached through ONE ANCHOR POINTER and its increment is a NAMED local
 *      stored back BEFORE the call, so the store lands in the `jalr` delay slot exactly like
 *      retail (`lw $v1,0($a1) / sll / lw fn / addiu $v1,$v1,1 / jalr $v0 / sw $v1,0($a1)`).
 *      Falsified: storing `*st` AFTER the call (27), an opacity fence on the anchor (27 there /
 *      14 here, identical), the named-`s` form without the anchor pointer (19 @49/50, one short).
 *  (3) the last 14 (a clean $v0<->$v1 swap on the dispatch head: retail keeps the STATE in $v1 and
 *      the FN POINTER in $v0, ours the reverse) is a local-alloc QTY-PRIORITY tie -- `fn` has 2
 *      refs, `s` has 3, so ours allocates `s` first and MIPS' numeric find_free_reg scan hands it
 *      $v0.  A ZERO-INSN read-only fence on `fn` buys the +1 ref that crosses the floor_log2 step
 *      and flips the pair (w49/w52 fence-dial law: read-only fence = +1 ref).  The identity fence
 *      also works; a fence on `s` (the demote direction) does NOT (14), nor does re-ordering the
 *      first uses so `fn` is born first (14). */
extern void _padSioMain(unsigned char *info)
{
    int (*fn)(unsigned char *);
    int r;
    int *st = &_padSioState;
    int s;

    s = *st;
    fn = (int (*)(unsigned char *))padIntFunc[s];
    __asm__("" : : "r"(fn));                     /* ref dial -- see (3) above */
    *st = s + 1;
    r = fn(info);
    if (r >= 0) {
        if (_padSioState != 0) {
            setRC2wait(0x3c);
            if (_padClrIntSio0() == 0)
                _padFuncNextPort(0xfffffffd);
        }
        if (_padSioState > 4)
            _padSioState = _padSioState - 1;
    } else {
        _padFuncNextPort(r);
    }
}

/* @0x80105128 : _padSioRW -- exchange one byte; first byte (tx<0) issues the line, else polls.
 * MATCH (w59-root, 57 -> PASS 118/118; earlier w52-a5, 137 -> 59): rebuilt from the oracle.
 * Signature is `int (u_char*, int)` and BOTH
 * exits return the RX byte (`addu $v0,$s1,$zero`).  Corrections: chkRC2wait's RESULT drives the
 * spins (`while (chkRC2wait() == 0);` / `if (chkRC2wait() != 0) return -0x14;`) -- it was being
 * called and discarded; the BAUD value is SELECTED into a local and stored ONCE, late, next to the
 * `rx = JOY_DATA8` read (`sh $a2,0xE($v0)`), not written twice at the top; `_waitTime` is stored
 * BEFORE `_startTime`.  Final GCC-2.7.2 source-shape receipts: `rx` is an `int`; both arms share
 * one physical `return_rx` label; the negative transmit byte is a block-local `unsigned char`;
 * the positive arm caches SIO/IRQ bases only for their retail-sized phases; and both STAT waits
 * are guard + do/while shapes.  Most decisively, the timer value and the first volatile JOY_STAT
 * read are named locals loaded before the two timer stores.  That statement/lifetime order gives
 * retail's a2 baud, a1 SIO base, a0 timer, v1 STAT allocation and exact scheduling without asm. */
extern int _padSioRW(unsigned char *dev, int tx)
{
    int rx;

    if (tx < 0) {
        unsigned char *out = *(unsigned char **)(dev + 0x40);
        rx = JOY_DATA8;
        dev[0x44] = 0xff;
        dev[0x45] = 1;
        *out = (unsigned char)~tx;
        while ((JOY_STAT & 1) == 0)
            ;
        while (chkRC2wait() == 0)
            ;
        {
            unsigned char value = (unsigned char)~tx;
            volatile unsigned char *data = _padSioRegs;
            *data = value;
        }
        goto return_rx;
    } else {
        unsigned short baud = 0x88;
        int hdr = **(unsigned char **)(dev + 0x3c);
        if (hdr >> 4 == 8 && dev[0x44] > 8)
            baud = 0x22;
        {
            unsigned short start = T2_VALUE;
            unsigned char *sio = _padSioRegs;
            unsigned short stat;
            stat = *(volatile unsigned short *)(sio + 4);
            _waitTime  = 0x1ae;
            _startTime = start;
            if ((stat & 2) == 0) {
                do {
                } while ((JOY_STAT & 2) == 0);
            }
        }
        {
            unsigned char *sio = _padSioRegs;
            unsigned char *ir = _padIntRegs;
            rx = *(volatile unsigned char *)sio;
            *(volatile unsigned short *)(sio + 0xe) = baud;
            if ((*(volatile unsigned int *)ir & 0x80) == 0) {
                do {
                    if (chkRC2wait() != 0)
                        return -0x14;
                } while ((I_STAT & 0x80) == 0);
            }
        }
        JOY_DATA8 = (unsigned char)tx;
        dev[0x45] = dev[0x45] + 1;
        *(*(unsigned char **)(dev + 0x3c) + dev[0x44]) = rx;
        dev[0x44] = dev[0x44] + 1;
return_rx:
        return rx;
    }
}

/* @0x80105300 : _padSioRW2 -- like _padSioRW but bounded by the RC2 timer.
 * MATCH (w59-root, 36 -> 2, count-EXACT 142/142; earlier w52-a5, 157 -> 36): the matched
 * Sled Storm donor confirms the baud-arm polarity and the `T2_TARGET != 0` arm order.  `rx` is
 * an int normalized with `& 0xff`; an int index stages the required second `dev[0x44]` read.
 * The allocator boundary is only 0.1142 vs 0.1111: the nibble threshold needs ONE extra real
 * baud reference for retail s1/s2 ownership.
 * MATCH (w62-a5, 2 -> PASS 142/142) -- REF WITHOUT VALUE-CAPTURE.  Spelling that extra ref as
 * `baud - 0x80` inside the compare hands cse the constant: it knows baud==0x88 there and
 * rewrites the literal 8 as `addiu v0,s1,-128` (13C cse-constant-capture, mirrored).  Buy the
 * SAME ref with a zero-insn read-only fence AFTER baud's last real use and write the threshold
 * as the literal `8`: `li v0,8` returns and the whole allocation is unchanged.  CONTROL GATED:
 * literal `8` with NO fence = 14 diffs (the ref really is load-bearing); `int baud` = 14; -G8
 * is not a solution.  The ACK wait embeds an INLINE COPY of
 * chkRC2wait's body (retail hoists _startTime/_waitTime and the four RC2/SIO MMIO addresses into
 * $a0/$a1/$t1/$a2/$t2/$t0 above the loop -- a call could never produce that), returning -2 on
 * timeout.  Also: baud is a selected local stored once, and the second baud decision reads the
 * JUST-RECEIVED byte (`if (dev[0x44] == 0 && (int)rx >> 4 == 8) JOY_BAUD = 0x22;`).  The
 * prescale arms are ordered `(T2_MODE & 0x200) != 0` FIRST (fall-through) so the >>3 arm is the
 * beqz target, matching retail's block layout. */
extern int _padSioRW2(unsigned char *dev, int tx)
{
    unsigned short baud = 0x88;
    int rx;
    int hdr = **(unsigned char **)(dev + 0x3c);

    if (hdr >> 4 == 8 && dev[0x44] > 8)
        baud = 0x22;

    while ((JOY_STAT & 2) == 0)
        ;
    setRC2wait(0x190);
    rx = JOY_DATA8 & 0xff;
    if (*(volatile unsigned char *)(dev + 0x44) != 0 ||
        rx >> 4 != 8)
        JOY_BAUD = baud;
    else
        JOY_BAUD = 0x22;
    __asm__("" : : "r"(baud));   /* MATCH w62-a5: +1 baud ref, 0 insns */

    while ((I_STAT & 0x80) == 0) {
        unsigned cur = T2_VALUE & 0xffff;
        if (cur < (unsigned)_startTime) {
            if (T2_TARGET != 0)
                cur += T2_TARGET;
            else
                cur += 0x10000;
        }
        if ((T2_MODE & 0x200) != 0) {
            if (cur - (unsigned)_startTime >= (unsigned)_waitTime)
                return -2;
        } else {
            if ((cur - (unsigned)_startTime) >> 3 >= (unsigned)_waitTime)
                return -2;
        }
    }
    if (dev[0xe8] != 8 && _padSioState == 2) {
        setRC2wait(0x3c);
        while (chkRC2wait() == 0)
            ;
    }
    JOY_DATA8 = (unsigned char)tx;
    {
        int idx = dev[0x44];
        dev[0x45] = dev[0x45] + 1;
        if (idx != 0xff) {
            idx = dev[0x44];
            *(*(unsigned char **)(dev + 0x3c) + idx) = rx;
        }
    }
    dev[0x44] = dev[0x44] + 1;
    return rx;
}

/* @0x80105538 : _padClrIntSio0 -- ack the SIO0 IRQ and re-enable. */
/* MATCH (w52-a5, 24 -> 7): the fn RETURNS int (retail stages `addu $v0,$zero,$zero` in the
 * timeout branch's delay slot and `addiu $v0,$zero,1` before the CTRL set) and the loop is a
 * PLAIN TOP-TESTED `while`, not a do/while with an in-body early return: gcc-2.8's jump.c
 * duplicate_loop_exit_test emits retail's second copy of the STAT test (the `.L8010559C`
 * reload+`bnez` back-edge).  Both call sites (MCXMAIN/_padSioMain) discard the result. */
/* MATCH (w53-a8, 8 @30/36 -> PASS 36/36).  Two cooperating facts, both read off the oracle:
 *  (1) THE WAIT IS A ZERO-TRIP-GUARDED do/while, not a plain `while`.  Retail tests SIO0 STAT
 *      ONCE before the loop (`lhu $v0,4($a0); andi 128; beqz`) and AGAIN at the back edge, with
 *      the two tests reaching the register base DIFFERENTLY (the entry test off the hoisted $a0,
 *      the back-edge test off a fresh `lui/lw`).  That is a guard + rotated do/while written in
 *      source: a plain `while` gives the entry `j <test>` shape (6 insns short), and the guard
 *      written around a plain `while` is JUMP-THREADED back into the loop test by gcc's jump.c
 *      (byte-identical to the bare `while`; a zero-insn `__asm__("" : : "i"(0))` at the loop head
 *      blocks the thread and lands 7 @37/36 -- the do/while needs no device at all).
 *  (2) BOTH register-block bases are DECL-INIT LOCALS, `_padIntRegs` FIRST.  The macros reach the
 *      globals directly, so cc1 emits `_padSioRegs`'s macro load ahead of `_padIntRegs`'s (4 diffs,
 *      count-exact) and the entry test pays a load-delay `nop`; two named locals in the oracle's
 *      materialization order fix both.  Falsified: `sio` alone as a decl-init (4), `sio` assigned
 *      after the I_STAT store (8 @30 -- the guard collapses again), non-volatile STAT read (8). */
extern int _padClrIntSio0(void)
{
    unsigned char *ir = _padIntRegs;
    unsigned char *sio = _padSioRegs;

    *(volatile unsigned int *)(ir + 0x00) = 0xffffff7f;
    if ((*(volatile unsigned short *)(sio + 0x04) & 0x80) != 0) {
        do {
            if (chkRC2wait() != 0)
                return 0;
        } while ((JOY_STAT & 0x80) != 0);
    }
    JOY_CTRL = JOY_CTRL | 0x10;
    return 1;
}

/* @0x801055C8 : _padWaitRXready -- spin until SIO0 RX has a byte (STAT bit 1). */
extern void _padWaitRXready(void)
{
    do {
    } while ((JOY_STAT & 2) == 0);
}
