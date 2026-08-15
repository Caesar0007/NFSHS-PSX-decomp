/* eaclib/psx/eacpsxz/movf.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 PASS ***
 *
 *   *** SEALED 2026-07-26 (w34 follow-up): movfxya PASS 221/221 byte-exact ***
 *   Requires PER_TU_FLAGS no_schedule_insns (sched1 OFF -- the 3.25-3d per-obj flag identity)
 *   PLUS six source levers, applied in this order on top of the flag (149 -> 88 baseline):
 *     1. 88->68  SET-TWICE dead-set carriers m1/m2 for the two `0xff - x` sites: `mN = 0xff;
 *                use; mN = 0;` -- loop.c counts the dead set (set_in_loop!=1, no hoist), flow
 *                deletes it for free; retail rematerializes `li $v0,255` per site.  Tiny 2-ref
 *                carriers color $v0, whose write-wins conflict with the `lw 0xC($s6)` load-delay
 *                slot pins the li in retail's position (a fat shared `t` carrier colored $v1 and
 *                sched2 hoisted it into the slot).
 *     2. 68->50  (a)-path: `cw` base pointer local + BOTH window loads up front -- shortens cw's
 *                range so QTY_CMP_PRI ranks it above the load temps (cw=$v0, tx=$v1, ty reuses
 *                $v0 at cw's death) and kills the tx/ty anti-dep so sched2 interleaves the
 *                arg reloads (E1238-E125C).
 *     3. 50->36  inner clamp: `t = *(short*)(shape+4); ... t -= xDone;` two-statement split
 *                (retail loads w BEFORE the 255/clampW pair and subtracts IN PLACE, E10C8-E10D4).
 *     4. 36->12  `page = *shape;` lbu split out early + v2 stores moved BEFORE u2/u3 stores:
 *                the $v1 lbu chain + $v0 v2-temp overlap u1's extended range -> local_alloc
 *                denies u1 both -> u1=$a0, w2=$a1 (E1134/E1140), and sched2 then reproduces
 *                retail's whole post-call interleave.  NEGATIVE: u3 textually before the v2 add
 *                (retail's FINAL order) collapses the denial, 6->22 -- retail got E115C via
 *                sched2's lw-delay fill, not source order.
 *     5. 12->6   dead 2nd nextprim reload moved INTO the asm template text (lui/lw $t5): it is
 *                the EA expander's own fixed-reg byte sequence; as a gcc "r" input it lands in
 *                whatever t-reg is free ($t1 here, $t5 in fastmovf only by pressure luck).
 *     6. 6->0    `wend = *(short*)(shape+4);` fresh condition temp before the volatile nextprim
 *                store (volatile sw = scheduling barrier, an in-condition load can never hoist
 *                above it to E11FC) -- fresh variable so it colors $v0, not t's $v1; and the
 *                tpage &3/<<7 math left IN the store expression (late luids lose the sched2
 *                ready-list tie to the v2 addu, E1160 vs E1164; early `page=(*shape&3)<<7`
 *                spelling = 2 diffs).
 *   The w32/w33 notes below are the HISTORY of this wall -- kept for the record; their
 *   "toolchain-level residual" verdicts are superseded by the levers above.
 *
 *   obj nfs4\eaclib\psx\movf.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 358083).
 *   1 fn @0x800F0738 (884 B).  movfxya -- blit a "shape" (fetexture sprite) to screen at (x,y).  Three paths:
 *     (a) shape not yet uploaded (*shape & 8 == 0)  -> DMA straight to VRAM via vramimage at the draw origin.
 *     (b) opaque-but-flagged semi-trans path        -> hand off to fastmovfxya.
 *     (c) otherwise                                 -> tile the sprite into <=256px GPU rectangles, emitting
 *         a textured POLY_FT4 (code 0x2c) per tile and stitching each into the ordering table (OT).
 *   Ghidra nfs4-f.exe.c (movfxya) + disasm-v3 (IDA sig recovers the 2 dropped reg args a2=x,a3=y; the OT-stitch
 *   is the fixed-$t6/$t7 lwl/swl P_TAG template -- EA DMPSX-analog .obj post-processor, see fastmovf.c seal
 *   2026-07-09; the two `/depth` div guards are --expand-div codegen from plain `/`).  Plain C -> extern "C".
 *
 *   w32-a5 2026-07-26 -- INSTRUCTION PARITY IS REACHABLE BUT COSTS MORE DIFFS (recorded, not kept):
 *     the single extra instruction at 222/221 is the CSE-HOISTED `li 255` (retail rematerializes 255
 *     at each of the two `0xff - x` sites; ours hoists one pseudo across both loop levels).  Turning
 *     the OUTER row loop into a label+goto loop kills that hoist -> exactly 221/221 -- but the diff
 *     count rises 149 -> 186 (shape moves s7->s4 and the row-header block re-schedules).  Same for a
 *     goto-loop on the INNER tile loop: 221/221 but 254 diffs, and it spills vPage to the frame.
 *     Both reverted per the wave keep-rule (strict diff drop).  Also falsified here: `short yPos`
 *     (IDA types $s7 as __int16 -> 226 insns/229 diffs), `(unsigned char)vCoord` for vc (no change),
 *     and inlining u1/v2 at both store sites as IDA renders them (no change -- gcc re-CSEs).
 *     IDA sub_800F0738's register map (v5=$s5 depth, v9=$fp vc, v14=$s7 yPos, v12=$s3 xDone,
 *     v13=$t0 vPage, v17=$s4 uTile, v19=$s2 colW, v20=$s1 clampW, spills at sp+0x18/0x1C/0x20)
 *     confirms our variable set is right; the residual really is the unscheduled-cc1 per-obj flag
 *     identity (METHODOLOGY 3.25-3d) plus the 255 hoist, both toolchain-level.
 *
 *   w33-a5 2026-07-26 -- THE PER-OBJ FLAG IDENTITY IS NOW MEASURED, WITH SIBLING CONTROLS.
 *     The earlier "-fno-schedule diag gives 128" used BOTH scheduler flags.  Isolating them shows
 *     it is SCHED1 ONLY, and the effect is large (scratch cc1 A/B, gate flags otherwise untouched):
 *         (none)                                     149 diffs, 222 insns
 *         -fno-schedule-insns                          88 diffs, 225      <-- sched1 off
 *         -fno-schedule-insns2                        155 diffs, 228
 *         -fno-schedule-insns -fno-schedule-insns2    128 diffs, 237
 *         -fno-cse-follow-jumps / -fno-rerun-cse-after-loop   149 (no effect at all)
 *         -fno-expensive-optimizations                161 ; +-fno-delayed-branch 115
 *     CONTROLS -- the same flag on the two sibling eacpsxz objs worked this session makes both far
 *     WORSE: vramfxya 68 -> 152, setfont 12 -> 23.  So this is not a global toolchain setting; it
 *     discriminates PER OBJECT exactly as METHODOLOGY 3.25-3d predicts, and movf.obj is on the
 *     unscheduled side while vramfxya.obj and textset.obj are on the scheduled side.
 *     NOT ADOPTED: -fno-schedule-insns still leaves 88 diffs AND breaks instruction parity
 *     (225 vs 221), so it fails the wave keep-rule; build.py's PER_TU_FLAGS has no
 *     `no_schedule_insns` key and adding one is a build-system change, not a recon change.
 *     Under the FIXED gate flags the 149 residual is dominated by sched1 reordering (retail emits
 *     the row-header sll/sra/subu chain after the store, ours hoists it into the load-delay) plus
 *     the {shape,yPos,vc} s6/s7/fp rotation that follows from it -- no source lever reaches it.
 *     Also re-falsified this session with the w33 param-copy ref-count dial (which cracked
 *     vramfxya 80->68 and is a real lever elsewhere): copies of shape/x/y in every combination make
 *     movfxya WORSE -- 174 (shape), 212 (x), 213 (y), 235 (shape+x / shape+y / all three);
 *     {x} and {x,y} do reach 221/221 parity but at 212 diffs.
 *
 *   w34-a4 2026-07-26 -- THE ROTATION IS QUANTIFIED FROM THE ALLOCNO DUMPS, AND THE FLAG IS
 *     RE-MEASURED WITH A DECISION RECORDED IN tools/build.py.
 *     (1) `cc1 -dl/-dg` on this TU prints the whole allocation.  The three fighting pseudos are
 *         80 = shape  (29 refs / 266 insns -> floor_log2(29)*29/266 = 0.436)
 *         95 = vc     (13 refs /  88 insns -> 3*13/88            = 0.443)
 *         99 = yPos   (11 refs /  78 insns -> 3*11/78            = 0.423)
 *         and gcc-2.8 global.c hands out REG_ALLOC_ORDER in that priority order, so ours is
 *         95,80,99 -> vc=$s6, shape=$s7, yPos=$fp.  Retail is shape=$s6, yPos=$s7, vc=$fp, i.e.
 *         the order 80,99,95.  Reaching it needs vc's weighted refs 13->12 (or its live length
 *         88->>=93) with everything else fixed.  Refs are LOOP-DEPTH weighted, so they only move in
 *         steps of the depth (2 outer / 3 inner): the ONLY -1 available is demoting one of vc's
 *         three inner uses to the outer loop, and the only loop-invariant one is `v2 = vc + rowH`.
 *         TESTED: hoisting v2 to the outer loop DOES produce retail's map (shape->$s6, vc->$fp,
 *         verified in the objdump) but v2 then has to live across the inner loop's calls, all nine
 *         callee-saved regs are already taken, so it spills and the FRAME GROWS 80->88 -- every
 *         frame displacement shifts and the gate goes 149 -> 167.  The oracle computes `addu
 *         $v0,$fp,$a2` INSIDE the inner loop (movfxya.s:155), so retail's vc has 13 refs too.
 *         ==> the ordering difference is the banked ALLOCNO_COMPARE DELTA (catalog SS-G), not a
 *         source miss: retail ranks a long-lived many-ref pointer above a short-lived one.
 *     (2) `-fno-schedule-insns` (sched1 OFF) re-measured: 149 -> 88 diffs, 222 -> 225 insns.  It
 *         fixes the SHAPE half of the rotation on its own (shape lands on retail's $s6; only the
 *         vc<->yPos pair stays swapped).  The +4 is the CSE-hoisted `li 255` pseudo (allocno 125,
 *         6 refs/204 insns -> $t1) plus its caller-save `sw/lw 36(sp)` pair.  Because it LOSES
 *         instruction parity it fails the wave keep-rule, so it is NOT enabled -- but the
 *         PER_TU_FLAGS key `no_schedule_insns` now exists in tools/build.py with the full
 *         measurement + the sibling controls, so adopting it is a one-line change if a later wave
 *         decides the diff drop outweighs the count.  movf.c holds exactly one function, so no
 *         in-TU regression is possible.
 *     (3) Attempts to kill the `li 255` hoist so the flag build reaches parity, all measured:
 *         label+goto OUTER loop  default 186 (221/221) | with -fno-schedule-insns 132 (225)
 *         label+goto INNER loop  default 254 (221/221) | with -fno-schedule-insns 229 (224)
 *         both                   default 224 (225)     | with -fno-schedule-insns 176 (225)
 *         and, under the flag, -fno-caller-saves 124, -fno-strength-reduce / -fno-peephole /
 *         -fno-cse-skip-blocks / -fno-force-mem / -fno-inline all 88 (no effect).
 *         Other flags on the default build: -mno-split-addresses 151, -fno-schedule-insns2 155,
 *         -fno-delayed-branch 174, -fno-expensive-optimizations 161.
 *     (4) NFS2 PC-beta cross-oracle (w34 lever 2) checked and found NOT APPLICABLE here: NFS2's
 *         movf.obj is a 6-function family of ~6-instruction THUNKS (_movfxya/_movf/_movfxy/
 *         _movcfxya/_movcf/_movcfxy) that all tail-call one shared PC blitter, `movdfl` in
 *         movdfl.obj -- a software frame-buffer routine with no GPU-primitive/OT-link structure.
 *         The PSX movfxya is a whole generation later (a tiling POLY_FT4 emitter); the only thing
 *         that transfers is the FAMILY shape (one core + thin x/y/anchor-adjusting wrappers), which
 *         the PSX side already reflects via fastmovfxya.
 *
 *   MATCH notes (264->149; residual = scheduler-order/scratch-choice class -- {shape,yPos,vc} s6/s7/fp rotation, hoisted-255 CSE pseudo (caller-save-spilled!) vs per-use li, arg-block interleave -- the oracle .obj again shows unscheduled output; -fno-schedule diag gives 128. Levers that landed, mirroring the fastmovf recipe):
 *     - NO `ret` variable / NO explicit return on ANY path: $v0 is incidental (vramimage's or
 *       fastmovfxya's return, or scratch on the tiling path) -- the oracle computes no return value.
 *     - path (a) draw origin read off ONE `currentwindow[]` base (+4/+8 as u_short), not two DAT_ externs.
 *     - prim+7 code byte stored TWICE: constant 0x2C, then (semitrans BYTE read | 0x2C) -- dead first
 *       store kept by gcc (pointer aliasing), exactly as retail.
 *     - all prim field temps are plain ints (sb/sh truncate); u1 = colW + w2 where w2 is the
 *       post-call copy of clampW; clamped w2/rowH2 feed xDone/sx1/sy2.
 *     - uAcc = xDone*depth at inner-loop TOP (mult lands in the back-edge delay slot);
 *       uBase/depth hoisted into uq BEFORE uTile/uNext (div1 between uCoord and uTile like retail).
 *     - outer loop = while(1)+break bottom test: `beqz->exit; j top` (a plain do-while emits bnez-top);
 *       height read BOTH ways per iteration: signed lh for the guards, lhu into a short var `hu`
 *       whose use sign-extends (sll/sra pair).
 *     - OT-stitch: fixed-reg template asm + `extern char * volatile nextprim` (dead 2nd reload into
 *       $t5 via the $t3-$t7 clobber window) -- the sealed fastmovfxya recipe verbatim.
 *
 *   GPU rect primitive (0x28 bytes): +0 tag(24b OT-link | len<<24), +3 len(=9), +7 code(=semitrans|0x2c),
 *   +0xe clutid, then 4 vertices of {x16,y16,u8,v8} interleaved at +8/+0xc/+0x10.../+0x16 tpage.
 *   Shape header: +4 w(short), +6 h(short), +0xc packed uv/tpage (12b u <<0x14, 4b vpage <<4), +0x10 pixels.
 */
typedef unsigned long u_long;
typedef struct { short x, y, w, h; } RECT;

extern int  shapedepth(unsigned char *shape);            /* shpdepth */
extern int  shapetoclutid(unsigned int *shape);          /* shpclut */
extern int  vramimage(RECT *rect, u_long *data);         /* vramfxya */
extern int  fastmovfxya(int shape, int x, int y);        /* fastmovf (deferred-trio sibling) */
extern char *primptr;                                    /* primate : primitive write cursor */
extern char * volatile nextprim;                         /* primate : OT link target (prev prim).
                               * volatile HERE (per-TU codegen device): the retail OT-stitch loads
                               * nextprim TWICE (dead 2nd load = placeholder-call setup the EA
                               * post-processor left) -- volatile keeps both reads as direct
                               * lui/lw self-temp loads, matching the oracle. */
extern int   semitrans;                                  /* primate : semi-transparency mode */
/* W65-A6 DATA-MAT: `currentwindow` was extern-only tree-wide (4 reloc-referenced undefined
 * sites, from movf.c + fastmovf.c).  Retail .bss run @0x801485AC (VA > t_addr+t_size
 * 0x8013E000 => pure zero-init BSS, no file bytes):
 *      windowbuf     @0x801485AC size 312  (= currentwindow - windowbuf)
 *      currentwindow @0x801486E4 size 156  (= sndmm @0x80148780 - 0x801486E4)
 * `windowbuf` is retail-named in configs/symbol_addrs.txt but referenced by nothing in the
 * recon (no undefined site); it is materialized here anyway so the object's .bss reproduces
 * the retail run's byte layout instead of leaving a 312-byte hole for the .ld to guess.
 * movf.obj is picked as owner over fastmovf.obj because the window block is the frame-move
 * primitive's own state (both TUs reference it; MEDIUM-confidence ownership, recorded).
 * DEVICE = file-scope asm .bss definition, keeping the UNSIZED `extern int currentwindow[]`
 * shape the decl documents ("ONE struct base like fastmovf").
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\twindowbuf\n\t.globl\tcurrentwindow\n\t.section\t.bss\n\t.align\t2\n"
        "windowbuf:\n\t.space\t312\n"
        "currentwindow:\n\t.space\t156\n\t.text");
extern int   currentwindow[];  /* @0x801486E4 : GPU window block -- draw-origin X/Y @+4/+8 (u_short
                                * reads here), clip @+0x18..0x24.  ONE struct base like fastmovf. */

extern int movfxya(unsigned char *shape, int x, int y);  /* @0x800F0738 */

/* movfxya @0x800F0738 : draw shape at (x,y).  $v0 incidental -- no explicit return (oracle). */
extern int movfxya(unsigned char *shape, int x, int y)
{
    int depth = shapedepth(shape);

    if ((*shape & 8) != 0) {                          /* in VRAM: paths (b)/(c); (a) = else at END */
      if (((*shape & 3) == 2) && ((semitrans & 2) == 0)) {   /* (b) */
        fastmovfxya((int)shape, x, y);
      } else {                                        /* (c) tile into GPU rects */
        int yRow, vCoord, vc, rowH, rowH2, vPage;
        int yPos;
        int xDone, uAcc, uCoord, uBase, uNext, colW, clampW, w2, uq;
        int uTile, u1, v2, sx, sx1, sy2, t, m1, m2, page, wend;
        short hu;                                     /* height via lhu; uses sign-extend sll/sra */
        char *prim, *np;

        hu = *(unsigned short *)(shape + 6);
        if (0 < *(short *)(shape + 6)) {
            yRow = 0;
            while (1) {
                vCoord = ((*(int *)(shape + 0xc) << 4) >> 20) + yRow;
                vc = vCoord & 0xff;
                m1 = 0xff;            /* SET-TWICE lever (w34-a9 variant): dedicated tiny carrier +
                                       * a DEAD second set below -> set_in_loop!=1 blocks the
                                       * move_movables hoist (loop.c runs BEFORE life analysis, so
                                       * the dead set still counts; flow then deletes it for free).
                                       * Tiny 2-ref range colors $v0 like retail (E0FEC), and $v0
                                       * conflicts with the lw 0xC load-delay slot so sched2 cannot
                                       * hoist the li -- retail's bare nop stays. */
                rowH = m1 - vc;
                m1 = 0;               /* dead set -- deleted by flow, counted by loop.c */
                t = hu - yRow;
                if (t < rowH) rowH = t;
                xDone = 0;
                if (0 < *(short *)(shape + 4)) {
                    vPage = (vCoord & 0x100) >> 4;
                    yPos = yRow + y;
                    do {
                        uAcc = xDone * depth;
                        uCoord = (*(int *)(shape + 0xc) << 20) >> 20;
                        if (uAcc < 0) uAcc += 0xf;
                        uBase = uCoord << 4;
                        uq = uBase / depth;
                        uTile = uCoord + (uAcc >> 4);
                        uNext = (uTile & 0xffffffc0) << 4;
                        colW = (uq + xDone) - uNext / depth;
                        t = *(short *)(shape + 4);    /* load FIRST, then subtract IN PLACE:
                                       * retail's lh lands 2 insns before its consumer with the
                                       * 255/clampW pair filling the gap, and `subu $v1,$v1,$s3`
                                       * reuses the load register (E10C8-E10D4). */
                        m2 = 0xff;    /* inner-loop 255: same dead-set device */
                        clampW = m2 - colW;
                        m2 = 0;       /* dead set -- deleted by flow, counted by loop.c */
                        t -= xDone;
                        if (t < clampW) clampW = t;
                        prim = primptr;
                        primptr = prim + 0x28;
                        prim[3] = 9;
                        prim[7] = 0x2c;               /* dead store kept (retail) */
                        prim[7] = *(unsigned char *)&semitrans | 0x2c;
                        *(short *)(prim + 0xe) = shapetoclutid((unsigned int *)shape);
                        w2 = clampW;
                        page = *shape;              /* JUST the byte read split out EARLY (retail
                                       * lbu at E113C): the $v1 chain then overlaps u1's range,
                                       * so local_alloc denies u1 both $v0 (v2 temp) and $v1 ->
                                       * u1=$a0, w2=$a1.  The &3/<<7 math stays IN the tpage
                                       * expression: its late luids lose the sched2 ready-list
                                       * tie to the v2 addu (retail E1160 before E1164). */
                        u1 = colW + w2;
                        prim[0xc] = colW;             /* u0 */
                        prim[0xd] = vc;               /* v0 */
                        prim[0x14] = u1;              /* u1 */
                        prim[0x15] = vc;              /* v1 */
                        prim[0x1c] = colW;            /* u2 */
                        v2 = vc + rowH;               /* v2 BEFORE the u3 store: extends u1's
                                       * live range over the v2 temp's $v0 so local_alloc denies
                                       * u1 $v0 -> u1=$a0, w2 -> $a1 (retail E1134/E1140).
                                       * NEGATIVE: u3 before the v2 add (retail's textual order)
                                       * collapses the denial, 6 -> 22 -- retail reaches E115C's
                                       * order via sched2, not source order. */
                        prim[0x1d] = v2;              /* v2 */
                        prim[0x25] = v2;              /* v3 */
                        prim[0x24] = u1;              /* u3 */
                        *(unsigned short *)(prim + 0x16) =
                            ((page & 3) << 7 | vPage) | ((uTile & 0x3c0) >> 6);   /* tpage */
                        if (w2 < 1) w2 = 1;
                        rowH2 = rowH;
                        if (rowH2 < 1) rowH2 = 1;
                        sx = xDone + x;
                        sx1 = sx + w2;
                        *(short *)(prim + 8)    = sx;
                        *(short *)(prim + 0x18) = sx;
                        sy2 = yPos + rowH2;
                        *(short *)(prim + 0x1a) = sy2;
                        *(short *)(prim + 0x22) = sy2;
                        np = nextprim;
                        *(short *)(prim + 0xa)  = yPos;
                        *(short *)(prim + 0x12) = yPos;
                        *(short *)(prim + 0x10) = sx1;
                        *(short *)(prim + 0x20) = sx1;
                        /* OT-stitch: insert `prim` after `nextprim` (24-bit P_TAG addr copy+write).
                         * FIXED-REG TEMPLATE (EA DMPSX-analog .obj post-processor): every retail
                         * site hardcodes $t5-$t7.  The DEAD 2nd nextprim reload (placeholder-call
                         * setup artifact) is TEMPLATE TEXT here, not a gcc "r" input: it is part
                         * of the expander's emitted byte sequence and always lands in $t5.  (The
                         * fastmovf volatile-3rd-input variant reproduces $t5 only by register
                         * pressure; in movfxya $t1/$t2 are free at this point, gcc parks the dead
                         * pseudo in $t1, and widening the clobber window to force it out regresses
                         * 48 -> 62 because the in-loop `lw 84/88(sp)` arg reloads NEED $t1/$t2.) */
                        /* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
                         * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
                         * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
                         * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
                         * Gate-lane object is byte-identical (proven by hash); see
                         * scratchpad/w64a20/RECEIPTS.md. */
                        __asm__ volatile(
                            "lui	$13,%%hi(nextprim)
	lw	$13,%%lo(nextprim)($13)
	lwl	$14,2(%0)
	sll	$15,%1,8
	swl	$14,2(%1)
	swl	$15,2(%0)"
                            : : "r"(np), "r"(prim)
                            /* clobber window = expander's reserved temps $t3-$t7 */
                            : "$11", "$12", "$13", "$14", "$15", "memory");
                        wend = *(short *)(shape + 4); /* condition read BEFORE the volatile
                                       * nextprim store: the volatile sw is a scheduling barrier,
                                       * so a bare in-condition load could never hoist above it
                                       * to retail's position (E11FC before E1204).  Own variable
                                       * (not `t`): t's pseudo owns $v1 from the clamp segment,
                                       * retail's condition temp is a fresh $v0 (in-place slt). */
                        xDone += w2;
                        nextprim = prim;
                    } while (xDone < wend);
                }
                yRow += rowH2;
                hu = *(unsigned short *)(shape + 6);
                if (*(short *)(shape + 6) <= yRow) break;
            }
        }
      }
    } else {                                          /* (a) not in VRAM -> upload (block at END) */
        RECT rect;
        int tx, ty;
        char *cw = (char *)currentwindow;   /* base in a REGISTER: keeps the +4/+8 as load
                                             * DISPLACEMENTS off %lo(currentwindow) (retail 4/8);
                                             * direct casts fold the +4 into the la and clobber
                                             * the base between the two reads. */
        tx = *(unsigned short *)(cw + 4);   /* BOTH loads up front: shortens cw's live range so
                                             * QTY_CMP_PRI ranks cw above the load temps (cw->$v0,
                                             * tx->$v1, ty reuses $v0 at cw's death = retail), and
                                             * kills the tx/ty anti-dependency so sched2 can
                                             * interleave the arg reloads (E1240-E125C). */
        ty = *(unsigned short *)(cw + 8);
        rect.x = tx + x;
        rect.y = ty + y;
        rect.w = *(unsigned short *)(shape + 4);
        rect.h = *(unsigned short *)(shape + 6);
        vramimage(&rect, (u_long *)(shape + 0x10));
    }
}
