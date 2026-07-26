/* eaclib/psx/eacpsxz/vramfxya.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\vramfxya.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 360607).
 *   3 fns: checkrect @0x800F6934 (44 B), vramimage @0x800F6960 (72 B), vramfxya @0x800F69A8 (660 B).
 *   FX-A shape -> VRAM uploader: walks a shape's chunk chain and DMAs each bitmap chunk (tags 0x40..0x43)
 *   and CLUT chunk (tags 0x22/0x23/0x24) into VRAM at the requested (x,y).  CLUT chunks are colour-reduced
 *   to 15-bit BGR on the way (>>1 for 0x22, >>3 for 0x24; 0x23 uploads the raw words unchanged).
 *   Ghidra nfs4-f.exe.c (all 3) + disasm-v3 (vramfxya: IDA sig recovers the 5 dropped reg/stack args;
 *   the compiler jump table @0x80056FD8 is rendered as a plain switch) + IDA sigs.  Plain C -> extern "C".
 *
 *   Shape chunk header (uint* `c`):
 *     c[0]  : low byte = tag; bits 8.. = byte offset to next chunk (0 in the high 24 bits => end of chain)
 *     c[1]  : low short = entry/pixel count
 *     c[3]  : packed VRAM xy = (c[3] & 0xf000f000) | x&0xfff | (y&0xfff)<<16
 *     c+4   : pixel / CLUT source data; CLUT entries are 3 bytes (R,G,B) at byte offsets 0x10,0x11,0x12
 */
typedef unsigned long u_long;
typedef struct { short x, y, w, h; } RECT;

extern int   shapedepth(unsigned char *shape);   /* shpdepth */
extern void  LoadImage(RECT *rect, u_long *data); /* PsyQ libgpu */
extern int   drawpending;                         /* primate */

extern unsigned int checkrect(int rectp);                         /* @0x800F6934 */
extern int  vramimage(RECT *rect, u_long *data);                  /* @0x800F6960 */
extern void vramfxya(int shapep, int imgX, int imgY,
                         int clutX, int clutY);                       /* @0x800F69A8 */

/* checkrect @0x800F6934 : if the RECT is flagged (+4 bit0), set bit0 of the +6 word.  Returns the +4 flag. */
extern unsigned int checkrect(int rectp)
{
    unsigned int flag = *(unsigned short *)(rectp + 4) & 1;
    if (flag != 0) {
        flag = *(unsigned short *)(rectp + 6) | 1;
        *(short *)(rectp + 6) = (short)flag;
    }
    return flag;
}

/* vramimage @0x800F6960 : pre-check the RECT, DMA `data` into VRAM, mark a draw as pending.  Returns 1. */
extern int vramimage(RECT *rect, u_long *data)
{
    checkrect((int)rect);
    LoadImage(rect, data);
    drawpending = 1;
    return 1;
}

/* vramfxya @0x800F69A8 : upload every chunk of shape `shapep` to VRAM.  Bitmap chunks (0x40..0x43) go to
 *   (imgX,imgY); CLUT chunks (0x22/0x23/0x24) go to (clutX,clutY). */
extern void vramfxya(int shapep, int imgX, int imgY, int clutX, int clutY)
{
    unsigned int *c = (unsigned int *)shapep;
    struct {
        RECT rect;
        unsigned int clut22[128]; /* >>1 BGR scratch */
        unsigned int clut24[131]; /* >>3 BGR scratch */
        unsigned int *clut22p;
    } scratch;

    if (c == (unsigned int *)0)
        return;

    /* clutX/clutY are loop-invariant (fixed params) -- the oracle hoists their masked/shifted forms
     * OUT of the loop (computed once, reused every CLUT-tail hit) rather than remasking each time.
     * The two AND-mask constants used by the packed-xy update (below, in both the bitmap block and
     * the CLUT tail) are ALSO shared/hoisted the same way -- named here so gcc materializes each
    * ONCE and reuses it at both write sites instead of rematerializing per-site. */
    {
    /* RAW/ORACLE (w32-a5 2026-07-26: 93 -> 80 diffs and INSTRUCTION PARITY reached, 165/165).
     * Two levers, both from the IDA per-variable register map of sub_800F69A8:
     *  (1) DECLARATION ORDER = param copies FIRST, derived mask constants LAST.  Retail's prologue
     *      copies a1..a3/stack-arg into saved regs before computing any mask (so the params have the
     *      LONGEST live ranges = lowest allocno priority = the high-numbered saved regs s5..fp, and
     *      the short-lived masks win s1..s4).  Declaring maskLo first cost one extra instruction.
     *  (2) the two CLUT convert loops are LABEL+GOTO loops, not do-while: as a do-while, loop.c
     *      strength-reduces the three byte givs onto the LAST one in body order (src[0x10]) and
     *      rebases the pointer to `c+16` with displacements 2/1/0; retail keeps base `c` with
     *      displacements 16/17/18, i.e. loop.c never ran (catalog SS-B goto-loop / giv-anchor).
     * ------------------------------------------------------------------------------------------
     * w33-a5 (2026-07-26): 80 -> 68 diffs, parity held 165/165, via the PARAM-COPY REF-COUNT LEVER,
     * and the residual is now QUANTITATIVELY closed out as a toolchain identity (not a source miss).
     *
     * METHOD -- read the allocation instead of guessing it.  `cc1 -dg` on the preprocessed TU prints
     * BOTH the priority-sorted allocation order ("N regs to allocate: ...") and the final
     * "Register dispositions", so the whole callee-saved assignment is directly readable.  gcc-2.8
     * global.c sorts allocnos by  floor_log2(n_refs)*n_refs*size / live_length , assigns them in that
     * order, and each takes the first free reg in REG_ALLOC_ORDER (s0,s1,...,s7,fp) -- so the s-reg
     * NUMBER *is* the priority rank.  n_refs is weighted by LOOP DEPTH (flow.c adds `loop_depth` per
     * reference), so an in-loop use counts 2 and a pre-header def counts 1.  That model reproduces our
     * assignment exactly, every variant tried:
     *     no copies : {maskLo,imgX,imgY}=5 refs(pri 10) > {clutX,clutY}=4(8) > {clutXm,clutYm}=3(3)
     *                 -> s2..s4 img/mask, s5/s6 clut, s7/fp clutXm/clutYm   (84 diffs)
     *     all four copied (w32 form): the copy insn adds a def+use, so all four params reach 7 refs
     *                 and outrank maskLo -> params take s2..s5                (80 diffs)
     * A LOCAL COPY OF A PARAM IS THEREFORE A PURE PRIORITY DIAL (+2 weighted refs, no code change --
     * gcc coalesces the copy away).  Exhaustively enumerating all 16 subsets of {ix,iy,cx,cy} copies:
     *     {} 84 | {ix} 82 | {iy} 82 | {cy} 82 | {cx} 76 | {ix,cx} 68 | {iy,cx} 68 | {ix,iy} 74 |
     *     {ix,cy} 74 | {iy,cy} 74 | {cx,cy} 74 | {ix,iy,cx} 74 | rest 80.
     * {ix,cx} (kept below) puts maskHi->s1, maskLo->s4, clutY->s6 and c->s0 on retail's registers.
     *
     * RESIDUAL 68 = REGISTER PERMUTATION ONLY (no instruction-shape diffs; 165/165):
     *   ours   {c s0, maskHi s1, imgX s2, clutX s3, maskLo s4, imgY s5, clutY s6, clutYm s7, clutXm fp}
     *   retail {c s0, maskHi s1, clutYm s2, clutXm s3, maskLo s4, clutX s5, clutY s6, imgX s7, imgY fp}
     * PROOF THAT NO SOURCE FORM REACHES RETAIL'S ORDER: the reference COUNTS are already identical to
     * retail's instruction-for-instruction (imgX/imgY/maskLo each have 1 def + 2 in-loop uses;
     * clutXm/clutYm 1 def + 1 in-loop use), and both clutXm/clutYm and maskLo are defined in the same
     * pre-header and die within 4 insns of each other in the CLUT tail, so their live_lengths differ
     * by ~1%.  Retail nevertheless ranks clutYm/clutXm (3 weighted refs) ABOVE maskLo (5) and imgX (5).
     * Under this cc1's formula that requires live_length(clutXm) < 0.3*live_length(maskLo), which the
     * shared pre-header/tail placement makes impossible.  ==> retail's cc1 ranks a short-lived
     * constant-initialised local ABOVE an equally-live param copy, i.e. this is a 5th exhibit of the
     * suspected ALLOCNO_COMPARE DELTA already banked for sbdload/purge/start/serve (catalog SS-G,
     * "retail allocates constant-init short-lived locals into EARLIER callee-saved regs").  Route to
     * the toolchain-identity investigation; do NOT re-fight from source.
     * w34 follow-up (post-movfxya): the DEAD-SET carrier (movfxya lever) does NOT dial refs here --
     * `clutXm = 0; clutXm = real;` with the param dials removed gates 84 (= the plain {} form).
     * Mechanism boundary now precise: loop.c COUNTS a dead set (set_in_loop, blocks move_movables)
     * but REG_N_REFS is computed in flow AFTER dead-code deletion, so the deleted set adds NOTHING
     * to allocno priority.  The dead-set device is a HOIST BLOCKER only, never a priority dial.
     * The 68 allocno_compare-delta floor therefore survives today's new levers too.
     * Also tried and rejected this session: all 6! declaration orders of the local block (no effect --
     * decl order only breaks allocno-number TIES, and here no two priorities tie), and 1- and 2-deep
     * COPY CHAINS on clutXm/clutYm to raise THEIR ref counts instead (68 with the param copies, 84
     * without -- a copy of a COMPUTED value is folded away before life analysis, so unlike a copy of
     * an incoming PARAMETER it is not a priority dial; same negative result as setfont.c's chained
     * copies of a global address).  Exact allocno arithmetic for the kept form, from `cc1 -dl`
     * ("Register N used R times across L insns"), which reproduces the observed s-order exactly:
     *   c 52/132=1.97 | maskHi 5/129=.0775 | imgX 5/131=.0763 | clutX 4/127=.063 | maskLo 5/260=.0385
     *   | imgY 5/268=.037 | clutY 4/266=.030 | clutYm 3/124=.0242 | clutXm 3/126=.0238
     * ------------------------------------------------------------------------------------------
     * w34-a4 2026-07-26 -- THE PROTOTYPE-CONDITIONAL RE-CHECK IS DONE; THE FLOOR HOLDS AT 68.
     * The w33 verdict above is a "no source form reaches retail's allocno order" claim, and the w33
     * epistemics rule says a floor is EVIDENCE-SOURCE-conditional and must survive a prototype audit
     * (args + return + PARAMETER WIDTH).  IDA types this function
     *     void __fastcall sub_800F69A8(int a1, __int16 a2, __int16 a3, __int16 a4, __int16 a5)
     * i.e. all FOUR coordinates as `short`, which is exactly the w33 NARROW-PARAM lever (a param
     * narrower than the ABI-promoted mode has its parm copy deferred into assign_parms'
     * conversion_insns, reordering the prologue and flipping sched2's luid ties -- it took
     * CdReadyHandler to PASS).  FALSIFIED HERE, exhaustively: all 16 subsets of
     * {imgX,imgY,clutX,clutY} declared `short` were gated --
     *   () 68 | (imgX) 69 | (imgY) 78 | (clutX) 85 | (clutY) 79 | (imgX,imgY) 79 | (imgX,clutX) 86
     *   | (imgX,clutY) 80 | (imgY,clutX) 81 | (imgY,clutY) 89 | (clutX,clutY) 88
     *   | (imgX,imgY,clutX) 82 | (imgX,imgY,clutY) 90 | (imgX,clutX,clutY) 89
     *   | (imgY,clutX,clutY) 84 | (all four) 85
     * -- EVERY narrowing is worse, and every one that touches an $a-register param also ADDS
     * instructions (166-168 vs the oracle's 165), whereas the `int` form is count-EXACT 165/165.
     * A short param would need a widening `sll/sra` (or an `andi`) the oracle does not have, so the
     * retail prototype is `int` and IDA's `__int16` is a use-site inference from the `& 0xfff` masks
     * and the `sh` RECT stores.  ==> prototype audit CLEAN; the 68 stays a STRONG allocno_compare
     * floor.  Also re-measured (not adopted): -mno-split-addresses 67 diffs but 164/165 insns (loses
     * the exact parity), -fno-expensive-optimizations 88, -fno-schedule-insns 152,
     * -fno-schedule-insns2 89 (+10 on vramimage), -fno-delayed-branch 106 (+9 on vramimage).  */
    int ix = imgX;                          /* +2 weighted refs -> priority dial only, see above  */
    int cx = clutX;                         /* (gcc coalesces both copies away; 0 insns added)     */
    unsigned int maskLo  = ~0xFFFu;         /* clears the low 12 bits (x field) */
    unsigned int maskHi  = 0xF000FFFFu;     /* clears bits 16-27 (y field) */
    unsigned int clutXm  = (unsigned int)clutX & 0xfff;
    unsigned int clutYm  = ((unsigned int)clutY & 0xfff) << 0x10;
    scratch.clut22p = scratch.clut22;
    do {
        u_long        *data;
        int            i;
        unsigned short *dst;
        unsigned char  *src;
        unsigned int  *next;
        RECT          *rectp;

        switch ((unsigned char)*c & 0xf7) {
        case 0x40:
        case 0x41:
        case 0x42:
        case 0x43:                                   /* bitmap chunk -> (imgX,imgY) */
            {
                int bits, w;
                /* the retail c[3] packed-xy update is TWO sequential mask/insert passes (clear the
                 * low 12 bits and OR in x, THEN clear bits 16-27 and OR in y<<16) -- not one combined
                 * `& 0xf000f000` mask; the oracle materializes and shares 2 distinct AND-mask
                 * constants (~0xFFF, 0xF000FFFF) across both this site and the CLUT-tail site below. */
                c[3] = (c[3] & maskLo) | ((unsigned int)ix & 0xfff);
                c[3] = (c[3] & maskHi) | (((unsigned int)imgY & 0xfff) << 0x10);
                *(unsigned char *)c = (unsigned char)*c | 8;
                scratch.rect.x = ix;
                scratch.rect.y = imgY;                 /* H04: was missing (oracle 0x800F6A80 *(short*)(18+sp)=imgY) */
                bits   = (short)c[1] * shapedepth((unsigned char *)c);
                w      = bits + 0xf;
                if (w < 0)
                    w = bits + 0x1e;
                scratch.rect.w = (short)(w >> 4);    /* width in 16-bit VRAM words */
                scratch.rect.h = *(short *)((int)c + 6);
                data   = (u_long *)(c + 4);
                vramimage(&scratch.rect, data);
            }
            goto walk;

        case 0x23:                                   /* raw CLUT words */
            rectp = &scratch.rect;
            data = (u_long *)(c + 4);
            break;

        case 0x22:                                   /* CLUT, 8->5 bit via >>1 */
            i   = 0;
            if (0 < (short)c[1]) {
                dst = (unsigned short *)scratch.clut22p;
                src = (unsigned char *)c;
            clut22loop:
                *dst++ = (unsigned short)(src[0x12] >> 1) << 10 |
                         (unsigned short)(src[0x11] >> 1) << 5 |
                         (unsigned short)(src[0x10] >> 1);
                src += 3;
                i += 1;
                if (i < (short)c[1])
                    goto clut22loop;
            }
            rectp = &scratch.rect;
            data = (u_long *)scratch.clut22;
            break;

        case 0x24:                                   /* CLUT, 8->5 bit via >>3 */
            i = 0;
            if (0 < (short)c[1]) {
                dst = (unsigned short *)scratch.clut24;
                src = (unsigned char *)c;
            clut24loop:
                *dst++ = (unsigned short)(src[0x12] >> 3) << 10 |
                         (unsigned short)(src[0x11] >> 3) << 5 |
                         (unsigned short)(src[0x10] >> 3);
                src += 3;
                i += 1;
                if (i < (short)c[1])
                    goto clut24loop;
            }
            rectp = &scratch.rect;
            data = (u_long *)scratch.clut24;
            break;

        default:                                     /* 0x25 etc.: nothing to upload */
            goto walk;
        }

        /* common CLUT tail (0x22/0x23/0x24) -> (clutX,clutY) */
        c[3] = (c[3] & maskLo) | clutXm;
        c[3] = (c[3] & maskHi) | clutYm;
        *(unsigned char *)c = (unsigned char)*c | 8;
        scratch.rect.x = cx;
        scratch.rect.y = clutY;                     /* H04: was missing (oracle 0x800F6BC4 *(short*)(18+sp)=clutY) */
        scratch.rect.w = (short)c[1];
        scratch.rect.h = 1;
        vramimage(rectp, data);

    walk:
        if ((*c & 0xffffff00) != 0)
            next = (unsigned int *)((int)c + ((int)*c >> 8));
        else
            next = (unsigned int *)0;
        c = next;
    } while (c != (unsigned int *)0);
    }
}
