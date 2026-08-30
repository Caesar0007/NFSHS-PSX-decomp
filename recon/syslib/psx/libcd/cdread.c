/* syslib/psx/libcd/cdread.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(CDREAD.OBJ): the high-level multi-sector CdRead engine.
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity over diff count): cc1plus (C++) measured
 *   strictly better per-fn diff counts than cc1 (C) on this TU -- _read_int 109->115 (w26-a1 dual-
 *   compile audit). Migrated anyway for source-uniformity across syslib/eaclib. Do NOT revert to
 *   .cpp without a user decision; see recon/eaclib/psx/eacpsxz/cdfs.c and
 *   recon/syslib/psx/libcd/iso9660.c and recon/syslib/psx/libgpu/FONT.c for the sibling KEEP-CPP-
 *   turned-uniform TUs (same ruling, same date).
 *
 *   CdRead(sectors, buf, mode) starts an asynchronous N-sector read; the per-sector work is driven
 *   by the libcd ready/data interrupt callbacks installed here, and CdReadSync() polls for / waits
 *   on completion.  Five private callbacks + helpers:
 *       _read_sync       (@0x8010887C) -- sync-complete: restore the saved sync cb, clear "reading".
 *       _read_int        (@0x801088B0) -- ready interrupt: on each DataReady, verify the sector
 *                                          header (2048-byte mode) and copy the sector into `cur`
 *                                          (or, in DMA mode, re-arm the data callback).
 *       _read_data_int   (@0x80108B24) -- DMA-data complete: advance cursor / remaining / expected.
 *       _read_issue      (@0x80108BF4) -- (re)issue the read: handle shell-open, set mode/loc,
 *                                          install callbacks and fire CdlReadN.
 *       CdRead           (@0x80108DDC), CdReadSync (@0x80108F78) -- public API.
 *
 *   W52-A2 TOOLCHAIN A/B (UNCHANGED source, whole-TU diff totals; gate = tools/verify_asm.py):
 *     gcc LADDER (NFS4_FORCE_CC1_ALT, 272 recipe)   base(2.8.0+maspsx) 169 | 2.6.0 303 |
 *       2.6.3 303 | 2.7.2-970404 173 | 2.7.2 289 | 2.8.0 175 | 2.8.1 175 | 2.91.66 303 |
 *       2.95.2 286.   ==> NO ladder rung beats the wired lane; cdread.c stays OFF cc1_272
 *       (w51-a3's 169->289 verdict reproduced exactly).  Per-fn the rungs disagree wildly
 *       (CdReadSync is 3 on 2.6.0/2.6.3/2.7.2 vs 6 on the lane; _read_issue 58 on
 *       2.7.2-970404/2.8.0 vs 64 then), so the TU is a genuine mixed basin.
 *     PER-TU FLAGS: no_split_addresses 199 (mixed: CdReadSync 6->2, CdRead 43->39, but
 *       _read_data_int 4->27 and _read_issue 64->81) | no_strength_reduce 169 (inert) |
 *       no_schedule_insns 222 | no_delayed_branch 363.  ==> keep the TU's default flags.
 *
 *   All five share one private state block @0x8013C290 (CDREAD.OBJ .bss).  Its fields are referenced
 *   purely by byte offset in the original; reproduced here as a struct with offset-named members and
 *   a semantic note for each.  Several stores land in JAL delay slots and therefore capture the value
 *   present *before* the call returns -- annotated inline where it matters (e.g. _issue's w20). */

typedef unsigned char u_char;
typedef unsigned long  u_long;
/* PsyQ 4.3 libcd.h: callback status byte plus the driver result buffer. */
typedef void (*CdlCB)(u_char, u_char *);

struct CdlLOC { u_char minute, second, sector, track; };
typedef struct CdlLOC CdlLOC;

/* ---- private CdRead state block @0x8013C290 (CDREAD.OBJ .bss) -------------------------------- */
struct CdrEnv {
    int      w00;   /* +0x00 : sectors requested                                     */
    u_char  *w04;   /* +0x04 : destination buffer                                    */
    u_char  *w08;   /* +0x08 : write cursor (advances by w10 words per sector)       */
    int      w0c;   /* +0x0C : read mode (|0x20 = "use callback")                    */
    int      w10;   /* +0x10 : sector size in words (0x200 / 0x249 / 0x246)          */
    int      w14;   /* +0x14 : sectors remaining (-1 = error/abort)                  */
    int      w18;   /* +0x18 : VSync stamp of the last interrupt                     */
    int      w1c;   /* +0x1C : VSync stamp at issue (overall watchdog base)          */
    int      w20;   /* +0x20 : next expected absolute sector number                  */
    int      w24;   /* +0x24 : "read in progress" flag                               */
    CdlCB    w28;   /* +0x28 : saved sync callback                                   */
    CdlCB    w2c;   /* +0x2C : saved ready callback                                  */
    void   (*w30)(void); /* +0x30 : saved data callback                              */
    u_char  *w34;   /* +0x34 : last driver result buffer passed to CdReadCallback    */
};
typedef struct CdrEnv CdrEnv;

/* 🔴 W65-A6 FALSIFIED, do not retry blind: `_cdr` is one of the tree's reloc-referenced
 * UNDEFINED symbols (34 sites, the biggest in libcd), and 0x8013C290 IS already emitted by the
 * splat blob as `dlabel D_8013C290` (asm/data/data_8010CCD4_r20.data.s) -- so the obvious fix
 * is the project's asm-label alias `extern volatile CdrEnv _cdr __asm__("D_8013C290");`, which
 * is byte-neutral everywhere else it was applied this session (13 symbols across INTR/INTR_DMA/
 * INTR_VB/VSYNC/FONT, all zero-delta).  HERE IT IS NOT: measured twice, it costs
 * CdReadSync PASS -> FAIL (2 diffs) while CdRead/_read_issue/_read_int stay put, i.e. 3/6 -> 2/6.
 * The alias is therefore REVERTED and `_cdr` stays undefined pending the blob-vs-TU ownership
 * decision for the 0x8013C290 region (the storage exists; only the NAME is missing).  The
 * mechanism is worth naming before the next attempt: everything else about the TU is unchanged,
 * so a reloc-NAME change alone moved a scheduling/coloring decision -- most likely through the
 * `volatile` MEM ordering this TU depends on (catalog: volatile-store-vs-slot).  Whoever
 * retries it should gate CdReadSync specifically, and prefer renaming the BLOB label to `_cdr`
 * (an oracle-side rename, zero effect on this object) over aliasing the C declaration. */
extern volatile CdrEnv _cdr;   /* @0x8013C290 -- zero-initialised .bss */

/* ---- libetc / libc ---------------------------------------------------------------------------- */
extern int  VSync(int mode);                 /* @0x800F231C */
extern int  puts(const char *s);             /* libc A63 @0x800E80CC */

/* ---- libcd public API (cdcont.cpp / SYS.OBJ) -------------------------------------------------- */
extern int   CdStatus(void);                                       /* @0x800F7780 */
extern int   CdMode(void);                                         /* @0x800F7790 */
extern CdlLOC *CdLastPos(void);                                    /* @0x800F77A0 */
extern void  CdFlush(void);                                        /* @0x800F7818 */
extern int   CdReady(int mode, u_char *result);                    /* @0x800F786C */
extern CdlCB CdSyncCallback(CdlCB func);                           /* @0x800F788C */
extern CdlCB CdReadyCallback(CdlCB func);                          /* @0x800F78A0 */
extern int   CdControl(int com, u_char *param, u_char *result);    /* @0x800F78B4 -- INT com,
                                     * see cdcont.c's CdControl receipt (w55-a5) */
extern int   CdControlF(int com, u_char *param);                   /* @0x800F79F0 -- INT com
                                     * (w53-a9): the definition's oracle copies the parameter RAW
                                     * and re-masks per use; a u_char parameter masks once at
                                     * entry and cannot match.  All call sites pass literals. */
extern int   CdControlB(int com, u_char *param, u_char *result);   /* @0x800F7B24 -- INT com */
extern int   CdGetSector(void *madr, int size);                    /* @0x800F7C70 */
extern int   CdGetSector2(void *madr, int size);                   /* @0x800F7C90 */
extern void (*CdDataCallback(void (*func)(void)))(void);           /* @0x800F7CB0 */
extern int   CdDataSync(int mode);                                 /* @0x800F7CD4 */
extern int   CdPosToInt(CdlLOC *p);                                /* @0x800F7DF8 */

/* ---- shared driver-config globals (EVENT.OBJ .bss) -------------------------------------------- */
extern CdlCB CD_cbread;      /* @0x8013C2D0 : user CdReadCallback */
extern int CD_read_dma_mode; /* @0x8013C2D4 : bit0 = copy sectors via DMA */

/* forward decls (callbacks reference each other and _read_issue) */
extern void _read_sync(void);
extern void _read_int(u_char intr, u_char *result);
extern void _read_data_int(void);
extern int  _read_issue(int retry);

/* @0x8010887C : sync-complete handler -- restore the saved sync cb and clear the busy flag. */
/* MATCH (w52-a2, DOUBLE OPACITY FENCE -- the split-addresses ORDER swap, 4 -> PASS 13/13):
 * count and instruction MULTISET already matched; the only divergence was WHERE the
 * `addiu s0,s0,%lo` landed.  Retail: `lui; addiu %lo; sw ra; lw a0,0(s0); jal; addiu s0,-40`
 * (the address completed UP FRONT, so the jal slot could only be filled from AFTER the call).
 * Ours: cc1's split-address lowering folds the lo_sum into the load (`lw a0,%lo(s0)`) and
 * leaves the standalone `addiu %lo` as the nearest stealable insn BEFORE the jal -- reorg
 * takes it and the post-call `addiu -40` stays put.  FIX = two zero-instruction W49 IDENTITY
 * fences: the first pins the FULL address of `&_cdr.w28` in a register (kills the lo_sum
 * fold, so the load must use the completed pointer), the second pins the derived block base
 * `saved - 10` == `&_cdr` as its own `addiu -40` (without it gcc folds -40+0x24 into a single
 * `sw zero,-4(s0)`, 12 insns).  reorg then steals that post-call addiu into the jal slot =
 * retail.  FALSIFIED on the way: plain direct `_cdr.w28`/`_cdr.w24` access (anchors on
 * `&_cdr`+40/36 displacements, nop in the jal slot, 4); read-only fence `: : "r"(saved)`
 * (right ORDER but splits high/full into v0/s0, 6); first fence alone (14 insns -- `saved`
 * loses its REG_EQUIV so `_cdr.w24` rematerializes its own lui); second fence alone (4, the
 * original order swap).  TU-level `no_split_addresses` also does NOT fix it (still 4) and is
 * net-worse for the TU (169 -> 199) -- see the ladder/flag table in the w52-a2 report. */
extern void _read_sync(void)
{
    volatile int *saved = &_cdr.w28;
    __asm__("" : "=r"(saved) : "0"(saved));
    CdSyncCallback((CdlCB)*saved); /* restore saved sync callback */
    {
        volatile CdrEnv *g = (volatile CdrEnv *)(saved - 10);
        g->w24 = 0;              /* reading = 0 */
    }
}

/* @0x801088B0 : ready interrupt -- one DataReady per sector.
 * NOTE: NO cached `CdrEnv *g` local -- the oracle addresses `_cdr` fresh (a cheap 2-insn lui/addiu
 * rematerialization of the constant .bss address) at each access, and instead spends its ONE
 * available callee-saved register on the incoming `result` ARGUMENT (which survives several `jal`s
 * and can't be cheaply rematerialized).  A persistent `g` pointer local pins the allocator's
 * saved-reg budget on the wrong value (methodology catalog: "eager-cache" / "don't cache derived
 * pointers across calls" class).
 *
 * MATCH (w52-a2): 48 -> 21 diffs, count EXACT-then-+1 (159/157 -> 158/157).  ONE device does
 * almost all of it -- the W49 IDENTITY FENCE `__asm__("" : "=r"(p) : "0"(p))` on each
 * per-region FIELD ANCHOR.  cc1's default -msplit-addresses lowers `&_cdr.wNN` into a (high)
 * pseudo plus a lo_sum, and the two halves get DIFFERENT registers (`lui $v1,%hi; addiu
 * $s0,$v1,%lo`) while retail emits one `la` into a single register (`lui $s0; addiu $s0,$s0`).
 * The identity fence forces the completed address into one register -- the anchors themselves
 * were already correct, only their materialization was split.  Fences on the two `cur`
 * anchors + the derived `g` view: 48 -> 24 with count EXACT 157/157.  A further anchor on
 * `&_cdr.w20` for the sector-check region (retail: `lw $v1,0($s0)` + `addiu $v1,$s0,-32`)
 * took 24 -> 21 (+1 insn).  FALSIFIED (measured, do NOT retry in this basin): fencing the
 * derived `&_cdr` view inside the sector-error arm (26); an anchor+fence for the head
 * `_cdr.w34 = result` store (27, +3 insns); an anchor+fence for the common tail (60, +4).
 * RESIDUAL 21 = the head store's split `lui $v0/addiu $v1` and the tail's `lui $v1/addiu $s0`
 * (same split-address class, but both fence attempts overshoot), plus three delay-slot
 * placement diffs.
 * W63-A6: re-gated at 15 @158/157 and the VOID-BARRIER POSITION axis is now CLOSED --
 * a mechanical sweep inserting a zero-insn `__asm__("" : : "i"(0))` before EVERY statement
 * in the body (scratchpad/w63a6/fencesweep.py, ~50 positions) found NOTHING under 15; the
 * best non-baseline results were 16 (three positions) and everything else 15 or worse.
 * This matters because the same sweep is what took _read_issue 15 -> 8 and StCdInterrupt
 * 36 -> 27 in this wave, so its emptiness here is a real negative, not an untried axis.
 * Remaining named clusters are unchanged: the two split-address `lui/addiu` pairs (head +
 * tail anchor), a `j` slot retail fills with `sw $v0,32($a0)` (the 3.25-3c non-volatile
 * cast is FALSIFIED at this site, see the in-body note), and the `beqz $v1` slot where
 * W64-A6: re-gated 15 @158/157 and the FENCE-REMOVAL axis is now closed too (the
 * w64 CdRead lesson -- an inherited fence can itself be the blocker -- does NOT apply
 * here): dropping the `exp` fence 24 @157, the DMA-arm `cur` fence 17, the PIO-arm
 * `cur` fence 37 @160, ALL FOUR 48 @159.  Only the trailing `g` fence in the PIO arm
 * is INERT (15) -- kept as documentation of the derived-view shape.
 * Per-fn `-mno-split-addresses` (the mechanism that seals CdRead) is decisively WRONG
 * here: 47 @162 (and _read_issue 32 @126, _read_data_int PASS -> 3, CdReadSync
 * PASS -> 2), so the two split `lui/addiu` pairs are not reachable that way.
 * retail carries `li $v0,1`.
 *
 * W71-A8: 15 -> 9 @156/157 (count was EXACT 157/157 after the first landing).  TWO
 * landings, both re-priced in a basin the earlier waves never reached:
 *  (1) 🔴 CORRECTNESS + MATCH, -3: the `_cdr.w24 = 1` store is UNCONDITIONAL.  The oracle
 *      carries `sw $v0,0x24($s0)` in the `beqz $v1,.L80108B10` DELAY SLOT (80108AF0), so
 *      it runs whether or not a user CdReadCallback is installed -- exactly the w48-a6
 *      class already fixed in `_read_data_int`, still live HERE.  The old shape put the
 *      store inside `if (CD_cbread != 0) { ... }`, i.e. a callback-less read never set the
 *      "read in progress" word that CdReadSync polls.  Fixed by lifting the store out of
 *      the guard, loading the callback into a local FIRST (so its load is not sunk under
 *      the store's alias) and writing w24 through a NON-VOLATILE cast (3.25-3c) so reorg
 *      may slot-fill it.  15 -> 12, and the +1 instruction surplus disappeared.
 *  (2) `g->w20++` written through a NON-VOLATILE lvalue cast, -3 (12 -> 9).  This is the
 *      SAME site w62-a6 measured at 25 and filed as "the lever is strictly site-selective";
 *      it is site-selective AND BASIN-RELATIVE -- from the post-(1) basin it is the win,
 *      while its neighbours still are not (w14 18, w08 31, w14+w20 17).
 * RESIDUAL 9, named and priced in THIS basin (all measured, all reverted):
 *  (a) 8 of the 9 are the TWO SPLIT-ADDRESS `lui/addiu` pairs (head `&_cdr` in $v1, tail
 *      `&_cdr` in $s0): retail self-temps (`lui $r; addiu $r,$r`), cc1 puts the HIGH in its
 *      own short-lived pseudo (`lui $v0; addiu $v1,$v0` / `lui $v1; addiu $s0,$v1`).  Head
 *      anchors re-swept in this basin: volatile-struct+fence 19, word-indexed `int *`+fence
 *      19, non-volatile struct+fence 18, `char *`+fence 16, volatile struct WITHOUT a fence
 *      9 (INERT -- the natural CSE already produces the same pair).  So this is a pure
 *      local-alloc combine_regs tie on the HIGH pseudo, not a shape question.
 *  (b) 1 diff: the `beqz` guarding the DMA `CdGetSector2` arm -- retail leaves the slot
 *      `nop`, ours steals the arm's leading `lui %hi(_cdr+8)`.  Fence sweep re-run here:
 *      a barrier at the arm head 11, before the `if` 9 (inert).  13B says a fence can only
 *      BLOCK a steal; it does not, because the stolen half is a SPLIT address (under the
 *      nosplit/`la`-macro form it would be a 2-word macro reorg could not slot at all --
 *      which is exactly what retail looks like, and is why (a) and (b) are ONE cause).
 *  PER-FN LADDER RE-RUN AT THIS BASIN (12G law): 2.8.1 (wired) 9 - 2.8.0 18 - 2.7.2-970404
 *  23 - 2.95.2 48 - 2.91.66 63 - 2.7.2 73 - 2.6.3 89.  Whole-TU `no_split_addresses` 37
 *  (and it breaks CdReadSync/_read_data_int); per-fn nosplit 44; per-fn -fforce-addr 18.
 *  The wired 2.8.1 splice stands.  ⚠️ NOTE the per-fn splice tables OVERWRITE each other:
 *  _apply_fn_splice (nosplit/faddr) runs AFTER _apply_cc1_ver_splice and re-splices from a
 *  DEFAULT-cc1 compile, so "2.8.1 + -mno-split-addresses" is not expressible today.
 *
 * W72-A16 re-gate: 9 @156/157.  The splice-composition cell above is RE-VERIFIED as still
 * inexpressible (probe: build.py's per-fn nosplit table applied to _read_int re-splices
 * from a default-cc1 compile, so the 2.8.1 ver-splice is lost).  SPEC for the orchestrator,
 * so the cell becomes measurable without another wave burning a probe on it:
 *   _apply_cc1_ver_splice / _apply_cc1_ver_splice_272 and _apply_fn_splice both work by
 *   RE-COMPILING the whole TU with an alternate cc1/flag set and splicing the named
 *   function's region out of that second .s into the primary one.  They are applied
 *   SEQUENTIALLY over the SAME primary text, and each one's second compile uses the
 *   DEFAULT cc1 + default flags -- so whichever runs last overwrites the other's region.
 *   FIX = make the two tables COMPOSE by keying the alternate compile on the UNION of the
 *   per-fn requests: build one extra .s per distinct (cc1, extra-flags) PAIR that any
 *   function in the TU asks for, then splice each function's region from ITS pair's .s.
 *   Concretely: collect {fn: (cc1_path, extra_flags)} from PER_FN_CC1_VER_SPLICE[_272],
 *   PER_FN_NO_SPLIT_ADDRESSES, PER_FN_NO_DELAYED_BRANCH, PER_FN_NO_THREAD_JUMPS,
 *   PER_FN_G8 and PER_FN_FORCE_ADDR; group by the pair; one compile per group; one splice
 *   pass over the union.  That is a pure build.py refactor -- no new flag semantics -- and
 *   it makes "2.8.1 + -mno-split-addresses" (this function) and the same composition for
 *   CdRead (2.8.0 + nosplit, already wired as a single-table entry) expressible together.
 * ALSO FALSIFIED at this basin (all gated + reverted): the 20B hard-register conflict
 * applied to the head split-address pair -- a volatile `&_cdr` anchor + launder with a
 * "$2" clobber 12, without the clobber 13, with "$2","$3" 14, with "$4" 19, and a bare
 * `__asm__("" ::: "$2")` before the head store 13.  The clobber DOES move the HIGH pseudo
 * off $v0, but it never TIES it to the base's $v1 -- combine_regs' tie is refused for a
 * lo_sum that is a GLOBAL allocno (21E-4), and a hard-reg denial cannot create a tie, only
 * relocate one side.  Per-fn `-mno-split-addresses` re-priced here: 44 (unchanged).
 *
 * ============================================================================
 * 🏆 W74-A14: SEALED.  9 -> 5 -> 1 -> PASS 157/157.  Three landings, each with its own
 * in-body receipt: (1) the TAIL ANCHOR + identity fence, (2) the HEAD ANCHOR + identity
 * fence, (3) a VOID BARRIER in BOTH arms of the sector-copy `if`.
 *
 * WHY THE W71 SWEEP MISSED IT (the reusable lesson -- catalog 21E-1 at its sharpest):
 * W71-A8 swept the HEAD anchor forms and measured 16-19 against its own 9, and w52-a2
 * had swept the TAIL anchor and measured 60 against its own 24, so BOTH halves of the
 * cure stood recorded as falsified.  They are falsified only PAIRWISE-INDEPENDENTLY:
 * with just one of the two anchors fenced the other region's split `lui/addiu` pair and
 * the newly-opaque pseudo fight over the same caller-saved band, and the fn gets worse.
 * Land the TAIL first (9 -> 5), and the HEAD forms that measured 16-19 now measure 1.
 * ⇒ a two-site device must be priced as a CELL, not as two independent axes (cf. 22C-8
 * "two independently-swept axes can hide a winner needing both at once", and 22A-1's
 * "TWO-SITE law: with only one of two sites escaped the fix is a NET LOSS").
 *
 * THE COMBINE_REGS LAW, NOW READ OFF THE COMPILER SOURCE (supersedes the (a) note above,
 * which called it "a pure local-alloc combine_regs tie ... not a shape question"):
 * combine_regs (gcc-2.8.1 local-alloc.c:1824) can NEVER tie a %hi pseudo to a lo_sum
 * whose destination is a GLOBAL allocno.  Three guards do it: :1868 needs reg_qty[ureg]
 * >= 0, :1877 rejects reg_qty[sreg] == -1, and :1946 returns 0 unless reg_qty[sreg] is
 * exactly -2 -- and :470-77 sets -2 only for a pseudo with REG_BASIC_BLOCK >= 0 AND
 * REG_N_DEATHS == 1, i.e. block-local with a single death.  Both the head and the tail
 * `&_cdr` base span three basic blocks, so the tie is structurally unreachable and NO
 * amount of ref/priority/hard-reg dialling can produce retail's self-temp.  The only two
 * shapes that CAN are (i) the `-mno-split-addresses` `la` MACRO (whose 2-word form the
 * assembler expands dest-as-scratch), and (ii) the W49 IDENTITY FENCE, which collapses
 * the (high)+(lo_sum) pair into ONE opaque pseudo before allocation ever sees it.  (ii)
 * is the one available per-site.  This is the same law `_read_data_int` already states in
 * its own receipt -- it just had never been applied to a MULTI-REGION function.
 *
 * THE SPLICE-COMPOSITION CELL IS NOW MEASURED, AND IT IS A NET LOSS HERE -- the ask above
 * can be RETIRED for this function.  scratchpad/W74_A14_mkbuild.py builds a scratch-only
 * copy of build.py + verify_asm.py whose _apply_cc1_ver_splice takes an extra env-driven
 * pass, so "2.8.1 + <extra flags>" is measurable without building the orchestrator
 * mechanism.  Result: `A14_NS_FNS=_read_int` (= 2.8.1 + -mno-split-addresses, the exact
 * composition the spec asks for) = 37 diffs @160/157, i.e. IDENTICAL to the whole-TU
 * `no_split_addresses` number already banked above.  That equality is itself the proof
 * that whole-TU nosplit ALREADY exercises the composition for a ver-spliced function
 * (`_cc1_flags_for_rung` forwards the TU flags to the rung compile), so the cell was
 * never unmeasured -- it was mis-read as unmeasured.  WHY it loses: without split
 * addresses gcc folds each field offset INTO the symbol (`la $v1,_cdr+52` then
 * `sw $s1,0($v1)`, `lw $v0,-32($v1)`), where retail anchors on `_cdr` itself and keeps
 * 52/20/16 as load displacements.  The composition mechanism is still worth building for
 * OTHER functions, but it is not this one's cure.
 * ============================================================================ */
extern void _read_int(u_char intr, u_char *result)
{
    /* MATCH (W74-A14, 5 -> 1): the HEAD ANCHOR + W49 IDENTITY FENCE, the same device as the
     * tail anchor above and for the same reason (retail's one self-temping `la $v1,_cdr`
     * vs cc1's split `lui $v0,%hi; addiu $v1,$v0,%lo`; combine_regs cannot tie a GLOBAL
     * allocno's lo_sum, local-alloc.c:1946 requires reg_qty[sreg] == -2).  W71-A8 swept
     * exactly these forms and measured 16-19 (all worse than its 9) -- that sweep was run
     * BEFORE the tail anchor existed; from the post-tail basin the same forms are the win
     * (21E-1).  Measured here (scratchpad/W74_A14_rint_head.json, all gated):
     *   volatile-struct + fence 1 (kept) - `volatile char *` + fence 1 - `volatile int *`
     *   + fence 1 - volatile struct WITHOUT the fence 5 (inert) - a bare block wrap 5
     *   (inert control) - NON-volatile struct + fence 9 (the volatile qualifier is
     *   load-bearing: without it cse re-derives the field addresses).  */
    {
    volatile CdrEnv *h = &_cdr;                     /* $v1 : one `la` for the head region */
    __asm__("" : "=r"(h) : "0"(h));
    h->w34 = result;                                /* remember driver result for user cb */

    if ((intr & 0xFF) == 1) {                       /* CdlDataReady */
        if (h->w14 > 0) {                            /* still sectors to read */
            if (h->w10 == 0x200) {                   /* 2048-byte mode: verify the MSF header */
                /* MATCH: a 16-byte scratch (Rage Racer read_callbacks.c spells it
                 * `long buf[4];`), not a 4-byte CdlLOC -- the oracle reserves 16
                 * bytes at sp+0x10 for it (frame 0x30, first save at 0x20). */
                long hdr[4];
                if (CD_read_dma_mode & 1) {
                    CdDataCallback(0);
                    CdGetSector2(hdr, 3);
                    CdDataSync(0);
                    CdDataCallback((int)_read_data_int);
                } else {
                    CdGetSector(hdr, 3);
                }
                {   /* MATCH: retail anchors this region on `&_cdr.w20` ($s0, offset 0) and
                     * derives `&_cdr` from it as `addiu $v1,$s0,-32` for the w14 store. */
                    volatile int *exp = &_cdr.w20;
                    __asm__("" : "=r"(exp) : "0"(exp));
                    if (CdPosToInt((CdlLOC *)hdr) != *exp) {
                        volatile CdrEnv *e = (volatile CdrEnv *)(exp - 8);
                        puts("CdRead: sector error\n");
                        e->w14 = -1;
                    }
                }
            }
            /* copy the sector body.
             * MATCH (per-region field anchor, w47-a5 "Per-region %hi/%lo anchor";
             * the same device Rage Racer uses throughout read_callbacks.c): the
             * oracle materializes a FRESH `%hi/%lo(_cdr+8)` anchor for this block
             * and reaches w10 by +8 off it, then derives `&_cdr` as `anchor-8`
             * for the three read-modify-writes.  A plain `_cdr.field` recon
             * rematerializes `%hi/%lo(_cdr)` per access instead.
             *
             * MATCH (W74-A14, 1 -> PASS): retail leaves the `beqz` slot `nop`; ours had
             * reorg steal the DMA arm's leading `lui %hi(_cdr+8)` out of the fall-through
             * thread (fill_eager_delay_slots -> fill_slots_from_thread, gcc-2.8.1
             * reorg.c:3455).  A zero-insn VOID BARRIER as each arm's first statement stops
             * the thread scan (reorg.c stop_search_p returns 1 for any asm) and the slot
             * goes back to `nop`.  🔑 NEW LAW -- the barrier must be placed in BOTH ARMS:
             * one arm alone measures 3 (it blocks the steal but de-merges the two arms'
             * shared `cur` anchor prologue, which jump.c cross-jumped), both arms 0.
             * The barrier must also sit AFTER the C89 declaration, so `cur` is split
             * decl/assign.  Measured (scratchpad/W74_A14_rint_slot.json): void both arms 0
             * (kept) - void DMA arm only 3 - void before the `if` 1 (inert) - a NON-volatile
             * launder on the live `result` at the arm head / before the `if` / in both arms 1
             * (inert: reorg stops at it, but it is not a sched1 barrier, and here the steal
             * needs the sched1 fence too) - splitting the decl alone 1 (inert control). */
            if (CD_read_dma_mode & 1) {
                volatile int *cur;
                __asm__("" : : "i"(0));
                cur = (volatile int *)&_cdr.w08;
                __asm__("" : "=r"(cur) : "0"(cur));
                CdGetSector2((u_char *)cur[0], cur[2]); /* DMA: advance deferred to _read_data_int */
            } else {
                volatile int *cur;
                __asm__("" : : "i"(0));
                cur = (volatile int *)&_cdr.w08;
                __asm__("" : "=r"(cur) : "0"(cur));
                CdGetSector((u_char *)cur[0], cur[2]);
                {   /* the `&_cdr` view is derived AFTER the call so it lands in a
                     * CALLER-saved temp (oracle `addiu $a0,$s0,-8`); computing it
                     * before the call forces a second callee-saved register. */
                    /* W62-A6: the 3.25-3c non-volatile-store lever that landed on
                     * CdRead and _read_issue is FALSIFIED here even though retail
                     * carries `sw $v0,32($a0)` in a `j` slot: w20 25, w14 23, w08 34,
                     * w14+w20 22, all three 22 -- every one worse than 15.  The lever
                     * is strictly site-selective.  */
                    volatile CdrEnv *g = (volatile CdrEnv *)(cur - 2);
                    g->w08 = (u_char *)(cur[0] + cur[2] * 4);  /* cursor += sector bytes */
                    g->w14--;                                   /* one fewer remaining */
                    /* W71-A8: 12 -> 9.  The 3.25-3c NON-VOLATILE-CAST-ON-THE-STORE
                     * lever, RE-PRICED in the post-w24 basin (w62-a6 measured it at 25
                     * from the 15-diff basin -- falsifications are basin-relative).
                     * Retail carries this store in the arm's `j` delay slot; a volatile
                     * MEM is unreachable to reorg.  Still SITE-SELECTIVE in this basin:
                     * w14 18, w08 31, w14+w20 17 -- only w20 alone is the win. */
                    *(int *)&g->w20 = g->w20 + 1;               /* next expected sector */
                }
            }
        }
    } else {
        /* CORRECTNESS (w51-a3): the oracle sets `$v0 = -1` in the `bne $a0,$v0`
         * DELAY SLOT and this arm is `sw $v0,0x14($v1)` -- the value stored is
         * -1 (error), NOT 1.  The old recon stored 1, which made a non-DataReady
         * interrupt look like "one sector still to go" instead of tripping the
         * error path that re-issues the read.  (methodology 3.1: the delay slot
         * runs before the branch lands, so its constant belongs to BOTH arms.) */
        h->w14 = -1;                                 /* @80108A14 : non-DataReady intr */
    }
    }

    /* ---- common tail @80108A18 ---------------------------------------------------------------- */
    /* MATCH (W74-A14, 9 -> 5): the TAIL ANCHOR + W49 IDENTITY FENCE -- the exact device
     * `_read_data_int` uses, and the one w52-a2 measured at 60 and filed as FALSIFIED.
     * That verdict was taken from the 24-diff basin; two W71 landings later it is the
     * win (catalog 21E-1: RE-PRICE any documented-exhausted cluster after a sibling
     * cluster in the same fn changes basin).  WHY it is needed: retail reaches the whole
     * tail through ONE self-temping `la $s0,_cdr` (`lui $s0,%hi; addiu $s0,$s0,%lo`);
     * cc1's default -msplit-addresses puts the HIGH in its own short-lived pseudo
     * (`lui $v1,%hi; addiu $s0,$v1,%lo`) and local-alloc's combine_regs can NEVER tie the
     * two, because the tie is refused unless the SET reg is block-local with a single
     * death (local-alloc.c:1868/1877/1946, reg_qty[sreg] must be -2) and this base is a
     * GLOBAL allocno that crosses calls.  The identity fence turns the completed address
     * into ONE opaque pseudo, so the self-temp form is all that can be emitted.
     * Measured in this basin (scratchpad/W74_A14_rint_tail.json, all gated):
     *   volatile-struct + fence 5 (kept) - `volatile char *` + fence 5 - non-volatile
     *   struct + fence 12 - volatile struct WITHOUT the fence 14 - non-volatile struct
     *   without the fence 21 - a bare block wrap / pure re-spelling 9 (inert controls).
     * The extra block scope is required for C89 declaration placement and is codegen-inert
     * on its own (the `respell_wrapped` control also measures 9). */
    {
    volatile CdrEnv *t = &_cdr;                     /* $s0 : one `la` for the whole tail */
    __asm__("" : "=r"(t) : "0"(t));
    t->w18 = VSync(-1);
    if (t->w14 < 0)                                  /* error -> re-issue the read */
        _read_issue(1);
    if (VSync(-1) > t->w1c + 0x4B0)                  /* overall watchdog (1200 frames) */
        t->w14 = -1;
    if (t->w14 != 0 && !(VSync(-1) > t->w1c + 0x4B0))
        return;                                      /* still busy, not timed out -> wait */

    /* ---- read finished (or timed out) @80108A98 ---------------------------------------------- */
    CdReadyCallback(t->w2c);                         /* restore ready cb */
    if (CD_read_dma_mode & 1)
        CdDataCallback(t->w30);                      /* restore data cb */
    CdSyncCallback((CdlCB)_read_sync);              /* install completion sync handler */
    CdControlF(9, 0);                               /* CdlPause */
    {
        /* CORRECTNESS (W71-A8, the same w48-a6 class already fixed in _read_data_int
         * below): the oracle's `sw $v0,0x24($s0)` sits in the `beqz $v1` DELAY SLOT,
         * so `reading = 1` executes on BOTH paths -- it is NOT inside the CD_cbread
         * guard (methodology 3.1).  The old shape stored w24 only when a user
         * CdReadCallback was installed, so a callback-less read never cleared the
         * flag path CdReadSync polls.  MATCH: load the callback BEFORE the store
         * (the store's fence/alias would otherwise sink the load) and write w24
         * through a NON-VOLATILE lvalue cast so reorg may slot-fill it (3.25-3c). */
        CdlCB cb = CD_cbread;
        *(int *)&t->w24 = 1;
        if (cb != 0)
            cb(t->w14 == 0 ? 2 : 5, result);
    }
    }
}

/* @0x80108B24 : DMA-data complete -- advance the ring and finish if this was the last sector. */
/* MATCH (w55-a5, 4 -> PASS 52/52): TWO cooperating levers.
 *   (1) FENCED WORD ANCHOR.  Retail materializes the state block with ONE self-temping
 *       `la $s0,_cdr` (`lui $s0,%hi; addiu $s0,$s0,%lo`); a bare `_cdr.field` recon lets
 *       -msplit-addresses put the HIGH in its own short-lived pseudo, which local-alloc
 *       hands the first free caller-saved reg -- `lui $v0,%hi; addiu $s0,$v0,%lo` (the
 *       high pseudo can never TIE to the base: local-alloc's combine_regs bails when the
 *       SET reg is not block-local, and the base crosses calls).  An explicit `volatile
 *       int *e = &_cdr` + w49 IDENTITY FENCE makes the address ONE opaque pseudo = the
 *       self-temp form (same lever CdReadSync already used for its `&_cdr.w1c` anchor).
 *   (2) The fence's price: `e` is now an UNKNOWN pointer, so the `*(int*)&e[9] = 1` store
 *       may-aliases CD_cbread and the callback load can no longer be hoisted above it --
 *       costing the beqz delay slot fill (+2 nops, and CD_cbread lands in $v0 not $v1).
 *       Reading the callback into a LOCAL before the store restores retail's order.
 *       Falsified in this basin: struct-typed anchor + fence (10), unfenced anchor (4). */
extern void _read_data_int(void)
{
    volatile int *e = (volatile int *)&_cdr;   /* $s0 : &_cdr (word-indexed) */
    __asm__("" : "=r"(e) : "0"(e));            /* MATCH: one `la`, not a split lui/addiu */

    e[2] += e[4] * 4;            /* w08 cursor += w10 sector bytes */
    e[5]--;                      /* w14 : one fewer remaining      */
    e[8]++;                      /* w20 : next expected sector     */
    if (e[5] != 0)
        return;

    CdReadyCallback(e[11]);      /* w2c */
    if (CD_read_dma_mode & 1)
        CdDataCallback((void (*)(void))e[12]); /* w30 */
    CdSyncCallback((CdlCB)_read_sync);
    CdControlF(9, 0);           /* CdlPause */
    {
        CdlCB cb = CD_cbread;   /* MATCH: load BEFORE the w24 store (see (2)) */
        /* CORRECTNESS (w48-a6): the oracle's `sw $v0,0x24($s0)` sits in the `beqz $v1`
         * DELAY SLOT, so `reading = 1` executes on BOTH paths -- it is NOT inside the
         * CD_cbread guard.  (Delay-slot placement is semantics, methodology 3.1.) */
        *(int *)&e[9] = 1;      /* w24; MATCH: non-volatile cast -- reorg refuses to
                                 * slot-fill a volatile MEM (3.25-3c). */
        if (cb != 0)
            cb(2, (u_char *)e[13]); /* w34 */
    }
}

/* @0x80108BF4 : (re)issue the read.  retry!=0 re-seeks to CdLastPos and re-sends mode.
 *
 * MATCH (w52-a2): 64 -> 23 diffs, 120 -> 121 insns vs oracle 122.  Three levers:
 *  (1) ERROR-TAIL PLACEMENT.  Retail's `_cdr.w14 = -1; return _cdr.w14;` tail sits INLINE in
 *      the CdlSetmode arm (`bnez $v0` skips it) and the CdlSetloc failure JUMPS INTO it;
 *      our trailing `error:` block made gcc cross-jump and invert the branch to `beqz`.
 *      FIX = write the body inline in the Setmode arm and put the `error:` label ON it, so
 *      the earlier site's `goto` targets the inline copy.  64 -> 50, and dropping the now-
 *      dead trailing block took 126 -> 120 insns.  (Inlining BOTH sites = 62/126: retail has
 *      exactly ONE copy, reached from two places.)
 *  (2) FIELD ANCHOR + IDENTITY FENCE for the mode region: retail keeps `&_cdr.w0c` in a
 *      register ($s1) and reads the field ONCE (`lw $s0,0($s1)`), reusing that value for
 *      both the `modeb` byte store and the `& 0xFF` compare; ours emitted two loads off a
 *      `&_cdr`+12 base.  50 -> 46 (-2 insns).
 *  (3) EXTEND THE ANCHOR'S LIVE RANGE past CdMode with a read-only fence.  Without it the
 *      anchor dies at its own load and `retry` takes $s1; retail spends a THIRD callee-saved
 *      register, keeping the anchor in $s1 and `retry` in $s2 (extra `sw $s2,32($sp)` +
 *      restore).  45 -> 23.  (The same fence placed INSIDE the if-body instead: 28.)
 *  Also landed here: a tail anchor `g = &_cdr` + identity fence (46 -> 45) so the whole tail
 *  runs off one `la` like retail's $s0.
 * RESIDUAL 23 = delay-slot fills where retail has `nop`, one `addu $a2,$a1,zero` copy where
 * retail rematerializes zero (the old-gcc no-copy-prop class), and the tail anchor being
 * materialized ~9 insns earlier than retail's. */
/* W64-A6: re-gated 8 @122/122 (count-EXACT).  The FENCE-REMOVAL axis is closed: every
 * one of w63's landed devices is load-bearing -- dropping the pre-anchor void barrier 9
 * @121, the post-CdFlush barrier 9 @121, the `mp` identity fence 15 @121, the in-arm
 * barrier 11 @121, the error-label barrier 11 @121, the tail `g` identity fence 14 @122.
 * Residual 8 = (a) `CdControl(9,0,0)`'s 3rd arg, the same 11B cse-shared-live-zero class
 * as CdRead's (2 diffs), and (b) the CdControlF(6,0) region where retail DUPLICATES its
 * `li $a0,6` into the preceding `beqz` delay slot (a reorg eager-steal duplicate) and
 * carries `lw $v0,4($s0)` in the call's own slot, where ours fills the beqz slot by the
 * simple backward scan and nops the call slot (6 diffs).  Per 13B a fence can only BLOCK
 * a steal, never supply one, so this half needs a filler hoisted into reorg's scan range
 * or a TEXT_MOVES row, not another barrier.
 *
 * 🏆 W71-A8: 8 -> 3 @121/122 with a ONE-STATEMENT REORDER, and w64's "(b) 6 diffs" reading
 * was a MIS-DIAGNOSIS -- it is not a reorg/TEXT_MOVES problem at all, it is SOURCE ORDER.
 * Retail carries `sw $v0,0x8($s0)` (w08 = w04, "cursor = buffer") in `jal CdControlF`'s OWN
 * delay slot (80108DA4/DA8), and a delay-slot insn executes BEFORE the call -- so the store
 * PRECEDES CdControlF in the original, while our recon had it after.  A delay slot is
 * SEMANTICS (methodology 3.1): reorg fills a call's slot by scanning BACKWARD only, so no
 * fence, splice or TEXT_MOVES row could ever have supplied it from a statement written
 * after the call.  FIX = move `w08 = w04` above `CdControlF(6, 0)` and write it through a
 * NON-VOLATILE lvalue cast so reorg may slot-fill it (3.25-3c).
 * CORPUS CONFIRMATION (the psyz/sotn "first stop" rule): sotn-decomp's fully-matched
 * `src/main/psxsdk/libcd/cdread.c::cd_read_retry` -- our `_read_issue`'s twin -- has exactly
 * `D_80032DBC.unk8 = D_80032DBC.unk4;` THEN `CdControlF(CdlReadN, NULL);`.
 * RESIDUAL 3, both halves the SAME retail-cc1 identity (constants are rematerialized where
 * our cc1 shares a live copy -- 3.25-3b "old-gcc no-copy-prop"): (a) 2 diffs, the third
 * argument of `CdControl(9,0,0)` (ours `addu $a2,$a1,$zero`, retail `addu $a2,$zero,$zero`,
 * the 11B cse-shared-live-zero class -- see CdRead's identical residual); (b) 1 diff, retail
 * DUPLICATES `addiu $a0,$zero,6` into the preceding `beqz`'s delay slot AND after the
 * CdDataCallback call, ours emits it once at the merge point.
 * RE-SWEPT AT THIS BASIN and falsified: an opaque named zero on the SECOND CdControl
 * argument (`int z2=0` + identity fence) 7, on the third 8, on both 9; per-fn ladder
 * 2.8.1 (wired) 3 - 2.8.0 7 - 2.7.2-970404 21 - 2.6.3 35 - 2.7.2 38 - 2.91.66 41.
 *
 * W72-A16 re-gate: 3 @121/122.  BOTH halves attacked with the two devices that sealed
 * CdRead and CD_init this wave; both FALSIFIED HERE, and the reason is now named:
 *  (a) the `CdControl(9,0,0)` third argument.  The cse-sharing break DOES work -- an
 *      identity launder on the `param` zero produces retail's `addu $a2,$zero,$zero` --
 *      but the laundered zero then lands in $s0 and the a1 load becomes
 *      `addu $a1,$s0,$zero` where retail has `addu $a1,$zero,$zero`, plus a 2-diff
 *      $v0->$s0 rotation on the shell-open `andi`/`beqz` pair: net 3 -> 7.  Unlike
 *      CdRead's site (a two-insn arm where the laundered zero coalesces straight into
 *      $a1 and materialises as `move $5,$0`), this one sits mid-block behind a `puts`
 *      call, and an OPAQUE value can never be spelled `addu $aN,$zero,$zero`.  MEASURED,
 *      all reverted: identity launder on the param zero 7 - read-only fence 6 - launder
 *      on the RESULT zero 8 - the CdRead-winning 2-OUTPUT TIED LAUNDER `(cmd, z)` 7,
 *      with `z` first 7, with a "$16" clobber 7, with a "$2" clobber 7, with an s0-s7
 *      clobber list 39 - a void barrier before the block / after the launder / both 7 -
 *      a "$16" clobber on the launder 7.
 *  (b) retail DUPLICATES `li $a0,6` into the preceding `beqz`'s slot; ours steals the
 *      DMA arm's leading `lui $a0,%hi(_read_data_int)` instead.  MECHANISM CONFIRMED
 *      (gcc-2.8.1 reorg.c stop_search_p, read this wave): retail's fall-through thread
 *      begins with a 2-word `la` MACRO, which reorg cannot slot at all, so it falls back
 *      to the target thread and takes the `li`; our -msplit-addresses `lui` half is a
 *      single stealable insn.  Cures measured: a void barrier at the arm head 4 (it
 *      blocks the steal but is also a sched1 barrier); the NON-VOLATILE launder -- which
 *      stop_search_p also stops at, without the sched barrier (reorg.c returns 1 for ANY
 *      `asm_noperands >= 0` insn, a NEW instrument this wave) -- needs a value that is
 *      LIVE AFTER the asm or it is deleted as dead (21A-3): `sect` and `retry` are both
 *      dead there and measure 3 (the asm vanished), and the only live candidate `g`
 *      costs its own allocation (8 at the arm head, 8 with a "$2" clobber, 7 after the
 *      call).  PER-FN `-mno-split-addresses` -- which WOULD give the `la` macro form --
 *      is 25 @125/122 here (re-priced this wave; it is the mechanism but it re-splits
 *      every other address in the function).  NAMED ANGLE for the next pass: a way to
 *      make ONE address materialise as the `la` macro while the rest stay split, i.e. a
 *      per-SITE nosplit, which today only exists as a per-FN build.py flag.
 *
 * W74-A14 re-gate: 3 @121/122.  Both halves re-attacked; (b)'s MECHANISM IS NOW PROVEN
 * AND ITS EXITS ARE ENUMERATED FROM THE COMPILER SOURCE, and the per-SITE-nosplit ask is
 * upgraded from "named angle" to a costed orchestrator spec:
 *  (b1) PROOF that nosplit is the mechanism: run under the W74 composition harness
 *      (scratchpad/W74_A14_mkbuild.py, `A14_NS_FNS=_read_issue` = 2.8.1 +
 *      -mno-split-addresses) the `+li $a0,6` diff DISAPPEARS from the diff list -- retail's
 *      duplicate is reproduced exactly.  The residual 21 @125/122 is then entirely
 *      elsewhere: the two UN-ANCHORED `_cdr` regions fold their field offsets into the
 *      symbol (`sw $v0,0($v1)` where retail has `sw $v0,28($v1)`) and THREE extra `nop`s
 *      appear because GNU-as does not split a `la` macro's %lo half across the following
 *      `jal` the way aspsx did (the W51 AT-MACRO-SPLIT identity, the same thing
 *      PER_FN_RAW40_SPLICE exists for).  ⇒ a per-fn nosplit landing for _read_issue is a
 *      THREE-part job: nosplit + a fenced anchor for the shell-open arm and for the error
 *      tail (the `_read_int` recipe, now proven) + the raw40/GNU-as route for the jal
 *      macro splits.  Priced, not speculative.
 *  (b2) WHY NO FENCE CAN SUBSTITUTE (gcc-2.8.1 reorg.c, read this wave).  The fill is
 *      gcc's, not the assembler's: our .s carries `.set noreorder / beq $2,$0,$L / lui
 *      $4,%hi(_read_data_int)`, i.e. fill_eager_delay_slots took the FALL-THROUGH thread.
 *      mostly_true_jump (reorg.c:1353) returns 0 for an EQ condition, so fill_eager tries
 *      fall-through FIRST and the target only `if (delay_list == 0)`.  Retail's
 *      fall-through began with a 2-word `la` that eligible_for_delay rejects, so its
 *      fall-through attempt returned 0 and the target steal ran.  🔑 MEASURED LAW: making
 *      OUR fall-through attempt fail with an asm does NOT hand the slot to the target --
 *      the target attempt then also returns 0 and maspsx nops the slot.  Sweep at this
 *      basin (scratchpad/W74_A14_issue_slot.json, all gated + reverted): void barrier in
 *      the arm 4 - void in the arm + a void `else` arm 6 - void `else` only 5 - identity
 *      launder on `g` in the arm 8 - in both arms 10 - read-only fence on `g` in the arm 4
 *      - in both arms 6 - braces only 3 (inert control).  ⇒ "block the thread you don't
 *      want" is NOT a way to buy the thread you do want; only making the unwanted thread's
 *      first insn INELIGIBLE (length 2 = the `la` macro) is.
 *  (b3) AND THERE IS NO SOURCE ESCAPE AT -G4: mips_check_split (mips.c:893) leaves a
 *      SYMBOL_REF splittable unless SYMBOL_REF_FLAG is set, and ENCODE_SECTION_INFO
 *      (mips.h:2792) sets that flag ONLY for a VAR_DECL of size <= the -G threshold.  A
 *      FUNCTION_DECL never gets it under any -G, so no `-G` value can make
 *      `(int)_read_data_int` materialise as a macro -- unlike the small-data VAR_DECL case
 *      that PER_FN_FLAG_SPLICE_272's -G4 row exploits for _padLoadActInfo_rcv (22A-5).
 *      The -G4 row is therefore NOT applicable here; -mno-split-addresses is the only
 *      mechanism.  (Note this TU is already at the default -G4.) */
/* ==========================================================================
 * W75-A17 re-gate: 3 @121/122.  NOTHING LANDED, but the function is now
 * ROUTE-SOLVED: a complete, measured recipe reaches **1 diff** and both named
 * residuals VANISH -- and it is blocked by a NEW, previously-unknown hazard
 * that also produces a broken object.  Everything below is reproducible from
 * scratchpad/w75/{a17_mkbuild.py,a17_msweep.py,a17_srcprobe.py,a17_ri_land.py}.
 *
 * 1. THE `CdControl(9,0,0)` RESIDUAL IS `reload_cse_regs`, AND IT IS A COMPILER-
 *    VERSION IDENTITY, NOT A SPELLING.  (W75-A20 named the pass; this is the
 *    consequence.)  `reload_cse_regs` is called UNCONDITIONALLY at `optimize > 0`
 *    (gcc-2.8.1 toplev.c:3501 -- there is no flag), and IT DOES NOT EXIST IN
 *    gcc-2.7.2 at all.  So retail's `addu $a2,$zero,$zero` is not a spelling we
 *    failed to find: it is what a 2.7.2 build emits.  MEASURED PROOF: under the
 *    PsyQ-4.0 (2.7.2) RAW40 route BOTH named residuals -- the `addu $a2,$a1,$zero`
 *    reload_cse rewrite AND the missing `li $a0,6` reorg duplicate -- disappear
 *    from the diff list without any source change.  ⇒ CDREAD.OBJ is a 2.7.2
 *    object like its libcd siblings drv.c/stcdint.c (both wired `cc1_272`); this
 *    TU's 2.8 lane is a RECON-SOURCE artifact, not a toolchain fact.
 *
 * 2. PER-FN LADDER RE-PROBED with the W74-A19 LM/.loc strip fix in place (the
 *    fix that invalidated every earlier sub-2.8 ver-splice number), through a
 *    scratch build.py copy that composes rung x extra-flags on BOTH lanes:
 *      wired(2.8.1) 3 - 2.8.0 7 - TU-own(2.8.0) 7 - 2.7.2-970404 18 @120 -
 *      psyq40 35 - 2.7.2 35 - 2.6.3 35 @127 - 2.6.0 35 @127 - 2.95.2 39 -
 *      2.91.66 41 @119 - **RAW40 23 @117**.
 *    No maspsx-lane rung beats the wired 2.8.1: the sub-2.8 rungs pay the
 *    AT-MACRO class (`sw $v0,_cdr+N` assembler macros for the un-anchored `_cdr`
 *    regions) plus maspsx's `.set noreorder` nops.  RAW40 (2.7.2 cc1 + GNU-as in
 *    reorder mode, no maspsx) pays only the first half.
 *
 * 3. THE RAW40 ROUTE, FULLY PRICED (this is the W74-A14 "three-part job", now
 *    measured end to end; each step gated, all reverted):
 *      RAW40 alone .......................................... 23 @117/122
 *      + ERROR-TAIL fenced anchor (`volatile CdrEnv *er = &_cdr;` + W49
 *        identity fence, the proven `_read_int` recipe) ...... 16 @122/122 (count-EXACT)
 *      + SHELL-OPEN fenced anchor, VSync SPLIT OUT FIRST
 *        (`v = VSync(-1); sh = &_cdr; fence; sh->w1c = v;`) ...  5 @121/122
 *      + the `_read_int` callback ADDRESS hoisted to its own
 *        local BEFORE the tail anchor AND identity-fenced
 *        (`cb = (int)_read_int; fence; g = &_cdr;`) ..........  1 @121/122
 *    Shell-anchor variants at the 16 basin: split-VSync 5 - field anchor 15 -
 *    plain identity anchor 15 @119 - anchor before CdControlF 17 @119 - no fence
 *    16 (inert) - read-only fence 18 @124.  The VSync SPLIT is the whole lever
 *    (same shape as w63-a6's tail-anchor split): with `sh->w1c = VSync(-1)` the
 *    anchor is minted before the call and lands in a callee-saved reg.
 *    `cb` variants: plain hoist before the anchor / before the barrier / before
 *    the CdPosToInt call are all 5 (INERT) -- only the IDENTITY-FENCED hoist
 *    (which stops cse from re-sinking the address) reaches 1.
 *
 * 4. 🔴🔴 WHY IT IS NOT LANDED -- NEW HAZARD, GATE-INVISIBLE, AND IT MAKES A
 *    BROKEN OBJECT: **a zero-insn `__asm__` fence can be chosen by reorg as a
 *    DELAY-SLOT FILLER.**  In the RAW40/272 route the merged .s comes out as
 *        .set noreorder / jal CdLastPos / #APP <empty asm> #NO_APP / .set reorder
 *    -- gcc counted the empty asm as the filler, it emits NOTHING, and the next
 *    real instruction (`jal CdPosToInt`) silently lands in the delay slot.  On
 *    R3000 a jump in a jump's delay slot is UNDEFINED, so the object is wrong;
 *    verify_asm/tugate cannot see it (the instruction STREAM still matches, one
 *    `nop` short -- that missing `nop` IS the residual 1 diff).  Removing the
 *    barrier does not help: any other zero-insn fence in range is taken instead
 *    (barrier variants all 1 @121: `"memory"` clobber, a `"$1"` clobber, a
 *    read-only fence on `sect`, the barrier moved above the call, both, none).
 *    NEW STANDING CHECK: `tools/slotcheck.py <obj> [fn]` -- flags any branch/jump
 *    sitting in a branch/jump delay slot.  TREE-WIDE SCAN RUN THIS WAVE:
 *    **521 objects in build/recon, 0 flagged** -- the shipped tree is clean and
 *    the hazard is specific to the (zero-insn asm x 272/RAW40 reorder route)
 *    combination.  Run it after ANY new 272/RAW40 wiring.
 *
 * ⇒ NEXT ANGLE (named, costed): land the RAW40 route once the fence device can be
 *    made non-slottable -- either (a) find the gcc-2.8 length/eligibility path that
 *    lets an empty asm into a MIPS delay slot and give the fences a form that fails
 *    it, or (b) rebuild the two anchors WITHOUT identity fences (the `_read_int`
 *    combine_regs law says the fence is the only per-site shape that collapses the
 *    %hi/lo_sum pair, so this needs the `-mno-split-addresses` half of the
 *    composition instead), or (c) a maspsx/route-level post-pass that re-nops a
 *    slot whose filler assembled to zero bytes.  Until then the wired 2.8.1
 *    3-diff basin stands, and its two residuals are FULLY EXPLAINED (reload_cse +
 *    the split-address reorg steal), not merely "named".
 * ========================================================================== */
extern int _read_issue(int retry)
{
    /* W62-A6: 22 -> 15.  TWO OPPOSITE delay-slot devices, both from the same law
     * (3.25 3c: gcc's reorg will not move a VOLATILE mem, and reorg.c stop_search_p
     * stops the backward scan at ANY asm):
     *   (1) SUPPLY a slot retail has -- `g->w20` and `g->w14` written through a
     *       NON-VOLATILE lvalue cast let reorg put those two stores in the following
     *       `jal` delay slots, exactly retail's shape (21 -> 15, -2 insns).  PRICED PER
     *       SITE: w20 alone 18, w14 alone 18, w08 26, w18 24 (+2 insns), all four 23 --
     *       only the w20+w14 pair is the win.
     *   (2) BLOCK a slot retail leaves EMPTY -- a zero-insn void fence as the first
     *       statement of the `retry` block stops reorg stealing the `puts` string's
     *       `lui` into the `beqz $s2` slot, restoring retail's `nop` (22 -> 21).
     *       Fence placements measured: inside the block 21 (kept); BEFORE the `if`
     *       22; before `CdFlush()` 22; after the CdlSetloc guard 22; and all three are
     *       still 15 (INERT) once the two casts land.
     * RESIDUAL 15 (ours 119 / oracle 122, 3 SHORT): three more `lui`-half steals into
     * slots retail leaves `nop`, the tail anchor's `lui $s0` materialized one call
     * earlier than retail's, and `CdControl(9,0,0)`'s third argument (the cse-substituted
     * live `$a1` zero, the same class as CdRead's).  NAMED ANGLE: the tail anchor's
     * materialization POSITION -- retail mints `la $s0,_cdr` only after the CdPosToInt
     * result is in `$a0`; splitting the sector value into its own local ahead of the
     * anchor is the untested shape.  */
    volatile CdrEnv *g;
    int sect;
    CdSyncCallback(0);
    CdReadyCallback(0);
    if (CD_read_dma_mode & 1)
        CdDataCallback(0);

    if (CdStatus() & 0x10) {                        /* shell open */
        if ((VSync(-1) & 0x3F) == 0)               /* throttle the spam */
            puts("CdRead: Shell open...\n");
        CdControlF(1, 0);                          /* CdlNop */
        _cdr.w1c = VSync(-1);
        _cdr.w14 = -1;
        return _cdr.w14;
    }

    if (retry != 0) {
        __asm__("" : : "i"(0));
        puts("CdRead: retry...\n");
        CdControl(9, 0, 0);                                  /* CdlPause */
        if (CdControl(2, (u_char *)CdLastPos(), 0) == 0)     /* CdlSetloc */
            goto error;
    }

    CdFlush();
    /* MATCH (w63-a6, 12 -> 8 @122/122 COUNT-EXACT): two more zero-insn VOID
     * BARRIERS at the branch delay slots retail leaves `nop`.  reorg.c stop_search_p
     * halts the backward scan at any asm, so the `lui` halves of the following
     * region anchors can no longer be stolen into the CdlSetloc `beqz` and the
     * CdlSetmode `bnez` slots.  Sweep (scratchpad/w63a6/probe_issue2.py, on the
     * 12-diff basin): before CdFlush 12 (inert), AFTER CdFlush 11, error-label head 9,
     * before-CdFlush+error 9, AFTER-CdFlush+error 8 -- POSITION is the dial, exactly
     * per the W45 fence-fixpoint law. */
    __asm__("" : : "i"(0));
    {
        volatile int *mp = &_cdr.w0c;   /* MATCH: FIELD ANCHOR ($s1) held across CdMode() */
        int    m;
        u_char modeb;
        __asm__("" : "=r"(mp) : "0"(mp));
        m     = *mp;                    /* MATCH: ONE load of w0c ($s0), reused for both uses */
        modeb = (u_char)m;
        if ((m & 0xFF) != CdMode() || retry != 0) {
            if (CdControl(0xE, &modeb, 0) == 0) {            /* CdlSetmode */
            error:
                __asm__("" : : "i"(0));
                _cdr.w14 = -1;      /* MATCH: retail keeps this error tail INLINE (bnez skips it); */
                return _cdr.w14;    /* sharing it via `goto error` cross-jumps + inverts polarity */
            }
        }
        __asm__("" : : "r"(mp));  /* MATCH: keep the anchor live PAST CdMode -> $s1,
                                    * which pushes `retry` onto retail's $s2 */
    }

    /* delay-slot capture: w20 receives CdPosToInt()'s result (computed before CdReadyCallback). */
    /* MATCH (w63-a6, 15 -> 12): the TAIL-ANCHOR POSITION angle named in the w62-a6
     * residual note, now measured.  Retail mints `la $s0,_cdr` only AFTER the
     * CdPosToInt result exists (`jal CdPosToInt` / `lui a0;addiu a0` for _read_int /
     * `lui s0;addiu s0` / `jal CdReadyCallback` with `sw v0,32(s0)` in its slot);
     * ours had reorg steal the `lui $s0` half backwards into an earlier jal's delay
     * slot where retail keeps a `nop`.  TWO parts, both required (either alone is
     * inert at 15): (a) split the sector value into its own local so the anchor is
     * minted after the call, (b) a zero-insn VOID BARRIER immediately before the
     * anchor -- reorg.c's stop_search_p halts the backward scan at any asm, so the
     * `lui` can no longer be stolen.  Measured: (a) alone 15, (b) alone 15,
     * (a)+(b) 12 @120/122, (a) without the identity fence 19.
     * scratchpad/w63a6/probe_issue.py. */
    sect = CdPosToInt((CdlLOC *)CdLastPos());                        /* start sector */
    __asm__("" : : "i"(0));
    g = &_cdr;                      /* MATCH: TAIL ANCHOR ($s0) -- one `la` for the whole tail */
    __asm__("" : "=r"(g) : "0"(g));
    *(int *)&g->w20 = sect;
    CdReadyCallback((CdlCB)_read_int);
    if (CD_read_dma_mode & 1)
        CdDataCallback(_read_data_int);
    /* MATCH (W71-A8): this store PRECEDES CdControlF -- retail carries it in that call's
     * delay slot (`jal CdControlF; sw $v0,0x8($s0)`), which executes BEFORE the call
     * (3.1); the sotn twin `cd_read_retry` has the same source order.  NON-VOLATILE cast
     * so reorg is allowed to slot-fill it (3.25-3c). */
    *(u_char **)&g->w08 = g->w04;                            /* cursor = buffer */
    CdControlF(6, 0);                                        /* CdlReadN */
    *(int *)&g->w14 = g->w00;                                        /* remaining = sectors */
    g->w18 = VSync(-1);
    return g->w14;
}

/* @0x80108DDC : CdRead -- start an asynchronous N-sector read into `buf`. Returns >0 on success.
 *
 * NOTE (unlike _read_int/_read_data_int above): here a cached struct-base local scores best.
 * FALSIFIED in this basin (w51-a3, measured -- do not retry): the w47-a5 "CdRead angle"
 * PER-REGION field anchor.  The oracle really does mint a fresh `%hi/%lo(_cdr+field)` base per
 * region ($s0=&_cdr.w24 busy-wait, $s0=&_cdr.w28 then -0x28 in the timeout arm, $a0=&_cdr for
 * the call-free switch, $v1=&_cdr for its default arm, $s0=&_cdr across the whole tail), and
 * spelling those anchors out DOES close the 9-instruction gap (94 -> 97 -> 105 vs oracle 103),
 * but each anchor re-rotates the s-register handout: 43 -> 54 (busy anchor) -> 70 (full region
 * split).  Kept at the cached-base form; direct `_cdr.field` access also regressed (43 -> 61).
 *
 * w52-a2 RE-PROBE (basin-relative, per the catalog's "falsifications are basin-relative" META):
 * the w51 anchor attempt was made WITHOUT the W49 identity fence, so every anchor still came
 * out split (`lui $vX,%hi; addiu $sY,$vX,%lo`).  Re-run with a fence on each of the four
 * regions (busy = &_cdr.w24, the timeout arm = &_cdr.w28 then -0x28 -- the exact _read_sync
 * recipe -- the mode/sector-size switch = &_cdr, and the tail = &_cdr): **53 diffs at
 * 108/103 insns**, i.e. better than w51's 70@105 but still worse than the cached-base 43@94.
 * The anchors DO close the 9-instruction shortfall (94 -> 108) and the switch/timeout blocks
 * line up; what is left is the anchor REGISTER handout ($v1 where retail has $a0 for the
 * switch region, and a copy instead of an in-place `addiu $s0,$s0,-40` in the timeout arm).
 * Extra promote/demote fences on the region anchors moved nothing (53 x3).  NAMED ANGLE:
 * land the fenced-anchor form and then dial the four anchors' allocno priorities the way
 * _st_dma's bit/dp/bv were dialled -- the shape is right, only the coloring is not.
 * (Reverted for now: the gate is the authority and 53 > 43.) */
extern int CdRead(int sectors, u_long *buf, int mode)
{
    /* w59-a7: 43 @94/103 (9 insns SHORT) -> 43 @102/103 -> PASS-track 38 @103/103 COUNT-EXACT
     * with the one-line orchestrator wiring below.  This retires the file-header / methodology
     * "BASE-POINTER-ANCHOR granularity = GENUINE FLOOR" verdict for CdRead exactly as w52-a2
     * retired it for CdReadSync.  Ladder was re-run at the new basin (04Z): the header's
     * per-fn rung table is unchanged in its verdict -- no rung beats the wired lane.
     *
     * ORCHESTRATOR WIRING (probe-validated on a scratchpad build.py copy; NEW MECHANISM,
     * ~2 lines): give the MASPSX lane the per-fn flag splice it already has for
     * -fno-delayed-branch / -fno-thread-jumps / -fforce-addr, extended with
     * `-mno-split-addresses`:
     *     PER_FN_NO_SPLIT_ADDRESSES = {"recon/syslib/psx/libcd/cdread.c": {"CdRead"}}
     *   and one extra tuple in _apply_fn_splice's table list:
     *     (PER_FN_NO_SPLIT_ADDRESSES, "-mno-split-addresses", "nosplit")
     * WHY per-FN and not per-TU: the file header already measures whole-TU
     * `no_split_addresses` as a net LOSS (169 -> 199: _read_data_int 4->27, _read_issue
     * 64->81) even though CdRead itself improves -- the classic PER_FN_NO_DELAYED_BRANCH
     * situation.  Measured with the splice: CdRead 43 -> 38 @103/103, _read_int 21,
     * _read_issue 23, three PASSes unchanged (whole-TU gate 3/6, zero PASS->FAIL).
     * MECHANISM: the residual 5 insns were cc1's PRE-SPLIT `lui/addiu` address halves --
     * three stray `lui $v1` copies that sched/jump-threading scattered across the switch
     * arms.  With split-addresses off cc1 emits the `la` MACRO and they collapse.
     * W61-A7 (38 @103/103 -> 23 @108/103): class (a) SOLVED with a reqdelta272-PRICED dial.
     * The mode-region anchor is global allocno 76 (refs 7 / live 12 / pri 1.1667) and its
     * `andi` selector temp is allocno 90 (refs 3 / live 4 / pri 0.75); they CONFLICT, 76 is
     * allocated first, and since both conflict with hard $v0 the anchor takes $v1 and the
     * selector is pushed to $a0 -- the exact inverse of retail.  `reqdelta272 --flip 90 76`
     * printed the requirement "refs 3->4 (+1, CROSSES a floor_log2 step)"; naming the
     * selector (`sel`) and buying ONE reference with a zero-insn read-only fence flips the
     * allocation order, and the anchor takes $a0 with the selector in $v1 exactly as retail.
     * SIDE EFFECT, receipted (hard-floor-basin rule -- the authoritative count improves, so
     * the branch is landed): with the anchor in $a0 the three switch arms stop cross-jump
     * merging their `sw $v0,0x10(anchor)` tails, which is retail's shape (09J "each arm
     * carries its own tail"), but reorg then leaves each arm's `j` delay slot EMPTY where
     * retail has the store in it -- +5 insns.  The fence POSITION is NOT the cause: read-only
     * fence after the andi, identity fence after the andi, and a read-only fence inside the
     * `case 0` arm before its store ALL measure 23 @108, and putting the ref on the DEFAULT
     * arm's existing identity fence instead is INERT (38) because the extra reference also
     * lengthens the selector's live range and cancels the priority gain.
     * RESIDUAL 23, named: (a') the three arm `j` delay slots (above); (b) which arm's constant
     * reorg steals into the `beq` delay slot (retail pre-sets the DEFAULT's `li $v0,0x246`,
     * ours steals case-0x20's `li $v0,0x249`); (c) `CdControlB(9,0,0)`'s third argument --
     * retail rematerializes `addu $a2,$zero,$zero`, cse substitutes our live `$a1` zero (the
     * catalog's cse-substituted-live-zero opacity-fence job), plus the `slt $v0,$zero,$v0`
     * scheduled before vs after the frame restores; (d) the prologue `sw $s2,24($sp)` /
     * `addu $s2,$a2,$zero` pair placement (a sched1 tie at the top of the first BB, the same
     * shape as CdControl's -- a 2-line PER_FN_TEXT_MOVES candidate).
     *
     * W62-A6 (23 -> 16): class (a') SOLVED by the 3.25 3c NON-VOLATILE-CAST-ON-THE-STORE
     * lever.  gcc's reorg REFUSES to move a volatile MEM into a delay slot, so every
     * `_cdr` store that retail carries in a `j`/`jal` slot was structurally unreachable
     * while the store went through the volatile anchor.  Writing the two switch-arm
     * stores and the CdSyncCallback result store through a NON-VOLATILE lvalue cast
     * (`*(int *)&g->w10 = ...`) hands reorg exactly the fillers retail has: two arm `j`
     * slots + one `jal` slot, -2 insns and -7 diffs.  PRICED PER SITE (each measured in
     * the landed basin -- the lever is NOT blanket-applicable): default arm `d->w10` and
     * `e->w30` INERT at 16; `e->w00` 25; `e->w04` 19; both 19; `e->w0c |= 0x20` 22;
     * `e->w2c` 28; `e->w1c` 19.  Only the three sites now cast are wins.
     * ALSO FALSIFIED at 23 (before the landing, so re-priceable): all 23 permutations of
     * the four local declarations and the split of `busy`'s decl-with-init (13A / 12D) --
     * ALL INERT (this fn has `vars= 0`, every local is a register, so neither the
     * spill-slot order nor the allocno-birth dial has anything to move).  Per-fn ladder
     * re-run in the maspsx lane with the nosplit splice removed: 2.7.2 28 / 2.7.2-970404
     * 45 / 2.6.3 23 / 2.8.1 27 / plain 30 -- the wired 2.8.0+nosplit stays.  NOTE the
     * cc1_alt 2.7.2 lane (272 recipe = direct GNU-as REORDER mode) scores CdRead 16 on
     * its own, i.e. the remaining slot fills are ASSEMBLER-side (vendor-toolchain class,
     * libcd being a Sony prebuilt), but whole-TU that lane costs 2 PASSes (_read_int 50,
     * _read_issue 33) so it is not wirable.
     * W63-A6 re-gate: 14 @105/103.  The switch residual (class b) is now known EXACTLY --
 * it is only WHICH ARM IS THE FALL-THROUGH of the `beq $v1,$v0` size test:
 *     retail  beq v1,v0 ; [slot] li v0,582   <- the DEFAULT (0x246) arm's constant
 *     ours    beq v1,v0 ; [slot] li v0,585   <- the case-0x20 (0x249) arm's constant
 * and retail's DEFAULT arm then reaches its own `lui/addiu` anchor with the 582 already
 * in $v0.  That is textbook W47-a2 "PRE-SET THE DEFAULT BEFORE THE TEST" + "case bodies
 * emit in SOURCE order", so the arm-order rewrite is the obvious lever -- and it is
 * FALSIFIED HERE (scratchpad/w63a6/probe_cdread.py, all gated + reverted): default arm
 * physically between case 0 and case 0x20 = 26 @103/103 (count-exact but far worse),
 * default arm FIRST = 21 @102, an if/else chain with the default pre-assigned before the
 * 0x20 test = 39 @102.  Class (c) also re-probed: a named opaque zero for CdControlB's
 * third argument (`int z=0; identity fence; CdControlB(9,0,z)`) = 16 alone and 28 with the
 * arm swap -- cse's live-zero substitution is NOT the reachable half here.
 * A18's sotn twin (src/main/psxsdk/libcd/cdread.c, fully matched) names the store-then-
 * read-back switch discriminator as the untried delta -- our recon ALREADY reads the
 * just-stored field back (`g->w0c = mode; sel = g->w0c & 0x30;`), so that one is closed.
 * The fence-POSITION axis is closed too: a void-barrier sweep over every statement in the
 * function (scratchpad/w63a6/fencesweep.py) found no position under 14.
 * RESIDUAL 16, named: (a) the prologue `sw $s2,24($sp)` / `addu $s2,$a2,$zero` pair
     * (retail sinks the save and puts the copy in the first `beq`'s slot -- sched1 tie,
     * PER_FN_TEXT_MOVES candidate, probe rows in scratchpad/w62a6); (b) which arm's
     * constant reorg steals into the `beq` slot (retail the DEFAULT's 0x246, ours
     * case-0x20's 0x249); (c) the remaining `jal CdSyncCallback` slot (`e->w00`, whose
     * cast is priced 25 above); (d) `CdControlB(9,0,0)`'s 3rd arg (cse-substituted live
     * zero -- `(u_char *)0` casts on both args INERT at 16) and the `slt` scheduled
     * before vs after the frame restores (`0 < _read_issue(0)` Yoda INERT at 16).
     *
     * W64-A6: 14 -> 5 (three levers, see the three in-body receipts).
     * RESIDUAL 5, named + priced in THIS basin:
     *  (c) the `jal CdSyncCallback` delay slot: retail carries the `sw $s4,0($s0)`
     *      (w00 = sectors) store there; gcc's reorg REFUSES a volatile MEM (3.25-3c) so
     *      the slot stays a nop, and every non-volatile-cast spelling that unblocks
     *      reorg ALSO lets gcc re-order the w04/w00 store pair, which flips the s3/s4
     *      parm homes and costs more than it saves.  MEASURED (all gated, all reverted):
     *      w00 nonvol 16 @103 - w04 nonvol 10 @103 - both 10 @103 - w0c nonvol 10 @103 -
     *      w00+w0c 10 @103 - source order swapped, both nonvol 14 @103 - w00 vol first,
     *      w04 nonvol 8 @103 - `e` declared NON-volatile throughout 15 @102 - w00 via a
     *      `(char *)e + 0` cast 16 @103.  A void barrier BETWEEN the two stores preserves
     *      the order but IS the reorg barrier (stop_search_p), so the slot stays empty
     *      (7 = inert) -- the two requirements are mutually exclusive with any asm.
     *      ORCHESTRATOR ROW, DERIVED AND PROVEN (15D TEXT_MOVES, one row -- the spec
     *      lives in scratchpad/w64a6/tm_cdread.json, the objdump proof in RECEIPTS.md):
     *          take  \tsw\t\$20,0\(\$16\)\n(?=\t#\.set\tnovolatile\n\tjal\tCdSyncCallback\n)
     *          after \tjal\tCdSyncCallback\n(?=\tmove\t\$4,\$0\n)      slot: true
     *      REGISTER RECONCILED against retail first: the store retail slots is the w00
     *      one, `sw $s4,0($s0)` = `sw $20,0($16)` in our .s -- NOT `sw $19,4($16)`,
     *      which is the w04 store ($19 = $s3 = buf, $20 = $s4 = sectors, $16 = $s0).
     *      No drop_nop: our .s carries no nop there (maspsx materialises it in reorder
     *      mode), and `slot: true`'s `.set noreorder` wrapper is what suppresses it.
     *      The `after` lookahead is LOAD-BEARING: unpinned, `jal CdSyncCallback` matches
     *      TWICE in this region and _apply_text_moves takes the FIRST -- the watchdog
     *      arm's call, whose slot already holds `addu $16,$16,-40`.
     *      MEASURED (vprobe W60_TEXT_MOVES_FILE, twice, whole TU): CdRead 5 -> 2
     *      COUNT-EXACT 103/103; CdReadSync/_read_data_int/_read_sync stay PASS,
     *      _read_int 15 and _read_issue 8 unchanged -> zero PASS->FAIL.
     *  (d) `CdControlB(9,0,0)`'s 3rd argument: ours `addu $a2,$a1,$zero` (cse shares the
     *      live zero), retail `addu $a2,$zero,$zero` -- the 11B cse-constant-sharing-
     *      across-two-identical-literal-args class (identity fence is NOT the cure).
     *      Re-measured INERT at 5 in this basin: `(u_char *)0` on both args, on the 3rd
     *      only, two named null locals, and naming CdStatus's result; a void barrier
     *      before the call costs an instruction (6 @105).
     * The fence-POSITION axis stays closed (w63 sweep) and no rung beats the wired lane.
     *
     * MATCH (w59-a7): PER-REGION FIELD ANCHORS, the same Rage-Racer idiom that already seals
     * CdReadSync's block below.  Retail does NOT hold one `&_cdr` across this function: it
     * materializes FOUR separate anchors (`la $s0,_cdr+0x24` for the busy poll; `la $s0,_cdr+0x28`
     * in the watchdog arm, from which cse derives `&_cdr` by `addiu $s0,$s0,-0x28` in the
     * CdSyncCallback delay slot; `la $a0,_cdr` for the mode/switch region -- plus its own
     * `la $v1,_cdr` inside the DEFAULT arm; `la $s0,_cdr` again for the tail region) and reaches
     * each region's fields by displacement off its own anchor.  That is exactly the 9 instructions
     * ours was SHORT.  Each anchor is pinned with the w49 zero-instruction identity fence, without
     * which cse collapses them all back into one hoisted base (the shape this file's own header
     * calls the "BASE-POINTER-ANCHOR granularity floor" -- retired here as it was for CdReadSync).
     *
     * W71-A8 re-gate: 2 @103/103, residual class (d) UNCHANGED and re-swept in this basin --
     * an opaque named zero on CdControlB's SECOND argument (`int z2 = 0` + identity fence,
     * the untried half of w63's probe) 2 (INERT), on the THIRD 6, on BOTH 6.  Per-fn ladder
     * with the nosplit splice dropped: plain 28 / 2.6.3 13 / 2.7.2 18 / 2.8.1 34 /
     * -fforce-addr 34 -- the wired 2.8.0 + per-fn `-mno-split-addresses` stays, and note the
     * ver splice CANNOT be stacked on it (_apply_fn_splice runs after _apply_cc1_ver_splice
     * and re-splices the region from a default-cc1 compile).  The remaining `addu $a2,$a1,
     * $zero` is cc1-2.8.0's cse choosing the live `$a1` zero over rematerializing `$zero`;
     * the emitted `.s` already carries `move $6,$5`, so it is a COMPILER-side identity
     * (3.25-3b), not an assembler or source question. */
    volatile int *busy;
    volatile CdrEnv *g;
    volatile CdrEnv *e;
    int sel;
    int read_mode;

    /* W79-A3: direct field anchoring plus the identity emits retail's one-register
     * `la $s0,_cdr+0x24`.  Copying `mode` only AFTER that fence lets reorg put its
     * $a2->$s2 handoff in the first beq's slot: strict 8 -> 3, with the former
     * per-function -mno-split-addresses splice removed. */

    busy = &_cdr.w24;
    __asm__("" : "=r"(busy) : "0"(busy));
    read_mode = mode;
    if (*busy != 0) {                               /* a previous read is still active */
        int t0 = VSync(-1);
        while (*busy != 0) {
            if (!((unsigned)(VSync(-1) - t0) < 0x79)) {   /* waited >= 121 frames -> force-finish */
                volatile int *sv = &_cdr.w28;
                CdSyncCallback((CdlCB)*sv);
                sv -= 10;                           /* -0x28 -> &_cdr (jal delay slot) */
                sv[9] = 0;                          /* w24 = 0 */
                break;
            }
        }
    }

    /* W79-A3: qtytrace/allocsim on the callback-slot basin measured p80/p81 at
     * refs=2/live=92 and refs=2/live=98.  This one extra `buf` reference is the
     * minimal +1-ref solution that restores retail's sectors=$s4, buf=$s3 handout. */
    g = &_cdr;
    g->w0c = read_mode;
    sel = g->w0c & 0x30;
    __asm__("" : : "r"(sel));   /* W61-A7: +1 ref, reqdelta272-priced (see the receipt) */
    switch (sel) {
    case 0:    *(int *)&g->w10 = 0x200; break;               /* 2048 bytes */
    case 0x20: *(int *)&g->w10 = 0x249; break;               /* 2340 bytes (full raw) */
    default: {                                      /* 2328 bytes -- own anchor in this arm */
        /* W64-A6: `sz` declared+initialised BEFORE the anchor is LOAD-BEARING (11 -> 7).
         * reorg fills the `beq $v1,$v0` slot from a THREAD; retail takes the fall-through
         * (this arm) and steals its `li $v0,582`, ours took the branch TARGET's `li $v0,585`.
         * Cause: this arm's first insn was the anchor's `lui $v1` -- and $v1 is the register
         * the `beq` READS, so insn_sets_resource_p (09L) barred it and reorg abandoned the
         * thread.  Naming the constant first puts an eligible `li` at the head of the thread.
         * A fence on `sz` is WRONG here (15 diffs): it is an asm at the thread head and
         * stop_search_p then bars the whole thread again. */
        int sz = 0x246;
        volatile CdrEnv *d;
        d = &_cdr;
        __asm__("" : "=r"(d) : "0"(d));
        d->w10 = sz;
        break;
    }
    }

    /* W79-A3: final strict 3 -> PASS 103/103.  The scoped opaque zero is born
     * after the status RMW so its $a0 materialization fills the preceding load
     * delay slot.  The zero-instruction memory fence keeps the nonvolatile w00
     * store below the volatile w0c/w04 stores while leaving it eligible for
     * reorg to fill CdSyncCallback's jal slot. */
    {
    int cbarg;
    e = &_cdr;
    e->w0c |= 0x20;
    cbarg = 0;
    __asm__("" : "=r"(cbarg) : "0"(cbarg));
    e->w04 = (u_char *)buf;
    *(int *)&e->w00 = sectors;
    *(int *)&e->w28 = (int)CdSyncCallback((CdlCB)cbarg);
    e->w2c = CdReadyCallback(0);                    /* save+clear ready cb */
    if (CD_read_dma_mode & 1)
        e->w30 = CdDataCallback(0);                 /* save+clear data cb */
    e->w1c = VSync(-1);
    if (CdStatus() & 0xE0)                          /* drive busy -> pause first */
    {
        /* 🏆 W72-A16 (2 -> PASS 103/103) -- THE MULTI-OUTPUT TIED IDENTITY FENCE.
         * Residual class (d) below was diagnosed as "cse-constant-sharing, identity
         * fence is NOT the cure".  Half right: a SINGLE identity fence on the `param`
         * zero DOES break the sharing (retail's `addu $a2,$zero,$zero` appears), but it
         * costs the arg-setup ORDER -- the laundered zero's init now sits on a 3-long
         * sched1 dependency chain (`move z,$0` -> asm -> `move $5,z` -> jal) while the
         * `li $a0,9` is depth 1, so sched1 emits the zero first and reorg steals THAT
         * into the `beqz` slot where retail has `li $a0,9`.  Net 2 diffs either way.
         * FIX = give BOTH argument values ONE fence with TWO tied outputs.  Both then
         * hang off the same asm at the same depth, the tie breaks on luid = source
         * declaration order, and `cmd` (declared first) is emitted first == retail;
         * the `param` zero is still opaque so the `result` zero re-materializes from
         * $zero.  Zero instructions, no pin.  ORDER IS LOAD-BEARING: the same fence
         * with `z` declared/listed first is 2 (the old shape).  MEASURED, all reverted:
         * single identity fence on the zero 2 - read-only fence 5 - fence on the 3rd
         * arg 6 - two separately-fenced zeros 6 - `__asm__("":::"$5")` 3 - `"$6"` 5 -
         * a `cmd` local without a fence 2 (cmd folds back into the call setup) -
         * cmd+z fenced SEPARATELY 3 - `cmd` as a plain "r" INPUT of the zero's fence
         * 3 (an input does not equalize the chain, only a tied OUTPUT does). */
        int cmd = 9;
        int z = 0;
        __asm__("" : "=r"(cmd), "=r"(z) : "0"(cmd), "1"(z));
        CdControlB(cmd, (u_char *)z, 0);
    }
    /* W64-A6: retail schedules the `slt $v0,$zero,$v0` BEFORE the frame restores; sched2
     * sinks ours below them.  A named boolean + a zero-insn read-only fence pins the
     * compare above the epilogue (7 -> 5).  An identity fence measures the same 5; the
     * plain `return f() > 0;`, the Yoda form, an if/return pair and a void barrier before
     * the return are all INERT at 7. */
    { int r = _read_issue(0) > 0; __asm__("" : : "r"(r)); return r; }
    }
}

/* @0x80108F78 : CdReadSync -- poll (mode!=0) or block (mode==0) until the read completes.
 *
 * MATCH: FIELD-ANCHOR base pointers, transplanted from the byte-exact Rage Racer
 * decomp (C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\read.c, CdReadSync:
 * `volatile long *state = &g_CdReadStartVSync;` then `state[0]`, `state[-1]`,
 * `state[-2]`, `state[-7]`).  This RETIRES the methodology's "GENUINE FLOOR --
 * BASE-POINTER-ANCHOR granularity" verdict that was filed against exactly this
 * function: the oracle anchors `$s1 = &_cdr.w1c` (D_8013C2AC) and `$s2 = $s1+8`
 * and reaches every other field by a SIGNED displacement off them; a struct-base
 * `_cdr.field` recon can never emit that, but NEGATIVE-INDEXED pointers into the
 * middle of the block can.
 *
 * MATCH (w52-a2): the anchor's own materialization was SPLIT (`lui $v0,%hi; addiu $s1,$v0,%lo`)
 * where retail emits a single `la $s1`.  Splitting the declaration from the assignment and
 * pinning it with a W49 IDENTITY FENCE gives retail's one-register form; the diff count stays
 * 6 but the residual is now only (a) WHERE the `sw $s2,24($sp)` / `addiu $s2,$s1,8` pair is
 * scheduled in the prologue and (b) one `addu $a0,$s0,zero` copy where retail rematerializes
 * `li $a0,-1` (the old-gcc no-copy-prop class: `s0 = -1` is still live at the second
 * `VSync(-1)` call, so our cc1 reuses it).  FALSIFIED: read-only and identity fences on
 * `busy` to pull its `addiu` forward (6 both).  The ladder answers (a)+(b) -- rungs 2.6.0 /
 * 2.6.3 / 2.7.2 all score CdReadSync at 3 -- but they cost the TU as a whole (see the header).
 *
 * CORRECTNESS (same pass): the oracle DISCARDS CdReady's return -- `lw $v0,0($s2)`
 * overwrites it, and the two return paths are `v0 = s0` (delay slot) and `v0 = 1`.
 * The old recon returned CdReady's result whenever `w24 == 0`.
 *
 * MATCH (w55-a5): residual (b) SOLVED at source -- 6 -> 4, count-exact 65/65.  See the
 * loop-top comment: the `-1` answer belongs to the watchdog-trip ARM, not the loop head.
 * RESIDUAL 4, NAMED + PROVEN: residual (a) alone, a PURE 2-LINE TEXT RELOCATION -- retail
 * emits `sw $18,24($sp); addiu $18,$17,8` immediately after the anchor's `addiu $17,$17,
 * %lo(_cdr+28)`, ours sinks the pair below `sw $31` / `sw $16`.  The anchor's identity
 * fence is a scheduling barrier that pins `busy`'s addiu behind it, and every fence
 * flavour/placement probed re-measures 4 (identity / read-only / void-tail on `busy`,
 * fence after `busy`, `busy` computed before the state fence, `busy` from `&_cdr.w24`,
 * a dead `(void)busy[0]` ref) -- basin-re-probed w55, the w52 verdict holds.
 *   ORCHESTRATOR: PER_FN_TEXT_MOVES (already wired for THIS lane, compile_c) --
 *   PROVEN PASS 65/65 by scratchpad/w55a5_moves.py:
 *     "recon/syslib/psx/libcd/cdread.c": {"CdReadSync": [
 *        {"take": r"\tsw\t\$18,24\(\$sp\)\n",
 *         "after": r"\taddiu\t\$17,\$17,%lo\(_cdr\+28\)[^\n]*\n"},
 *        {"take": r"\taddu\t\$18,\$17,8\n",
 *         "after": r"\tsw\t\$18,24\(\$sp\)\n"}]}                                  */
extern int CdReadSync(int mode, u_char *result)
{
    volatile int *state;                               /* $s1 : issue-VSync stamp   */
    volatile int *busy;                                /* $s2 : &_cdr.w24           */
    int s0;

    state = (volatile int *)&_cdr.w1c;
    __asm__("" : "=r"(state) : "0"(state));  /* MATCH: one `la`, not a split lui/addiu */
    busy  = state + 2;

    for (;;) {
        /* MATCH (w55-a5): the `-1` answer belongs to the WATCHDOG-TRIP arm ONLY.
         * A loop-top `s0 = -1;` is dead on all three other paths, but it keeps
         * `s0 == -1` live at the SECOND `VSync(-1)` call, so cc1's cse feeds that
         * argument by copy (`addu $a0,$s0,zero`) where retail rematerializes
         * `li $a0,-1`.  Sinking the assignment into its own arm removes the
         * live -1 and restores the rematerialization: 6 -> 4, count-exact 65/65
         * (falsified in this basin: identity/read-only fence on s0 7/11, opacity
         * fence on the VSync argument 8). */
        if (VSync(-1) > state[0] + 0x4B0)              /* overall watchdog tripped  */
            goto trip;
        if (state[-2] < 0)                             /* _cdr.w14 : error          */
            goto reissue;
        if (!(VSync(-1) > state[-1] + 0x3C))           /* _cdr.w18 : per-intr stall */
            goto still;
    reissue:
        /* MATCH (block order / branch polarity): the oracle reaches the "still
         * progressing" load through the TAKEN edge of `beqz` and lays it
         * OUT-OF-LINE after the re-issue block, so re-issue is the fall-through.
         * Written as an inline `if (...) { s0 = state[-2]; goto check; }` the arm
         * is inlined and the branch inverts to `bnez`. */
        _read_issue(1);
        s0 = state[-7];                                /* _cdr.w00 : sectors        */
        goto check;
    trip:
        s0 = -1;
        goto check;
    still:
        s0 = state[-2];                                /* still progressing         */
    check:
        if (mode != 0) break;
        if (busy[0] != 0 && s0 == 0) continue;         /* still draining            */
        if (s0 > 0) continue;                          /* sectors left              */
        break;
    }

    CdReady(1, result);
    /* MATCH: the "drained" answer is assigned back INTO s0 (`li s0,1` lands in the
     * `bnez s0` delay slot, then the shared `addu v0,s0,zero` tail); a literal
     * `return 1;` materializes it straight into $v0 and loses the funnel. */
    if (busy[0] == 0) return s0;
    if (s0 == 0) s0 = 1;
    return s0;
}
