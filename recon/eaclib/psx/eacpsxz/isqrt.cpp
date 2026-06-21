/* eaclib/psx/eacpsxz/isqrt.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\isqrt.obj ; EACPSXZ.LIB.  1 fn @0x800F32CC.  isqrt -- 32-bit integer square root.
 *   Ghidra nfs4-f.exe.c (isqrt) + IDA sig.  Seeds low/high bounds from two per-byte tables (isqrttbl = a
 *   sqrt-estimate u16[256], DAT_8013be0f = its companion u8[256], both rodata / data-mat #75) scaled by the
 *   magnitude of `a`, then binary-searches to the exact floor-sqrt.
 */
extern "C" unsigned short isqrttbl;      /* @rodata : u16[256] sqrt low-bound estimate per top byte */
extern "C" unsigned char  DAT_8013be0f;  /* @0x8013BE0F : u8[256] companion estimate */

extern "C" unsigned int isqrt(unsigned int a);   /* @0x800F32CC */

/* isqrt @0x800F32CC : floor(sqrt(a)). */
extern "C" unsigned int isqrt(unsigned int a)
{
    unsigned int lo, hi, mid, cur;
    if ((a & 0xffff0000) != 0) {
        if ((a & 0xff000000) == 0) {
            hi = ((unsigned int)(&isqrttbl)[a >> 0x10] + 1) * 0x10;
            lo = (unsigned int)(unsigned char)(&DAT_8013be0f)[a >> 0x10] << 4;
        } else {
            lo = (unsigned int)(unsigned char)(&DAT_8013be0f)[a >> 0x18] << 8;
            hi = ((unsigned int)(&isqrttbl)[a >> 0x18] + 1) * 0x100;
        }
        while (cur = lo, 1 < hi - cur) {
            mid = (cur + hi) >> 1;
            lo = mid;
            if (a < mid * mid) {
                lo = cur;
                hi = mid;
            }
        }
        return cur;
    }
    if ((a & 0xff00) == 0) {
        if (a == 0)
            return 0;
        lo = (unsigned int)((unsigned char)(&DAT_8013be0f)[a] >> 4);
    } else {
        if ((a & 0xf000) == 0) {
            if ((a & 0xc00) == 0) {
                hi = (unsigned int)((unsigned char)(&DAT_8013be0f)[a >> 2] >> 3);
                lo = (unsigned int)((&isqrttbl)[a >> 2] >> 3);
            } else {
                hi = (unsigned int)((unsigned char)(&DAT_8013be0f)[a >> 4] >> 2);
                lo = (unsigned int)((&isqrttbl)[a >> 4] >> 2);
            }
        } else if ((a & 0xc000) == 0) {
            hi = (unsigned int)((unsigned char)(&DAT_8013be0f)[a >> 6] >> 1);
            lo = (unsigned int)((&isqrttbl)[a >> 6] >> 1);
        } else {
            lo = (unsigned int)(&isqrttbl)[a >> 8];
            hi = (unsigned int)(unsigned char)(&DAT_8013be0f)[a >> 8];
        }
        if ((lo + 1) - hi < 2)
            return hi;
        lo = (hi + lo + 1) >> 1;
        if (a < lo * lo)
            return hi;
    }
    return lo;
}
