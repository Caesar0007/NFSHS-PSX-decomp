/* eaclib/psx/eacpsxz/textcode.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   obj nfs4\eaclib\psx\textcode.obj ; EACPSXZ.LIB.  Three adjacent text decoders
 *   @[0x801069AC .. 0x80106A34): ANSI, ASCII-to-Shift-JIS remap, and Shift-JIS.
 *   The paired SYM archive records identify textcode.obj immediately before the
 *   separate, data-only isqrttbl.obj member.
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "textcode.h"

extern unsigned short D_8013BD50[];     /* ASCII(0x20..0x7f) -> full-width SJIS */

int decodeansi(unsigned char **cursor)
{
    /* The oracle loads the byte with `lbu` straight into $v0 and returns it with NO
     * re-mask -- an `unsigned char c` local re-masks (`andi v0,255`) on the return
     * (lever #9).  Read+advance the pointer, return the lbu value directly as int. */
    unsigned char *p = *cursor;
    int c = *p;
    *cursor = p + 1;
    return c;
}

unsigned int remapshiftjiscode(unsigned int c)
{
    unsigned int i = c - 0x20;
    if (i < 0x60)
        c = (unsigned int)D_8013BD50[i];
    return c;
}

#if defined(__mips__)
__asm__(
    "\t.globl decodeshiftjis2\n"
    "decodeshiftjis2 = decodeshiftjis\n"
    "\t.globl decodeshiftjis3\n"
    "decodeshiftjis3 = decodeshiftjis\n"
);
#else
extern int decodeshiftjis2(unsigned char **cursor) __attribute__((alias("decodeshiftjis")));
extern int decodeshiftjis3(unsigned char **cursor) __attribute__((alias("decodeshiftjis")));
#endif

int decodeshiftjis(unsigned char **cursor)
{
    unsigned char *p = *cursor;
    unsigned int b1 = *p;
    unsigned int code;
    p = p + 1;
    if ((b1 & 0x80) != 0) {
        code = (unsigned int)*p | (b1 << 8);
        p = p + 1;
    } else {
        code = remapshiftjiscode(b1);
    }
    *cursor = p;
    return (int)(code & 0xffff);
}
