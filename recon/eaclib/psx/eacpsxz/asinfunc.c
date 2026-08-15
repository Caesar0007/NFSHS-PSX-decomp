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
 *   intarcsin      def 2 | 2.6.0 39 | 2.6.3 39 | 2.7.2-970404 2 | 2.7.2 35 | 2.8.1 2 | 2.91.66 6 | 2.95.2 6
 */
/* eaclib/psx/eacpsxz/asinfunc.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx/asinfunc.obj ; archive C:
fs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   2 fns @ [0x800EACD8, 0x800EADBC): intarcsin, intarccos -- integer inverse trig.
 *   FULL reconstruction of the actual code (disasm-v3 MIPS); NOT stubs/thunks. C-linkage XDEFs.
 *
 *   Angle unit = "brads": 0x100 (256) == 90 degrees (a full circle = 1024).  Input is a 16.16
 *   signed sine value (1.0 == 0x10000).  intarcsin uses a 512-entry lookup table (sine>>7 -> angle)
 *   with linear interpolation in the steep high region (|x| in (0xFA00,0xFFFF]) and round-to-nearest
 *   table lookup below.  The table @0x80137260 is obj-local rodata -> materialized inline (real bytes
 *   from NFS4.EXE) so this TU is self-contained.  intarccos(x) = 90deg - intarcsin(x).
 */

/* arcsin lookup: index = (|x| >> 7), value = angle in brads.  @0x80137260 (512 B, monotonic 0..246) */
static const unsigned char kArcsinTable[512] = {
    0x00,0x00,0x01,0x01,0x01,0x02,0x02,0x02,0x03,0x03,0x03,0x04,0x04,0x04,0x04,0x05,
    0x05,0x05,0x06,0x06,0x06,0x07,0x07,0x07,0x08,0x08,0x08,0x09,0x09,0x09,0x0A,0x0A,
    0x0A,0x0B,0x0B,0x0B,0x0B,0x0C,0x0C,0x0C,0x0D,0x0D,0x0D,0x0E,0x0E,0x0E,0x0F,0x0F,
    0x0F,0x10,0x10,0x10,0x11,0x11,0x11,0x12,0x12,0x12,0x13,0x13,0x13,0x13,0x14,0x14,
    0x14,0x15,0x15,0x15,0x16,0x16,0x16,0x17,0x17,0x17,0x18,0x18,0x18,0x19,0x19,0x19,
    0x1A,0x1A,0x1A,0x1B,0x1B,0x1B,0x1C,0x1C,0x1C,0x1C,0x1D,0x1D,0x1D,0x1E,0x1E,0x1E,
    0x1F,0x1F,0x1F,0x20,0x20,0x20,0x21,0x21,0x21,0x22,0x22,0x22,0x23,0x23,0x23,0x24,
    0x24,0x24,0x25,0x25,0x25,0x26,0x26,0x26,0x27,0x27,0x27,0x28,0x28,0x28,0x29,0x29,
    0x29,0x2A,0x2A,0x2A,0x2A,0x2B,0x2B,0x2B,0x2C,0x2C,0x2C,0x2D,0x2D,0x2D,0x2E,0x2E,
    0x2E,0x2F,0x2F,0x2F,0x30,0x30,0x30,0x31,0x31,0x31,0x32,0x32,0x32,0x33,0x33,0x33,
    0x34,0x34,0x34,0x35,0x35,0x35,0x36,0x36,0x36,0x37,0x37,0x37,0x38,0x38,0x39,0x39,
    0x39,0x3A,0x3A,0x3A,0x3B,0x3B,0x3B,0x3C,0x3C,0x3C,0x3D,0x3D,0x3D,0x3E,0x3E,0x3E,
    0x3F,0x3F,0x3F,0x40,0x40,0x40,0x41,0x41,0x41,0x42,0x42,0x42,0x43,0x43,0x43,0x44,
    0x44,0x45,0x45,0x45,0x46,0x46,0x46,0x47,0x47,0x47,0x48,0x48,0x48,0x49,0x49,0x49,
    0x4A,0x4A,0x4B,0x4B,0x4B,0x4C,0x4C,0x4C,0x4D,0x4D,0x4D,0x4E,0x4E,0x4E,0x4F,0x4F,
    0x50,0x50,0x50,0x51,0x51,0x51,0x52,0x52,0x52,0x53,0x53,0x54,0x54,0x54,0x55,0x55,
    0x55,0x56,0x56,0x56,0x57,0x57,0x58,0x58,0x58,0x59,0x59,0x59,0x5A,0x5A,0x5B,0x5B,
    0x5B,0x5C,0x5C,0x5C,0x5D,0x5D,0x5E,0x5E,0x5E,0x5F,0x5F,0x5F,0x60,0x60,0x61,0x61,
    0x61,0x62,0x62,0x63,0x63,0x63,0x64,0x64,0x64,0x65,0x65,0x66,0x66,0x66,0x67,0x67,
    0x68,0x68,0x68,0x69,0x69,0x6A,0x6A,0x6A,0x6B,0x6B,0x6C,0x6C,0x6C,0x6D,0x6D,0x6E,
    0x6E,0x6E,0x6F,0x6F,0x70,0x70,0x70,0x71,0x71,0x72,0x72,0x73,0x73,0x73,0x74,0x74,
    0x75,0x75,0x76,0x76,0x76,0x77,0x77,0x78,0x78,0x78,0x79,0x79,0x7A,0x7A,0x7B,0x7B,
    0x7C,0x7C,0x7C,0x7D,0x7D,0x7E,0x7E,0x7F,0x7F,0x80,0x80,0x80,0x81,0x81,0x82,0x82,
    0x83,0x83,0x84,0x84,0x85,0x85,0x85,0x86,0x86,0x87,0x87,0x88,0x88,0x89,0x89,0x8A,
    0x8A,0x8B,0x8B,0x8C,0x8C,0x8D,0x8D,0x8E,0x8E,0x8F,0x8F,0x90,0x90,0x91,0x91,0x92,
    0x92,0x93,0x93,0x94,0x94,0x95,0x95,0x96,0x96,0x97,0x97,0x98,0x98,0x99,0x99,0x9A,
    0x9B,0x9B,0x9C,0x9C,0x9D,0x9D,0x9E,0x9E,0x9F,0xA0,0xA0,0xA1,0xA1,0xA2,0xA2,0xA3,
    0xA4,0xA4,0xA5,0xA5,0xA6,0xA7,0xA7,0xA8,0xA9,0xA9,0xAA,0xAA,0xAB,0xAC,0xAC,0xAD,
    0xAE,0xAE,0xAF,0xB0,0xB0,0xB1,0xB2,0xB2,0xB3,0xB4,0xB4,0xB5,0xB6,0xB7,0xB7,0xB8,
    0xB9,0xBA,0xBA,0xBB,0xBC,0xBD,0xBE,0xBE,0xBF,0xC0,0xC1,0xC2,0xC3,0xC3,0xC4,0xC5,
    0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD5,0xD6,
    0xD7,0xD8,0xDA,0xDB,0xDD,0xDE,0xE0,0xE1,0xE3,0xE5,0xE7,0xE9,0xEC,0xEE,0xF2,0xF6
};

/* ===================================================================== *
 *  intarcsin @0x800EACD8 : arcsine of a 16.16 sine value -> brads.        *
 * ===================================================================== */
extern int intarcsin(int x)   /* @0x800EACD8 */
{
    int idx;
    int result;
    int sign = 0;
    if (x < 0) { x = -x; sign = 1; }            /* abs, remember sign  */


    /* MATCH: coarse region = the if-BODY (bnez -> out-of-line steep block); the round
     * select is a BRANCHED if/else (a ?: strength-reduces to the branchless
     * (x>>6&1)+(x>>7)); the steep t0/t1 pair reads through ONE element pointer.
     * RESIDUAL (2 diffs, count-exact 48==48, w16-a6): the steep-region table-address
     * materialization. Oracle computes v1=a1+tablebase ONCE then COPIES it into v0
     * (`addu v0,v1,zero`) before the two `lbu`s (v1<-*v1, v0<-*(v0+1)); our cc1plus
     * independently RE-EMITS the identical `addu ?,a1,tablebase` add a 2nd time into v0
     * instead of copying v1 -- both source operands (a1, tablebase) are unchanged between
     * the two adds, a missed-CSE the compiler happens to take differently than the oracle.
     * Tried: pointer-temp `p=&kArcsinTable[idx]; t0=p[0]; t1=p[1];` (48->47 insns but
     * cascaded a 3-var recolor, 25 diffs, worse); t1-before-t0 assignment order (18 diffs,
     * worse). decomp-permuter (base score 35, 700+ iters, no perm macros) PLATEAUS at the
     * base score -- confirms §asm_pattern_catalog Row E "register-materialization FLOOR
     * (v0-vs-a2 tie-break)": the address-scratch choice is allocator-internal, not
     * source-shapable. Accept as a floor.
     * w33-a4 RE-VERDICT (floor CONFIRMED, mechanism sharpened): the two shapes are a cse.c
     * copy-vs-rematerialise choice on the SECOND `(plus asintbl, idx)` address pseudo -- retail
     * replaces it with a register copy from the first (`addu v0,v1,zero`), ours re-emits the add.
     * Any source form that names the address ONCE collapses to a single address pseudo and 47
     * insns (`lbu ?,0(p)` + `lbu ?,1(p)`), i.e. it LOSES the instruction retail has; any form that
     * writes the subscript TWICE reproduces the 48-insn shape but always with the second add.
     * Re-tested this wave: `*(&kArcsinTable[idx] + 1)` (2 diffs), `{int i2=idx; ...[i2+1];}` (2),
     * explicit `q = p` alias (25 diffs / 47), `p[0]`+`p[1]` (25 / 47).
     * w34-a3 (floor RE-CONFIRMED, STRONG by the >=3-alternate-forms rubric): the w33 trichotomy's
     * cse-double-evaluation cure (one ANONYMOUS + one NAMED evaluation of the same address expr,
     * which turns the second into retail's register COPY -- the FILE_cancelop lever) does NOT reach
     * this site in either order.  Anonymous t0 + named `p = &kArcsinTable[idx]; t1 = p[1];` collapses
     * to ONE address pseudo (47 insns / 25 diffs); named t0 (`p`) + anonymous `t1 =
     * kArcsinTable[idx+1]` stays at 48/2; pointer-arithmetic spellings `*(kArcsinTable + idx + 1)`
     * with either `t0 = kArcsinTable[idx]` or `t0 = *(kArcsinTable + idx)` also stay at 48/2 (they
     * only flip the second add's operand ORDER, `addu v0,v0,a1` instead of `addu v0,a1,v0`) -- i.e.
     * cse re-materialises the `(plus asintbl, idx)` value rather than substituting the live
     * equivalent register, and no C spelling of the second subscript changes that decision.
     * ==== w47-a5 NEW NAMED ANGLE (the w33/w34 'no C spelling reaches it' claim is REFUTED for
     * the INSTRUCTION SHAPE; what is left is a 2-pointer coloring, which is a different and
     * much smaller target).  A zero-insn OPACITY FENCE with a matching "0" constraint makes
     * the aliased pointer un-coalescable, so retail's register COPY survives instead of being
     * propagated away:
     *     const unsigned char *pt = &kArcsinTable[idx];
     *     const unsigned char *qt = pt;
     *     __asm__("" : "=r"(qt) : "0"(qt));
     *     t0 = pt[0];  t1 = qt[1];
     * That gates 24 at COUNT-EXACT 48/48 with retail's exact insn shape --
     *     ours   addu v0,v1,v0 / addu v1,v0,zero / lbu a1,0(v0) / lbu v0,1(v1)
     *     oracle addu v1,a1,v0 / addu v0,v1,zero / lbu v1,0(v1) / lbu v0,1(v0)
     * i.e. the sum lands in the WRONG member of the pair (retail: sum->v1, copy->v0; ours the
     * other way), which is a local-alloc QTY_CMP_PRI question (w45 SS-A0), NOT a cse question.
     * Measured around it: fence on `pt` instead of `qt` = 25 diffs / 47 insns (the copy is
     * eliminated again); load order t1-then-t0 = 22 / 48.  NEXT: qtytrace/-dl the two pointer
     * qtys and dial the pair with the standard birth/live/ref levers -- do NOT go back to
     * spelling the subscript.  The 2-diff baseline is kept because 24 > 2, not because the
     * fence form is wrong.
     * 🔴 w49-a8 2026-08-08: the w47-a5 NEXT step ("dial the two pointer qtys") was run with the
     * source-level dials before reaching for qtytrace, and they do NOT move the pair -- every
     * variant reproduces w47-a5's 24 at 48/48, or loses the copy again:
     *   pt/qt as published 24 | loads swapped (`t0 = qt[0]; t1 = pt[1]`) 24 | fence on `pt`
     *   instead of `qt` 25 (47/48 -- copy eliminated again) | fence + a trailing use fence on
     *   `qt` 24 | same on `pt` 26.
     * So the sum/copy pair really is decided inside local_alloc (QTY_CMP_PRI), not by which
     * pointer the source names or how many times it is referenced at C level.  The 2-diff
     * baseline is kept (24 > 2); the next attack is the instrumented qtytrace/-dl route named
     * by w47-a5, NOT another spelling of the subscript or the fence.
     * 🆕 w50-a9 2026-08-09 -- the FENCE BASIN IS 24 -> 6 AT COUNT-EXACT 48/48, and the residual is
     * now a DIFFERENT (and much smaller) question than w47/w49 recorded.  The w49 verdict "the
     * sum/copy pair is decided inside local_alloc and no source dial moves it" was measured only
     * with fence/spelling dials; the catalog w44 ZERO-COST REF INFLATOR family was never tried
     * here.  A depth-2 `do{}while(0)` wrapper on the qt load, on top of the w47-a5 fence pair --
     *     const unsigned char *pt = &kArcsinTable[idx];
     *     const unsigned char *qt = pt;
     *     __asm__("" : "=r"(qt) : "0"(qt));
     *     t0 = pt[0];
     *     do { do { t1 = qt[1]; } while (0); } while (0);
     * -- flips the pair to retail's assignment and gates 6 at 48/48.  The ONLY residual left is the
     * table-base materialization REGISTER: ours `lui $v1; addiu $v1,$v1,%lo; addu $v1,$a1,$v1`
     * (dest-as-%hi-scratch, self-temp) vs retail `lui $v0; addiu $v0,$v0,%lo; addu $v1,$a1,$v0`
     * (separate scratch that then dies and is reused by the copy).  The SUM lands in $v1 on BOTH
     * sides -- this is the pure §3.15 self-temp-vs-separate-temp tie-break on an ADD, one register
     * name, three insns.  Depth 1/3/4 = 24/6/6; wrapping BOTH loads or the pt load instead = 24;
     * loads swapped inside the wrapper = 8.
     * Falsified against the base-register question itself (all in the depth-2 basin, all 6/48/48):
     * a named `base = kArcsinTable` temp; `base` declared in the outer block; an opacity fence on
     * `base` before or after the sum; the int-cast operand swap `(idx + (int)kArcsinTable)`;
     * `&kArcsinTable[0] + idx`; recomputing `&kArcsinTable[idx]` for qt; a duplicated `t0 = pt[0]`
     * arm-dup inflator; and the §3.12 #5 UNSIZED-ARRAY ASM-LABEL VIEW
     * (`extern const unsigned char kArcsinTable_v[] asm("kArcsinTable")`, used in the steep block
     * only and TU-wide) -- the view is inert here because the address is ALREADY a separate la
     * pseudo; the question is only which caller-saved reg it wins.  Worse: a USE fence on `base`
     * (28), `base` spanning both arms of the 0x1FF test (21 at 47), `if (idx != 0x1FF)` inverted
     * (32).  The 2-diff baseline is KEPT (2 < 6, honest-count rule) -- but the 6-diff form is the
     * structurally-correct one (it carries retail's copy) and is the right base for the next pass.
     * NEXT: qtytrace/-dl the base-address qty vs the sum qty in the depth-2 basin (the two are
     * tied+coalesced in ours, distinct in retail); do NOT re-run the fence or subscript spellings.
     * SLD could not have helped:
     * eaclib .lib C members are debug-stripped (0 SLD records anywhere above 0x800E0000). */

    /* w53-a10 2026-08-09 -- TWO FRESH AXES MEASURED, BOTH DEAD; the 2-diff baseline is KEPT.
     * (1) PER-OBJ FLAG AXIS (the 3.25-3d axis the W52 header receipt named as still open for
     *     eacpsxz) is now CLOSED for asinfunc.c.  21 cc1 flags x the whole TU, measured in BOTH
     *     basins (the kept 2-diff form AND the w50-a9 depth-2 fence basin) through a scratchpad
     *     verify_asm copy that injects raw cc1 flags (tools/ untouched):
     *       control 2 | -fno-peephole 2 | -fno-schedule-insns 2 | -fno-strength-reduce 2 |
     *       -fno-cse-follow-jumps 2 | -fno-cse-skip-blocks 2 | -fno-rerun-cse-after-loop 2 |
     *       -fno-thread-jumps 2 | -fno-force-mem 2 | -fno-caller-saves 2 | -fno-function-cse 2 |
     *       -fno-defer-pop 2 | -fno-inline 2 | -fomit-frame-pointer 2 | -funsigned-char 2 |
     *       -fno-schedule-insns2 2 (but it costs intarccos 0 -> 3) | -fno-expensive-optimizations
     *       6 | -fno-delayed-branch 23 | -mno-split-addresses 35.  (-fno-regmove is not a 2.8.0
     *       flag.)  In the 6-diff fence basin every flag is 6 or worse.  NO flag reaches the
     *       la-scratch register question.  Do NOT re-run the flag ladder on this TU.
     * (2) The w50-a9 residual was attacked from the source side once more (the qtytrace/-dl route
     *     it named is still the open instrument).  In the depth-2 basin the ONLY residual is
     *     `lui/addiu/addu` landing in $v1 (dest-as-%hi-scratch) vs retail $v0 (separate scratch).
     *     Falsified, all 6 @48/48 unless noted: a 2nd and 3rd identity fence on `qt`; an identity
     *     fence on `pt` as well (24); a `base` temp identity-fenced then `pt = base + idx` (6, the
     *     add's operand order flips only); a VOID-TAIL fence `__asm__("" : : "i"(0))` at the block
     *     head (6); the int-cast `(const unsigned char *)((int)kArcsinTable + idx)` (6); the
     *     depth-2 do-while wrapped around the `pt` load as well (24).
     *     NEW SHAPE, recorded because it is the exact MIRROR of retail and therefore the closest
     *     structural neighbour found so far:
     *       qt = kArcsinTable; pt = qt + idx; qt = pt; <identity fence on qt>;
     *       t0 = pt[0]; do { do { t1 = qt[1]; } while (0); } while (0);
     *     gates 16 @48/48 emitting `addiu v1,v0,0 / addu v0,a1,v1 / addu v1,v0,zero` -- i.e. la ->
     *     $v1, sum -> $v0, copy -> $v1: retail's three-pseudo shape with the two members SWAPPED.
     *     So the single QTY_CMP_PRI question is now reachable from BOTH sides (6 = right pair,
     *     wrong split; 16 = right split, swapped pair) -- that pair of basins is the material for
     *     the qtytrace pass, not another subscript spelling. */
    /* W61-A19 2026-08-15 -- RE-GATED at 2 @48/48; the residual is confirmed to be ONE line
     * (ours `addu v0,a1,v0` re-emitting the address vs retail `addu v0,v1,zero` copying it), and
     * the w50-a9 "the base materialisation register is the only residual" reading applies to the
     * FENCE basin, not to this one: HERE the la scratch is already retail's $v0 and the sum is
     * already retail's $v1.  NEW, gcc-source-cited BOUND on the whole family (local-alloc.c:1866,
     * `combine_regs`): a copy `(set P2 P1)` survives allocation only when `reg_qty[P1] < 0`, i.e.
     * only when P1 is NOT BLOCK-LOCAL or DIES MORE THAN ONCE.  Both loads live in ONE basic block
     * here and P1 has a single death, so there is no C spelling of the subscript that can keep the
     * copy -- which is exactly why every one of the ~20 spellings receipted above collapses to
     * either 47 insns (one address pseudo) or 48 with a second ADD.  The w47-a5 opacity fence works
     * precisely because an `asm_operands` def makes P1 non-tieable; that basin (6 diffs at 48/48,
     * with retail's copy present) is therefore the structurally-correct one and its residual is a
     * pure local-alloc QTY_CMP_PRI pair assignment.  ANGLE UNCHANGED and now bounded: qtytrace/-dl
     * the two pointer qtys in the depth-2 fence basin.  Do NOT re-spell the subscript. */
    if (x <= 0xFA00) {                           /* coarse region: round-to-nearest lookup */
        if (x & 0x40)
            idx = (x >> 7) + 1;
        else
            idx = x >> 7;
        result = kArcsinTable[idx];
    } else {                                     /* steep region near +/-1.0 */
        if (0xFFFF < x) {
            result = 0x100;                      /* clamp to 90 degrees */
        } else {
            int t0;
            int t1;
            int frac;

            idx  = x >> 7;
            frac = x & 0x7F;                     /* 0x800EAD40 (branch delay slot -> both paths) */
            if (idx == 0x1FF) {                  /* top step interpolates toward 90deg */
                t0 = kArcsinTable[0x1FF];
                t1 = 0x100;
            } else {
                t0 = kArcsinTable[idx];
                t1 = kArcsinTable[idx + 1];
            }
            result = t0 + (((t1 - t0) * frac) >> 7);
        }
    }

    if (sign) result = -result;
    return result;
}

/* ===================================================================== *
 *  intarccos @0x800EAD98 : arccos(x) = 90deg - arcsin(x).                 *
 * ===================================================================== */
extern int intarccos(int x)   /* @0x800EAD98 */
{
    return 0x100 - intarcsin(x);
}
