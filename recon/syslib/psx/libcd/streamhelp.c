/* syslib/psx/libcd/streamhelp.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   The CD-streaming ring consumer, teardown, and the small one-function helper objects that the
 *   streaming core (stream.cpp / stcdint.cpp) calls.  Grouped here as the logical "streaming helpers"
 *   module; each retains its libcd/libds object tag:
 *     StGetNext         (@0x800F9A28, C_009)  -- hand the caller the next decoded frame, if ready.
 *     StUnSetRing       (@0x800F8EC8, C_003)  -- tear the streaming callbacks down.
 *     init_ring_status  (@0x80108758, C_008)  -- zero the status word of a run of ring slots.
 *     data_ready_callback(@0x80108798, C_004) -- per-sector decode-done hook (marks slot ready).
 *     StSetMask         (@0x8010885C, C_010)  -- set the start-flag / start-frame / end-frame gate.
 *     DsReadyCallback   (@0x80108824, DSCB)   -- libds ready-callback slot.
 *     DsDataCallback    (@0x80108838, DSCB)   -- libds data-callback -> DMACallback(3,..).
 *
 *   Ring slots are 0x20 bytes; the per-frame data area starts at StRingAddr + StRingSize*0x20, one
 *   0x7E0-byte (0x3F*0x20) frame slot per ring index.  slot[0] is a status word: 0 free, 1 wrap
 *   marker, 2 decoded/ready, 3 DMA in flight, 4 handed to the caller. */

typedef unsigned long  u_long;
typedef unsigned short u_short;
typedef unsigned char  u_char;

/* ---- streaming state (stream.cpp) ------------------------------------------------------------- */
extern int StRingAddr, StRingIdx1, StRingIdx2, StRingIdx3, StRingSize, StEndFrame;
extern int StFunc1, StFinalSector, StSTART_FLAG, StStartFrame;

/* ---- peers ------------------------------------------------------------------------------------ */
extern int  CdDataCallback(int func);   /* cdcont @0x800F7CB0 */
extern int  CdReadyCallback(int func);  /* cdcont @0x800F78A0 */
extern int  DMACallback(int ch, int func); /* libetc @0x800F28AC */
extern int  EnterCriticalSection(void); /* BIOS @0x8010698C */
extern void ExitCriticalSection(void);  /* BIOS @0x8010696C */
extern int  DS_active;                  /* @0x8013BF68 : libds stream active */

/* ---- libds / C_004 globals (anonymous in the original) ---------------------------------------- */
/* Regular .bss, reached absolutely in the oracle (their 0x801489Dx addresses are far outside the
 * -G4 small-data window) -- pin to .bss so they are not placed in .sdata/.sbss (= gp-relative). */
#define ST_BSS __attribute__((section(".bss")))

int _ds_word0   ST_BSS;   /* @0x801489D0 : last sector sub-header (slot+28) */
int _ds_word1   ST_BSS;   /* @0x801489D4 : last sector word (slot+8)        */
int _ds_ready_cb ST_BSS;  /* @0x801489E4 : DsReadyCallback slot             */


/* cached CD register pointers used only by StUnSetRing.  In the original these live in regular
 * .data @0x80136C48/0x80136C54 and are reached ABSOLUTELY (lui %hi; lw %lo) -- a plain initialised
 * `static` pointer is only 4 bytes so -G4 would place it in .sdata -> gp-relative (mismatch).
 * Pin to .data to keep the absolute addressing. */
static volatile u_char *_un_cd_idx  __attribute__((section(".data"))) = (volatile u_char *)0x1F801800;  /* @0x80136C48 CDREG0 */
static volatile u_char *_un_cd_reg3 __attribute__((section(".data"))) = (volatile u_char *)0x1F801803;  /* @0x80136C54 CDREG3 */

extern void data_ready_callback(void);
extern int  DsReadyCallback(int func);
extern int  DsDataCallback(int func);

/* @0x800F8EC8 (C_003) : remove the streaming callbacks and quiesce the drive. */
extern void StUnSetRing(void)
{
    EnterCriticalSection();
    if (DS_active == 1) {
        DsDataCallback(0);
        DsReadyCallback(0);
    } else {
        CdDataCallback(0);
        CdReadyCallback(0);
    }
    *_un_cd_idx  = 0;     /* CDREG0 = 0 */
    *_un_cd_reg3 = 0;     /* CDREG3 = 0 */
    ExitCriticalSection();
}

/* @0x800F9A28 (C_009) : if the next frame is decoded, return its data + header; else return 1. */
extern u_long StGetNext(u_long **addr, u_long **header)
{
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx3 << 5));

    if (slot[0] == 1) {                         /* wrap marker: rewind to slot 0 */
        StRingIdx3 = 0;                          /* oracle: unconditional (beqz delay slot) */
        if (StEndFrame != 0)                     /* bounded stream: also clear the marker */
            slot[0] = 0;
        slot = (u_short *)(StRingAddr + (StRingIdx3 << 5));
    }
    {   u_long r = 1;                             /* MATCH: pre-load return val so gcc puts addiu v0,1 in bne delay slot */
        if (slot[0] != 2)                       /* not decoded yet */
            return r;
    }
    slot[0] = 4;                                /* claim it */
    *addr   = (u_long *)(StRingAddr + (StRingSize << 5) + ((StRingIdx3 * 0x3F) << 5));
    *header = (u_long *)slot;
    return 0;
}

/* @0x800FA994 (C_007) : release the frame that `base` points into; advance the read index past it.
 * MATCH (w51-a4): shape TRANSPLANTED from the byte-exact Rage Racer libpress decomp,
 * C:/Temp/rage-racer-decomp/src/main/PAL/lib/libpress/stream_ring.c :: StFreeRing.  Levers:
 *  (1) the index is a POINTER DIFFERENCE in u_long units divided by 504 -- the oracle's
 *      `sra v0,a0,2; mult v0,a1; ... sra v0,v0,8` is the magic divide for /504 AFTER the
 *      pointer-difference >>2, not a single /0x7E0 magic divide (which gives `sra ...,10`);
 *  (2) the frame STATE is read SIGNED (`lh`) while nSectors is read unsigned (`lhu`) into a
 *      `short` local, so the loop guard sign-extends (`sll;sra;blez`) like the oracle;
 *  (3) the loop counter is incremented INSIDE the body and the tail uses the COUNTER
 *      (`i + slot`), not `nsectors + slot`.
 *  (4) the loop is spelled GUARDED-do/while (the rotated shape the oracle has): a counted
 *      `for`/`while` makes gcc-2.7.2 reserve a spurious 8-byte `vars` frame (subu/addu $sp
 *      + an epilogue on the early-return path, which also flips the guard's bne->beq) --
 *      35 -> 6 with the transplant, 6 -> PASS with the guarded do/while.  A guard+goto
 *      spelling is frameless too but re-colors the loop body (23 diffs) -- falsified. */
extern u_long StFreeRing(u_long *base)
{
    int       slot;
    int       i;
    short     nsectors;
    u_short  *frame;
    u_short  *sector;

    slot     = (base - (u_long *)(StRingAddr + (StRingSize << 5))) / 504;
    frame    = (u_short *)(StRingAddr + (slot << 5));
    nsectors = frame[3];
    if (*(short *)frame != 4)                  /* not claimed by a StGetNext caller */
        return 1;
    /* guard-then-goto, NOT a counted `for`: gcc-2.7.2 gives every counted for-loop a spurious
     * 8-byte `vars` frame (subu/addu $sp + an epilogue on the early-return path, which also
     * flips the `bne`/`beq` polarity above).  Same lever as init_ring_status below. */
    i = 0;
    if (nsectors > 0) do {
        sector = (u_short *)(StRingAddr + ((i + slot) << 5));
        i++;
        *sector = 0;
    } while (i < nsectors);
    StRingIdx3 = i + slot;
    return 0;
}

/* @0x80108758 (C_008) : zero the status word of `count` slots from `base`.
 * Oracle ends `jr ra; nop` with NO $v0 set -> the original returns void (the loop's
 * last $v0 scratch is left dead). A `return 0` would emit `addu v0,zero,zero` in the
 * delay slot (1 extra diff). Declared void here; the callers discard the result. */
/* MATCH (w51-a4, cc1_272 lane): the natural `for (i = 0; i < count; i++)` makes gcc-2.7.2
 * reserve an 8-byte `vars` frame (`.frame $sp,8` -> subu/addu $sp pair) on EVERY counted
 * for-loop, even with no memory locals -- the oracle is frameless.  Falsified: `for` with
 * int/unsigned counter, `for` with a hoisted `int *p`, and `while (i != count)` (frameless
 * but emits `bne i,count` instead of the oracle's `sltu`+`bnez`).  The guard-then-goto form
 * below is frameless AND reproduces the oracle byte-for-byte (entry `beqz count` with `i=0`
 * in the delay slot, bottom `sltu v0,i,count; bnez` with the `sw` in ITS slot).  It also
 * still PASSes on the 2.8 lane, so the spelling is lane-neutral. */
extern void init_ring_status(int base, unsigned count)
{
    unsigned i = 0;
    if (count == 0)
        return;
loop:
    *(int *)(StRingAddr + ((i + base) << 5)) = 0;   /* oracle adds i+base (addu v0,a2,a0) */
    i++;
    if (i < count)
        goto loop;
}

/* a 2-byte-aligned 4-byte payload: forces gcc to emit unaligned word ops (lwl/lwr, swl/swr)
 * for the sub-header copy, matching the oracle (the original copied a CdlLOC struct field
 * out of a u_short*-typed ring slot). */
struct _ds_loc { short lo, hi; };

/* @0x80108798 (C_004) : a sector finished decoding -- mark its slot ready and notify StFunc1. */
extern void data_ready_callback(void)
{
    /* W63-A6: re-gated at 9 @34/35 (unchanged) and TWO more axes closed.
     *  (1) VOID-BARRIER POSITION: a mechanical sweep inserting a zero-insn
     *      `__asm__("" : : "i"(0))` before every statement in the body
     *      (scratchpad/w63a6/fencesweep.py) leaves all 8 positions at exactly 9.
     *  (2) The matched-twin devices A18 harvested from sotn `libcd/c_004.c:16` are
     *      already present or inert here: sotn hoists an ELEMENT POINTER to the top
     *      (`StHEADER *ptr = &ring[idx];`) -- our `slot` local IS that -- and opens with
     *      a literal `do { } while (0);` scaffold, which is a loop-depth REF dial and has
     *      nothing to lift in a fn whose whole residual is the ANCHOR'S HARD REGISTER.
     * The residual therefore stays exactly as w55-a5/w61-a8 left it: the fenced basin is
     * count-EXACT 35/35 and structurally right, and the only thing wrong is that the
     * anchor lands in $a0 (numeric first-free) where retail has $a2 -- and retail's body
     * never uses $a1 at all, so this is NOT "two other qtys took $a0/$a1".  NAMED ANGLE
     * (new): find what EXCLUDES $a0/$a1 from the scan at that point in retail -- most
     * likely the 4-byte align-1 struct copy being expanded as a movstrsi block move,
     * whose expander reserves its own address registers.  Measure with qty272 --keep on
     * the fenced basin and read `[find_free_reg]`, do not spell-probe further. */
    /* RESIDUAL 9 (ours 34 / oracle 35, 1 SHORT) -- CLASSIFIED w55-a5, NOT landed.
     * Retail reaches the 3-byte unaligned sub-header destination through ONE anchor
     * (`lui $a2; addiu $a2,$a2,%lo(D_801489D0); swl $v0,3($a2); swr $v0,0($a2)`);
     * ours const-folds `dst` straight back to the symbol and emits two `$at`
     * assembler macros (`lui $at; swl $v0,%lo`, twice) = 1 insn short.  A W49
     * IDENTITY FENCE on `dst` DOES restore the anchor -- count becomes EXACT 35/35
     * and the whole body lines up -- but the residual is then 10: the anchor lands
     * in $a0 (numeric first-free) where retail has $a2, and its `lui/addiu` pair is
     * scheduled at the TOP of the block instead of after the `sh $v0,0($v1)`.
     * 10 > 9, so the gate says keep the un-anchored form; the fenced form is the
     * structurally correct BASIN for a future coloring dial.  Measured: identity
     * fence before or after the status store 10 (count-exact), read-only fence 26,
     * fence + `dst` assigned after the status store 10, same in a nested block 10,
     * `dst` assigned late WITHOUT a fence 9 (identical to the current form).
     * W61-A8 re-priced the fenced (count-exact) basin with the w61-a20 preference law:
     * the anchor's defining expression is a SYMBOL_REF, so set_preference records
     * NOTHING and only the numeric scan runs -- $a0 is simply the first free reg, and
     * nothing here can make $a0/$a1 busy without adding an instruction.  FALSIFIED on
     * that basin (all gated, all reverted): a read-only fence on `dst` after the copy
     * 18, two operands 18, `dst` defined after the status store 10, and routing the
     * aligned `_ds_word1` store through the same anchor 21. */
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx2 << 5));
    struct _ds_loc *dst = (struct _ds_loc *)&_ds_word0;

    slot[0]  = 2;                               /* status = decoded/ready */
    *dst = *(struct _ds_loc *)(slot + 14);      /* unaligned sub-header copy (slot+0x1C) */
    _ds_word1 = *(int *)(slot + 4);             /* aligned (slot+8) */
    StRingIdx2 = StRingIdx1;                     /* oracle: unconditional (beqz delay slot) */
    if (StFunc1 != 0)
        ((void (*)())StFunc1)();
    StFinalSector = 0;
}

/* @0x8010885C (C_010) : configure the start gate. */
extern void StSetMask(u_long mask, u_long start_frame, u_long end_frame)
{
    StSTART_FLAG = (int)mask;
    StStartFrame = (int)start_frame;
    StEndFrame   = (int)end_frame;
}

/* DsReadyCallback (@0x80108824) and DsDataCallback (@0x80108838) are OWNED by
 * libds.lib(DSCB.OBJ) -> defined in syslib/psx/libds/DSCB.cpp.  They were duplicated
 * here originally; removed to avoid a multiple-definition link conflict.  The extern
 * decls above keep the calls below resolving against the libds definitions. */
