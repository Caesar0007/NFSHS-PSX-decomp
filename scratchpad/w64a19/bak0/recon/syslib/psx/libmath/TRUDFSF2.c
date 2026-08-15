/* syslib/psx/libmath/TRUDFSF2.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj TRUDFSF2.obj ; libmath.lib.  __truncdfsf2 @0x800F5924 (304 B) -- double -> float (narrow, round).
 *   a1=lo, a2=hi double words; returns the single bit-pattern.  Uses _dbl_shift; overflow -> _err_math(34,16).
 *   The `1 << (1-(v4+0x80))` denormal shifts rely on MIPS sllv masking (count & 0x1f), as in the binary.
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
/* MATCH (W53-A12): 109 -> 2 diffs, count EXACT 76/76.  Lane: cc1_272 (unchanged).
 * FOUR levers, all read off the oracle:
 *
 * 1. `double` PARAMETER + `union double_long` (the libmath cluster lever, full
 *    mechanism in GTDF2.c): retail's `addu $s0,$a0,$zero; addu $s1,$a1,$zero`
 *    is ONE DFmode pseudo in the even-aligned callee-saved PAIR $s0:$s1, which
 *    two independent int params can never produce.
 * 2. TWO 8-BYTE ARRAYS, MODELLED AS ONE `int buf[4]`.  Retail stores the input
 *    words at 0x18/0x1C but hands _dbl_shift `$sp+0x20` as the OUT pointer and
 *    reads the result from 0x24 -- an INPUT buffer and an OUTPUT buffer.
 *    Spelling them as one `int buf[4]` with `&buf[2]` as the out pointer is
 *    what reproduces the frame AND (unlike two separate arrays) most of the
 *    aliasing; it was worth 10 diffs over the two-array spelling.
 * 3. ONE IN-PLACE MANTISSA VARIABLE.  Retail runs the whole rounding chain in
 *    $a1 (`addiu $a1,$a1,1; srl $a1,$a1,1; ... srl $a1,$a1,1`).  Writing the
 *    steps as COMPOUND ASSIGNMENTS on a single `unsigned int m` (`m += 1;
 *    m >>= 1;` -- separate statements, NOT `m = (m+1)>>1`) is what produces the
 *    in-place updates; the fused form parks `m+1` in its own pseudo and lets
 *    cc1 refold the second shift into `>>2` (24 -> 12 -> 2 across these two).
 * 4. Branch polarity: `if (v5 > 0) {...} else {...}` (the >0 arm is retail's
 *    FALL-THROUGH after `blez $s2`), `if (v5 < 255) return ...;` before the err
 *    tail, and `if (ua.w.hi >= 0) return +INF;` (retail's `bgez $s1`).
 *
 * MATCH (W56, 2 -> PASS 76/76): retail RELOADS the low input word at the
 * `_dbl_shift` call (`lw $a2,0x18($sp)`) instead of forwarding the still-live
 * `$s0`.  A one-use volatile view of `buf[0]` preserves its real stack read
 * without changing the object, frame, or instruction count.  Keep the
 * qualifier local to that call argument; making the buffer itself volatile
 * would unnecessarily constrain the rest of the rounding function. */
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int _err_math(int errnum, int code);

typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

int __truncdfsf2(double a)   /* @0x800F5924 */
{
    double_long ua;
    int buf[4];
    int v4, v5;
    unsigned int m;
    ua.d = a;
    if ((ua.w.hi & 0x7FFFFFFF) == 0 && !ua.w.lo) return ua.w.hi & 0x80000000;
    v4 = (ua.w.hi >> 20) & 0x7FF;
    v5 = v4 - 896;
    buf[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
    buf[0] = ua.w.lo;
    _dbl_shift((unsigned int *)&buf[2], 0,
               *(volatile unsigned int *)&buf[0], buf[1], 4);
    m = buf[3];
    if (v5 > 0) {
        m += 1;
        m >>= 1;
        if ((m & 0xFF000000) != 0) {
            m >>= 1;
            v5 = v4 - 895;
        }
    } else {
        int n = -v5;
        m += 1 << (n + 1);
        m >>= n + 2;
        v5 = 0;
    }
    m &= 0xFF7FFFFF;
    if (v5 < 255) return ua.w.hi & 0x80000000 | (v5 << 23) | m;
    _err_math(34, 16);
    if (ua.w.hi >= 0) return 2139095040;
    return -8388608;
}
