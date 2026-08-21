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

/* 🔴 W65-A6: the `ST_BSS` (`section(".bss")`) attribute above is INERT on this lane -- gcc-2.7.2
 * emits an uninitialised file-scope object as `.comm NAME,4` regardless, and this TU is on the
 * cc1_272 lane (no maspsx to rewrite it).  `nm` reported all three as COMMON (`C`): 3 of the 37
 * tree-wide COMMONs, which ld -- not the object -- places, so none could reach the VA its own
 * breadcrumb names (W62-A18 T6 / W64-A19 sec.3.4).  All three ARE genuine BSS
 * (> t_addr+t_size 0x8013E000), so they get real, object-owned definitions here, with the C
 * view demoted to `extern` so cc1's absolute addressing is untouched (5/6 PASS unchanged,
 * residual pre-existing).
 * LAYOUT: _ds_word0/_ds_word1 are adjacent at 0x801489D0/D4 (they are already read as ONE
 * struct below, `struct _ds_loc *dst = &_ds_word0`), then 8 unattributed bytes, then
 * GlobalCallback @0x801489E0 -- so _ds_ready_cb @0x801489E4 is INSIDE GlobalCallback's span
 * (= GlobalCallback+4, its slot 1), i.e. a THIRD retail run this object does not own alone.
 * W66-A3 LANDS THE SPLIT: the two runs now live in SEPARATE nobits sections
 * (`.bss.ds_<retail base VA>`), so a linker script can place each at its own base
 * and ONE object reproduces two DISJOINT runs.  This also DELETES the 8-byte
 * filler, which was not neutral: it was storage this object does not own, sitting
 * exactly on GlobalCallback @0x801489E0.  Byte-neutral for the gate (nobits emits
 * nothing, the C view stays `extern`, names/order/sizes unchanged); the un-placed
 * link is unchanged because the catch-alls now read `*(.bss); *(.bss.*)`.
 * Receipts: scratchpad/w65a6/RECEIPTS.md + scratchpad/w66a3/RECEIPTS.md */
__asm__("\t.globl\t_ds_word0\n\t.globl\t_ds_word1\n\t.globl\t_ds_ready_cb\n"
        /* run A @0x801489D0, 8 B */
        "\t.section\t.bss.ds_801489D0,\"aw\",@nobits\n\t.align\t2\n"
        "_ds_word0:\n\t.space\t4\n"
        "_ds_word1:\n\t.space\t4\n"
        /* run B @0x801489E4, 4 B -- == GlobalCallback+4, slot 1 of a block this
         * object does not own alone; kept a separate section so nothing here
         * claims the 8 bytes at 0x801489D8 or GlobalCallback itself. */
        "\t.section\t.bss.ds_801489E4,\"aw\",@nobits\n\t.align\t2\n"
        "_ds_ready_cb:\n\t.space\t4\n\t.text");
extern int _ds_word0;     /* @0x801489D0 : last sector sub-header (slot+28) */
extern int _ds_word1;     /* @0x801489D4 : last sector word (slot+8)        */
extern int _ds_ready_cb;  /* @0x801489E4 : DsReadyCallback slot (== GlobalCallback+4) */


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

/* 🏆 W71-A8 (9 -> PASS 35/35): this is a `CdlLOC` -- FOUR u_char fields, ALIGN 1 -- not the
 * `{short lo, hi;}` (align 2) the recon carried.  THE ALIGNMENT IS THE WHOLE MATCH, and the
 * mechanism is structural, not a coloring dial:
 *   align 2 (size 4, STRICT_ALIGNMENT) still lets `*dst = *src` lower to a plain unaligned
 *   SImode move whose MEM keeps the SYMBOL_REF address -- cc1 emits `swl $5,_ds_word0+3` /
 *   `swr $5,_ds_word0` and GNU as expands each into its own `lui $at` macro (4 insns, no
 *   anchor, and the `lui` also steals the lwr's load-delay slot => 34 insns, 1 SHORT).
 *   align 1 makes the type BLKmode, so the assignment goes through emit_block_move ->
 *   mips.c expand_block_move, which `copy_addr_to_reg`s BOTH addresses.  The destination
 *   address is a bare symbol, so that copy survives as retail's `lui $a2,%hi; addiu $a2,%lo`
 *   ANCHOR (`swl $v0,3($a2)`, `swr $v0,0($a2)`), the source address folds back to the
 *   already-live slot base (`lwl $v0,0x1F($v1)`), and the freed load-delay slot becomes
 *   retail's `nop` -- 35/35 byte-exact, INCLUDING the $a2 home.
 * This RETIRES the W63/W64-A6 "$a0-is-the-first-free-register hardness certificate" below:
 * the anchor never was an allocation problem -- the block-move expander mints its address
 * register at expand time, before local-alloc's numeric scan ever runs.  The W64 qty272
 * measurement was correct about the FENCED basin; the fenced basin was simply the wrong
 * shape.  SOURCE: sotn-decomp `src/main/psxsdk/libcd/c_004.c` (fully matched) writes the
 * destination as `static CdlLOC fp_2; ... fp_2 = ptr->loc;` -- the corpus twin the earlier
 * waves mined for CONTROL FLOW but not for the destination's TYPE. */
struct _ds_loc { u_char minute, second, sector, track; };

/* @0x80108798 (C_004) : a sector finished decoding -- mark its slot ready and notify StFunc1. */
extern void data_ready_callback(void)
{
    /* ✅ W71-A8: PASS 35/35.  The fix was the DESTINATION TYPE'S ALIGNMENT (see the
     * `struct _ds_loc` receipt above), not any register/fence/priority dial.  Everything
     * below this line is the HISTORICAL record of the W55/W61/W63/W64 grind on the wrong
     * basin -- kept because its measurements are still valid negatives for the
     * fenced-anchor shape, but the "$a0 vs $a2 is an availability hardness certificate"
     * verdict is RETIRED: the block-move expander picks that register at expand time. */
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
    /* W64-A6 -- THE ANGLE WAS MEASURED, AND IT CLOSES AS A QUANTIFIED HARDNESS
     * CERTIFICATE: this is an AVAILABILITY loss (a find_free_reg exclusion), not a
     * priority loss, and 15A bounds every fence/ref/live dial out of that class by
     * construction.  qty272 on the FENCED (count-EXACT 35/35) basin, cc1_272 lane,
     * -O2 -G0 -mgas:
     *     pseudo blk refs live sz calls    pri    home
     *        72   0    4    5   4   0   1.6000   $v1   (slot base)
     *        74   0    2    2   4   0   1.0000   $v0
     *        76   0    4    9   4   0   0.8888   $a0   <- `dst`, THE ANCHOR
     *        77/80/73/75/81   all pri <= 0.5, all reuse $v0/$v1
     *     global allocnos: only p82 (refs 3 / live 5), home $a0 after 76 dies.
     * The movstrsi hypothesis is FALSIFIED: the block-move expander mints no reserved
     * hard reg here -- `dst` is an ordinary BLOCK-LOCAL qty, served 3rd, and $a0 is
     * simply the FIRST FREE register in find_free_reg's numeric scan (MIPS has no
     * REG_ALLOC_ORDER).  Retail's $a2 is the THIRD free register, so reaching it needs
     * TWO MORE values simultaneously live across the anchor's 9-insn window.  This
     * function has exactly two ($v0 = the lwl/lwr value, $v1 = the slot base) and there
     * is no zero-insn way to mint a third: every hoist that would occupy $a0/$a1 also
     * moves retail's own loads, which retail emits AFTER the copy.  MEASURED on the
     * fenced basin (all gated, all reverted): hoist the _ds_word1 load 24 - hoist
     * StFunc1 18 - hoist StRingIdx1 22 - w1+StFunc1 28 - w1+StRingIdx1 28; unfenced
     * with both hoists 23.  Baseline 9, fenced control 10.
     * ==> no priority/live/ref dial can reach retail's register; KEEP the un-anchored
     * form.  Re-open only with a device that adds a live value at ZERO instructions. */
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
