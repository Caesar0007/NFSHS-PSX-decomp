/* syslib/psx/libmath/GTDF2.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\GTDF2.obj ; libmath.lib.  __gtdf2 @0x800F0514 (212 B) -- libgcc double compare
 *   `int __gtdf2(double a, double b)`; soft-float ABI passes a=$a0:$a1, b=$a2:$a3 (lo:hi word pairs).
 *   Returns >0 iff a>b (sign-of-difference convention).  IDA Hex-Rays (fresh NFS4.EXE.i64), verbatim.
 */
/* MATCH (W52-A4, 40 -> 21 diffs; RECOMMEND per-TU {"cc1_alt": "2.7.2-970404"}).
 * Supersedes the W51-A6 note.  Four findings, in order of value:
 *
 * 1. IDENTITY (whole-cluster): retail's libmath is Sony's PREBUILT vendor object,
 *    not an EA rebuild -- __gtdf2's 212 retail bytes appear VERBATIM inside
 *    PSX/LIB/LIBMATH.LIB of psq43/44/45/47 AND COFF/LIB/LIBMATH.A (ECOFF magic
 *    0x0162, symbols `gtdf2.c` + `gcc2_compiled.` + `__gnu_compiled_c`).  The
 *    same holds for every fn in this directory (10/10 checked).  So the target
 *    is a mid-90s gcc-2.x mips-ecoff build that Sony shipped unchanged for years
 *    -- the ladder, not our 2.8 lane, is the right search axis.
 *
 * 2. CORRECTNESS BUG (fixed here): the old body ended
 *        if (b_lo < a_lo) goto greater;
 *      greater: ...
 *    so the a_lo <= b_lo case FELL THROUGH into `greater` and answered 1 for a
 *    positive a that is strictly LESS than b.  The oracle's last test is
 *    `sltu $v0,$a2,$t0; beqz $v0,.L800F05DC(lesseq)` -- fall-through is the
 *    greater block.  Written `if (a_lo <= b_lo) goto lesseq;` + greater as the
 *    fall-through, which is both correct and the oracle's exact block layout.
 *    (gcc had been DELETING the redundant test; that was the tell.)
 *
 * 3. `a_hi < 0` must NOT see a literal 0.  Every ladder rung (2.6.0..2.95.2)
 *    folds `x < 0` to `srl $v0,x,31`; the oracle has `slti $v0,$t1,0`.  A
 *    BLOCK-LOCAL runtime zero (`{ int z = 0; return a_hi < z; }`) expands to
 *    `(lt reg reg)` = `slt` and cse then substitutes the 0 IN THE INSN -> the
 *    oracle's slti, at ZERO instructions.  Must be block-local: one fn-scope
 *    `zero` spans blocks, cse cannot reach it and the `li` survives (+1 insn,
 *    measured 36 vs 33).  Same family as the `^ zero` device (methodology 3.13).
 *    The `greater` tail is the branched `if (a_hi & 0x80000000) return 0;
 *    return 1;` -- that spelling (NOT `(a_hi & M) == 0`) is what emits the
 *    oracle's `lui;and;sltiu` instead of a folded `srl;xori`.
 *
 * 4. OPACITY FENCE on a_hi mints retail's entry parm copy for a_lo
 *    (`addu $t0,$a0,$zero`): killing the copy-preference lets `ae` take $a0.
 *    Worth 2 diffs; every placement variant measured identical (10 probed).
 *
 * LADDER (this basin): 2.7.2-970404 = 21 * BASE/2.6.0/2.6.3/2.7.2 = 33 *
 * 2.8.0/2.8.1 = 35 * 2.91.66/2.95.2 = 68.  Basin-relative: before levers 2-4
 * the same table read 36/40/46/58, so re-ladder after every landing.
 *
 * RESIDUAL (21, ONE named class): a_hi lives in $a1, retail has it in $t1 with
 * an entry `addu $t1,$a1,$zero`.  EVERY other instruction is identical.  All 10
 * fence placements plateau at 21; nothing in the fn prefers or conflicts on $a1,
 * so find_reg's numeric scan hands a_hi the lowest free reg.  ANGLE (untried):
 * make some other allocno PREFER $a1 (find_reg skips regs_someone_prefers) --
 * i.e. an allocno dial on `ae`/`be`, not another fence.  NOT a floor. */
int __gtdf2(unsigned int a_lo, int a_hi, unsigned int b_lo, int b_hi)   /* @0x800F0514 */
{
    int ae, be, am, bm;
    __asm__("" : "=r"(a_hi) : "0"(a_hi));
    if (a_hi == b_hi && a_lo == b_lo) return 0;
    if ((a_hi & 0x7fffffff) == 0 && a_lo == 0 &&
        (b_hi & 0x7fffffff) == 0 && b_lo == 0) return 0;
    if ((a_hi & 0x80000000) != (b_hi & 0x80000000)) {
        if (a_hi & 0x80000000) return 0;
        return 1;
    }
    ae = (a_hi >> 20) & 0x7ff;
    be = (b_hi >> 20) & 0x7ff;
    if (be < ae) goto greater;
    if (ae != be) { int z = 0; return a_hi < z; }
    am = (a_hi & 0xfffff) | 0x100000;
    bm = (b_hi & 0xfffff) | 0x100000;
    if (bm < am) goto greater;
    if (am != bm) { int z = 0; return a_hi < z; }
    if (a_lo <= b_lo) goto lesseq;
greater:
    if (a_hi & 0x80000000) return 0;
    return 1;
lesseq:
    { int z = 0; return a_hi < z; }
}
