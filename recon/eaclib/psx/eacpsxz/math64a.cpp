/* eaclib/psx/eacpsxz/math64a.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\math64a.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE488 .. 0x800FE4E0].  64-bit helpers (the PSX MIPS lacks 64-bit ops).  Ghidra + IDA sigs.
 *   Ghidra-isms: make64 is void (the `return in_v0` was a dropped-value artifact); divu64's `this` = hi word.
 */
extern "C" void make64(int *out, int y, unsigned int shift);   /* @0x800FE488 */
extern "C" int  divu64(int hi, int lo, unsigned int den);      /* @0x800FE4E0 */

/* make64 @0x800FE488 : out[0..1] = sign-extended `y` shifted left by `shift` (handles >=32 / 0 / negative). */
extern "C" void make64(int *out, int y, unsigned int shift)
{
    if (0x1f < (int)shift) {
        out[0] = 0;
        out[1] = y << (shift - 0x20 & 0x1f);
    } else if (0 < (int)shift) {
        out[0] = y << (shift & 0x1f);
        out[1] = y >> (0x20 - shift & 0x1f);
    } else {
        out[0] = y;
        out[1] = y >> 0x1f;
    }
}

/* divu64 @0x800FE4E0 : (hi:lo) / den -- 32-iteration shift-subtract, returns the quotient. */
extern "C" int divu64(int hi, int lo, unsigned int den)
{
    int q = 0;
    int i = 0x1f;
    do {
        q  = q * 2;
        lo = lo * 2 - (hi >> 0x1f);
        hi = hi << 1;
        if (den <= (unsigned int)lo) {
            lo = lo - (int)den;
            q  = q + 1;
        }
    } while (i-- != 0);
    return q;
}
