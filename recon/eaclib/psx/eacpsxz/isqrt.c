/* eaclib/psx/eacpsxz/isqrt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\isqrt.obj ; EACPSXZ.LIB.  1 fn @0x800F32CC.  isqrt -- 32-bit integer square root.
 *   Ghidra nfs4-f.exe.c (isqrt) + IDA sig.  Seeds low/high bounds from ONE u8[256] estimate ramp
 *   (isqrttbl below; the old u16-isqrttbl + DAT_8013be0f pair was a Ghidra two-view artifact of this
 *   single table) scaled by the magnitude of `a`, then binary-searches to the exact floor-sqrt.
 *   Gate 2026-07-26 (w32-a5): PASS 113/113 byte-exact.  The w31 "retail lazy-copy identity floor"
 *   verdict on the last 24 diffs was WRONG -- all three residuals were source-reachable:
 *     (1) the a&0xC000 seed path was written as a POINTER (`p = isqrttbl + (a>>8)`), which CSEs to
 *         one register; its three sibling paths use ARRAY-INDEX form and already matched.  Writing
 *         it the same way (`isqrttbl[(a>>8)-1]` / `isqrttbl[a>>8]`) reproduces retail's
 *         `addu a0,idx,base; addu v0,a0,zero` base+copy pair. (24 -> 13)
 *     (2) midpoint-probe BRANCH POLARITY: the oracle branches to `return mid` and falls through to
 *         `return lo`, i.e. `if (mid*mid <= a) return mid;` not `if (a < mid*mid) return lo;`.
 *         (13 -> 9)
 *     (3) ONE textual `return lo` for the whole small half (probe nested in `if (hi-lo >= 2){}`)
 *         so both exits share the single tail (9 -> 5), and the big-half loop must use the SAME
 *         named `mid` local as the small half -- one pseudo across both halves is what parks mid in
 *         $v1 and forces retail's `addu v0,v1,zero` copy into the mult latency slot (5 -> PASS).
 *   Raw nfs4-f.exe E3ACC..E3C8F SHA-256:
 *   7b06f575a01ba23f321d2e1bba53b3b6f3a9a40c57c100fb744f7bc59b0a9cab.
 */
/* ONE u8[256] estimate ramp @0x8013BE10: isqrttbl[i] = round(16*sqrt(i+1)) (0x10..0xff, monotonic,
 * byte-exact from image; model verified 255/255 within +-2). The oracle brackets sqrt with TWO byte
 * loads off the SAME base: `lbu 0(base+i)` = isqrttbl[i] and `lbu -1(base+i)` = isqrttbl[i-1] (every
 * reachable index is >=1). The old recon mis-declared this as `u16 isqrttbl` (scaled the index by 2 —
 * out-of-bounds garbage reads) + a phantom never-defined scalar `DAT_8013be0f` (= base-1 view; the
 * 0x81 byte at 0x8013BE0F belongs to the PREVIOUS symbol). */
extern unsigned char isqrttbl[];     /* @0x8013BE10 */

extern unsigned int isqrt(unsigned int a);   /* @0x800F32CC */

/* isqrt @0x800F32CC : floor(sqrt(a)).  lo/hi = bracketing estimates isqrttbl[i-1]/isqrttbl[i]
 * scaled by the operand magnitude; big half binary-searches, small half does one midpoint probe. */
extern unsigned int isqrt(unsigned int a)
{
    unsigned int lo, hi, mid;
    if ((a & 0xffff0000) != 0) {
        if ((a & 0xff000000) != 0) {   /* oracle: beqz skips -> 24-bit path is the fall-through */
            lo = (unsigned int)isqrttbl[(a >> 0x18) - 1] << 8;
            hi = ((unsigned int)isqrttbl[a >> 0x18] + 1) << 8;
        } else {
            lo = (unsigned int)isqrttbl[(a >> 0x10) - 1] << 4;
            hi = ((unsigned int)isqrttbl[a >> 0x10] + 1) << 4;
        }
        while (2 <= hi - lo) {
            mid = (lo + hi) >> 1;
            if (a < mid * mid)
                hi = mid;
            else
                lo = mid;
        }
        return lo;
    }
    if ((a & 0xff00) != 0) {           /* oracle: beqz skips -> the a<0x100 tail is out-of-line last */
        if ((a & 0xf000) != 0) {
            if ((a & 0xc000) != 0) {
                lo = (unsigned int)isqrttbl[(a >> 8) - 1];
                hi = (unsigned int)isqrttbl[a >> 8] + 1;
            } else {
                lo = (unsigned int)(isqrttbl[(a >> 6) - 1] >> 1);
                hi = (unsigned int)(isqrttbl[a >> 6] >> 1) + 1;
            }
        } else if ((a & 0xc00) != 0) {
            lo = (unsigned int)(isqrttbl[(a >> 4) - 1] >> 2);
            hi = (unsigned int)(isqrttbl[a >> 4] >> 2) + 1;
        } else {
            lo = (unsigned int)(isqrttbl[(a >> 2) - 1] >> 3);
            hi = (unsigned int)(isqrttbl[a >> 2] >> 3) + 1;
        }
        if (hi - lo >= 2) {
            mid = (lo + hi) >> 1;
            if (mid * mid <= a)
                return mid;
        }
        return lo;
    }
    if (a != 0)   /* MATCH: table path = bnez branch target, return-0 = fall-through (oracle) */
        return (unsigned int)(isqrttbl[a - 1] >> 4);
    return 0;
}
