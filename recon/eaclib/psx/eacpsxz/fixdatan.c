/* eaclib/psx/eacpsxz/fixdatan.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\fixdatan.obj (EACPSXZ.LIB).  1 fn @0x800ED528 : fixedatan.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  atan2(y,x) in a 16-bit angle unit
 *   (full circle = 0x10000, 0x4000 = 90 deg).  Octant-reduces to ratio = min/max, looks up
 *   atan(ratio) in the separate SYM-proven fatantbl.obj table (@0x80137868), with 16-bit interpolation
 *   over a 64-bit ratio (the EA make64/divu64 path), then maps the octant back to the full circle.
 *   (The 8-way octant remap is taken directly from the oracle jump table @0x80056CB8 / blocks
 *    0x800ED610-0x800ED658, delay-slots resolved -- see the switch below.)
 */

extern int fatantbl[257];

extern void make64(int *out, int y, unsigned int shift);   /* @0x800FE488 math64a.obj */
extern int  divu64(int lo, int hi, unsigned int den);      /* @0x800FE4E0 math64a.obj; ABI $a0=lo,$a1=hi,$a2=den */

extern int fixedatan(int x, int y)   /* @0x800ED528 */
{
    int a2;
    /* MATCH: keep the normalized coordinates in x/y and swap them in place.  Separate num/den
     * locals let GCC retain the incoming argument registers and caused the former whole-function
     * coloring residual.  Likewise, split the division result only once: save r>>8 as `frac`,
     * then shift `r` itself to become the table index.  That preserves the oracle's $v0 result
     * web and leaves the interpolation accumulator in `a2`. */
    int oct = 0;
    if (y < 0) { oct |= 2; y = -y; }      /* bit1: y negative */
    if (x < 0) { oct |= 4; x = -x; }      /* bit2: x negative */


    if (x == y) {
        a2 = 0x2000;                       /* 45 deg */
    } else {
        int d;
        unsigned frac;
        int buf[2];
        unsigned r;

        if (y < x) {
            int tmp = x;
            x = y;
            y = tmp;
            oct |= 1;                                      /* bit0: |x| dominant */
        }

        make64(buf, x, 32);                                /* (@0x800FE488/E4E0; NOT libgcc __udivdi3) */
        r = (unsigned)divu64(buf[0], buf[1], (unsigned)y); /* (x<<32)/y as a 0.32 fraction */
        frac = r >> 8;
        r >>= 24;
        a2 = fatantbl[r];
        d = fatantbl[r + 1] - a2;
        /* MATCH: plain 32-bit `mult;mflo;srl 16` -- d and frac both fit comfortably in 32 bits
         * (d <= ~41, frac < 0x10000) so the oracle does NOT widen to a 64-bit multiply here
         * (that's the "mult;mfhi" HIGH-part idiom for OVERFLOWING products, not this). Cast frac
         * to (signed) int so the multiply is `mult` not `multu` (matches oracle's signed mult). */
        a2 += (int)((unsigned)(d * (int)(frac & 0xFFFF)) >> 16);
    }

    switch (oct) {                         /* octant -> full circle; oracle jump table @0x80056CB8 (H02) */
    case 0:  goto return_a2;               /* 0x800ED658 v0=a2                       */
    case 1:  a2 = (-a2) + 0x4000;          /* 0x800ED610 v0=-a2; a2=v0+0x4000; v0=a2 */
             goto return_a2;
    case 2:  return 0x8000 - a2;           /* 0x800ED61C v0=0x8000; v0-=a2           */
    case 3:  return a2 + 0x4000;           /* 0x800ED628 v0=a2+0x4000                */
    case 4:  return -a2;                   /* 0x800ED630 v0=-a2                      */
    case 5:  return a2 - 0x4000;           /* 0x800ED638 v0=a2-0x4000                */
    case 6:  return a2 - 0x8000;           /* 0x800ED640 v0=-0x8000; v0=a2+v0        */
    case 7:  return -a2 - 0x4000;          /* 0x800ED64C v0=-a2; v0+=-0x4000         */
    default: goto return_a2;               /* out of range -> shared unmodified tail  */
    }
return_a2:
    return a2;
}
