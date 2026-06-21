/* eaclib/psx/eacpsxz/unref.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\unref.obj ; EACPSXZ.LIB.  2 fns @[0x800F52B8 .. 0x800F5530].  EA RefPack decompressor
 *   (unrefpack) + the unbtree tree-node expander (chase).  Ghidra nfs4-f.exe.c (unref) + disasm-v3 + IDA sigs.
 *   Every puti() writes 4 bytes (delay-slot a2=4 -- the RefPack "over-write 4, advance by the real count"
 *   trick; the cursor advances via the back-reference arithmetic).  refcpy/memcpyl live in unhuff.obj.
 */
extern "C" int  SQVd;       /* destination cursor (shared with unbtree) */
extern "C" int  SQVclue;    /* clue table base */
extern "C" int  SQVleft;    /* node left-child table base */
extern "C" int  SQVright;   /* node right-child table base */

extern "C" unsigned int   geti(void *p, char nbits);               /* getm */
extern "C" void           puti(unsigned char *buf, unsigned int val, int n); /* textcrnt */
extern "C" unsigned char *refcpy(unsigned char *src, unsigned int count, int len); /* unhuff */
extern "C" void           memcpyl(char *dst, char *src, int len);  /* unhuff */

extern "C" int unrefpack(unsigned char *comp, unsigned char *out, unsigned char *dst); /* @0x800F52B8 */
extern "C" int chase(int code);                                                        /* @0x800F5530 */

/* unrefpack @0x800F52B8 : decompress RefPack stream `comp` into `out` (only if `dst` != 0, else size-query);
 *   returns the 24-bit uncompressed size. */
extern "C" int unrefpack(unsigned char *comp, unsigned char *out, unsigned char *dst)
{
    int           size = 0;
    unsigned char trail[8];
    if (comp != (unsigned char *)0) {
        unsigned int   flags = geti(comp, 4);
        unsigned char *hdr   = comp + 2;
        unsigned char *ip;
        if ((flags & 1) != 0)
            hdr = comp + 5;
        ip   = hdr + 3;
        size = (int)((unsigned int)hdr[0] * 0x10000 + (unsigned int)hdr[1] * 0x100 + hdr[2]);
        if (dst != (unsigned char *)0) {
            puti(trail, geti(out + size, 4), 4);          /* save the bytes at the splice point */
            for (;;) {
                unsigned int op = geti(ip, 4);
                if ((op & 0x80) == 0) {                   /* 2-byte command */
                    unsigned char *back;
                    unsigned int   count;
                    int            len;
                    puti(out, geti(ip + 2, 4), 4);
                    back  = out + (op & 3);
                    ip    = ip + 2 + (op & 3);
                    count = (op & 0x60) * 8 + (op >> 8 & 0xff) + 1;
                    len   = (int)(op >> 2 & 7) + 3;
                    out   = refcpy(back, count, len);
                } else if ((op & 0x40) == 0) {            /* 3-byte command */
                    unsigned int   lit = op >> 0xe & 3;
                    unsigned char *back;
                    unsigned int   count;
                    int            len;
                    puti(out, geti(ip + 3, 4), 4);
                    back  = out + lit;
                    ip    = ip + 3 + lit;
                    count = (op & 0x3f00) + (op >> 0x10 & 0xff) + 1;
                    len   = (int)(op & 0x3f) + 4;
                    out   = refcpy(back, count, len);
                } else if ((op & 0x20) == 0) {            /* 4-byte command */
                    unsigned char *back;
                    unsigned int   count;
                    int            len;
                    puti(out, geti(ip + 4, 4), 4);
                    back  = out + (op & 3);
                    ip    = ip + 4 + (op & 3);
                    count = (op & 0x10) * 0x1000 + (op & 0xff00) + 1 + (op >> 0x10 & 0xff);
                    len   = (int)((op & 0xc) * 0x40 + (op >> 0x18)) + 5;
                    out   = refcpy(back, count, len);
                } else {                                  /* literal run / terminator */
                    ip = ip + 1;
                    if (0xfb < (op & 0xff)) {
                        unsigned int n;
                        for (n = op & 3; n != 0; n = n - 1) {
                            *out = *ip;
                            ip   = ip + 1;
                            out  = out + 1;
                        }
                        puti(out, geti(trail, 4), 4);     /* restore the saved splice bytes */
                        return size;
                    }
                    {
                        int len = (int)((op & 0x1f) + 1) * 4;
                        memcpyl((char *)out, (char *)ip, len);
                        out = out + len;
                        ip  = ip + len;
                    }
                }
            }
        }
    }
    return size;
}

/* chase @0x800F5530 : recursively expand unbtree node `code` -- emit a literal or descend left+right.
 *   Returns the (advanced) SQVd. */
extern "C" int chase(int code)
{
    int          ret;
    unsigned int idx = (unsigned int)code & 0xff;
    if (*(char *)(SQVclue + idx) == '\0') {
        *(char *)SQVd = (char)code;
        ret = SQVd + 1;
        SQVd = ret;
    } else {
        chase((int)(unsigned int)*(unsigned char *)(SQVleft + idx));
        ret = chase((int)(unsigned int)*(unsigned char *)(SQVright + idx));
    }
    return ret;
}
