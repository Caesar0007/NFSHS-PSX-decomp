/* MATCH (w51-a8, 2026-08-09) -- ACCEPT-AS-FLOOR RE-VERIFIED with the W50 toolkit AND
 * against a byte-matched vendor sibling; the 2-diff residual survives everything:
 *   VENDOR CROSS-CHECK: Rage Racer's 100%-complete decomp ships this exact function as
 *   plain C (C:\Tempage-racer-decomp\src\main\PAL\lib\libc\memmove.c, gcc-2.6.3
 *   -O2 -G0).  Its spelling is character-for-character our shape (`if (dest >= src)`
 *   backward `dest[count] = src[count]`, else forward `*dest++ = *src++`, `return dest`)
 *   and gates the SAME 2 diffs at 27/27 here -- so the BODY is the vendor body and the
 *   residual is purely a toolchain decision.
 *   THE RESIDUAL, named: at the end of the backward arm the oracle keeps `j .L800FE3FC`
 *   with the shared `addu v0,a3,zero` stolen into its delay slot; our reorg relaxes that
 *   jump-to-a-return into a real `jr ra` (gcc-2.8 reorg.c relax_delay_slots).  Post-RTL,
 *   no source form reaches it.
 *   FALSIFIED THIS WAVE (all still 2, or worse): void-tail fence `asm("":: "i"(0))` and
 *   read-only fence `asm("":: "r"(d))` at the arm end (2 each -- the STREAM_cancelrequest
 *   de-merge row does not apply); duplicated `return d;` in both arms (5 -- cross_jump
 *   re-merges them); `return dest;` in the backward arm (10 / +1 pseudo);
 *   -fno-thread-jumps, -fno-schedule-insns2, -fno-peephole, -fomit-frame-pointer (2 each);
 *   -fno-delayed-branch (16 @33-vs-27).  The cc1_272 lane is WORSE (22; with
 *   -fno-strength-reduce 5 @26-vs-27, where reorg fills the RETURN's slot instead of
 *   stealing into the `j`).  ==> genuine floor at 2.
 */
/* syslib/psx/libc/MEMMOVE.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   obj nfs4\syslib\psx\MEMMOVE.obj ; libc.lib.  1 fn memmove @0x800FE398 (108 B) -- REAL code (in EXE).
 *   Ghidra nfs4-f.exe.c.  Overlap-safe: backward (index form dst[i]=src[i]) when dest>=src, else forward
 *   (pointer-walk *d++ = *s++).  Returns the dest pointer = dest+n in the forward case (d is walked), dest
 *   in the backward case (d untouched) -- matches the binary.
 *   VERIFY: 27/27 insns, 2-diff near-miss -- the only residual is gcc cross-jumping the backward path's
 *   `jr ra` into the shared epilogue (oracle `j .L3FC; addu v0,a3,zero[delay]`) vs our inline `jr ra`.
 *   A pure code-layout tie-break (both byte-valid); not reachable from C structure (early-return form
 *   regresses to 5 diffs).  branch polarity + loop shapes are exact.
 */
extern void *memmove(void *dest, void *src, int n)   /* @0x800FE398 */
{
    unsigned char *d = (unsigned char *)dest;
    unsigned char *s = (unsigned char *)src;
    if (d >= s) {
        while (n-- > 0) {
            d[n] = s[n];
        }
    } else {
        while (n-- > 0) {
            *d = *s;
            s = s + 1;
            d = d + 1;
        }
    }
    return d;
}
