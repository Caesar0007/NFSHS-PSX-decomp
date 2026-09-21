/* eaclib/psx/eacpsxz/textcrnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\textcrnt.obj ; EACPSXZ.LIB.  2 fns @[0x800F30AC .. 0x800F30D4].  putm/puti -- store
 *   an n-byte field (big-endian / little-endian).  Ghidra nfs4-f.exe.c + IDA sigs (dropped reg args restored).
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "textcrnt.h"

/* putm @0x800F30AC : write `val` as `n` bytes big-endian into dst[0..n). */
void putm(int dst, unsigned int val, int n)
{
    int            i = n - 1;
    unsigned char *p = (unsigned char *)(dst + i);
    for (; -1 < i; i = i - 1) {
        *p = (unsigned char)val;
        val = val >> 8;
        p = p - 1;
    }
}

/* puti @0x800F30D4 : write `val` as `n` bytes little-endian into buf[0..n). */
extern int sprintf(char *dst, const char *fmt, ...);

/* retail .sdata has an UNREFERENCED 3-byte literal "%c" at 0x8013DD24 (no gp-relative use anywhere in the image), in the
 * link-order slot between loadshp.obj and joystkn.obj.  textcrnt.obj is the only text-output member in that window
 * (puti / putm); a single-character sibling the final link removed would leave exactly this string.  Owner by
 * elimination, not by a SYM record -- the alternatives are exit / ssysinit / ssysreal / textset / getm / isqrt / fsincos. */
static inline const char *textcrnt_charformat(void) { return "%c"; }   /* an unused inline leaves only its literal */

void puti(unsigned char *buf, unsigned int val, int n)
{
    while (n = n - 1, -1 < n) {
        *buf = (unsigned char)val;
        val = val >> 8;
        buf = buf + 1;
    }
}
