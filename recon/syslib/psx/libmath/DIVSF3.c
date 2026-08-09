/* syslib/psx/libmath/DIVSF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj DIVSF3.obj ; libmath.lib.  __divsf3 @0x800F66E4 (324 B) -- IEEE-754 single divide (a1/a2 bit
 *   patterns) via restoring bitwise long division of the mantissas.  Div-by-0 -> +/-Inf; overflow -> _err_math.
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
int _err_math(int errnum, int code);

unsigned int __divsf3(int a1, int a2)   /* @0x800F66E4 */
{
    int          v2 = (unsigned char)(a1 >> 23) - (unsigned char)(a2 >> 23);
    int          v3 = v2 + 126;
    unsigned int v4 = a1 & 0x80000000 ^ a2 & 0x80000000;
    if ((a2 & 0x7FFFFFFF) != 0) {
        if ((a1 & 0x7FFFFFFF) != 0) {
            int v6 = a1 & 0x7FFFFF | 0x800000;
            int v7 = a2 & 0x7FFFFF | 0x800000;
            int v8 = 0x1000000;
            int v9, v10, v11, v13;
            unsigned int v12;
            if (v6 < v7) { v6 *= 2; v3 = v2 + 125; }
            v9 = 0;
            do {
                if (v6 >= v7) { v9 |= v8; v6 -= v7; }
                v8 >>= 1;
                v6 *= 2;
            } while (v8);
            if (v3 < 0) {
                v11 = (v9 + (1 << -(char)v3)) >> (1 - v3);
                v10 = 0;
            } else {
                v10 = v3 + 1;
                v11 = (v9 + 1) >> 1;
            }
            v12 = v11 & 0xFF7FFFFF;
            if (v10 < 255) return v4 | (v10 << 23) | v12;
            _err_math(34, 14);
            v13 = 2139095040;
            if (v4) return -8388608;
            return v13;
        } else {
            return a1 & 0x80000000 ^ a2 & 0x80000000;
        }
    } else {
        unsigned int result = 1325400064;
        if (v4) return 1333788672;
        return result;
    }
}
