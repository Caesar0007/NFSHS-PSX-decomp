/* syslib/psx/libmath/GTDF2.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\GTDF2.obj ; libmath.lib.  __gtdf2 @0x800F0514 (212 B) -- libgcc double compare
 *   `int __gtdf2(double a, double b)`; soft-float ABI passes a=$a0:$a1, b=$a2:$a3 (lo:hi word pairs).
 *   Returns >0 iff a>b (sign-of-difference convention).
 */
/* MATCH: PASS 53/53 (W53-A12).  Lane: per-TU {"cc1_alt": "2.7.2-970404"}.
 *
 * IDENTITY (whole-cluster, W52-A4 / catalog 04X): retail's libmath is Sony's
 * PREBUILT vendor object, not an EA rebuild -- __gtdf2's 212 retail bytes
 * appear VERBATIM inside PSX/LIB/LIBMATH.LIB of psq43/44/45/47 AND
 * COFF/LIB/LIBMATH.A.  So the ladder, not our 2.8 lane, is the search axis.
 *
 * === THE LEVER THAT SEALED IT (W53-A12): DOUBLE PARAMS + A REGISTER-RESIDENT
 * === `union double_long` -- i.e. the ACTUAL libgcc source shape.
 *
 * The residual W52-A4 left (21 diffs, and the identical 15 on the __ltdf2
 * twin) was ONE named class: a_hi lived in $a1 where retail has it in $t1
 * behind an entry `addu $t1,$a1,$zero`; every other instruction matched.
 * A4 falsified 10 fence placements, block-local qty dials and statement
 * swaps.  The allocator instruments say why no dial could ever work:
 *
 *   -dg for the 4-int-param shape:  p81(a_hi) refs 12 live 39 pri .923 is
 *   allocated FIRST and carries `preferences: 5` (the $a1 parm copy), and
 *   $a1 is in NEITHER its hard-conflict set NOR someone_prefers -- so the
 *   preference block of find_reg hands it $a1 and delete_noop_moves eats
 *   the copy.  `reqdelta --want "p81=t1"` reports NO single- or two-dial
 *   solution in +-40 on refs/live: the fix is a CONFLICT-SET change, which
 *   no allocno dial can express.
 *
 * The conflict-set change comes for free from the right SOURCE SHAPE.  With
 * `double a, double b` under -msoft-float the parameter is ONE DFmode pseudo
 * occupying a REGISTER PAIR, and the union (address never taken, so it stays
 * in that pseudo -- frame 0, verified) keeps it live across blocks:
 *   - `a`'s pair is a GLOBAL allocno; local_alloc has already parked block
 *     temps in $v0/$v1/$a0, so its copy-preference on $a0 is PRUNED (the
 *     pref set is masked by the hard-conflict set) -> no preference left;
 *   - find_reg then scans numerically for an EVEN-ALIGNED free pair
 *     (HARD_REGNO_MODE_OK): 2/3 conflict, 4 conflict, 6/7 conflict -> 8/9.
 *     => a in $t0:$t1, and the parm copy survives as retail's TWO `addu`s.
 *   - `b`'s pair is born one insn later, has no $a2/$a3 conflict, keeps its
 *     preference -> $a2:$a3, copy deleted.  Exactly retail's asymmetry.
 * That single shape change closed 21 diffs at once (and 15 on __ltdf2).
 *
 * KEPT from the W52-A4 basin (each still load-bearing, re-verified):
 *  - CORRECTNESS: the last word test is `if (a_lo <= b_lo) goto lesseq;`
 *    with `greater` as the FALL-THROUGH (oracle `sltu $v0,$a2,$t0; beqz
 *    $v0,.L800F05DC`).  The older `if (b_lo < a_lo) goto greater;` fell
 *    through into `greater` and answered 1 for a positive a strictly LESS
 *    than b -- a real bug, fixed.
 *  - `a_hi < 0` must NOT see a literal 0: every rung folds `x < 0` to
 *    `srl $v0,x,31`, the oracle has `slti $v0,$t1,0`.  A BLOCK-LOCAL runtime
 *    zero (`{ int z = 0; return ua.w.hi < z; }`) expands to `(lt reg reg)` =
 *    `slt`, and cse then substitutes the 0 into the insn -> the oracle's
 *    slti at ZERO instructions.  MUST be block-local (a fn-scope `zero`
 *    spans blocks, cse cannot reach it and the `li` survives, +1 insn).
 *  - the sign-differ tail is spelled `if (ua.w.hi & 0x80000000) return 0;
 *    return 1;` -- NOT `(... & M) == 0` -- which is what emits the oracle's
 *    `lui;and;sltiu` instead of a folded `srl;xori`.
 *  - the W52-A4 opacity fence on a_hi is now REMOVED: it existed only to
 *    mint the a_lo parm copy, which the pair shape provides natively.
 *
 * LADDER (this basin, re-laddered after the landing per 04Z -- the table is
 * NOT the W52 one): 2.7.2-970404 = PASS (0) * 2.6.0/2.6.3/2.7.2 = 14 *
 * 2.8.0/2.8.1 = 22 (count-exact 53/53, pure coloring) * 2.91.66 = 39 *
 * 2.95.2 = 43.  The 970404 snapshot stays wired.
 */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

int __gtdf2(double a, double b)   /* @0x800F0514 */
{
    double_long ua, ub;
    int ae, be, am, bm;

    ua.d = a;
    ub.d = b;
    if (ua.w.hi == ub.w.hi && ua.w.lo == ub.w.lo) return 0;
    if ((ua.w.hi & 0x7fffffff) == 0 && ua.w.lo == 0 &&
        (ub.w.hi & 0x7fffffff) == 0 && ub.w.lo == 0) return 0;
    if ((ua.w.hi & 0x80000000) != (ub.w.hi & 0x80000000)) {
        if (ua.w.hi & 0x80000000) return 0;
        return 1;
    }
    ae = (ua.w.hi >> 20) & 0x7ff;
    be = (ub.w.hi >> 20) & 0x7ff;
    if (be < ae) goto greater;
    if (ae != be) { int z = 0; return ua.w.hi < z; }
    am = (ua.w.hi & 0xfffff) | 0x100000;
    bm = (ub.w.hi & 0xfffff) | 0x100000;
    if (bm < am) goto greater;
    if (am != bm) { int z = 0; return ua.w.hi < z; }
    if (ua.w.lo <= ub.w.lo) goto lesseq;
greater:
    if (ua.w.hi & 0x80000000) return 0;
    return 1;
lesseq:
    { int z = 0; return ua.w.hi < z; }
}
