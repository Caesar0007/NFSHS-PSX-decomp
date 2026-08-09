/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: identity = gcc-2.8.0 + maspsx (the DEFAULT lane).
 *
 *   lane            SNDbankheadercopy
 *   default         10 (81/81)
 *   2.6.0           55 (80/81)
 *   2.6.3           55 (80/81)
 *   2.7.2-970404    17 (82/81)
 *   2.7.2           55 (80/81)
 *   2.8.0 CONTROL   10 (81/81)
 *   2.8.1           10 (81/81)
 *   2.91.66         50 (83/81)
 *   2.95.2          73 (82/81)
 *
 * READING: only 2.8.0/2.8.1 reproduce the default's 10 at count parity; every other rung
 * loses or gains instructions.  Compiler-version axis closed.
 */
/* eaclib/psx/sndpsxz/sbhdrcpy.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbhdrcpy.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7BA8.  SNDbankheadercopy -- copy a loaded bank's header into `dst` and rebase its patch
 *   pointers to the new buffer, repointing the bank table at the copy.  Ghidra nfs4-f.exe.c (sbhdrcpy).
 */

struct SNDGlobals {
    char pad0[0x3c];
    signed char initialized;
    char pad3d[0x5b];
    int bank_table;
};
extern struct SNDGlobals sndgs;
extern int SNDbankheadersize(int bankId);          /* sbhdrsze */
extern void *memcpy(void *dst, const void *src, int n);   /* C42 (BIOS thunk) */

extern int SNDbankheadercopy(void *dst, int bankId);   /* @0x800E7BA8 */

/* SNDbankheadercopy @0x800E7BA8 : memcpy the bank header to `dst`, relocate each patch pointer (+0x14 for
 *   bank type 4, else +0xc) relative to `dst`, then point the bank table entry at `dst`.
 *
 * NEAR-MISS 13 diffs (ours 82 / oracle 81).  Register ALLOCATION is already oracle-exact
 * (i=$v1, src20=$a0, dst20=$a1, src12=$a2, dst12=$a3, origin=$t0, type4=$t1, dest=$s1, bankId=$s3);
 * the residual is two emission-ORDER ties:
 *   (a) prologue -- the oracle emits the `dest=$a0` param copy first and puts the `bankId=$a1` copy
 *       in the guard's `bnez` delay slot; ours emits them the other way round (reorg fills the slot
 *       with whichever copy is emitted last).  FALSIFIED: decl-order swap, assigning `dest` after
 *       the decls, taking `unsigned char *dest` as the parameter directly (31 diffs) -- the local
 *       cast copy is load-bearing.
 *   (b) the oracle fills the `lw s0,0(s0)` load-delay slot with `addu $v1,$zero,$zero` (i = 0),
 *       leaving `addu $a0,$s0,$zero` for the end of the preheader; ours nops that slot and emits
 *       `move v1,zero` last -- the +1 instruction.  The oracle's `i = 0` therefore sits in the
 *       PRE-guard block, i.e. before `if (count)`.  FALSIFIED (each measured): hoisting `i = 0`
 *       above the guard, block-local or function-scope (both 82/81, and `i` slides to $a3 taking the
 *       whole pointer set with it -- longer live range = lower allocno priority, whereas the oracle
 *       ranks `i` FIRST); natural `for` with the walkers assigned before it (27 diffs, setup moves
 *       hoist above the guard); index form `bankData + i*4 + 0x14` (77 insns -- our cc1 CSEs the
 *       four address expressions down to TWO givs where retail keeps four, the same weaker-CSE
 *       identity seen across this archive).
 *
 * W33 follow-up, a3's giv-anchor levers (power-of-2 stride + "two refs to the same element"):
 * the stride here IS 4, so the giv machinery does fire -- but `combine_givs` merges the four
 * address givs down to TWO in EVERY index spelling tried: `bankData + i*4 + disp` (77 insns),
 * four separately-based arrays `((int*)(bankData+0x14))[i]` etc. (77 insns, 42 diffs), and four
 * per-iteration recomputed walkers `dst12 = dest + i*4; ...` (77 insns, 38 diffs).  Ours is
 * invariably 4 instructions SHORT of the oracle's 81.  Retail keeps four independent walkers, so
 * the explicit-pointer form below is not a mis-derivation -- it is the only shape that reproduces
 * them, and the 4-vs-2 giv count is a `combine_givs` cost-model identity (the w28-31 SS.B
 * "gcc 2.8 combines all in-loop address givs onto the LAST giv in body order" finding), not
 * source-reachable.
 * NO SLD EVIDENCE is available (sbhdrcpy.obj has only a type-2 symbol record).
 *
 * W34-a6 (two NEW evidence classes applied, both NEGATIVE here -- record so they are not re-run):
 *  - NFS2 PC-beta NAMED source (`pc-split/shdr.obj/SNDbankheadercopy.c`, an OLDER generation of this
 *    same EA lib) confirms the two-arm rebase and the per-arm src/dst base pair, but its patch loop
 *    walks a single BYTE-OFFSET induction variable (`for (off = 0; off < count*4; off += 4)` with
 *    `*(int *)(hdr + 8 + off)` / `*(int *)(dst + off + 8)`), and its type test is `< 2` not `== 4`.
 *    That is a different library generation, so it does NOT overturn the four-walker shape the PSX
 *    oracle plainly shows ($a0/$a1/$a2/$a3 all +4 per iteration).
 *  - cc1 `-dl`/`-dg` allocno dumps (the instrument that cracked SNDPKTPLAY_purge/start this wave):
 *    the residual here is NOT an allocno-priority tie.  Both diffs are EMISSION-ORDER ties that the
 *    priority model does not describe: (a) sched2's descending-luid tie between the two prologue
 *    parm copies -- retail emits `dest = $a0` first and leaves `bankId = $a1` for the guard's delay
 *    slot, ours the reverse (a `int id = bankId;` second local copy makes it WORSE, 29 diffs); and
 *    (b) retail's scheduler fills the `lw s0,0(s0)` LOAD-delay slot with `i = 0` and then lets reorg
 *    eager-steal `origin = bankData` into the `beqz` slot, while ours leaves the load delay empty and
 *    gives the branch slot to `i = 0`.  Hoisting `i = 0` above the guard (both before and after the
 *    bankData load) does NOT change that -- it only turns `i` into a cross-block allocno that loses
 *    $v1 to $a3 and costs a 7th preheader move (37 diffs both ways).  Scheduler-tie class.
 *
 * W35-a6 2026-07-26: residual (b) re-attacked from the one angle the earlier waves did NOT cover --
 * they only tried HOISTING `i = 0` out of the preheader block; this session swept its position
 * WITHIN the block, which is what actually feeds sched2's ready list.  Moving the `i = 0` statement
 * to each of the 7 slots gates 37 / 37 / 37 / 33 / 29 / 21 / 13, i.e. the diff count falls
 * MONOTONICALLY the LATER `i = 0` is written and the kept form (last) is the optimum; putting
 * `origin = bankData` last instead gates 15, and doing both gates 39.  Every variant stays 82/81, so
 * no statement position anywhere in the preheader recovers the missing instruction -- the oracle's
 * choice to spend the `lw s0,0(s0)` load-delay slot on `i = 0` (and only then eager-steal `origin`
 * into the `beqz` slot) is a scheduler decision that no source order reaches.  Floor CONFIRMED, and
 * the sweep is exhaustive over statement order, so do not re-run it.
 *
 * 🔴 w49-a8 2026-08-08 -- THE MISSING INSTRUCTION IS RECOVERABLE (statement ORDER was the wrong
 * dial; the w45 fence-as-sched-position-fixpoint is the right one).  A ZERO-INSN barrier placed
 * immediately BEFORE the `base->initialized` guard --
 *     __asm__("" : : "i"(0));
 *     if (base->initialized == 0) return -10;
 * -- gates 12 at COUNT-EXACT 81/81 (vs the kept 13 at 82/81): it recovers residual (b)'s
 * instruction and lands retail's `sw s1/addu s1,a0` prologue pair (residual (a) SOLVED).  The
 * effect is the BARRIER POSITION, not the operand: dest / bankId / both / base / opacity-dest /
 * void all gate 12 at that position (opacity-dest 16, opacity-bankId 48 are the two exceptions).
 * Position sweep (10 slots): pre-guard 12@81 | pre-size= 13@82 | pre-memcpy 14@83 | pre-bankData
 * 13@82 | pre-if(count) 13@82 | preheader top 12@83 | after type4 12@83 | pre-i=0 17@82 | pre-do
 * 17@82 | pre-tail-store 13@82.  The w35 `i = 0` position sweep was RE-RUN inside the new fence
 * basin (lever-order-dependence law) and is unchanged: 36/36/36/32/28/20/12, optimum still last.
 * NOT LANDED: -1 diff does not justify a bare barrier a 1998 programmer would not write, and no
 * NATURAL source form reproduces it -- a volatile read of `base->initialized` (the semantically
 * plausible candidate, the flag is set by another module) gates 15 (82/81) in both spellings, and
 * the branch-polarity rewrite `if (initialized != 0) goto initok; return -10;` is canonicalized
 * away (13 alone, 12 with the fence = identical to the fence alone).
 * ==> residual re-stated for the next wave: with the barrier, 12 = the `sw s3`/`addu s3,a1` save
 * position + the guard's branch polarity + the `i = 0` slot.  Hunt a NATURAL barrier, not order.
 * w50-a8 2026-08-09: barrier LANDED (the honest-count rule is satisfied: 13 -> 10 AND count-exact
 * 81/81) together with the positive-test body wrap.  The NATURAL-barrier hunt came up empty --
 * every natural rearrangement at that position (guard on sndgs directly, dest/base assigned after
 * the guard, goto-polarity, else-arm) is 12-13 or loses the count.  Also re-run and unchanged in
 * the new basin: the `i = 0` position sweep (36/36/36/32/28/20/10, optimum still LAST) and
 * hoisting `i = 0` above the count guard (36 -- `i` loses $v1; a do{}while(0) ref inflator on the
 * hoisted init restores the rank and returns to exactly 10, so the hoist is a no-op, not a win). */
extern int SNDbankheadercopy(void *dst, int bankId)
{
    unsigned char *dest = (unsigned char *)dst;
    struct SNDGlobals *base = &sndgs;
    int size;
    unsigned char *bankData;

    /* MATCH (w50-a8, 13 -> 10, and count-exact 81/81): TWO cooperating dials.
     *  (1) the w45 ZERO-INSN BARRIER immediately before the guard (w49-a8 found this; it is the
     *      sched-position fixpoint that recovers the missing instruction and lands retail's
     *      `sw s1 / addu s1,a0` prologue pair).  Operand-independent: void / dest / bankId /
     *      base all gate the same at this position.
     *  (2) the POSITIVE-TEST BODY WRAP (this `if (initialized != 0) { ... } return -10;`), which
     *      is also the more natural 1998 spelling.  It is worth -2 ONLY on top of the barrier
     *      (alone it is 17); the barrier alone is 12.
     * Falsified this wave at the guard: reading sndgs.initialized directly (13); assigning
     * `dest`/`base` after the guard (12 @ 83/81 -- count lost); the goto-form `if (init != 0)
     * goto ok;` (13 alone / 12 with the barrier = barrier only); an else-arm `{ ... } else {
     * return -10; }` (identical 10); a fence inside the -10 arm (13 alone / 10 @ 83 with the
     * pre-guard one).  RESIDUAL 10, one cause: retail does NOT jump-thread the -10 return --
     * it keeps a `bnez v0,body` (with the `bankId = $a1` parm copy eager-stolen into its slot)
     * falling through to an out-of-line `j epilogue / li v0,-10` TRAMPOLINE, and defers
     * `sw s3,28(sp)` past `sw ra`; ours threads the -10 straight into the `beqz` and pays a nop
     * in the later `lw s0,0(s0)` load-delay slot where retail spends `i = 0`.  All 10 diffs are
     * that one un-merged trampoline plus its cascade -- the w47 else-arm fence mode (the
     * documented de-merger) does NOT reach it here. */
    __asm__("" : : "i"(0));
    if (base->initialized != 0) {
    size = SNDbankheadersize(bankId);
    if (size < 0)
        return size;
    memcpy(dest, *(unsigned char **)(bankId * 0xc + base->bank_table), size);
    bankData = *(unsigned char **)(bankId * 0xc + base->bank_table);
    {
        unsigned char *origin;
        int type4;
        unsigned char *dst12;
        unsigned char *src12;
        unsigned char *dst20;
        unsigned char *src20;
        int i;

        if (*(unsigned short *)(bankData + 6) != 0) {
            origin = bankData;
            type4 = 4;
            dst12 = dest;
            src12 = bankData;
            dst20 = dest;
            src20 = bankData;
            i = 0;
        do {
            if (*(unsigned char *)(bankData + 4) == type4) {
                int sp = *(int *)(src20 + 0x14);
                if (sp != 0)
                    *(int *)(dst20 + 0x14) = (int)dest + (sp - (int)origin);
            } else {
                int sp = *(int *)(src12 + 0xc);
                if (sp != 0)
                    *(int *)(dst12 + 0xc) = (int)dest + (sp - (int)bankData);
            }
            dst12 += 4;
            src12 += 4;
            dst20 += 4;
            src20 += 4;
            i++;
        } while (i < (int)(unsigned)*(unsigned short *)(bankData + 6));
        }
    }
    *(int *)(bankId * 0xc + sndgs.bank_table) = (int)dest;
    return 0;
    }
    return -10;
}
