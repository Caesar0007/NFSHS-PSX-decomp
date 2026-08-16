/* eaclib/psx/eacpsxz/atanfunc.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\atanfunc.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col10)
 *   1 fn @0x800E5B38 (300 B): intatan -- integer atan2(y,x) in "brads" (full circle = 1024,
 *   0x100 = 90deg).  FULL reconstruction of the actual code (disasm-v3 MIPS); NOT a stub/thunk.
 *
 *   Reduces (|y|,|x|) to the first octant (ratio = smaller/larger in [0,1]), looks up
 *   atan(ratio) in a 257-entry table (kAtanTable[i]=atan(i/256), 0..0x80), then remaps by the
 *   quadrant base s1 (0/+/-0x100/0x200) and parity s2.  The ratio index is round(256*smaller/larger):
 *   computed in 32-bit normally, or via 64-bit make64/divu64 (@0x800FE488/@0x800FE4E0) when the
 *   numerator >= 0x800000 would overflow a <<8.  Table @0x80136CE8 is obj-local rodata ->
 *   materialized inline (real EXE bytes) so this TU is self-contained.
 *   (Several assignments are MIPS branch delay slots that run on BOTH paths: v0=(|x|<|y|)@5B70,
 *    v0=0x80 for the ratio==1 / (0,0) case @5BB4, s0=larger @5B98.)
 */

extern void make64(int *out, int y, unsigned int shift);   /* @0x800FE488 math64a.obj */
extern int  divu64(int hi, int lo, unsigned int den);      /* @0x800FE4E0 math64a.obj */

extern unsigned char atantbl[257];   /* data-only atantbl.obj @0x80136CE8 */

/* intatan @0x800E5B38 : atan2(y,x) -> brads. */
extern int intatan(int y, int x)
{
    int atanv;
    int v1 = y;                 /* $a0 */
    int s0 = x;                 /* $a1 */
    int s2 = 0;                 /* parity (subtract vs add) */
    int s1 = 0;                 /* quadrant base, brads */

    if (s0 < 0) { s0 = -s0; s2 = 1;        s1 = 0x200; }
    if (v1 < 0) { v1 = -v1; s2 = 1 - s2;   s1 = -s1;   }

    if (s0 < v1) {                          /* |x| < |y| : swap so denom is the larger */
        int t = v1; v1 = s0; s0 = t;        /* v1 = smaller, s0 = larger */
        s1 += (s2 != 0) ? -0x100 : 0x100;   /* MATCH: beqz->+0x100 arm out-of-line */
        s2 = 1 - s2;
    }


    if (v1 == s0) {                         /* ratio 1.0 (incl. 0,0) -> 45deg */
        atanv = 0x80;
    } else {
        unsigned num;
        unsigned den;
        num = (unsigned)v1;
        den = (unsigned)s0;
        if (num & 0xFF800000u) {            /* big numerator: EA make64 + divu64 (@0x800FE488/E4E0,
                                               the original's own 64-bit helpers -- NOT libgcc __udivdi3) */
            int buf[2];
            make64(buf, (int)num, 32);                          /* buf = num << 32 */
            v1 = divu64(buf[0], buf[1], den);             /* (num<<32)/den -- args = buf[0],buf[1] */
            /* MATCH: BRANCHED round (a ?: strength-reduces to the branchless bit-add) */
            if ((unsigned)v1 & 0x800000u)
                v1 = ((unsigned)v1 >> 24) + 1;
            else
                v1 = (unsigned)v1 >> 24;
        } else {
            v1 <<= 8;
            v1 += s0 >> 1;
            v1 = (unsigned)v1 / den;                  /* round(256*num/den); s0>>1 = SRA */
        }
        atanv = atantbl[(unsigned)v1];
    }

    return (s2 == 0) ? (s1 + atanv) : (s1 - atanv);
}
