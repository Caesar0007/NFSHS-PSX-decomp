/* eaclib/psx/eacpsxz/textcode.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   obj nfs4\eaclib\psx\textcode.obj ; EACPSXZ.LIB.  Three adjacent text decoders
 *   @[0x801069AC .. 0x80106A34): ANSI, ASCII-to-Shift-JIS remap, and Shift-JIS.
 *   The paired SYM archive records identify textcode.obj immediately before the
 *   separate, data-only isqrttbl.obj member.
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "textcode.h"

/* ASCII(0x20..0x7f) -> full-width SJIS; textcode.obj .data 0x8013BD50..0x8013BE10, owned here since 2026-09-19 */
unsigned short D_8013BD50[96] = {
    0x8140, 0x8149, 0x8167, 0x8194, 0x8190, 0x8193, 0x8195, 0x8166, 0x8169, 0x816A, 0x8196, 0x817B,
    0x8143, 0x817C, 0x8144, 0x815E, 0x824F, 0x8250, 0x8251, 0x8252, 0x8253, 0x8254, 0x8255, 0x8256,
    0x8257, 0x8258, 0x8146, 0x8147, 0x8183, 0x8181, 0x8184, 0x8148, 0x8197, 0x8260, 0x8261, 0x8262,
    0x8263, 0x8264, 0x8265, 0x8266, 0x8267, 0x8268, 0x8269, 0x826A, 0x826B, 0x826C, 0x826D, 0x826E,
    0x826F, 0x8270, 0x8271, 0x8272, 0x8273, 0x8274, 0x8275, 0x8276, 0x8277, 0x8278, 0x8279, 0x816D,
    0x815F, 0x816E, 0x81AA, 0x8151, 0x8165, 0x8281, 0x8282, 0x8283, 0x8284, 0x8285, 0x8286, 0x8287,
    0x8288, 0x8289, 0x828A, 0x828B, 0x828C, 0x828D, 0x828E, 0x828F, 0x8290, 0x8291, 0x8292, 0x8293,
    0x8294, 0x8295, 0x8296, 0x8297, 0x8298, 0x8299, 0x829A, 0x816F, 0x8162, 0x8170, 0x8160, 0x81A6,
};

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
