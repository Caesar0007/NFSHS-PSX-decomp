/* syslib/psx/libmath/LTDF2.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\LTDF2.obj ; libmath.lib.  __ltdf2 @0x800EB8E4 (220 B) -- libgcc double compare
 *   `int __ltdf2(double a, double b)`; soft-float ABI a=$a0:$a1, b=$a2:$a3 (lo:hi).  Returns <0 iff a<b.
 *   IDA Hex-Rays (fresh NFS4.EXE.i64), verbatim.
 */
int __ltdf2(unsigned int a_lo, int a_hi, unsigned int b_lo, int b_hi)   /* @0x800EB8E4 */
{
    int result;
    int v6;
    if (a_hi == b_hi) {
        result = 0;
        if (a_lo == b_lo) return result;
    }
    if ((a_hi & 0x7fffffff) == 0 && !a_lo && (b_hi & 0x7fffffff) == 0 && !b_lo)
        return 0;
    if ((a_hi & 0x80000000) != (b_hi & 0x80000000)) {
        result = -1;
        if ((a_hi & 0x80000000) == 0) return 0;
        return result;
    }
    v6 = (b_hi >> 20) & 0x7ff;
    if (((a_hi >> 20) & 0x7ff) >= v6) {
        int v7, v8;
        if (((a_hi >> 20) & 0x7ff) != v6
            || ((v7 = a_hi & 0xfffff | 0x100000, v8 = b_hi & 0xfffff | 0x100000, v7 >= v8)
                && (v7 != v8 || a_lo >= b_lo))) {
            result = -1;
            if (a_hi < 0) return result;
            return 0;
        }
    }
    result = 0;
    if (a_hi >= 0) return -1;
    return result;
}
