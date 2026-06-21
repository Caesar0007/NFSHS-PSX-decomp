/* eaclib/psx/eacpsxz/textfor.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\textfor.obj ; EACPSXZ.LIB.  2 fns @[0x800F4470 .. 0x800F4510].  Look up a font glyph
 *   record by character code -- direct index then binary search.  Ghidra nfs4-f.exe.c + IDA sigs.
 *   (Ghidra showed the count as the global DAT_80135c14; it is the 3rd parameter.)
 */
extern "C" unsigned int geti(void *p, char nbits);   /* getm */
extern "C" int DAT_80135c14;   /* font glyph-table entry count */
extern "C" int DAT_80135c24;   /* font glyph-table base (0xb bytes/entry) */

extern "C" int          textbsearch(unsigned int key, int base, int count, int stride); /* @0x800F4470 */
extern "C" unsigned int getcharacter(unsigned int code);                                /* @0x800F4510 */

/* textbsearch @0x800F4470 : binary-search `count` records (stride `stride`) for the one whose 2-byte key
 *   matches `key`; returns its address, or 0. */
extern "C" int textbsearch(unsigned int key, int base, int count, int stride)
{
    int entry;
    for (;;) {
        if (count == 0)
            return 0;
        entry = base + (count >> 1) * stride;
        {
            unsigned int v = geti((void *)entry, 2);
            if (key == v)
                break;
            if (0 < (int)(key - v)) {
                base = entry + stride;
                count = count - 1;
            }
        }
        count = count >> 1;
    }
    return entry;
}

/* getcharacter @0x800F4510 : glyph record for `code` -- try the direct slot (code-0x20), else binary-search. */
extern "C" unsigned int getcharacter(unsigned int code)
{
    int          base  = DAT_80135c24;
    int          entry = DAT_80135c24 + (int)(code - 0x20) * 0xb;
    unsigned int v     = geti((void *)entry, 2);
    if (v != code)
        entry = textbsearch(code, base, DAT_80135c14, 0xb);
    return (unsigned int)entry;
}
