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
 *   table lookup below.  The table @0x80137260 is owned by the separate SYM-proven asintbl.obj
 *   archive member.  intarccos(x) = 90deg - intarcsin(x).
 */

/* arcsin lookup table is owned by the SYM-proven asintbl.obj archive member. */
extern unsigned char asintbl[512];

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
    /* W71-A15 2026-08-21 -- RE-GATED at 2 @48/48 (baseline confirmed); the w47-a5/w50-a9
     * FENCE BASIN re-derived here and re-measured at 6 @48/48, so both basins reproduce.
     * The W61-A19 combine_regs bound is CONFIRMED and now has a same-wave twin: the exact
     * same mechanism (local-alloc.c:1866 tying an output to an input that dies in the same
     * insn) was CRACKED this wave in sndpsxz/sdmemman.c iSNDpsxmalloc by an identity launder
     * -- but ONLY because the laundered pseudo had a LATER USE there.  That is precisely the
     * ingredient this site cannot supply, which is why every launder variant below stalls at
     * the same 6.  Read the two receipts together before re-opening this one.
     * NEW FALSIFICATIONS (04Z re-measurement; the first two in the 2-diff basin, the rest in
     * the 6-diff fence basin, none < its basin's floor):
     *   2-diff basin: `pt` assigned in BOTH arms of the 0x1FF test so the element-address
     *     pseudo spans blocks (the reg_qty<0 route the W61 bound names) ............ 2 @48/48
     *     -- inert because the 0x1FF arm's `&asintbl[0x1FF]` is a CONSTANT address that
     *     const-props away, so the pseudo never actually becomes multi-block;
     *   2-diff basin: `extern unsigned char asintbl[];` (UNSIZED, the plain declaration
     *     rather than the asm-label view the w50 note tested) ..................... 2 @48/48
     *   6-diff fence basin, all 6 @48/48: unsized `asintbl[]` on top of the fence; a named
     *     `base` temp with `qt` RE-COMPUTED off it (`qt = base + idx`, giving the la a
     *     second use so it should die twice); the same with `qt = &asintbl[idx]` recomputed
     *     off the array; an identity launder on `base` BEFORE the sum; that launder
     *     combined with the recompute.  Worse: the recompute WITHOUT the qt fence 25 @47
     *     (the copy is coalesced away again); `t1 = base[idx + 1]` 26 @48.
     * So in the fence basin the residual is unchanged and precisely stated: the la pseudo
     * is SELF-temped into $v1 and the sum's dest is TIED to it, where retail separates them
     * ($v0 for the la, $v1 for the sum, and the copy then REUSES the la's dead $v0).  It is
     * the same tie as the 2-diff basin's, one level up.  ANGLE UNCHANGED: qtytrace/-dl the
     * la and sum qtys in the fence basin.  Do NOT re-spell the subscript or the fence. */
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
    /* W72-A20 2026-08-22 -- RE-GATED at 2 @48/48 (baseline confirmed) and the w47-a5 /
     * w50-a9 FENCE BASIN re-derived and re-measured at 6 @48/48, so both basins still
     * reproduce byte-for-byte.  NO landing; three NEW falsifications, and one relevant
     * cross-file result recorded because it is the closest device this wave produced.
     *
     * NEW MECHANISM TRIED (untried by every previous wave here): the 21A-1 / 20B
     * ZERO-INSN HARD-REGISTER DENIAL -- a fence carrying a CLOBBER, which is the only
     * instrument that speaks directly to the "which member of the pair gets $v0" question
     * the W50/W61 receipts left open.  All in the 6-diff fence basin, all worse:
     *   read-only clobber fence on a named table base before the sum,
     *     `const unsigned char *bs = asintbl; __asm__("" : : "r"(bs) : "$3");
     *      pt = bs + idx; qt = pt; <identity fence on qt>` .................. 14 @48/48
     *   the SAME clobber attached to the existing `qt` identity fence,
     *     `__asm__("" : "=r"(qt) : "0"(qt) : "$3")` ......................... 21 @47/48
     *     (the $v1 denial also un-does the fence's own job -- the copy is coalesced
     *      away again and we lose the 48th instruction)
     *   control: the published w50-a9 pt/qt + depth-2 form, re-derived .......... 6 @48/48
     * READING: the clobber denies $N to EVERY allocno live at that insn (the 21A-1
     * boundary), and here the la, the sum and the copy are all live in the same tiny
     * window, so there is no placement that separates them.  The W61-A19 combine_regs
     * bound therefore stands unchanged, and so does the named angle: qtytrace/-dl the la
     * and sum qtys in the fence basin.
     *
     * NEGATIVE-CONTROL RESULT (why the brief called this one a control, confirmed): the
     * device that took syslib/libmath/ADDDF3.c from 6 to 2 this same wave -- a DOUBLE
     * identity fence, pointer-first, so that the pointer's materialization becomes the
     * first insn of a call block AND the first occurrence of a shared literal is
     * laundered -- has NO site here.  intarcsin's residual is not a call block and not a
     * shared literal; it is one cse copy-vs-rematerialise decision inside a single basic
     * block.  The W71-A15 statement that this site "cannot supply a LATER USE" for the
     * launder is re-confirmed: it is still the whole reason the launder stalls at 6. */
    if (x <= 0xFA00) {                           /* coarse region: round-to-nearest lookup */
        if (x & 0x40)
            idx = (x >> 7) + 1;
        else
            idx = x >> 7;
        result = asintbl[idx];
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
                t0 = asintbl[0x1FF];
                t1 = 0x100;
            } else {
                t0 = asintbl[idx];
                t1 = asintbl[idx + 1];
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
