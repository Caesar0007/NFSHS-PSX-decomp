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
            /* MATCH (W51-A6, 8 diffs -> PASS 45/45, gcc-2.7.2 lane).  Three cooperating shapes:
             *  (1) the zero case is an early `return 0;` in the ELSE arm, NOT a result-funnel
             *      assignment -- that is what lays the zero block PHYSICALLY BETWEEN the srav and
             *      the sign-fix (oracle `j .L800F39D0; srav $v1,$v1,$v0` then
             *      `.L800F39C8: j END; addu $v0,$zero,$zero`);
             *  (2) `shifted` stays a SEPARATE live variable across that join, so the shift lands in
             *      $v1 instead of being coalesced into the return register;
             *  (3) the sign fix negates the RESULT variable, not `shifted` in place -- that is what
             *      puts the oracle's `addu $v0,$v1,$zero` copy in the bgez DELAY SLOT (unconditional)
             *      with `negu $v0,$v0` on the fall-through.  `shifted = -shifted; return shifted;`
             *      inverts the pair (negu $v1,$v1 then the copy) = the residual-3 near-miss. */
            if ((exp - 0x7e < 0x20) && (shifted != 0)) {
                shifted = (int)shifted >> (-e);
            } else {
                return 0;
            }
            result = shifted;
            if ((int)arg1 < 0) {
                result = -result;
            }
            return result;
        }
    }
    return result;
}
