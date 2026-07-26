/* eaclib/psx/eacpsxz/setfont.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\textset.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 359149).
 *   1 fn @0x800F2E94 (400 B).  setfont -- install `fontId` (a font-header pointer) as the current text font:
 *   copies its glyph metrics into the global current-font descriptor (a flat struct based at 0x80135BA0),
 *   measures the bitmap depth/stride via shapedepth, selects the per-glyph decoder (ANSI vs Shift-JIS), then
 *   clears the blit state and re-inits the text draw lists.  Returns the chosen decoder fn pointer.
 *   Ghidra nfs4-f.exe.c (setfont) + disasm-v3 (delay-slot field stores, the two shapedepth calls,
 *   blockclear(&0x80135BD4,0x40)) + IDA sig.  Plain C (unmangled symbol) -> extern free function; the
 *   DAT_* globals are the shared current-font descriptor (the same ones textfor/textcrnt/textcode reference).
 *
 *   Font header layout read (offsets into `fontId`):
 *     +0x0a u16 glyphCount   +0x0e u16 flags(&3==2 => Shift-JIS)   +0x10..0x13 i8 metrics(ascent/descent...)
 *     +0x14 i32 glyphTblOff  +0x1c i32 shapeOff   +0x20 encoded-data start (probed by geti)
 */
typedef int (*DecodeFn)(unsigned char **cursor);

extern unsigned int geti(void *p, char nbits);                 /* getm */
extern int   shapedepth(unsigned char *shape);                 /* shpdepth */
extern int   decodeansi(unsigned char **cursor);               /* textcode */
extern int   decodeshiftjis(unsigned char **cursor);           /* isqrttbl (obj name misnomer) */
extern void  blockclear(void *dst, int n);                     /* blkfill */
extern void  inittextdraw(void);                                /* textpsx (game) */

/* --- current-font descriptor (flat struct @0x80135BA0; SHARED with textfor.c) ---
 * MATCH: every Ghidra DAT_80135xxx global setfont touches is really a FIELD at a fixed offset
 * INTO this one blob (0x80135C1C-0x80135BA0=0x7C, 0x80135BD4-0x80135BA0=0x34, etc -- verified
 * for all 22 fields below). The oracle materializes `&currentfont` ONCE into a saved reg and
 * stores every field through it (`sw v0,0x7C(s1)`, ...); the OLD reconstruction declared each
 * field as its own independent `extern int DAT_...` global, which can't share one base pointer
 * (each gets its own %hi/%lo) -- a textbook §4-gotcha-13 "overlapping/bulk struct" miss.
 * Accessed via an explicit LOCAL POINTER `cf = currentfont;` (NOT the bare global inline) --
 * an inline `currentfont+off` reference lets gcc CSE the address of the FIRST-touched FIELD
 * (a biased %hi/%lo(currentfont+0x7c)) as the shared base, so every other field becomes a
 * NEGATIVE offset from it; a separate local pointer variable forces gcc to materialize the
 * BARE base (offset 0) once, matching the oracle exactly (same lever textfor.c's
 * getcharacter() already uses: `unsigned char *cf = currentfont;`). */
extern unsigned char currentfont[];
#define CFI(base,off)       (*(int *)((base) + (off)))         /* 4-byte int field            */
#define CFP(base,off)       (*(void **)((base) + (off)))       /* 4-byte pointer field         */
#define CFFN(base,off)      (*(DecodeFn *)((base) + (off)))    /* 4-byte function-ptr field    */

/* setfont @0x800F2E94 : install font header `fontId` as the current text font.
 * MATCH: the TRUE return type is void -- callers (font.cpp `setfont(f1);`, libfns.h
 * `void setfont(...)`) all discard the result, and the oracle does NOT preserve `decode`
 * across the trailing blockclear()/inittextdraw() calls (v0 is caller-saved and clobbered by
 * both, with nothing restoring it before `jr ra`) -- a `DecodeFn`-returning reconstruction
 * forces gcc to needlessly park `decode` in a saved reg across those 2 calls (+frame, wrong
 * scheduling). Ghidra typed it non-void; this is the mirror-image of the §3.2 void-return bug. */
extern void setfont(int fontId);   /* @0x800F2E94 */

extern void setfont(int fontId)
{
    unsigned char *cf;
    unsigned char *cf2;
    unsigned char *shape;
    DecodeFn       decode;
    int            depth;

    /* Oracle loads the shape offset in the prologue, before copying any metrics. */
    cf            = currentfont;
    shape         = (unsigned char *)(fontId + *(int *)(fontId + 0x1c));
    CFI(cf, 0x7c) = 100;
    CFI(cf, 0x0c) = (int)*(signed char *)(fontId + 0x10);
    CFI(cf, 0x10) = (int)*(signed char *)(fontId + 0x11);
    CFI(cf, 0x1c) = (int)*(signed char *)(fontId + 0x12);
    CFI(cf, 0x20) = (int)*(signed char *)(fontId + 0x13);
    CFI(cf, 0x24) = (int)*(signed char *)(fontId + 0x13) + (int)*(signed char *)(fontId + 0x12);
    CFI(cf, 0x28) = (int)*(signed char *)(fontId + 0x13) + (int)*(signed char *)(fontId + 0x12);
    CFI(cf, 0x74) = (int)*(unsigned short *)(fontId + 10);
    CFI(cf, 0x18) = 1;
    CFI(cf, 0xb0) = 0;
    CFI(cf, 0xac) = 0;
    CFI(cf, 0x80) = fontId;
    CFP(cf, 0x88) = shape;
    CFI(cf, 0x84) = fontId + *(int *)(fontId + 0x14);
    CFI(cf, 0x14) = shapedepth(shape);
    depth         = shapedepth(shape);
    CFI(cf, 0x78) = (int)((unsigned int)(*(short *)(shape + 4) * depth + 0x1f) & 0xffffffe0) >> 3;

    /* ==== w33-a5 (2026-07-26): 84 -> 14 diffs.  THE s1<->s2 SWAP IS SOLVED. ====================
     * The w32 note below concluded "only a ref-count or live-length change flips it" and stopped
     * there.  A live-length change WAS available, and it is one statement.
     *
     * DIAGNOSIS (cc1 `-dl` local-alloc dump -- it prints the numbers directly, no guessing):
     *     Register 80 used 17 times across 106 insns; crosses 2 calls;            <- fontId
     *     Register 81 used 19 times across 144 insns; crosses 3 calls; pointer;   <- currentfont
     * gcc-2.8 global.c orders allocnos by floor_log2(refs)*refs*size/live_length and hands out
     * REG_ALLOC_ORDER (s0,s1,...) in that order, so the s-number IS the priority rank:
     *     fontId      4*17/106 = 0.642   -> wins s1
     *     currentfont 4*19/144 = 0.528   -> gets s2      (retail is the other way round)
     * The reference counts are ALREADY retail's instruction-for-instruction, so refs cannot move;
     * `-dg` confirms the sorted order "122 83 80 81".  currentfont needed live_length < 118.
     *
     * THE FIX: `cf` was live 38 insns longer than fontId for ONE reason -- it carried the trailing
     * `currentfont[0xA0] = decode` store, which sits AFTER the whole decoder-selection tree, while
     * fontId dies at the `geti(fontId+0x20,...)` call inside it.  The oracle materializes a SECOND
     * &currentfont for the tail block anyway (`lui $s0,%hi(currentfont)` right after that store), so
     * moving the 0xA0 store onto THAT pointer -- assigning `cf2 = currentfont;` at the `decoded:`
     * join -- ends `cf`'s range at the 0x78 store, drops it under fontId's, and the whole function
     * re-colors to retail's map (currentfont->$s1, fontId->$s2, shape->$s0) in one edit: 84 -> 14.
     * Costs nothing: the same 3 instructions are emitted, only their ORDER inside the join block
     * changes (ours materializes then stores; retail stores then materializes = 2 of the 14).
     * REJECTED on the way (all diff-neutral at 84): 1/2/3 chained copies of `cf` (a global ADDRESS
     * is CSE-propagated, so extra copies add no allocno refs -- unlike a PARAM copy, which does;
     * cf. vramfxya.c same session), and a copy of `fontId` (17 -> 19 refs = 84 -> 94, wrong way).
     * GENERAL RULE worth keeping: to lose a priority compare, move the loser's LAST USE onto another
     * pointer that the oracle already materializes; to win one, add a copy of a PARAMETER.
     *
     * THEN 14 -> 12: the `lhu`-vs-`lh` at fontId+0xE is NOT the old-gcc narrowing after all -- it
     * is the local's TYPE.  A `short flags` local lets combine fold the sign-extend away (only bits
     * 0-1 survive the `& 3`), while declaring it `int flags = *(short *)(fontId + 0xe);` keeps the
     * widening explicit in the source and emits retail's `lh`.  (`(int)flags` in the test, a bare
     * expression, and a separate masked temp all still give `lhu` -- it has to be the LOCAL's type.)
     *
     * RESIDUAL 12, all in the decoder-selection tree, two causes:
     * (a) 10 = the 2-vs-3 `lui/addiu(decodeshiftjis)` materializations (retail never merges
     *     identical tails -- catalog SS-G old-gcc identity) plus the two branch POLARITIES that
     *     fall out of that merge.  Re-tested this session now that the coloring is right, since the
     *     w32 spelling sweep ran under the wrong register map: if/else-if chain, Yoda compares on
     *     both tests, and each arm inverted to an early-out -- all six spellings give exactly 12.
     *     The polarity is downstream of the merge, not a source choice.
     *     w34-a4: FOUR MORE spellings gated, including the one the NFS2 PC-beta named source
     *     suggests, and the merge is unmoved -- nested if/else-if (12), three separate per-arm
     *     temps d1/d2/d3 (12), a 3-level ternary chain (15, 95 insns), and the NFS2 shape where each
     *     arm STORES THE FIELD DIRECTLY with no `decode` temp (56, 98 insns -- the extra store per
     *     arm is itself cross-jumped, so it buys nothing).  NFS2 PC textset.obj's _setfont is a real
     *     structural twin (same three-way decoder pick: `(flags>>0x10 & 3)==2`, then a >0xFF glyph
     *     count, then a >0xFF probe, else the ANSI decoder, followed by a shared init call) and it
     *     writes the decoder GLOBAL in each arm -- but on PSX that spelling is strictly worse, so
     *     retail's PSX source used the `decode` temp + shared store the current form has.
     *     Flags re-measured (none adopted): -mno-split-addresses 27 (95 insns), -fno-schedule-insns
     *     23 (97), -fno-schedule-insns2 26 (98), -fno-delayed-branch 37 (103),
     *     -fno-expensive-optimizations 12.  Mechanism: gcc-2.8 rest_of_compilation's post-reload
     *     `jump_optimize(insns, 1, 1, 0)` runs cross-jumping on HARD registers, and all three
     *     `lui $v0,%hi(sjis); addiu $v0,$v0,%lo(sjis); j join` blocks are byte-identical there, so
     *     they always merge; there is no gcc-2.8 flag for it (-fno-crossjumping is gcc-3+).
     * (b) 2 = the 0xA0 store's base (`sw v0,0xA0($s0)` ours vs `$s1` retail) -- the unavoidable
     *     price of the live-range fix above; gcc must emit cf2's lui/addiu before a store through
     *     it, while retail stores through the still-live cf and materializes afterwards.
     *     Net trade: -70 diffs for +2.  Do not "fix" this back.
     * ---- w32 note (still accurate for the residual) -------------------------------------------
     * The 4-instruction gap is ONE thing: retail emits THREE separate
     * `lui/addiu %hi/%lo(decodeshiftjis)` materializations (one per arm, each `lui` in its branch's
     * delay slot + `j`/`addiu` pair), while our cc1 TAIL-MERGES arms 2+3 into one block and shares the
     * `addiu` with arm 1.  Falsified this session: -fno-thread-jumps, -fno-cse-follow-jumps,
     * -fno-expensive-optimizations, -fno-rerun-cse-after-loop and -O1 ALL still emit 2 luis, and no
     * source spelling (goto/label tree, nested if/else, explicit case 3 -- all previously tried)
     * changes it.  Same signature as the second residual: the `flags & 3` test loads `fontId+0xe`
     * with `lh` in retail and `lhu` here (gcc narrows the sign-extend away because only bit 0-1
     * matter; `int flags`, a direct expression, and a masked temp all still give `lhu`).  Both are
     * the documented per-obj OLD-GCC identity class (catalog section G: retail never merges identical
     * tails / weaker combine), NOT a source problem -- do not re-fight without a toolchain change.
     * (The w32 claim that the s1<->s2 swap was forced by this is WRONG -- see the w33 note above;
     * the swap was an independent live-range effect and is now fixed.) */
    {
        int flags = *(short *)(fontId + 0xe);
        if ((flags & 3) != 2)
            goto notsjis;
        decode = decodeshiftjis;                                  /* explicit Shift-JIS flag */
        goto decoded;

    notsjis:
        if (CFI(cf, 0x74) >= 0x100) {
            decode = decodeshiftjis;                              /* large table => multi-byte */
            goto decoded;
        }
        /* small glyph table: probe the encoded stream -- ANSI if the first code is < 0x100 */
        if (geti((void *)(fontId + 0x20), 2) >= 0x100) {
            decode = decodeshiftjis;
            goto decoded;
        }
        decode = decodeansi;
    }
decoded:
    cf2 = currentfont;
    CFFN(cf2, 0xa0) = decode;

    /* MATCH: the oracle RE-MATERIALIZES `&currentfont` into a fresh reg here instead of reusing
     * the still-live `cf` -- a 2nd local pointer reproduces that separate lui/addiu.
     * w33-a5: that SAME second pointer now also carries the 0xA0 decoder store (assigned at the
     * `decoded:` join above).  See the header note: it is what ENDS `cf`'s live range early enough
     * for currentfont to outrank fontId in the allocno priority compare -- 84 -> 14 diffs. */
    {
        CFI(cf2, 0x2c) = 0;
        CFI(cf2, 0x30) = 0;
        CFI(cf2, 0xb4) = 0;   /* oracle: this store sits in blockclear's DELAY slot => it precedes
                               * the call in source order; after the call gcc steals it for the
                               * inittextdraw slot instead and the oracle's `jal; nop` is lost. */
        blockclear(cf2 + 0x34, 0x40);                            /* @0x80135BD4 : clear 0x40-byte blit state */
        inittextdraw();
        CFI(cf2, 0xa4) = 0;
    }
}
