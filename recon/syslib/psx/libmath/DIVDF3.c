/* syslib/psx/libmath/DIVDF3.cpp -- RECONSTRUCTED from nfs4-f.exe (IDA Hex-Rays).
 *   obj DIVDF3.obj ; libmath.lib.  __divdf3 @0x800F5DD4 (736 B) + _comp_mant @0x800F60B4 (80 B) --
 *   IEEE-754 double divide via restoring bitwise long division of the 53-bit mantissas (_comp_mant compares
 *   64-bit mantissa pairs; _mainasu + _add_mant_d do subtract-and-restore).  IDA verbatim.  The IDA locals
 *   v19/v20, v13/v14, v15/v16 are stack-adjacent word pairs the helpers write through &v19 etc -> int[2]
 *   here (dbl_shift order: out[0]=low word, out[1]=high word).
 *
 *   _comp_mant TOOLCHAIN-IDENTITY WALL (w24-a2, 2026-07-25): NO SYM entry (stripped libmath primitive).
 *   The oracle unconditionally spills EVERY incoming arg to its ABI stack home on entry
 *   (`sw a0,0(sp); sw a1,4(sp); sw a2,8(sp); sw a3,12(sp)`, reusing the CALLER's outgoing-arg shadow
 *   space -- .frame $sp,0) yet NEVER reloads them, using the live registers directly for every `sltu`.
 *   Empirically this "defensive spill, no reload" shape is NOT reachable with CC1PSX.EXE (our cc1) at
 *   ANY optimization level: -O2/-O1 spill nothing (register-only, matches OUR current recon, 0 stores);
 *   -O0 spills to the SAME offsets byte-for-byte but ALSO reloads every operand via `lw` before each
 *   `sltu` (oracle has zero `lw`s); `-fomit-frame-pointer`, `register`-qualified params, and K&R-style
 *   (unprototyped) parameter lists were all tried at every -O level -- none reproduce spill-without-
 *   reload. Corroborated by 3 independent sibling primitives (_add_mant_d, _mainasu, _dbl_shift[_us] --
 *   see ADDMANT.c/MAINASU.c/DBSHIFT[U].cpp) all showing the IDENTICAL signature, while the higher-level
 *   routines in THIS SAME FILE (__divdf3 below) show ORDINARY -O2 register allocation with zero
 *   defensive spills -- i.e. libmath.lib's small arithmetic PRIMITIVES were built by a genuinely
 *   DIFFERENT/older compiler pass than the -O2 CC1PSX.EXE that built the rest of the game (per
 *   methodology §3.20's "libmath vendor wall" precedent + §3.25 PER-MODULE TOOLCHAIN IDENTITY). A prior
 *   session's stack-homing-only experiment on this fn was independently recorded net-neutral, consistent
 *   with this conclusion. STRONG floor (>=4 corroborating fns, exact insn-count divergence, exhaustive
 *   flag sweep) -> transcribed VERBATIM as file-scope __asm__; portable C fallback kept for the host. */
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
int _comp_mant(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4);   /* fwd decl for __divdf3 below */

#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"   /* tab form: turns maspsx is_reorder OFF (no auto branch-delay nop) */
    "\t.set noreorder\n"    /* space form: passes through to gnu-as                             */

    "\t.globl _comp_mant\n"        /* @0x800F60B4 : int _comp_mant(uint a0,a1,a2,a3) -- compare [a1:a0] vs [a3:a2] as u64 -> 1/-1/0 */
    "_comp_mant:\n"
    "\tsltu\t$v0,$a3,$a1\n"
    "\tsw\t$a0,0($sp)\n"
    "\tsw\t$a1,4($sp)\n"
    "\tsw\t$a2,8($sp)\n"
    "\tbnez\t$v0,.L800F60F8\n"
    "\t sw\t$a3,12($sp)\n"
    "\tsltu\t$v0,$a1,$a3\n"
    "\tbnez\t$v0,.L800F60FC\n"
    "\t addiu\t$v0,$zero,-1\n"
    "\tsltu\t$v0,$a2,$a0\n"
    "\tbnez\t$v0,.L800F60FC\n"
    "\t addiu\t$v0,$zero,1\n"
    "\tsltu\t$v1,$a0,$a2\n"
    "\tbnez\t$v1,.L800F60FC\n"
    "\t addiu\t$v0,$zero,-1\n"
    "\tj\t.L800F60FC\n"
    "\t addu\t$v0,$zero,$zero\n"
    ".L800F60F8:\n"
    "\taddiu\t$v0,$zero,1\n"
    ".L800F60FC:\n"
    "\tjr\t$ra\n"
    "\t nop\n"
    "\t.set pop\n"
);
#else
/* Direct-return cascade (lever 3.12#8): each return materializes $v0 in the branch
 * delay slot; staging through a `result` temp would pin $t0+move instead. */
int _comp_mant(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4)
{
    if (a4 < a2) return 1;
    if (a2 < a4) return -1;
    if (a3 < a1) return 1;
    if (a1 < a3) return -1;
    return 0;
}
#endif

unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_mainasu(int *out, int a2, int a3);
int           _err_math(int errnum, int code);

double __divdf3(int a1, int a2, int a3, int a4)   /* @0x800F5DD4 */
{
    union { double d; unsigned int w[2]; } u;
    int          v4 = ((a2 >> 20) & 0x7FF) - ((a4 >> 20) & 0x7FF) + 1022;
    unsigned int v5 = a2 & 0x80000000 ^ a4 & 0x80000000;
    if ((a4 & 0x7FFFFFFF) != 0 || a3) {
        if ((a2 & 0x7FFFFFFF) != 0 || a1) {
            int d[2];   /* v19(lo), v20(hi) -- dividend */
            int q[2];   /* v13(lo), v14(hi) -- quotient */
            int b[2];   /* v15(lo), v16(hi) -- current bit */
            int v21 = a3, v22 = a4 & 0xFFFFF | 0x100000;   /* divisor */
            int v7, v8;
            unsigned int v10;
            d[0] = a1;
            d[1] = a2 & 0xFFFFF | 0x100000;
            if (_comp_mant(d[0], d[1], v21, v22) < 0) {
                --v4;
                _dbl_shift((unsigned int *)d, 0, d[0], d[1], 1);
            }
            b[1] = 0x200000; b[0] = 0; q[0] = 0; q[1] = 0;
            do {
                if (_comp_mant(d[0], d[1], v21, v22) >= 0) {
                    int v23[2];
                    q[1] |= b[1];
                    q[0] |= b[0];
                    _mainasu(v23, v21, v22);
                    _add_mant_d(d, d[0], d[1], v23[0], v23[1]);
                }
                _dbl_shift((unsigned int *)d, 0, d[0], d[1], 1);
                _dbl_shift_us((unsigned int *)b, 1, b[0], b[1], 1);
            } while (b[1] || b[0]);
            if (v4 < 0) {
                int v17 = 1 << -(char)v4;
                _add_mant_d(q, q[0], q[1], v17, 0);
                v7 = -v4 + 1;
                v8 = 0;
            } else {
                v7 = 1;
                v8 = v4 + 1;
                _add_mant_d(q, q[0], q[1], 1, 0);
            }
            _dbl_shift_us((unsigned int *)q, 1, q[0], q[1], v7);
            v10 = q[1] & 0xFFEFFFFF;
            if (v8 < 2047) { u.w[1] = v5 | (v8 << 20) | v10; u.w[0] = q[0]; }
            else { int v11; _err_math(34, 15); v11 = 2146435072; if (v5) v11 = -1048576; u.w[1] = v11; u.w[0] = 0; }
        } else {
            u.w[1] = a2 & 0x80000000 ^ a4 & 0x80000000;
            u.w[0] = 0;
        }
    } else {
        u.w[1] = (v5 == 0) ? 0x7FFFFFFF : 0xFFFFFFFF;
        u.w[0] = 0xFFFFFFFF;
    }
    return u.d;
}
