/* syslib/psx/libmath/LTDF2.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\LTDF2.obj ; libmath.lib.  __ltdf2 @0x800EB8E4 (220 B) -- libgcc double compare
 *   `int __ltdf2(double a, double b)`; soft-float ABI a=$a0:$a1, b=$a2:$a3 (lo:hi).  Returns <0 iff a<b.
 *   IDA Hex-Rays (fresh NFS4.EXE.i64), verbatim.
 */
/* MATCH (W52-A4, 29 -> 15 diffs; RECOMMEND per-TU {"cc1_alt": "2.7.2-970404"}).
 * Supersedes the W51-A6 note.  Twin of GTDF2.c -- read that receipt first for
 * the cluster-level IDENTITY finding (retail libmath == Sony's PREBUILT vendor
 * LIBMATH objects, byte-verbatim in psq43/44/45/47 PSX/LIB/LIBMATH.LIB and
 * COFF/LIB/LIBMATH.A; __ltdf2's 220 bytes confirmed EXACT).
 *
 * Three shape corrections, all read off the oracle's branch polarity:
 *  1. BLOCK ORDER.  Retail lays less(.L800EB99C) BEFORE greater(.L800EB9AC),
 *     and greater FALLS THROUGH into the shared ret0 (.L800EB9B4).  The last
 *     word compare is `sltu $v0,$t0,$a2; beqz $v0,.L9AC` = the GREATER block is
 *     the beqz target and LESS is the fall-through -- so the source reads
 *     `if (b_lo <= a_lo) goto greater;` with `less:` immediately after.
 *  2. The sign-differ arm ends `return 0;`, NOT `goto ret0;` (-4): the literal
 *     return lets gcc emit `bnez $v1,<epilogue>` with the value in the delay
 *     slot; the goto inverts the branch to beqz and wastes the slot.
 *  3. Same for the `less` arm: `if (a_hi < 0) return 0;` not `goto ret0;` (-4)
 *     -- retail's `bltz $t1,.L9B8` carries `addu $v0,$zero,$zero` in its delay
 *     slot, which only the literal return produces.  `greater` KEEPS its
 *     fall-through into ret0 (that one really is the shared block).
 *  + the GTDF2 opacity fence on a_hi (worth 2; mints retail's a_lo parm copy).
 *
 * LADDER (this basin): 2.7.2-970404 = 15 * BASE/2.8.0/2.8.1 = 21 *
 * 2.6.0/2.6.3/2.7.2 = 34 * 2.91.66/2.95.2 = 43.  (Before the levers the same
 * table read 23/29/35/49 -- falsifications here are basin-relative.)
 *
 * RESIDUAL (15) = EXACTLY the GTDF2 class, nothing else: a_hi sits in $a1 where
 * retail has $t1 + an entry `addu $t1,$a1,$zero`.  Six identical rename lines.
 * Falsified dials (all 15): fence on a_lo/b_lo, extra block-local qty in the
 * exponent blocks, ae/be statement swap (21 = worse), int-cast forms, no-fence
 * (17).  NEXT INSTRUMENT: tools/allocsim.py + reqdelta.py --want "p<a_hi>=t1"
 * -- the question is which allocno must PREFER or OCCUPY $a1 so find_reg's
 * numeric scan skips it.  Cracking it converts BOTH __ltdf2 and __gtdf2. */
int __ltdf2(unsigned int a_lo, int a_hi, unsigned int b_lo, int b_hi)   /* @0x800EB8E4 */
{
    int ae, be, am, bm;
    __asm__("" : "=r"(a_hi) : "0"(a_hi));
    if (a_hi == b_hi && a_lo == b_lo) return 0;
    if ((a_hi & 0x7fffffff) == 0 && a_lo == 0 &&
        (b_hi & 0x7fffffff) == 0 && b_lo == 0) goto ret0;
    if ((a_hi & 0x80000000) != (b_hi & 0x80000000)) {
        if (a_hi & 0x80000000) return -1;
        return 0;
    }
    ae = (a_hi >> 20) & 0x7ff;
    be = (b_hi >> 20) & 0x7ff;
    if (ae < be) goto less;
    if (ae != be) goto greater;
    am = (a_hi & 0xfffff) | 0x100000;
    bm = (b_hi & 0xfffff) | 0x100000;
    if (am < bm) goto less;
    if (am != bm) goto greater;
    if (b_lo <= a_lo) goto greater;
less:
    if (a_hi < 0) return 0;
    return -1;
greater:
    if (a_hi < 0) return -1;
ret0:
    return 0;
}
