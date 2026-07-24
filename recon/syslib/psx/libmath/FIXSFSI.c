/* syslib/psx/libmath/FIXSFSI.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\FIXSFSI.obj ; libmath.lib (PsyQ/GCC 2.7.2 soft-float).  1 fn __fixsfsi @0x800F3938
 *   (180 B) -- REAL code: convert an IEEE-754 single (passed as its 32-bit pattern) to a signed int (truncate
 *   toward zero).  Ghidra nfs4-f.exe.c, verbatim.  Overflow -> _err_math(0x22,0x12) (ERANGE) and INT_MAX.
 */
extern int _err_math(int errnum, int code);   /* FERR.obj @0x80106A54 */

extern unsigned int __fixsfsi(unsigned int arg1)   /* @0x800F3938 */
{
    unsigned int result;
    if ((arg1 & 0x7fffffff) == 0) {
        result = arg1 & 0x80000000;                       /* +/-0 -> 0 */
    } else {
        unsigned int exp = (int)arg1 >> 0x17 & 0xff;
        int          e   = exp - 0x9d;
        /* e>0 (overflow) is the FIRST arm textually in the oracle (blez skips PAST it to the e<=0
         * fraction path) -- our prior e<1-first ordering compiled with the opposite branch sense. */
        if (e > 0) {
            if ((int)arg1 >= 0) {
                _err_math(0x22, 0x12);
                result = 0x7fffffff;
            } else {
                result = 0x80000000;
            }
        } else {
            unsigned int mant     = (arg1 & 0x7fffff) | 0x800000;
            unsigned int shifted  = mant << 7;
            if ((exp - 0x7e < 0x20) && (shifted != 0)) {
                unsigned int t = (int)shifted >> (-e);
                if ((int)arg1 < 0) {
                    result = -t;
                } else {
                    result = t;
                }
            } else {
                result = 0;
            }
        }
    }
    return result;
}
