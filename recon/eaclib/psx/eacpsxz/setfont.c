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

    /* RESIDUAL 84 diffs (w32-a5: 87 -> 84 after moving the 0xb4 store ahead of blockclear, above;
     * ours 96 insns vs oracle 100).  The 4-instruction gap is ONE thing: retail emits THREE separate
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
     * The remaining ~40 diff lines are the s1<->s2 swap this forces: retail colors currentfont ->
     * $s1 and fontId -> $s2, ours the reverse; the cc1 -dl allocno table shows fontId at 17 refs /
     * 106 insns vs currentfont at 19 / 144, i.e. fontId legitimately wins the priority compare here
     * and only a ref-count or live-length change flips it. */
    {
        short flags = *(short *)(fontId + 0xe);
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
    CFFN(cf, 0xa0) = decode;

    /* MATCH: the oracle RE-MATERIALIZES `&currentfont` into a fresh reg here instead of reusing
     * the still-live `cf` -- a 2nd local pointer reproduces that separate lui/addiu. */
    {
        unsigned char *cf2 = currentfont;
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
