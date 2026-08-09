/* syslib/psx/libmath/ADDDF3.c -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays). C lane (3.25, task #90).
 *   obj ADDDF3.obj ; libmath.lib.  __adddf3 @0x800F5A54 (884 B) -- IEEE-754 double add (and, via sign, the
 *   subtract path).  Aligns exponents, adds/subtracts 64-bit mantissas (sign-magnitude through _mainasu),
 *   renormalises, round-to-nearest.  IDA verbatim; the __int64 accumulator v12 is a union (`.ll` for the
 *   64-bit compares/masks, `.w[2]` for the helper word-writes).  Overflow -> _err_math(34,11).
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
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_mainasu(int *out, int a2, int a3);
int           _err_math(int errnum, int code);

typedef union I64 { double d; long long ll; unsigned long long ull; int w[2]; unsigned int uw[2]; } I64;

double __adddf3(int a1lo, int a1hi, int a2lo, int a2hi)   /* @0x800F5A54 */
{
    I64 a2, v3, v12, v17;
    unsigned int v2 = 0;
    int v4, v6, v7, v8, v10, v11;
    int vb[2];
    unsigned int v9;
    a2.w[0] = a2lo; a2.w[1] = a2hi;
    v3.w[0] = a1lo; v3.w[1] = a1hi;        /* v3 = a1 */
    v17.ll = 0;
    v4 = a2hi;
    if ((a1hi & 0x7FFFFFFF) == 0 && a1lo == 0) return a2.d;
    if ((a2hi & 0x7FFFFFFF) != 0 || a2lo) {
        v6 = (a1hi >> 20) & 0x7FF;
        v7 = (a2hi >> 20) & 0x7FF;
        if (v7 + 54 >= v6) {
            if (v6 + 54 < v7) return a2.d;
            v12.w[1] = a1hi & 0xFFFFF | 0x100000;
            v12.w[0] = a1lo;
            vb[1] = a2hi & 0xFFFFF | 0x100000;
            vb[0] = a2lo;
            if (a1hi < 0) _mainasu(v12.w, v12.w[0], v12.w[1]);
            if (v4 < 0)   _mainasu(vb, vb[0], vb[1]);
            _dbl_shift(v12.uw, 0, v12.uw[0], v12.w[1], 9);
            _dbl_shift((unsigned int *)vb, 0, vb[0], vb[1], 9);
            if (v7 >= v6) {
                v11 = v7 - v6;
                v6 = v7;
                _dbl_shift(v12.uw, 1, v12.uw[0], v12.w[1], v11);
            } else {
                _dbl_shift((unsigned int *)vb, 1, vb[0], vb[1], v6 - v7);
            }
            _add_mant_d(v12.w, v12.uw[0], v12.w[1], vb[0], vb[1]);
            if (v12.ll < 0) {
                v2 = 0x80000000;
                _mainasu(v12.w, v12.w[0], v12.w[1]);
            } else if (v12.ll <= 0) {
                return v17.d;
            }
            for (; (v12.ull & 0xE000000000000000ULL) == 0; --v6)
                _dbl_shift(v12.uw, 0, v12.uw[0], v12.w[1], 1);
            if ((v12.ull & 0x4000000000000000ULL) != 0) {
                ++v6;
                _dbl_shift(v12.uw, 1, v12.uw[0], v12.w[1], 1);
            }
            v8 = 255;
            if ((v12.w[0] & 0x200) != 0) v8 = 256;
            _add_mant_d(v12.w, v12.uw[0], v12.w[1], v8, 0);
            if ((v12.ull & 0x4000000000000000ULL) != 0) {
                ++v6;
                _dbl_shift(v12.uw, 1, v12.uw[0], v12.w[1], 1);
            }
            _dbl_shift(v12.uw, 1, v12.uw[0], v12.w[1], 9);
            v9 = v12.w[1] & 0xFFEFFFFF;
            if (v6 < 2047) {
                v3.w[1] = v2 | (v6 << 20) | v9;
                v3.w[0] = v12.w[0];
            } else {
                _err_math(34, 11);
                v10 = 2146435072;
                if (v2) v10 = -1048576;
                v3.w[1] = v10;
                v3.w[0] = 0;
            }
        }
    }
    return v3.d;
}
