/* eaclib/psx/sndpsxz/smath64.cpp -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj smath64.obj @[0x80103424..0x801034C0] */
/*   64-bit unsigned multiply/divide helpers (the PSX MIPS has no 64-bit ops).  Ghidra nfs4-f.exe.c. */

extern "C" int *iSNDmulu64(int *out, unsigned int a, unsigned int b);             /* @0x80103424 */
extern "C" int  iSNDdivu64(unsigned int hi, unsigned int lo, unsigned int div);   /* @0x801034C0 */

/* iSNDmulu64 @0x80103424 : out[0..1] = a * b (64-bit), via 16-bit partial products. */
extern "C" int *iSNDmulu64(int *out, unsigned int a, unsigned int b)
{
    unsigned int ll = (a & 0xffff) * (b & 0xffff);
    unsigned int lh = (a & 0xffff) * (b >> 0x10);
    unsigned int hl = (a >> 0x10) * (b & 0xffff);
    out[0] = (int)(ll + lh * 0x10000 + hl * 0x10000);
    out[1] = (int)((lh >> 0x10) + (hl >> 0x10) + (a >> 0x10) * (b >> 0x10) +
                   (((ll >> 0x10) + (lh & 0xffff) + (hl & 0xffff)) >> 0x10));
    return out;
}

/* iSNDdivu64 @0x801034C0 : (hi:lo) / div -- 32-iteration shift-subtract, returns the quotient. */
extern "C" int iSNDdivu64(unsigned int hi, unsigned int lo, unsigned int div)
{
    int q = 0;
    int i = 0x1f;
    do {
        q = q * 2;
        lo = lo * 2 + (hi >> 0x1f);   /* H07: ADD carry bit; hi is unsigned so >>31 is logical 0/1 (oracle 0x801034E0 $a1+=$v0). Was `- (hi>>31)` which is only correct for SIGNED hi (math64a.cpp). */
        hi = hi << 1;
        if (div <= lo) {
            lo = lo - div;
            q = q + 1;
        }
    } while (i-- != 0);
    return q;
}
