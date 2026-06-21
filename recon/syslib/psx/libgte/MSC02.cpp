/* syslib/psx/libgte/MSC02.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(MSC02.OBJ): VectorNormal / VectorNormalS / VectorNormalSS -- normalise a 3D
 *   vector to unit length using the GTE.  The three public entries differ only in operand width
 *   (int VECTOR vs short SVECTOR in/out); all share one GTE worker (@0x800F1B3C):
 *     - load the vector into IR1..IR3, GTE SQR -> |v|^2 (sum of MAC1..MAC3);
 *     - GTE leading-zero-count (LZCS/LZCR) to bracket the magnitude, index the inverse-sqrt
 *       table, and derive the post-scale shift;
 *     - reload the vector, GTE GPF (IR0 * IR1..IR3) -> scaled components, then shift down.
 *   On MIPS this is the cop2 instruction stream (byte-faithful SQR/GPF via .word); on the host
 *   the GTE is absent, so the worker is a stub (matching the project's gte_* host convention).
 *
 *   _rsqrt_tbl @0x80134A5C is a runtime-populated (BSS) inverse-sqrt mantissa table. */

typedef short SVECTOR_xyz;

extern short _rsqrt_tbl[];   /* @0x80134A5C : inverse-sqrt table (filled at GTE init) */

/* @0x800F1B3C : GTE unit-normalise (x,y,z) -> (*ox,*oy,*oz); returns |v|^2. */
static int _vecnorm(int x, int y, int z, int *ox, int *oy, int *oz)
{
#if defined(__mips__)
    int sq1, sq2, sq3, mag, lz, shift, idx, scale, nx, ny, nz;
    __asm__ volatile(
        "mtc2 %3,$9\n\t mtc2 %4,$10\n\t mtc2 %5,$11\n\t"
        ".word 0x4aa00428\n\t"                       /* GTE SQR (square IR1..3) */
        "mfc2 %0,$25\n\t mfc2 %1,$26\n\t mfc2 %2,$27"
        : "=r"(sq1), "=r"(sq2), "=r"(sq3) : "r"(x), "r"(y), "r"(z));
    mag = sq1 + sq2 + sq3;                            /* |v|^2 */
    __asm__ volatile("mtc2 %1,$30\n\t nop\n\t mfc2 %0,$31"
                     : "=r"(lz) : "r"(mag));           /* leading-zero count of |v|^2 */
    lz &= ~1;
    shift = (0x1f - lz) >> 1;
    if (lz - 0x18 >= 0) idx = mag << (lz - 0x18);
    else                idx = mag >> (0x18 - lz);
    idx = (idx - 0x40) << 1;
    scale = _rsqrt_tbl[idx >> 1];
    __asm__ volatile(
        "mtc2 %3,$8\n\t mtc2 %4,$9\n\t mtc2 %5,$10\n\t mtc2 %6,$11\n\t"
        ".word 0x4b90003d\n\t"                       /* GTE GPF (IR0 * IR1..3) */
        "mfc2 %0,$25\n\t mfc2 %1,$26\n\t mfc2 %2,$27"
        : "=r"(nx), "=r"(ny), "=r"(nz)
        : "r"(scale), "r"(x), "r"(y), "r"(z));
    *ox = nx >> shift;
    *oy = ny >> shift;
    *oz = nz >> shift;
    return mag;
#else
    (void)x; (void)y; (void)z;                        /* GTE not present on the host */
    *ox = 0; *oy = 0; *oz = 0;
    return 0;
#endif
}

/* @0x800F1ADC : int vector -> int vector. */
extern "C" long VectorNormal(void *v0, void *v1)
{
    int *s = (int *)v0, *d = (int *)v1, ox, oy, oz;
    int mag = _vecnorm(s[0], s[1], s[2], &ox, &oy, &oz);
    d[0] = ox; d[1] = oy; d[2] = oz;
    return mag;
}

/* @0x800F1AC8 : int vector -> short vector. */
extern "C" long VectorNormalS(void *v0, void *v1)
{
    int   *s = (int *)v0;
    short *d = (short *)v1;
    int ox, oy, oz;
    int mag = _vecnorm(s[0], s[1], s[2], &ox, &oy, &oz);
    d[0] = (short)ox; d[1] = (short)oy; d[2] = (short)oz;
    return mag;
}

/* @0x800F1B0C : short vector -> short vector. */
extern "C" long VectorNormalSS(void *v0, void *v1)
{
    short *s = (short *)v0, *d = (short *)v1;
    int ox, oy, oz;
    int mag = _vecnorm(s[0], s[1], s[2], &ox, &oy, &oz);
    d[0] = (short)ox; d[1] = (short)oy; d[2] = (short)oz;
    return mag;
}
