/* syslib/psx/libmath/LTDF2.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\LTDF2.obj ; libmath.lib.  __ltdf2 @0x800EB8E4 (220 B) -- libgcc double compare
 *   `int __ltdf2(double a, double b)`; soft-float ABI a=$a0:$a1, b=$a2:$a3 (lo:hi).  Returns <0 iff a<b.
 */
/* MATCH: PASS 55/55 (W53-A12).  Lane: per-TU {"cc1_alt": "2.7.2-970404"}.
 * Twin of GTDF2.c -- READ THAT RECEIPT FIRST for the cluster IDENTITY finding
 * (retail libmath == Sony's PREBUILT vendor LIBMATH objects, byte-verbatim in
 * psq43/44/45/47) and for the full mechanism of the lever below.
 *
 * === THE LEVER (W53-A12), identical to GTDF2's: DOUBLE PARAMS + a
 * === REGISTER-RESIDENT `union double_long` = the real libgcc source shape.
 * W52-A4 left a 15-diff residual that was ONE class: a_hi in $a1 where retail
 * has $t1 + an entry `addu $t1,$a1,$zero`.  It is NOT an allocno-dial problem
 * (reqdelta: no 1-/2-dial solution on refs/live in +-40) -- it is a CONFLICT-SET
 * problem, and the conflict set follows from the parameter SHAPE:
 *   `double a` under -msoft-float is ONE DFmode pseudo = a REGISTER PAIR.  The
 *   union (address never taken -> stays in that pseudo, frame 0) keeps it live
 *   across blocks, so it is a GLOBAL allocno; local_alloc has already parked
 *   block temps in $v0/$v1/$a0, which PRUNES its $a0 copy-preference; find_reg
 *   then takes the first EVEN-ALIGNED free pair = $t0:$t1, and the parm copy
 *   survives as retail's two entry `addu`s.  `b`'s pair keeps its preference
 *   -> $a2:$a3, copy deleted.  Exactly retail's asymmetry, 15 diffs -> 0.
 *
 * KEPT from the W52-A4 basin (branch-polarity shape, all still load-bearing):
 *  1. BLOCK ORDER.  Retail lays less(.L800EB99C) BEFORE greater(.L800EB9AC),
 *     and greater FALLS THROUGH into the shared ret0 (.L800EB9B4).  The last
 *     word compare is `sltu $v0,$t0,$a2; beqz $v0,.L9AC` = the GREATER block is
 *     the beqz target and LESS is the fall-through -- so the source reads
 *     `if (b_lo <= a_lo) goto greater;` with `less:` immediately after.
 *  2. The sign-differ arm ends `return 0;`, NOT `goto ret0;`: the literal
 *     return lets gcc emit `bnez $v1,<epilogue>` with the value in the delay
 *     slot; the goto inverts the branch to beqz and wastes the slot.
 *  3. Same for the `less` arm: `if (ua.w.hi < 0) return 0;` not `goto ret0;`
 *     -- retail's `bltz $t1,.L9B8` carries `addu $v0,$zero,$zero` in its delay
 *     slot, which only the literal return produces.  `greater` KEEPS its
 *     fall-through into ret0 (that one really is the shared block).
 *  - the W52-A4 opacity fence on a_hi is REMOVED: it existed only to mint the
 *    a_lo parm copy, which the pair shape now provides natively.
 *
 * LADDER (this basin, re-laddered after the landing per 04Z -- NOT the W52
 * table): 2.7.2-970404 = PASS (0) * 2.8.0/2.8.1 = 6 (count-exact 55/55) *
 * 2.91.66 = 20 * 2.95.2 = 24 * 2.6.0/2.6.3/2.7.2 = 25.  The 970404 snapshot
 * stays wired; note 2.8.x is now the RUNNER-UP here (it was mid-table before
 * the landing) -- a fresh confirmation of 04Z basin-relativity.
 */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

int __ltdf2(double a, double b)   /* @0x800EB8E4 */
{
    double_long ua, ub;
    int ae, be, am, bm;

    ua.d = a;
    ub.d = b;
    if (ua.w.hi == ub.w.hi && ua.w.lo == ub.w.lo) return 0;
    if ((ua.w.hi & 0x7fffffff) == 0 && ua.w.lo == 0 &&
        (ub.w.hi & 0x7fffffff) == 0 && ub.w.lo == 0) goto ret0;
    if ((ua.w.hi & 0x80000000) != (ub.w.hi & 0x80000000)) {
        if (ua.w.hi & 0x80000000) return -1;
        return 0;
    }
    ae = (ua.w.hi >> 20) & 0x7ff;
    be = (ub.w.hi >> 20) & 0x7ff;
    if (ae < be) goto less;
    if (ae != be) goto greater;
    am = (ua.w.hi & 0xfffff) | 0x100000;
    bm = (ub.w.hi & 0xfffff) | 0x100000;
    if (am < bm) goto less;
    if (am != bm) goto greater;
    if (ub.w.lo <= ua.w.lo) goto greater;
less:
    if (ua.w.hi < 0) return 0;
    return -1;
greater:
    if (ua.w.hi < 0) return -1;
ret0:
    return 0;
}
