/* eaclib/psx/eacpsxz/setfont.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\textset.obj ; EACPSXZ.LIB (xlsx col12 / SYM v3 FILE record line 359149).
 *   1 fn @0x800F2E94 (400 B).  setfont -- install `fontId` (a font-header pointer) as the current text font:
 *   copies its glyph metrics into the global current-font descriptor (a flat struct based at 0x80135BA0),
 *   measures the bitmap depth/stride via shapedepth, selects the per-glyph decoder (ANSI vs Shift-JIS), then
 *   clears the blit state and re-inits the text draw lists.  Returns the chosen decoder fn pointer.
 *   Ghidra nfs4-f.exe.c (setfont) + disasm-v3 (delay-slot field stores, the two shapedepth calls,
 *   blockclear(&0x80135BD4,0x40)) + IDA sig.  Plain C (unmangled symbol) -> extern "C" free function; the
 *   DAT_* globals are the shared current-font descriptor (the same ones textfor/textcrnt/textcode reference).
 *
 *   Font header layout read (offsets into `fontId`):
 *     +0x0a u16 glyphCount   +0x0e u16 flags(&3==2 => Shift-JIS)   +0x10..0x13 i8 metrics(ascent/descent...)
 *     +0x14 i32 glyphTblOff  +0x1c i32 shapeOff   +0x20 encoded-data start (probed by geti)
 */
typedef int (*DecodeFn)(unsigned char **cursor);

extern "C" unsigned int geti(void *p, char nbits);                 /* getm */
extern "C" int   shapedepth(unsigned char *shape);                 /* shpdepth */
extern "C" int   decodeansi(unsigned char **cursor);               /* textcode */
extern "C" int   decodeshiftjis(unsigned char **cursor);           /* isqrttbl (obj name misnomer) */
extern "C" void  blockclear(void *dst, int n);                     /* blkfill */
extern "C" void  inittextdraw(void);                               /* textpsx (game) */

/* --- current-font descriptor (flat struct @0x80135BA0; one field per Ghidra DAT_) --- */
extern "C" int      DAT_80135c1c;   /* @0x80135C1C : +0x7c  (=100, default tab/space metric) */
extern "C" int      DAT_80135bac;   /* @0x80135BAC : +0x0c  metric i8[0x10] */
extern "C" int      DAT_80135bb0;   /* @0x80135BB0 : +0x10  metric i8[0x11] */
extern "C" int      DAT_80135bbc;   /* @0x80135BBC : +0x1c  metric i8[0x12] */
extern "C" int      DAT_80135bc0;   /* @0x80135BC0 : +0x20  metric i8[0x13] */
extern "C" int      DAT_80135bc4;   /* @0x80135BC4 : +0x24  i8[0x13]+i8[0x12] */
extern "C" int      DAT_80135bc8;   /* @0x80135BC8 : +0x28  i8[0x13]+i8[0x12] */
extern "C" int      DAT_80135bb8;   /* @0x80135BB8 : +0x18  (=1) */
extern "C" int      DAT_80135c50;   /* @0x80135C50 : +0xb0 */
extern "C" int      DAT_80135c4c;   /* @0x80135C4C : +0xac */
extern "C" int      DAT_80135c20;   /* @0x80135C20 : +0x80  font header ptr */
extern "C" unsigned char *DAT_80135c28; /* @0x80135C28 : +0x88  glyph bitmap (shape) ptr */
extern "C" int      DAT_80135c14;   /* @0x80135C14 : +0x74  glyph count */
extern "C" int      DAT_80135c24;   /* @0x80135C24 : +0x84  glyph table base */
extern "C" int      DAT_80135bb4;   /* @0x80135BB4 : +0x14  bitmap depth (bits/pixel) */
extern "C" int      DAT_80135c18;   /* @0x80135C18 : +0x78  bitmap row stride (bytes) */
extern "C" int      DAT_80135bcc;   /* @0x80135BCC : +0x2c */
extern "C" int      DAT_80135bd0;   /* @0x80135BD0 : +0x30 */
extern "C" int      DAT_80135c54;   /* @0x80135C54 : +0xb4 */
extern "C" DecodeFn DAT_80135c40;   /* @0x80135C40 : +0xa0  selected glyph decoder */
DecodeFn DAT_80135c40;              /* definition (runtime-set; NULL at load). Owned here (DecodeFn TU-local). */
extern "C" int      DAT_80135c44;   /* @0x80135C44 : +0xa4 */
extern "C" unsigned char DAT_80135bd4[0x40]; /* @0x80135BD4 : +0x34  0x40-byte blit state buffer */

extern "C" DecodeFn setfont(int fontId);   /* @0x800F2E94 */

/* setfont @0x800F2E94 : install font header `fontId` as the current text font; returns its glyph decoder. */
extern "C" DecodeFn setfont(int fontId)
{
    unsigned char *shape;
    DecodeFn       decode;
    int            depth;

    DAT_80135c1c = 100;
    DAT_80135bac = (int)*(signed char *)(fontId + 0x10);
    DAT_80135bb0 = (int)*(signed char *)(fontId + 0x11);
    DAT_80135bbc = (int)*(signed char *)(fontId + 0x12);
    DAT_80135bc0 = (int)*(signed char *)(fontId + 0x13);
    DAT_80135bc4 = (int)*(signed char *)(fontId + 0x13) + (int)*(signed char *)(fontId + 0x12);
    shape        = (unsigned char *)(fontId + *(int *)(fontId + 0x1c));
    DAT_80135bc8 = (int)*(signed char *)(fontId + 0x13) + (int)*(signed char *)(fontId + 0x12);
    DAT_80135c14 = (int)*(unsigned short *)(fontId + 10);
    DAT_80135bb8 = 1;
    DAT_80135c50 = 0;
    DAT_80135c4c = 0;
    DAT_80135c24 = fontId + *(int *)(fontId + 0x14);
    DAT_80135c20 = fontId;
    DAT_80135c28 = shape;
    DAT_80135bb4 = shapedepth(shape);
    depth        = shapedepth(shape);
    DAT_80135c18 = (int)((unsigned int)(*(short *)(shape + 4) * depth + 0x1f) & 0xffffffe0) >> 3;

    if ((*(unsigned short *)(fontId + 0xe) & 3) == 2) {
        decode = decodeshiftjis;                                  /* explicit Shift-JIS flag */
    } else if (DAT_80135c14 < 0x100) {
        /* small glyph table: probe the encoded stream -- ANSI if the first code is < 0x100 */
        if (geti((void *)(fontId + 0x20), 2) < 0x100)
            decode = decodeansi;
        else
            decode = decodeshiftjis;
    } else {
        decode = decodeshiftjis;                                 /* large table => multi-byte */
    }

    DAT_80135bcc = 0;
    DAT_80135bd0 = 0;
    DAT_80135c54 = 0;
    DAT_80135c40 = decode;
    blockclear(DAT_80135bd4, 0x40);                              /* @0x80135BD4 : clear 0x40-byte blit state */
    inittextdraw();
    DAT_80135c44 = 0;
    return decode;
}
