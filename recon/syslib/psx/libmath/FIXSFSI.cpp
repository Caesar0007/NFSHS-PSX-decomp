/* syslib/psx/libmath/FIXSFSI.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\FIXSFSI.obj ; libmath.lib (PsyQ/GCC 2.7.2 soft-float).  1 fn __fixsfsi @0x800F3938
 *   (180 B) -- REAL code: convert an IEEE-754 single (passed as its 32-bit pattern) to a signed int (truncate
 *   toward zero).  Ghidra nfs4-f.exe.c, verbatim.  Overflow -> _err_math(0x22,0x12) (ERANGE) and INT_MAX.
 */
extern "C" int _err_math(int errnum, int code);   /* FERR.obj @0x80106A54 */

extern "C" unsigned int __fixsfsi(unsigned int arg1)   /* @0x800F3938 */
{
    unsigned int result;
    if ((arg1 & 0x7fffffff) == 0) {
        result = arg1 & 0x80000000;                       /* +/-0 -> 0 */
    } else {
        unsigned int exp = (int)arg1 >> 0x17 & 0xff;
        int          e   = exp - 0x9d;
        if (e < 1) {
            unsigned int mant = (arg1 & 0x7fffff) | 0x800000;
            if ((exp - 0x7e < 0x20) && (mant != 0)) {
                result = (int)(mant << 7) >> (-e);
                if ((int)arg1 < 0) result = -result;
            } else {
                result = 0;
            }
        } else if ((int)arg1 < 0) {
            result = 0x80000000;
        } else {
            _err_math(0x22, 0x12);
            result = 0x7fffffff;
        }
    }
    return result;
}
