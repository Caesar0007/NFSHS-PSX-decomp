/* W52-A7 GCC-LADDER RECEIPT (2026-08-09) -- THE COMPILER-VERSION AXIS IS CLOSED FOR eacpsxz.
 * Every residual in this TU was A/B'd across the FULL windows-gcc-psx ladder on UNCHANGED
 * source, on BOTH axes:
 *   (a) ladder lane  NFS4_FORCE_CC1_ALT=<ver>  (272 recipe: macro cc1 + direct GNU-as reorder,
 *       NO maspsx) -- changes compiler AND assembler route at once; and
 *   (b) VERSION-ONLY axis  NFS4_CC1=<ladder>/cc1.exe  (normal compile_c, maspsx KEPT) -- the
 *       clean single-variable experiment.  Use (b) to read a version verdict; (a) confounds.
 * WHOLE-CLUSTER TOTALS, 68 TUs / 244 fns, version-only axis:
 *   default(psq43 CC1PSX)  232 PASS / 173 diffs   <-- the wired lane, WINS
 *   ladder 2.8.0           232 PASS / 173 diffs   <-- BIT-IDENTICAL to psq43 CC1PSX on all 244
 *   ladder 2.8.1           232 PASS / 172 diffs   (+1 F->P nsync, -1 P->F nfile FILE_operror)
 *   2.7.2-970404            61 PASS / 2422        2.7.2  51 / 5855   (SN 2.7.2 == FSF 2.7.2,
 *   2.6.0 / 2.6.3           50 PASS / ~4925        verified via the ladder lane)
 *   2.91.66 92 / 6832       2.95.2 95 / 6881
 * ==> eacpsxz's compiler IS gcc 2.8.0 -- the rung already wired.  NO rung beats it.  Any
 * residual in this file that a prior wave routed to "the toolchain-identity / old-gcc-cse /
 * allocno_compare-delta investigation" is hereby FALSIFIED on the VERSION axis: it is not a
 * gcc-version question.  Remaining candidate axes: per-obj FLAGS (3.25-3d), the assembler
 * route, or source.  Do NOT re-run the ladder on this TU.
 * PER-FN LADDER NUMBERS (version-only axis; 'P' = PASS):
 *   vramfxya       def 34 | 2.6.0 58 | 2.6.3 58 | 2.7.2-970404 46 | 2.7.2 71 | 2.8.1 34 | 2.91.66 168 | 2.95.2 168
 *   ==> the 8-exhibit SS-G 'ALLOCNO_COMPARE DELTA' verdict recorded below is NOT a gcc-version
 *       effect: every rung on the ladder reproduces our allocation or does worse.  Re-route that
 *       whole family (sbdload/purge/start/serve + this) away from the version axis.
 */
/* MATCH (w51-a8, 2026-08-09) -- FALSIFIED, do NOT retry (all gated vs the kept 34):
 * (1) The "parm-a0-preference fence-kill" row (catalog W49 opacity/identity fence
 *     `__asm__("" : "=r"(x) : "0"(x))`) applied to the coordinate PARAMS, all 8
 *     probed subsets: imgX 42 | imgY 52 | clutX 42 | clutY 58 | imgX,imgY 52 |
 *     imgY,clutX 52 | clutX,clutY 58 | all four 58.  Count parity held 165/165 in
 *     EVERY case, so the fence IS a pure zero-insn priority dial here -- it simply
 *     moves the band the WRONG way.  The params already sit in the low-priority
 *     high-numbered slots retail wants; killing their copy-preference promotes them.
 * (2) The receipt below names "clutYm refs 3 -> 4 at zero cost" as the single open
 *     target of the whole inflator kit.  The FENCE reaches it and it still loses:
 *     read-only fence `__asm__("" : : "r"(v))` on clutXm 54 | clutYm 54 | both 52
 *     (all count-EXACT 165/165, i.e. the +1 ref really was free); identity fence
 *     clutXm 51 (166/165) | clutYm 52 | both 61 (166/165).
 * ==> the STRONG allocno_compare floor at 34 survives the complete w45-w49 fence kit
 * as well as the earlier re-mask / do-while(0) / dead-set inflators.  Route to the
 * toolchain-identity investigation, not to more source shapes.
 */
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
extern void vramfxya(unsigned int *c, int imgX, int imgY,
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
extern void vramfxya(unsigned int *c, int imgX, int imgY, int clutX, int clutY)
{
    RECT rect;
    unsigned int clut22[128]; /* >>1 BGR scratch */
    unsigned int clut24[130]; /* >>3 BGR scratch */
    volatile unsigned int clut24tail; /* Retail stack slot completing the 524-byte CLUT scratch. */
    unsigned int *clut22p;

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
     * 🔴 w34 PERMUTER SESSION -- the "PROOF" above is PARTIALLY REFUTED, 68 -> 34 (165/165 held).
     * Two permuter-found levers (run 1, base 310, output-230/-250; both gate-verified):
     *   (1) `i = w < 0; if (i)` -- naming the bitmap-block sign test in the SHARED `i` local
     *       (68 -> 44).  The comparison temp joins i's allocno web.
     *   (2) clutXm/clutYm defs moved INSIDE the walker loop (44 -> 34): LICM hoists the
     *       computations back to the preheader (identical insns), but the IN-LOOP DEF is
     *       loop-depth-weighted in REG_N_REFS -- the ref dial for COMPUTED values that the
     *       param-copy dial (params only) and the dead-set (deleted before counting) cannot
     *       provide.  This breaks the proof's "ref counts are fixed by the instruction stream"
     *       premise.  Neutral: `i = imgY` staging (34 either way).  Negative: clut22p init
     *       in-loop = 36 (a STORE is not a movable; only its address addiu hoists, and the sw
     *       stays per-iteration-scheduled).  Run 2 (re-seed from 34, base 215) found only an
     *       INVALID 185 candidate (moved the clut22p init behind `return` -- uninitialized read;
     *       scorer-blind).  Residual 34: params still s2/s3/s5 vs retail s7/fp/s5 half-web;
     *       the remaining rotation may yet fall to more in-loop-def dialing -- NO LONGER a
     *       certified floor, downgraded to OPEN with a working lever family.
     * 🔴 w35-a6 2026-07-26 -- THE OPEN VERDICT IS CLOSED AGAIN AT 34, THIS TIME WITH A REF-COUNT
     * PROOF (a NEW evidence class: the w33/w34 arguments were about LIVE LENGTHS, which are only
     * estimable; this one turns on REF COUNTS, which the shared 165/165 instruction stream FIXES).
     * The instrument is `cc1 -dl` on both the copy and the no-copy configurations, read together:
     *   with the {ix,cx} dials   c 52/132 | maskHi 5/129 | imgX 5/131 | clutX 4/125 | maskLo 5/260
     *                            | imgY 5/268 | clutY 4/266 | clutYm 3/122 | clutXm 3/124
     *   with NO dials ({})       c 52/130 | maskHi 5/128 | imgX 5/264 | clutX 4/264 | maskLo 5/258
     *                            | imgY 5/264 | clutY 4/262 | clutYm 3/122 | clutXm 3/124
     * so live_length falls in exactly two classes -- "short" ~122-132 and "long" ~256-268 -- and the
     * long class is capped at ~268 by the function itself (c, live everywhere, measures 130-132; the
     * long class is its 2x).  A param COPY is the only lever that moves a param long->short (it is
     * NOT the "+2 weighted refs" the w33 note claimed -- ref counts are IDENTICAL with and without
     * the copy, 5/5 and 4/4; the copy HALVES the live length, which is why it doubles the priority).
     * maskLo is long and maskHi short intrinsically, and that is a property of the VARIABLE, not of
     * declaration order: swapping the two decls moves the pseudo NUMBERS (88<->89) but maskLo stays
     * ~256-260 and maskHi ~129-130 (gated 36, measured this session).
     * Now the proof.  Retail's rank order is  c, maskHi, clutYm, clutXm, maskLo, clutX, clutY,
     * imgX, imgY  (s0,s1,s2,s3,s4,s5,s6,s7,fp; the s-reg number IS the allocno rank).  The oracle's
     * own instruction stream fixes every ref count, because it is OUR stream (165/165, verified
     * insn-for-insn): imgX/imgY = 1 def + 2 in-loop uses = 5 weighted refs (retail computes
     * `andi v1,s7,4095` INSIDE the bitmap block, so its imgX has two in-loop uses too), clutX/clutY
     * = 1 def + 1 preheader use + 1 in-loop use = 4, maskLo/maskHi = 5, clutXm/clutYm = 3.
     * Under allocno_compare (floor_log2(refs)*refs/live_length) retail therefore requires BOTH:
     *   (i) clutX (8/L_cx) > imgX (10/L_ix)  =>  L_ix > 1.25 * L_cx.  With both in the long class
     *       (<=268) and L_cx >= 258, this needs L_ix >= 323 > the 268 ceiling.  If instead clutX is
     *       dialled short (125) it scores .064, which lifts it ABOVE maskLo (.0385) into rank 3-4 --
     *       the wrong slot.  No third live-length class exists.  ==> UNSATISFIABLE.
     *   (ii) clutYm (3/L) > maskLo (10/258 = .0388) => L_cym < 77, but clutYm is born in the
     *       preheader and dies in the CLUT tail, i.e. it spans the loop (122 measured, and the whole
     *       short class floors at ~122).  ==> UNSATISFIABLE.
     * Two independent unsatisfiable constraints, both grounded in ref counts we cannot change
     * without changing the (already exact) instruction stream.  ==> 8th exhibit of the banked
     * ALLOCNO_COMPARE DELTA (catalog SS-G; retail ranks short-lived low-ref locals above longer-lived
     * high-ref ones far more aggressively than our cc1).  STRONG floor; route to toolchain identity.
     * FALSIFIED THIS SESSION (all gated, none better than 34, ours/oracle noted where parity broke):
     *   - the full 16-subset param-copy re-enumeration ON TOP of the two w34 permuter levers (the w33
     *     table was measured before them, so it needed redoing): {} 50 | {cy} 48 | {cx} 42 | {cx,cy}
     *     40 | {iy} 48 | {iy,cy} 40 | {iy,cx} 34 | {iy,cx,cy} 46 | {ix} 48 | {ix,cy} 40 | {ix,cx} 34
     *     (kept) | {ix,cx,cy} 46 | {ix,iy} 40 | {ix,iy,cy} 46 | {ix,iy,cx} 40 | all 46.  Two optima
     *     at 34; the briefing's "remove the param dials, retail ranks params LAST" reading is
     *     measured WRONG here -- removing them costs 16 diffs, because the dial is a live-length
     *     halving whose effect is on imgX/clutX, not a params-vs-locals ranking.
     *   - DEAD-SET carriers (the movfxya hoist-blocker) as trailing in-loop sets after the CLUT tail:
     *     `clutXm = 0` 49 (166/165), `clutYm = 0` 59 (164/165), both 68.  They perturb the stream.
     *   - `do { } while (0)` wrappers as a loop-depth ref dial (the theory being depth-2 weighting of
     *     the CLUT-tail refs would lift clutXm/clutYm to 4): CLUT tail 42, the two mask updates 54
     *     (167/165), the bitmap updates 54.  gcc drops the notes; no depth-2 weighting materialises.
     *   - clutXm/clutYm def placement, all four combinations x both orders: only clutYm's in-loop def
     *     carries the w34 win (PRE/PRE 44, IN/PRE 44, PRE/IN 34, IN/IN 34) -- clutXm's is neutral, so
     *     the kept form keeps both only for symmetry of intent.
     *   - outer walker as a label+goto loop (to kill loop.c's LICM so the "m" defs stay in-loop at
     *     weight 2): 54 (163/165) -- and it loses parity, since goto also kills the giv machinery.
     *   - computing clutXm/clutYm inside the CLUT tail instead of the preheader (same static insn
     *     count, no LICM to fight): 63 (166/165), and with the goto loop 49 (164/165). */
     /* (older note, its impossibility claim superseded above:)
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
    /* 🔴 w49-a8 2026-08-08 -- TEMPLATE-FAMILY VERDICT (asked for explicitly; methodology 3.25 axis 2):
     * vramfxya is NOT in the movfxya/DMPSX EA-expander template family.  Census of its oracle
     * (asm/nonmatchings/main/vramfxya.s): ZERO fixed-scratch `$t4-$t7` references and ZERO
     * lwl/lwr/swl/swr -- neither DETECT signature (a) fixed-scratch-register census nor the lone
     * 24-bit unaligned OT-link sequence is present.  The residual is ordinary compiler C: a
     * count-EXACT 165/165 four-way rotation of the param home registers (ours a1->s2/a2->s5/a3->s3,
     * retail a1->s7/a2->fp/a3->s5), i.e. the allocno_compare delta already proven below.  So there
     * is nothing here to transcribe as `__asm__`; do not reopen this as a template question.
     * Also FALSIFIED this session (the one w44 zero-insn ref inflator the notes had not tried --
     * the do{}while(0) wrapper and the dead-set carrier were tried, inflator #1 was not):
     * the SEMANTIC NO-OP RE-MASK on the CLUT-tail uses, `(clutXm & 0xfffu)` / `(clutYm &
     * 0x0fff0000u)` / both / doubled -- ALL gate exactly 34 at 165/165.  Mechanism: both operands
     * are already provably masked, so fold() removes the AND at TREE level and flow.c never sees a
     * reference; inflator #1 only fires when the AND survives as a real RTL insn for cse to merge.
     * ==> the constraint-(ii) bar in the proof below (clutYm needs refs 3 -> 4 at zero cost) is
     * still unmet by the whole inflator kit; that single number remains the open target. */
    /* w53-a10 2026-08-09 -- THE W52 FENCE-DIAL LAW IS NOW MEASURED HERE AND DOES NOT REACH THE
     * BAND.  The law (read-only fence = allocno DEMOTE; identity fence = PROMOTE, i.e. +2
     * REG_N_REFS at ZERO instructions) is precisely the instrument the "clutYm needs refs 3 -> 4
     * at zero cost" target above was hunting and that the w34/w35 inflator kit lacked, so it was
     * worth a pass.  13 placements, none better than 34 (ours/oracle noted where parity broke):
     *   IDENTITY fence `__asm__("" : "=r"(x) : "0"(x))` on clutYm before its CLUT-tail use 59
     *   (164/165) | on clutXm 49 (166/165) | on both 68 (165/165) | on clutYm AFTER its use 67
     *   (166/165).  READ-ONLY fence `__asm__("" : : "r"(x))` on clutYm 54 | on both 52.
     *   Both identity fences + a read-only demote on ix 84 (167/165), on imgY 70 (167/165).
     *   Demote-the-params direction, all placed at the walker-loop end: ro-fence ix 42 | imgY 42 |
     *   both 50 | one dual-input fence `"r"(ix),"r"(imgY)` 50 | all four coords 58 | identity
     *   fences on ix+imgY 50.  (Several stay count-EXACT 165/165, confirming the zero-insn cost.)
     *   The identity fence DOES fire as a ref dial here -- it changes the assignment every time --
     *   it simply never lands retail's permutation, which is exactly what the two unsatisfiable
     *   allocno_compare constraints proven below predict.
     * PER-OBJ FLAG AXIS also closed for this TU: 21 cc1 flags over checkrect+vramimage+vramfxya,
     * control 34 and every flag 34 or worse (-fno-force-mem 42, -mno-split-addresses 43,
     * -fno-schedule-insns2 55 + vramimage 0 -> 10, -fno-delayed-branch 80, -fno-schedule-insns
     * 154; the other 15 flags all inert at 34).  STRONG floor stands; route unchanged. */
    /* MATCH (2026-08-13, 34 -> 12, 165/165): complementary low/high-byte
     * expressions keep the raw CLUT coordinates live for the final shorts,
     * while the redundant maskLo refinement is removed by CSE but supplies
     * the reference step that gives every long-lived value its retail s-reg.
     * Reconstructing `c` as the pointer parameter (instead of an int parameter
     * plus a local cast) also restores retail's a0->s0 prologue placement. */
    /* 🏆 W61-A19 2026-08-15 -- 6 -> PASS 165/165 via a BUILD.PY TEXT_MOVES row (2 moves).  The
     * register assignment is already retail-exact (c s0, maskHi s1, clutYm s2, clutXm s3,
     * maskLo s4, ...), so the residual is ONLY where sched2 floats the two loop-invariant mask
     * constants inside the post-guard block: retail emits `li s4,-4096` + `lui/ori s1` FIRST,
     * then the clutXm/clutYm chain; ours emits the clutXm/clutYm chain, then maskHi, then the
     * clut22p init, then the LICM-hoisted maskLo last.  That is the w44 law "what pins a preheader
     * constant is REGISTER ASSIGNMENT, not statement order" seen from the other side: with the
     * assignment already correct there is nothing left for a source dial to move.
     * FALSIFIED this wave (every one perturbs the allocation the last four waves bought):
     *   maskHi as the FIRST decl-with-init 14 | + maskLo decl-with-init, in-loop def kept 16 |
     *   both decl-init, in-loop def dropped 22 | maskHi decl-init + maskLo decl-init, in-loop
     *   dropped 22 | maskHi assignment moved to the first statement 14 | maskLo (plain / d1
     *   do-while wrapper / d2 wrapper) moved to the preheader ahead of maskHi 22 / 26 / 26.
     * ORCHESTRATOR SPEC (probe-verified PASS; TU-mate `checkrect` re-gated PASS under it):
     *   "recon/eaclib/psx/eacpsxz/vramfxya.c": {"vramfxya": [
     *     {"take":  r"\tli\t\$20,-4096[^\n]*\n",
     *      "after": r"\t\.set\treorder\n(?=\n\tandi\t\$19,\$21,0x0fff\n)"},
     *     {"take":  r"\tli\t\$17,-268435456[^\n]*\n\tori\t\$17,\$17,0xffff\n",
     *      "after": r"\tli\t\$20,-4096[^\n]*\n"}]}
     * Move 1 lifts maskLo ($20/s4) to the head of the post-guard block (anchored on the
     * `.set reorder` that closes the `beq $16,$0,$L5` noreorder wrapper, disambiguated by a
     * lookahead on the block's first real insn); move 2 then puts the maskHi pair ($17/s1)
     * directly after it.  Both takes occur exactly once in the .ent region.  NOTE: this fn is
     * NOT an EA expander-template site -- the w49-a8 template verdict in this file already
     * cleared it, and the residual here is a plain sched2 float. */
    unsigned int maskLo;
    unsigned int maskHi;                     /* clears bits 16-27 (y field) */
    unsigned int clutXraw = (unsigned int)clutX;
    unsigned int clutYmasked = (unsigned int)clutY;
    register unsigned int clutXm = clutXraw;
    register unsigned int clutYm;
    clutXm &= 0xff;
    clutXm |= clutXraw & 0xf00;
    clutYmasked &= 0xfff;
    clutYm = clutYmasked << 0x10;
    clutYm &= 0xffff0000u;
    maskHi = 0xF000FFFFu;
    clut22p = clut22; /* in-loop variant tested: 36 (the sw is not a movable;
                             * only its addiu hoists) -- stays in the preheader */
    do {
        u_long        *data;
        int            i;
        unsigned short *dst;
        unsigned char  *src;
        unsigned int  *next;
        RECT          *rectp;
        unsigned int tailX, tailY;
        unsigned int packed;
        maskLo = ~0xFFFu;
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
                c[3] = (c[3] & maskLo) | ((unsigned int)imgX & 0xfff);
                c[3] = (c[3] & maskHi) | (((unsigned int)imgY & 0xfff) << 0x10);
                *(unsigned char *)c = (unsigned char)*c | 8;
                rect.x = imgX;
                rect.y = imgY;                 /* H04: was missing (oracle 0x800F6A80 *(short*)(18+sp)=imgY) */
                bits   = (short)c[1] * shapedepth((unsigned char *)c);
                w      = bits + 0xf;
                i = w < 0;             /* permuter find (w34, output-230): naming the sign test
                                        * in the shared `i` local re-weights the allocno web */
                if (i)
                    w = bits + 0x1e;
                rect.w = (short)(w >> 4);    /* width in 16-bit VRAM words */
                rect.h = *(short *)((int)c + 6);
                data   = (u_long *)(c + 4);
                vramimage(&rect, data);
            }
            goto walk;

        case 0x23:                                   /* raw CLUT words */
            rectp = &rect;
            data = (u_long *)(c + 4);
            break;

        case 0x22:                                   /* CLUT, 8->5 bit via >>1 */
            i   = 0;
            if (0 < (short)c[1]) {
                dst = (unsigned short *)clut22p;
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
            rectp = &rect;
            data = (u_long *)clut22;
            break;

        case 0x24:                                   /* CLUT, 8->5 bit via >>3 */
            i = 0;
            if (0 < (short)c[1]) {
                dst = (unsigned short *)clut24;
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
            rectp = &rect;
            data = (u_long *)clut24;
            break;

        default:                                     /* 0x25 etc.: nothing to upload */
            goto walk;
        }

        /* common CLUT tail (0x22/0x23/0x24) -> (clutX,clutY) */
        packed = c[3] & maskLo;
        packed &= maskLo;
        c[3] = packed | clutXm;
        c[3] = (c[3] & maskHi) | clutYm;
        *(unsigned char *)c = (unsigned char)*c | 8;
        tailX = (unsigned int)clutX & 0xff;
        tailX |= (unsigned int)clutX & 0xff00;
        tailY = (unsigned int)clutY & 0xff;
        tailY |= (unsigned int)clutY & 0xff00;
        rect.x = tailX;
        rect.y = tailY;                     /* H04: was missing (oracle 0x800F6BC4 *(short*)(18+sp)=clutY) */
        rect.w = (short)c[1];
        rect.h = 1;
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
