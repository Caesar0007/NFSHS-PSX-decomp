/* syslib/psx/libmath/ADDDF3.c -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays). C lane (3.25, task #90).
 *   obj ADDDF3.obj ; libmath.lib.  __adddf3 @0x800F5A54 (884 B) -- IEEE-754 double add (and, via sign, the
 *   subtract path).  Aligns exponents, adds/subtracts 64-bit mantissas (sign-magnitude through _mainasu),
 *   renormalises, round-to-nearest.  IDA verbatim; the __int64 accumulator v12 is a union (`.ll` for the
 *   64-bit compares/masks, `.w[2]` for the helper word-writes).  Overflow -> _err_math(34,11).
 */
/* W52-A4 CLUSTER IDENTITY (applies to every TU in this directory):
 * retail's libmath is NOT an EA rebuild -- it is Sony's PREBUILT vendor object.
 * Each function's retail bytes appear VERBATIM inside the shipped PsyQ
 * PSX/LIB/LIBMATH.LIB of psq43 / psq44 / psq45 / psq47(Lib43,44,45) AND inside
 * psq43/COFF/LIB/LIBMATH.A (ECOFF magic 0x0162; members named adddf3.o,
 * muldf3.o, ... with symbols `<name>.c` + `gcc2_compiled.` + `__gnu_compiled_c`).
 * Verified 10/10 fns: EXACT where the fn has no relocs, HI16-masked where it
 * has jal/%hi (scratchpad/w52a4_libscan.py).  Identical in every SDK drop from
 * 4.0 to 4.7 => Sony compiled it ONCE with a mid-90s gcc-2.x mips-ecoff and
 * shipped that binary unchanged for years.  CONSEQUENCE: the search axis for
 * this cluster is the COMPILER LADDER (04U), not our 2.8 flag space, and no
 * public source exists for it (Sony's own soft-float: _dbl_shift/_add_mant_d/
 * _mainasu/_comp_mant/_mul_mant_d are NOT FSF libgcc2/fp-bit names; searched
 * rage-racer-decomp + psyz + the whole disk -- nothing).  Full ladder tables and
 * the cracked levers are in GTDF2.c / LTDF2.c / MULSF3.c. */
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_mainasu(int *out, int a2, int a3);
int           _err_math(int errnum, int code);

/* MATCH (2026-08-14): 347 -> 67 diffs (ours 222 / oracle 221).  Lane UNCHANGED
 * {"cc1_alt": "2.7.2-970404"}.  04Z re-ladder on the landed basin: 2.6.0/2.6.3
 * = 128 * 2.7.2-970404 = 126 (count-exact) * 2.7.2 = 125 (222 insns) *
 * 2.8.0/2.8.1 = 126 (count-exact) * 2.91.66 = 269 * 2.95.2 = 233.  The wired
 * 970404 rung stays: it is count-exact and within 1 of the best.
 *
 * LANDINGS: 347 -> 138 the 05B `double` params + `double_long` unions + the
 * 32-bit normalisation tests (the old body compared the 64-bit `union I64`
 * with `long long` operators -- retail only ever ANDs A[1], the HIGH word);
 * 138 -> 126 (a) the zero-double spelled as a union with an ARRAY member; the
 * later `zp` address escape completes the required frame placement (retail
 * `sw zero,0x30/0x34` ... `lw v0,0x30;
 * lw v1,0x34`; the struct form kept it in two registers = 3 wasted insns),
 * and (b) the SECOND early `return b` spelled `return ub.d` so it uses the
 * $s0:$s1 copy the way retail does (the FIRST one legitimately still uses the
 * live $a2:$a3).
 *
 * The latest reduction makes the zero-union address escape through `zp`, forcing
 * retail's stack-backed 0x30/0x34 representation, and keeps a named sign mask
 * live across both sign tests and the result-sign assignment.  That moves the
 * function from 126 to 67 and establishes the retail 0x60-byte frame and $s7
 * result-sign lifetime without asm or volatile.
 *
 * MATCH (W61-A9, 2026-08-15): 67 -> 12 diffs, and the stream is now COUNT-EXACT
 * (221/221).  Four statement-position landings, no asm, no volatile, no wiring
 * change (04Z re-ladder on the NEW basin, whole-TU: 2.6.0/2.6.3 = 52 *
 * 2.7.2 = 49 * 2.7.2-970404 = 12 (WIRED, optimal by 20) * 2.8.0/2.8.1 = 32 *
 * 2.91.66 = 163 * 2.95.2 = 212):
 *   (1) `sign = 0x80000000;` as a LITERAL, not `sign = signMask;`.  The copy
 *       from the named mask was worth 24 diffs: it made retail rematerialize
 *       `lui $s7,0x8000` unreachable AND it held signMask live to the end, which
 *       is what rotated the {be,mask} = {$s5,$s6} seats.  Writing the literal
 *       shortens signMask's live range and the seats snap to retail by
 *       themselves -- the standing "one allocation seat, needs a ref-count dial"
 *       angle was solved by DELETING a ref, not adding one.  67 -> 43.
 *   (2) `rnd[1] = 0;` moved between `k = 255;` and the k-select `if`.  reorg
 *       fills the beqz slot from the nearest preceding movable insn: with the
 *       store there it steals `sw zero,44(sp)` (retail) instead of `li v1,255`,
 *       and the freed `li` then fills the `lw v0,24(sp)` load-delay slot.
 *       43 -> 38.
 *   (3+4) `ae += 1;` moved AFTER its `_dbl_shift(...,1,...,1)` call at BOTH
 *       sites, and `sign = 0x80000000;` moved AFTER its `_mainasu` call.
 *       38 -> 18 -> 12.  KEY: LAW REFINEMENT (sharpens the w60-a5 DIVDF3 row
 *       "reorg can only steal what PRECEDES the jal"): reorg fills a CALL delay
 *       slot from EITHER side.  A statement written BEFORE the call competes
 *       with the argument setup and usually loses (the arg move is nearer);
 *       written AFTER the call it is the nearest candidate in the forward scan
 *       and wins, provided it touches no caller-saved register (`ae` and `sign`
 *       both live in $s4/$s7).  Pick the side by which insn retail put in the
 *       slot: retail's slot insn is the one that must sit on the side reorg
 *       scans first.
 *
 * RESIDUAL (12) -- ALL FOUR are one class, "ours cse-shares a live value where
 * retail re-materializes / re-loads" (the 3b old-gcc no-copy-prop identity):
 *   (a) x2 `addu v0,a1,zero` vs retail `li v0,1` -- the two literal `1`s of
 *       `_dbl_shift(A, 1, A[0], A[1], 1)` (register arg2 + stack arg5).
 *   (b) `addu a3,v1,zero` vs retail `lw a3,40(sp)` -- store-to-load forwarding
 *       of `rnd[0]` at the `_add_mant_d` rounding call.
 *   (c) `addu s0,v1,zero` vs retail `lui s0,57344` -- the 0xE0000000 loop mask
 *       re-materialized in the preheader instead of copied from the peeled test.
 *   (d) `sw zero,48(sp)` scheduled at prologue index 1 by retail, index 19 by us
 *       (sched2 luid order inside the prologue block), plus the paired
 *       `lw a3,32(sp)` arg-order row at the first `_add_mant_d` (11B).
 *   FALSIFIED at this basin (whole-TU gated, scratchpad/w61a9/add_v*.json):
 *   rnd through a pointer local `rp` 17 * rnd[0] AND rnd[1] through `rp` 20 *
 *   identity fence on `k` after the store 12 (inert) * named `int one = 1;` for
 *   the count arg 12 (inert -- constant-propagated) * named `normMask` for the
 *   loop constant 16 * `zp[1]` before `zp[0]` 14 * `sign = 0;` hoisted above the
 *   zp stores 12 (inert) * zp stores after `ua.d`/`ub.d` 12 (inert) * `uz.w[1]`
 *   spelled directly instead of `zp[1]` 12 (inert) * all 8 ladder rungs (above).
 *   NAMED NEXT ANGLE: this is a cse COST-MODEL delta, not a spelling -- in
 *   gcc-2.7 `cse_insn` only substitutes when `rtx_cost` strictly improves, so
 *   retail's cc1 scored a 16-bit `li`/`lui` at the same cost as a reg copy and
 *   kept the constant.  The reachable lever is therefore an instrument question
 *   (dump cse's table on the 970404 rung and find which source shape stops the
 *   value being RECORDED), or a rung not on our ladder.  Not a floor.
 *
 * W71-A12 (2026-08-21) -- RE-GATED at 8 (221/221; the w63/w64 TEXT_MOVES rows had
 * already taken 12 -> 8).  ONE landing + one wiring spec + two new falsifications.
 *
 * LANDED (source): row (b) -- the 05E VOLATILE VIEW ON THE READ, the device the
 * W61-A9 receipt had NOT tried here (it tried `rp` pointer locals instead):
 *     `_add_mant_d(A, A[0], A[1], *(volatile int *)&rnd[0], rnd[1]);`
 * That converts `addu $a3,$v1,$zero` into retail's `lw $a3,0x28($sp)`, i.e. it turns
 * a VALUE row (cse store-to-load forwarding, source-unreachable per the W61 cse
 * cost-model analysis) into a pure 11B arg-EMISSION-ORDER row -- which IS mechanically
 * fixable.  Diff-neutral on its own (8), and it is what the wiring spec below needs.
 * Only rnd[0] takes the volatile view; rnd[1] is the stack (5th) arg and retail
 * register-forwards it too -- same rule as MULDF3/_mul_mant_d.
 *
 * 🔧 ORCHESTRATOR WIRING SPEC (probe-verified 2x, 8 -> 6, count stays 221/221):
 *   in tools/build.py PER_FN_TEXT_MOVES["recon/syslib/psx/libmath/ADDDF3.c"]["__adddf3"],
 *   DUPLICATE the existing row 0 (the generic 11B `lw $7` row) and INSERT the copy at
 *   index 1 (i.e. rows = [row0, row0-copy, row1]).  Row 0 currently fires at the first
 *   `_add_mant_d` (arg4 = B[0], `lw $7,32($sp)`); the copy fires at the rounding
 *   `_add_mant_d` (arg4 = rnd[0], `lw $7,40($sp)`), which the volatile view above just
 *   created.  The row's regex already tolerates the `#.set volatile` wrapper maspsx
 *   emits around it (verified against build/.../ADDDF3.c.s lines 303-311).  No branch
 *   word is touched (the moved line is a `lw`).  Probe harness:
 *   `python scratchpad/A12_w71/tmprobe.py recon/syslib/psx/libmath/ADDDF3.c __adddf3
 *    "recon/syslib/psx/libmath/ADDDF3.c" __adddf3 0 1`  (loads build.py from source,
 *   mutates PER_FN_TEXT_MOVES in memory, then execs verify_asm against it -- it never
 *   writes to tools/).
 *
 * 🔑 NEW ANGLE ON ROW (a), the two `addu $v0,$a1,$zero` vs `li $v0,1` -- HALF-CRACKED,
 * and the half that is left is a TEXT_MOVES row, not a cse question.  The W61 receipt
 * filed "named `int one = 1;` 12 (inert -- constant-propagated)"; the fix for that is
 * an IDENTITY FENCE on the named constant, which makes it OPAQUE so cse cannot equate
 * it with the `1` already sitting in $a1:
 *     if (A[1] & 0x40000000) {
 *         int one; one = 1; __asm__("" : "=r"(one) : "0"(one));
 *         _dbl_shift((unsigned int *)A, 1, A[0], A[1], one);
 *         ae += 1;
 *     }
 * MEASURED: both `addu $v0,$a1,$zero` rows DISAPPEAR -- we emit retail's `li $v0,1` at
 * both sites -- but the whole-fn score goes 8 -> 12, because the opaque `li $2,1` is
 * emitted BEFORE the argument setup and reorg then steals IT for the `beq $2,$0,$L17`
 * delay slot instead of retail's `addu $4,$sp,24`.  Ours becomes
 *   `beq; li $2,1 [slot]; addu $4,$sp,24; li $5,1; sw $2,16($sp)`
 * against retail's
 *   `beq; addu $4,$sp,24 [slot]; li $5,1; li $2,1; sw $2,16($sp)`
 * i.e. a ONE-LINE relocation at each of the two sites (take the `li $2,1`, put it after
 * `li $5,1`; the freed slot then re-fills with `addu $4,$sp,24`).  ALSO FALSIFIED here:
 * the same constant written as a GCC statement-expression argument
 * `({ int one; one = 1; __asm__("" : "=r"(one) : "0"(one)); one; })` -- identical 12,
 * because expand_call PRECOMPUTES an argument with side effects, so the `li` still
 * lands ahead of the arg-store loop.  ==> row (a) is reachable as
 * [identity-fenced `one` in-source] + [2 TEXT_MOVES rows], total residual would be the
 * single row (c).  Not landed in this wave: it trades 4 gate-visible diffs for 2
 * unprobed TEXT_MOVES rows, and the wave budget went to _mul_mant_d (now PASS).
 *
 * ROW (c) `addu $s0,$v1,$zero` vs `lui $s0,57344` -- TWO MORE FALSIFICATIONS (both
 * whole-fn gated at 8, i.e. inert): the 05H/07A BARE-CONSTANT device that cracked
 * MULDF3's `lui $s0,0x8000` does NOT transfer here.  Tried: an explicit peel
 * `if ((A[1] & 0xE0000000) == 0) { normMask = 0xE0000000; <identity fence>; do {...}
 * while (((unsigned)A[1] & normMask) == 0); }` with ONE fence, and the same with THREE
 * fences (the exact MULDF3 recipe).  WHY IT CANNOT WORK HERE (the law refinement): an
 * identity fence LAUNDERS a value, it does not RE-MATERIALIZE it -- the `"0"` constraint
 * ties the output to the input register, so cse still forwards the peeled test's
 * `lui $v1,57344` INTO the fence and we get the same `addu $s0,$v1,$zero`.  MULDF3's
 * signmask worked because its OTHER sign test was spelled `acc[1] < 0` (`bgez`) and
 * therefore materialized NO constant for cse to forward from.  Here BOTH the peeled
 * test and the loop test need the same 32-bit constant, so any spelling gives cse a
 * partner.  The reachable levers are unchanged from W61: a cse-table instrument read on
 * the 970404 rung, or a TEXT_MOVES/rung answer.  NOT a floor.
 *
 * 🏆 W72-A20 (2026-08-22) -- RE-GATED at 6 (the W71 wiring spec landed: 8 -> 6) and
 * taken 6 -> 2, COUNT-EXACT 221/221, SOURCE-ONLY.  Rows (a) x2 are GONE and NO
 * TEXT_MOVES row was needed.  The W71 spec below (identity-fence `one` + 2 relocation
 * rows per site) is SUPERSEDED -- it is still correct (probe-verified again this wave,
 * see the ledger) but the pure-source form is strictly better.
 *
 *   🔑 THE DEVICE: A DOUBLE IDENTITY FENCE, POINTER-FIRST (new catalog row candidate).
 *   At BOTH `if (A[1] & 0x40000000) { _dbl_shift(A,1,A[0],A[1],1); ae += 1; }` sites:
 *       int *ap = A;
 *       int one = 1;
 *       __asm__("" : "=r"(ap) : "0"(ap));
 *       __asm__("" : "=r"(one) : "0"(one));
 *       _dbl_shift((unsigned int *)ap, one, A[0], A[1], 1);
 *   TWO INDEPENDENT JOBS THAT ONLY WORK AS A PAIR:
 *     * `one` is the 21E-5 CSE-CONSTANT-SHARING BREAKER APPLIED TO THE *FIRST*
 *       OCCURRENCE.  The two literal `1`s are arg2 (register, emitted first) and arg5
 *       (stack).  cse serves the stack one as a copy of $a1 (`addu $v0,$a1,$zero`).
 *       Laundering ARG2 makes the first occurrence opaque, so the second re-materializes
 *       retail's `li $v0,1`.  The W71 receipt fenced arg5 (the SECOND occurrence) --
 *       that also kills both rows but the opaque `li` is then emitted ahead of the whole
 *       argument block and reorg steals IT for the `beq` slot (+4).
 *     * `ap` is a POSITION dial: the fence's operand is materialized at the fence, so
 *       `addiu $a0,$sp,24` becomes the FIRST insn of the call block and reorg's eager
 *       steal puts THAT in the `beq` delay slot -- which is exactly retail's slot.
 *   MEASURED (whole-fn gate, this basin): baseline 6 | `one` fence alone at site 1 8,
 *   at both sites 10 (the W71 number, reproduced) | `ap` fence alone at both sites 6
 *   (inert -- it fixes the slot but leaves the shared constant) | BOTH at site 1 only
 *   (not run) | BOTH at both sites 2.  Order inside the block is load-bearing only in
 *   that `ap`'s fence must precede `one`'s (they are emitted in fence order).
 *
 *   FOR THE RECORD -- the W71 TEXT_MOVES route, re-probed and CONFIRMED this wave before
 *   the source form was found (scratchpad/W72_A20/rows_add_a.json + a20_tmprobe.py):
 *   with ONLY `one` fenced at both sites, appending FOUR rows [A,B,A,B] where
 *     A = take `(?<=\tbeq\t\$2,\$0,\$L\d\d\n)\tli\t\$5,1[^\n]*\n`
 *         after `\taddu\t\$4,\$sp,24\n(?=\tli\t\$2,1[^\n]*\n)`
 *     B = take `\taddu\t\$4,\$sp,24\n(?=\tli\t\$5,1[^\n]*\n\tli\t\$2,1[^\n]*\n)`
 *         after `\tbeq\t\$2,\$0,\$L\d\d\n(?=\t\.set\t macro\n)`   [no space -- see json]
 *   gates 2 as well (10 -> 2, objdump-verified: each site becomes
 *   `beq; addiu $4,$sp,24 [slot]` + `li $5,1; li $2,1; sw $2,16($sp)` = retail's words).
 *   Rows-without-fences is INERT (6), so the pair was safe -- but the source form needs
 *   no wiring at all, so THE ROWS WERE NOT REQUESTED.
 *
 * RESIDUAL (2) = row (c) ONLY: `addu $s0,$v1,$zero` vs retail `lui $s0,57344`, the
 * 0xE0000000 normalisation mask copied from the peeled entry test instead of being
 * re-materialized in the loop preheader.  NEW FALSIFICATIONS in the W72 basin (04Z
 * re-measurement -- every one of these was re-run AFTER the double-fence landed):
 *   explicit peel `if (mask==0) do{...}while(mask==0)` (two source occurrences) .. 2 (inert)
 *   same + a named `normMask` ASSIGNED IN THE LOOP BODY (21B-3 born-in-the-loop) .. 2 (inert)
 *   same + an identity fence on `normMask` INSIDE the guarded block ............... 2 (inert)
 *   a fenced `normMask` materialized BEFORE the entry test (15B born-first) ....... 5 @222
 *   the 21E-5 form -- fence the ENTRY test's OWN mask, loop uses the literal ...... 13 @222
 *     (+1 = a load-delay `nop`: with the mask pre-materialized nothing is left to fill
 *      the `lw $v1,28($sp)` slot, where retail's own `lui` is the filler)
 * MECHANISM, restated and now confirmed from both sides: an identity fence LAUNDERS,
 * it does not RE-MATERIALIZE (the `"0"` tie forwards cse's value into the fence), and
 * the only occurrence whose materialization we could make opaque is the one whose
 * `lui` retail uses as a delay-slot filler.  Live routes unchanged: a cse-table
 * instrument read on the 970404 rung, or TEXT_MOVES.  NOT a floor.
 *
 * 📚 W72-A20 CORPUS VERDICT -- THE fp-bit LINEAGE QUESTION IS SETTLED (see FIXDFSI.c
 * for the decisive receipt): retail's LIBMATH double soft-float is NOT FSF `fp-bit.c`
 * (that file's fp_number_type/unpack/pack machinery has no relation), but it IS
 * derived from FSF **`gcc-2.8.1/floatlib.c`** -- the W52-A4 header note above should be
 * read as "not fp-bit, and the HELPER NAMES are Sony's", not "no FSF ancestor".  Proof
 * chain: floatlib's `__fixdfsi` uses the byte-exact same `EXPD - EXCESSD - 31` (= our
 * `v4 - 1053`) and the exact `if (<range> && l) l >>= -exp; else return 0;` shape that
 * took __fixdfsi to PASS this wave; floatlib's appended Barrett-Richardson `__divdf3`
 * is paired with a two-word mantissa comparator `__dcmp` == Sony's `_comp_mant`, and
 * DIVDF3.obj ships exactly that pair.  floatlib's own `__adddf3` is a punt-to-float
 * stub, so THIS function has no ready-made body in the corpus -- Sony wrote the double
 * add themselves around the same helper decomposition.  Source read from
 * C:\Temp\gcc-2.8.1-src\gcc281.tar.gz (gcc-2.8.1/floatlib.c, gcc-2.8.1/config/fp-bit.c,
 * gcc-2.8.1/libgcc2.c); none of _dbl_shift/_add_mant_d/_mainasu/_comp_mant/_mul_mant_d
 * appears in any of them (grep-confirmed), and none appears in C:\Temp\windows-gcc-psx.
 * Vendor-byte cross-check: psyq43/extracted LIBMATH/obj/*.obj are retail verbatim
 * (objtruth `diff` on FIXDFSI = 64/64 words, 0 drift) -- 04X re-confirmed.
 *
 * ---- shape notes ----
 * Same 05B soft-float PAIR shape + oracle re-derivation as DIVDF3.c/MULDF3.c.
 * Oracle tells (frame 0x60): a -> $s2:$s3, b -> $s0:$s1 (BOTH DFmode pairs land
 * in EVEN-ALIGNED CALLEE-SAVED pairs because both live across calls); the RESULT
 * reuses a's pair (`addu v0,s2; addu v1,s3`), i.e. the result union IS `ua`.
 * Frame local map == declaration order: 0x18 A[2] | 0x20 B[2] | 0x28 rnd[2],
 * then the spilled zero-double at 0x30.  `B` is reached through a POINTER LOCAL
 * ($s1 = sp+0x20, `addu a0,s1,zero`) at two sites.  The normalisation tests are
 * 32-bit on A[1] ONLY (`and v0,v0,0xE0000000`), NOT the 64-bit `long long`
 * compares the old IDA transcription used -- that alone was worth ~10 insns.
 * Retail spells the sign tests asymmetrically (`bgez` for A, mask test for B).
 * The current named-mask form deliberately tests both through the same mask: it
 * adds one instruction but raises the mask allocation quantity and is the verified
 * lower-diff basin from which the final $s5/$s6 priority swap can be solved. */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

double __adddf3(double a, double b)   /* @0x800F5A54 */
{
    double_long ua, ub;
    union { double d; int w[2]; } uz;   /* ARRAY member + the `zp` address escape
                                         * force the frame, which is what retail's
                                         * `sw zero,0x30/0x34` + `lw v0,0x30;
                                         * lw v1,0x34` return path shows. */
    int A[2];     /* 0x18 */
    int B[2];     /* 0x20 */
    int rnd[2];   /* 0x28 */
    int *zp;
    int *bp;
    int ae, be, k;
    int sign;
    int signMask;

    zp = uz.w;
    zp[0] = 0;
    zp[1] = 0;
    sign = 0;
    ua.d = a;
    ub.d = b;
    if ((ua.w.hi & 0x7FFFFFFF) == 0 && ua.w.lo == 0) return b;
    if ((ub.w.hi & 0x7FFFFFFF) == 0 && ub.w.lo == 0) return ua.d;
    ae = (ua.w.hi >> 20) & 0x7FF;
    be = (ub.w.hi >> 20) & 0x7FF;
    if (be + 54 < ae) return ua.d;
    if (ae + 54 < be) return ub.d;
    A[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
    A[0] = ua.w.lo;
    B[1] = (ub.w.hi & 0xFFFFF) | 0x100000;
    B[0] = ub.w.lo;
    signMask = 0x80000000;
    if (ua.w.hi & signMask) _mainasu(A, A[0], A[1]);
    if (ub.w.hi & signMask) _mainasu(B, B[0], B[1]);
    _dbl_shift((unsigned int *)A, 0, A[0], A[1], 9);
    bp = B;
    _dbl_shift((unsigned int *)bp, 0, B[0], B[1], 9);
    if (be < ae) {
        _dbl_shift((unsigned int *)bp, 1, B[0], B[1], ae - be);
    } else {
        _dbl_shift((unsigned int *)A, 1, A[0], A[1], be - ae);
        ae = be;
    }
    _add_mant_d(A, A[0], A[1], B[0], B[1]);
    if (A[1] < 0) {
        _mainasu(A, A[0], A[1]);
        sign = 0x80000000;
    } else if (A[1] == 0 && A[0] == 0) {
        return uz.d;
    }
    while ((A[1] & 0xE0000000) == 0) {
        _dbl_shift((unsigned int *)A, 0, A[0], A[1], 1);
        ae -= 1;
    }
    if (A[1] & 0x40000000) {
        /* W72-A20 DOUBLE IDENTITY FENCE -- DO NOT DELETE EITHER HALF, DO NOT REORDER.
         * Zero insns.  Two independent jobs that only work as a PAIR (see the receipt
         * above): (1) the `ap` launder makes `addiu $a0,$sp,24` the FIRST insn of the
         * call block, so reorg's eager steal puts THAT in the `beq`'s delay slot like
         * retail (unfenced, the block starts with `li $5,1` and reorg steals that);
         * (2) the `one` launder is the 21E-5 cse-constant-sharing breaker on the FIRST
         * occurrence of the literal 1 -- with arg2 opaque, cse can no longer serve the
         * 5th (stack) argument's `1` as a copy of $a1, so it re-materializes retail's
         * `li $v0,1`.  Fencing only `one` (the W71 receipt's form) fixes (2) but the
         * `li` then lands ahead of the arg setup and reorg steals IT (+4); fencing only
         * `ap` fixes (1) alone (inert, 6). */
        int *ap = A;
        int one = 1;
        __asm__("" : "=r"(ap) : "0"(ap));
        __asm__("" : "=r"(one) : "0"(one));
        _dbl_shift((unsigned int *)ap, one, A[0], A[1], 1);
        ae += 1;
    }
    k = 255;
    rnd[1] = 0;
    if ((A[0] & 0x200) != 0) k = 256;
    rnd[0] = k;
    _add_mant_d(A, A[0], A[1], *(volatile int *)&rnd[0], rnd[1]);
    if (A[1] & 0x40000000) {
        /* W72-A20 DOUBLE IDENTITY FENCE -- second site, identical recipe (see above). */
        int *ap = A;
        int one = 1;
        __asm__("" : "=r"(ap) : "0"(ap));
        __asm__("" : "=r"(one) : "0"(one));
        _dbl_shift((unsigned int *)ap, one, A[0], A[1], 1);
        ae += 1;
    }
    _dbl_shift((unsigned int *)A, 1, A[0], A[1], 9);
    A[1] &= 0xFFEFFFFF;
    if (ae >= 2047) {
        _err_math(34, 11);
        ua.w.hi = sign ? 0xFFF00000 : 0x7FF00000;
        ua.w.lo = 0;
    } else {
        ua.w.hi = sign | (ae << 20) | A[1];
        ua.w.lo = A[0];
    }
    return ua.d;
}
