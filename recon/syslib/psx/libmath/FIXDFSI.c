/* syslib/psx/libmath/FIXDFSI.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj FIXDFSI.obj ; libmath.lib.  __fixdfsi @0x800F6834 (252 B) -- double -> signed int (truncate toward 0).
 *   Soft-float ABI: a1=lo word, a2=hi word.  Uses _dbl_shift; overflow -> _err_math(34,17), INT_MAX/MIN.
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
unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int _err_math(int errnum, int code);

unsigned int __fixdfsi(int a1, int a2)   /* @0x800F6834 */
{
    unsigned int result;
    int v4;
    if ((a2 & 0x7FFFFFFF) == 0 && !a1) return a2 & 0x80000000;
    v4 = (a2 >> 20) & 0x7FF;
    if (v4 - 1053 <= 0) {
        int sh[2];
        int v8;
        char v5;
        sh[1] = a2 & 0xFFFFF | 0x100000;
        sh[0] = a1;
        _dbl_shift((unsigned int *)sh, 0, a1, sh[1], 10);
        v8 = sh[1];
        v5 = 29 - v4;
        if ((unsigned int)(v4 - 1022) < 0x20 && v8 != 0) {
            int v6 = v8 >> v5;
            result = (unsigned int)(v8 >> v5);
            if (a2 < 0) return (unsigned int)(-v6);
        } else {
            return 0;
        }
    } else {
        _err_math(34, 17);
        result = 0x7FFFFFFF;
        if (a2 < 0) return 0x80000000;
    }
    return result;
}
