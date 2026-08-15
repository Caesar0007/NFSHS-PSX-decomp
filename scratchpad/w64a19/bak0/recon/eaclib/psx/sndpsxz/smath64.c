/* eaclib/psx/sndpsxz/smath64.c -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj smath64.obj @[0x80103424..0x801034C0] */
/*   64-bit unsigned multiply/divide helpers (the PSX MIPS has no 64-bit ops).  Ghidra nfs4-f.exe.c. */

struct SNDu64Value { unsigned int lo, hi; };
extern struct SNDu64Value *iSNDmulu64(struct SNDu64Value *out, unsigned int a, unsigned int b); /* @0x80103424 */
extern int  iSNDdivu64(struct SNDu64Value value, unsigned int div);           /* @0x801034C0 */

/* iSNDmulu64 @0x80103424 : out[0..1] = a * b (64-bit), via 16-bit partial products. */
extern struct SNDu64Value *iSNDmulu64(struct SNDu64Value *out, unsigned int a, unsigned int b)
{
    struct SNDu64Value value;
    unsigned int ll = (a & 0xffff) * (b & 0xffff);
    int carry;
    unsigned int lh = (a & 0xffff) * (b >> 0x10);
    unsigned int hl = (a >> 0x10) * (b & 0xffff);
    value.lo = (ll + lh * 0x10000) + hl * 0x10000;
    carry = ((ll >> 0x10) + (lh & 0xffff) + (hl & 0xffff)) >> 0x10;
    value.hi = ((lh >> 0x10) + (hl >> 0x10) + (a >> 0x10) * (b >> 0x10)) + carry;
    *out = value;
    return out;
}

/* iSNDdivu64 @0x801034C0 : (hi:lo) / div -- 32-iteration shift-subtract, returns the quotient.
 * MATCH: the 8-byte by-value argument accounts for the ABI home stores at sp+0/sp+4; scalar field
 * copies keep the loop in registers, while compound shifts reproduce the oracle's in-place flow. */
extern int iSNDdivu64(struct SNDu64Value value, unsigned int div)
{
    int q = 0;
    unsigned int i = 0x20;
    unsigned int hi = value.lo;
    unsigned int lo = value.hi;
    do {
        i--;
        q <<= 1;
        lo <<= 1;
        lo += hi >> 0x1f;   /* H07: ADD carry bit; hi is unsigned so >>31 is logical 0/1 (oracle 0x801034E0 $a1+=$v0). Was `- (hi>>31)` which is only correct for SIGNED hi (math64a.cpp). */
        hi <<= 1;
        if (div <= lo) {
            lo = lo - div;
            q = q + 1;
        }
    } while (i != 0);
    return q;
}
