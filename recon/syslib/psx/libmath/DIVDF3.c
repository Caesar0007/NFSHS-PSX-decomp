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

unsigned int *_dbl_shift(unsigned int *out, int dir, unsigned int w0, int w1, int count);
unsigned int *_dbl_shift_us(unsigned int *out, int dir, unsigned int w0, int w1, int count);
int          *_add_mant_d(int *out, unsigned int a2, int a3, unsigned int a4, int a5);
int          *_mainasu(int *out, int a2, int a3);
int           _err_math(int errnum, int code);

/* MATCH (W55-A4): 300 -> 27 diffs, ours 183 / oracle 184.  Lane RE-WIRED
 * {"cc1_alt": "2.7.2"} (was 2.91.66 = now the WORST rung; 04Z re-ladder on the
 * landed basin: 2.6.0/2.6.3=30 * 2.7.2-970404/2.7.2=27 * 2.8.0/2.8.1=28
 * [count-EXACT 184/184] * 2.91.66=171 * 2.95.2=164).
 *
 * THE FIVE LANDINGS, in the order they were measured (each gated separately):
 *   300 -> 192  `double a, double b` + `double_long` union (05B pair law): the
 *                entry `addu $tN,$aN,$zero` quartet appears.
 *   192 -> 188  arm ORDER: the zero tests are POSITIVE (`if (b==0) {..} else if
 *                (a==0) {..} else {main}`), so the small arms are the FALL-THROUGH
 *                (oracle `bnez v1,<else>` / `bnez t2,<else>`), not branch targets.
 *   [re-ladder] 188 -> 92 on 2.6.x, and later 27 on 2.7.2 -- the rung table had
 *                fully INVERTED vs the pre-landing one (04Z).
 *    92 -> 53   05C REF-FENCE on `n` (`__asm__("" : : "r"(n))` before the tail
 *                _dbl_shift_us).  WHY: `ur` is a size-2 DFmode allocno, so
 *                global.c's priority (floor_log2(refs)*refs/live_length * SIZE)
 *                doubles it and it takes the first free even pair $s0:$s1,
 *                pushing n/exp to $s2/$s3 -- the exact MIRROR of retail.  One
 *                extra ref on `n` flips the order to retail's {n=$s0, exp=$s1,
 *                ur=$s2:$s3}.  Falsified first: all 6 decl orders (no effect),
 *                a `int rlo,rhi` funnel (69: gets the arms right but strands the
 *                words in $v0/$v1 + 2 extra moves), fences on exp alone (92).
 *    53 -> 40   `int *dp = buf;` in the LOOP PREHEADER, used only as the
 *                _add_mant_d out-arg -> retail's `addiu $s5,$sp,0x30` + `addu
 *                $a0,$s5,$zero` + the $s5 save (frame 0x60 -> 0x68).  Assigning
 *                dp at the top of the arm instead scores 62; routing every
 *                buf-pointer arg through dp also 62.
 *    40 -> 34   buf init STORE ORDER = hi-then-lo per operand
 *                (buf[1],buf[0],buf[3],buf[2]).
 *    34 -> 27   `exp -= 1;` AFTER the pre-shift call (retail fills the
 *                `jal _dbl_shift` delay slot with it).
 *
 * RESIDUAL (27, ours 1 insn short): (a) the div-by-zero arm -- retail
 * re-materializes 0x7FFFFFFF fresh into $s3 (`li s3,-1; lui; ori`) while our cse
 * REUSES the live mask constant in $v0 and adds a `addu s3,v0,zero` (this also
 * flips the ternary's branch polarity beqz/bnez -- ONE root cause, 4 diffs).
 * FALSIFIED here: 4 ternary/if spellings, 0xFFFFFFFF vs -1, lo-first, and 4 fence
 * placements (void, "r"(sign), after-hi, lo-first) -- all neutral or worse.
 * (b) arg-load ORDER at the three `_add_mant_d` sites: retail emits arg4 right
 * after the arg5 stack store (5,4,2,3), ours defers it (5,2,3,4). (c) three
 * reorg delay-slot picks (`addiu a0,sp,0x18` / `addiu s1,s1,1` / `addu
 * s1,zero,zero`).  NAMED NEXT ANGLE for (a): stop cse from carrying the mask
 * constant into the arm -- an opacity device on the b-side mask, not a barrier
 * (barriers were falsified).  NOT a floor.
 *
 * MATCH (w60-a5, 2026-08-14): 27 -> 25.  Residual (c) half-cleared: the
 * exponent update belongs BEFORE its `_add_mant_d` call, not after -- reorg's
 * backward scan can only steal an insn that PRECEDES the jal, so after the call
 * `exp += 1` / `exp = 0` are unreachable to it and the a0 arg-setup gets stolen
 * instead; moved, retail's `addiu $s1,$s1,1` / `addu $s1,$zero,$zero` land in
 * the two slots.  (Arm 1 carries the whole win; arm 2's move is oracle-evidenced
 * and gate-neutral, kept for faithfulness.)
 * FALSIFIED at 25 for residual (b), the arg-load order: a named temp for arg4
 * `t[0]` 27 | a named temp for the arg5 `t[1]` 25 | a pointer local for `q`
 * assigned at the top of the arm 25.  And re-confirmed for (a) at this basin:
 * if/else instead of the ternary 69 (head) / 73 (tail) / 73 (both), inverted
 * if/else 70 -- the ternary IS retail's shape, the residual is cse's mask reuse
 * exactly as the note above says.
 *
 * The W53-A12 handoff recipe applied in full:
 * `double` params + a register-resident `union double_long` (the 05B soft-float PAIR law,
 * mechanism in GTDF2.c) TOGETHER with the oracle re-derivation.
 *
 * WHAT THE ORACLE DICTATES (read off asm/nonmatchings/main/__divdf3.s, frame 0x68):
 *  - entry `addu $t0,$a0; addu $t1,$a1; addu $t2,$a2; addu $t3,$a3` = BOTH DFmode pairs
 *    lose their arg-reg preference and land in $t0:$t1 / $t2:$t3.  Four int params can
 *    never emit this (05B).
 *  - the RETURN is a DFmode pseudo too: every arm writes $s2 (lo) / $s3 (hi) -- an
 *    EVEN-ALIGNED callee-saved pair -- and the epilogue is `addu v0,s2; addu v1,s3`.
 *    That is `double_long ur; ...; return ur.d;`, not two independent ints.
 *  - frame local map (address order == declaration order):
 *      0x18 q[2] | 0x20 bit[2] | 0x28 t[2] | 0x30 buf[4] | 0x40 sub[2]
 *    The dividend AND the divisor live in ONE `int buf[4]` (0x30..0x3C): the loop RELOADS
 *    all four words at every _comp_mant, which scalar divisor locals can never produce
 *    (same one-array lever as __truncdfsf2's buf[4]).
 *  - the `+1` / `1<<n` addend is a real two-word array `t[2]` at 0x28 (`sw zero,0x2C;
 *    sw sN,0x28` then `lw a3,0x28`), NOT the literals `1,0`.
 *  - ONE in-place exponent (`$s1`: `addiu s1,s1,-1` / `addiu s1,s1,1` / `addu s1,zero,zero`)
 *    and ONE in-place shift count (`$s0`), not v4/v7/v8 triples.
 *  - `q[1] &= 0xFFEFFFFF` is stored BACK (`sw v1,0x1C(sp)`), not parked in a temp.
 *  - branch polarity: the overflow test is `if (exp >= 2047) {err} else {normal}`
 *    (`slti v0,s1,0x7FF; bnez v0,<normal>` = the err block is the FALL-THROUGH).
 *  - the loop shift counts are LITERAL 1s (LICM hoists them into $s0 at the preheader);
 *    only the tail count is a variable.
 */
typedef union {
    double d;
    struct { unsigned int lo; int hi; } w;
} double_long;

double __divdf3(double a, double b)   /* @0x800F5DD4 */
{
    double_long ua, ub, ur;
    int q[2];      /* 0x18 -- quotient            */
    int bit[2];    /* 0x20 -- current quotient bit */
    int t[2];      /* 0x28 -- rounding addend      */
    int buf[4];    /* 0x30 -- [0..1] dividend, [2..3] divisor */
    int sub[2];    /* 0x40 -- _mainasu result      */
    int *dp;
    int exp, n;
    int sign;

    ua.d = a;
    ub.d = b;
    exp = ((ua.w.hi >> 20) & 0x7FF) - ((ub.w.hi >> 20) & 0x7FF) + 1022;
    sign = (ua.w.hi & 0x80000000) ^ (ub.w.hi & 0x80000000);
    if ((ub.w.hi & 0x7FFFFFFF) == 0 && ub.w.lo == 0) {
        ur.w.hi = sign ? -1 : 0x7FFFFFFF;
        ur.w.lo = -1;
    } else if ((ua.w.hi & 0x7FFFFFFF) == 0 && ua.w.lo == 0) {
        ur.w.hi = sign;
        ur.w.lo = 0;
    } else {
        {
            buf[1] = (ua.w.hi & 0xFFFFF) | 0x100000;
            buf[0] = ua.w.lo;
            buf[3] = (ub.w.hi & 0xFFFFF) | 0x100000;
            buf[2] = ub.w.lo;
            if (_comp_mant(buf[0], buf[1], buf[2], buf[3]) < 0) {
                _dbl_shift((unsigned int *)buf, 0, buf[0], buf[1], 1);
                exp -= 1;
            }
            dp = buf;
            bit[1] = 0x200000;
            bit[0] = 0;
            q[0] = 0;
            q[1] = 0;
            do {
                if (_comp_mant(buf[0], buf[1], buf[2], buf[3]) >= 0) {
                    q[1] |= bit[1];
                    q[0] |= bit[0];
                    _mainasu(sub, buf[2], buf[3]);
                    _add_mant_d(dp, buf[0], buf[1], sub[0], sub[1]);
                }
                _dbl_shift((unsigned int *)buf, 0, buf[0], buf[1], 1);
                _dbl_shift_us((unsigned int *)bit, 1, bit[0], bit[1], 1);
            } while (bit[1] || bit[0]);
            if (exp >= 0) {
                n = 1;
                t[1] = 0;
                t[0] = n;
                /* w60-a5: the exponent update sits BEFORE the call in retail --
                 * reorg's backward scan steals it into the jal's delay slot
                 * (`addiu $s1,$s1,1` / `addu $s1,$zero,$zero`).  After the call
                 * it is unreachable to reorg and the a0 arg-setup gets stolen
                 * instead.  27 -> 25. */
                exp += 1;
                _add_mant_d(q, q[0], q[1], t[0], t[1]);
            } else {
                n = -exp;
                t[1] = 0;
                t[0] = 1 << n;
                exp = 0;
                _add_mant_d(q, q[0], q[1], t[0], t[1]);
                n += 1;
            }
            __asm__("" : : "r"(n));   /* 05C ref-fence: see receipt */
            _dbl_shift_us((unsigned int *)q, 1, q[0], q[1], n);
            q[1] &= 0xFFEFFFFF;
            if (exp >= 2047) {
                _err_math(34, 15);
                ur.w.hi = sign ? 0xFFF00000 : 0x7FF00000;
                ur.w.lo = 0;
            } else {
                ur.w.hi = sign | (exp << 20) | q[1];
                ur.w.lo = q[0];
            }
        }
    }
    return ur.d;
}

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
