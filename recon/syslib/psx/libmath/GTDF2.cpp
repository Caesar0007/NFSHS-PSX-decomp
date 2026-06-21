/* syslib/psx/libmath/GTDF2.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\GTDF2.obj ; libmath.lib.  __gtdf2 @0x800F0514 (212 B) -- libgcc double compare
 *   `int __gtdf2(double a, double b)`; soft-float ABI passes a=$a0:$a1, b=$a2:$a3 (lo:hi word pairs).
 *   Returns >0 iff a>b (sign-of-difference convention).  IDA Hex-Rays (fresh NFS4.EXE.i64), verbatim.
 */
extern "C" int __gtdf2(unsigned int a_lo, int a_hi, unsigned int b_lo, int b_hi)   /* @0x800F0514 */
{
    int          result;
    unsigned int v6;
    if (a_hi != b_hi || (result = 0, a_lo != b_lo)) {
        if ((a_hi & 0x7fffffff) != 0 || a_lo || (b_hi & 0x7fffffff) != 0) {
            v6 = a_hi & 0x80000000;
        } else {
            v6 = a_hi & 0x80000000;
            if (!b_lo) return 0;
        }
        result = (v6 == 0);
        if (v6 == (unsigned int)(b_hi & 0x80000000)) {
            int v7 = (a_hi >> 20) & 0x7ff;
            int v8 = (b_hi >> 20) & 0x7ff;
            if (v8 < v7) return a_hi >= 0;
            result = a_hi < 0;
            if (v7 != v8) return result;
            int v9  = a_hi & 0xfffff | 0x100000;
            int v10 = b_hi & 0xfffff | 0x100000;
            if (v10 < v9) return a_hi >= 0;
            result = a_hi < 0;
            if (v9 != v10) return result;
            if (b_lo >= a_lo) return a_hi < 0;
            else             return a_hi >= 0;
        }
    }
    return result;
}
