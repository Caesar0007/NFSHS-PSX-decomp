/* eaclib/psx/eacpsxz/fixddiv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixddiv.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800E4404 (168 bytes), dual XDEF: `fixeddiv` (caller-facing) + `rdiv` (EA alias).
 *   C-linkage symbol; callers resolve via the central extern "C" lib/libfns.h.
 *
 *   16.16 fixed-point SIGNED divide:  result = (a << 16) / b   (truncated toward zero).
 *   The MIPS (disasm-v3 @0x800E4404) does it overflow-safely without 64-bit: extract operand
 *   signs -> unsigned DIV (integer quotient/remainder) -> bit-by-bit refine the 16 fractional
 *   bits -> reapply sign (= sign(a) ^ sign(b)). Divide-by-zero returns 0 (@0x800E44A4).
 *   Transcribed 32-bit (matches the MIPS: native DIV + shift/compare/subtract refine) -- NO 64-bit
 *   `long long` (which would pull in libgcc __divdi3 that the original never used). @VA breadcrumbs.
 */

extern "C" int fixeddiv(int a, int b)   /* @0x800E4404 */
{
    unsigned ua, ub, rem, result, bit;
    int      neg;

    if (b == 0) return 0;                                /* @0x800E44A4 div-by-zero -> 0 */
    neg = (a < 0) ^ (b < 0);                              /* @0x800E4420 sign = sign(a) ^ sign(b) */
    ua  = (a < 0) ? (unsigned)(0 - a) : (unsigned)a;      /* @0x800E440C |a| */
    ub  = (b < 0) ? (unsigned)(0 - b) : (unsigned)b;      /* @0x800E4418 |b| */

    result = (ua / ub) << 16;                             /* @0x800E441C hardware DIV: int part (LO) */
    rem    = ua % ub;                                     /*             remainder (HI)               */
    for (bit = 0x8000; bit != 0; bit >>= 1) {             /* @0x800E4448 refine 16 fractional bits    */
        rem <<= 1;
        if (rem >= ub) { result |= bit; rem -= ub; }      /*             shift / compare / subtract    */
    }
    return neg ? -(int)result : (int)result;              /* @0x800E4468 reapply sign                 */
}

/* `rdiv` = co-equal XDEF label at the same address (EA legacy name). */
extern "C" int rdiv(int a, int b) __attribute__((alias("fixeddiv")));
