/* eaclib/psx/eacpsxz/unref.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   obj nfs4\eaclib\psx\unref.obj ; EACPSXZ.LIB.  2 fns @[0x800F52B8 .. 0x800F5530].  EA RefPack decompressor
 *   (unrefpack) + the unbtree tree-node expander (chase).  Ghidra nfs4-f.exe.c (unref) + disasm-v3 + IDA sigs.
 *   Every puti() writes 4 bytes (delay-slot a2=4 -- the RefPack "over-write 4, advance by the real count"
 *   trick; the cursor advances via the back-reference arithmetic).  refcpy/memcpyl live in unhuff.obj.
 */
/* MATCH: chase's oracle reaches all four via %gp_rel -- tentative defs (mergeable
 * .comm; unbtree.c tentative-defines the same set, the linker folds them). */
int SQVd;       /* destination cursor (shared with unbtree) */
int SQVclue;    /* clue table base */
int SQVleft;    /* node left-child table base */
int SQVright;   /* node right-child table base */

extern unsigned int   geti(void *p, char nbits);               /* getm */
extern void           puti(unsigned char *buf, unsigned int val, int n); /* textcrnt */
extern unsigned char *refcpy(unsigned char *src, unsigned int count, int len); /* unhuff */
extern void           memcpyl(char *dst, char *src, int len);  /* unhuff */

extern int  unrefpack(unsigned char *comp, unsigned char *out, int reverse); /* @0x800F52B8 */
extern void chase(unsigned int code);                                               /* @0x800F5530 */

/* unrefpack @0x800F52B8 : decompress RefPack stream `comp` into `out` (only if `reverse` != 0, else size-query);
 *   returns the 24-bit uncompressed size.
 * RAW/ORACLE REDUCTION (146->113): the retail body mutates the incoming compressed/output cursors
 * directly.  Removing the hdr/ip/back aliases restores the four command layouts, including the
 * literal-run fall-through and terminator branch.  Remaining residual is dominated by the saved-reg
 * cycle for the two cursor parameters plus five arithmetic/scheduling instructions. */
extern int unrefpack(unsigned char *comp, unsigned char *out, int reverse)
{
    int           size = 0;
    unsigned char trail[8];
    if (comp != (unsigned char *)0) {
        unsigned int flags = geti(comp, 4);
        comp += 2;
        if ((flags & 1) != 0)
            comp += 3;
        size = (int)(((unsigned int)comp[0] << 16) +
                     ((unsigned int)comp[1] << 8) + comp[2]);
        comp += 3;
        if (reverse != 0) {
            puti(trail, geti(out + size, 4), 4);          /* save the bytes at the splice point */
            for (;;) {
                unsigned int op = geti(comp, 4);
                if ((op & 0x80) == 0) {                   /* 2-byte command */
                    unsigned int   count;
                    int            len;
                    comp += 2;
                    reverse = op & 3;
                    puti(out, geti(comp, 4), 4);
                    out += reverse;
                    comp += reverse;
                    count = ((op << 3) & 0x300) + (((op >> 8) & 0xff) + 1);
                    len   = (int)(op >> 2 & 7) + 3;
                    out   = refcpy(out, count, len);
                } else if ((op & 0x40) == 0) {            /* 3-byte command */
                    unsigned int   count;
                    int            len;
                    comp += 3;
                    reverse = op >> 0xe & 3;
                    puti(out, geti(comp, 4), 4);
                    out += reverse;
                    comp += reverse;
                    count = (((op >> 8) & 0x3f) << 8) + (((op >> 16) & 0xff) + 1);
                    len   = (int)(op & 0x3f) + 4;
                    out   = refcpy(out, count, len);
                } else if ((op & 0x20) == 0) {            /* 4-byte command */
                    unsigned int   count;
                    int            len;
                    comp += 4;
                    reverse = op & 3;
                    puti(out, geti(comp, 4), 4);
                    out += reverse;
                    comp += reverse;
                    count = ((op << 12) & 0x10000) + ((op & 0xff00) + 1) +
                            ((op >> 16) & 0xff);
                    len   = (int)(((op << 6) & 0x300) + (op >> 24)) + 5;
                    out   = refcpy(out, count, len);
                } else {                                  /* literal run / terminator */
                    comp += 1;
                    if ((op & 0xff) < 0xfc) {
                        int len = (int)((op & 0x1f) + 1) * 4;
                        memcpyl((char *)out, (char *)comp, len);
                        out = out + len;
                        comp = comp + len;
                    } else {
                        reverse = op & 3;
                        for (; reverse != 0; reverse = reverse - 1) {
                            *out = *comp;
                            comp = comp + 1;
                            out  = out + 1;
                        }
                        puti(out, geti(trail, 4), 4);     /* restore the saved splice bytes */
                        return size;
                    }
                }
            }
        }
    }
    return size;
}

/* chase @0x800F5530 : recursively expand unbtree node `code` -- emit a literal or descend left+right.
 *   MATCH: VOID (unbtree.c's decl; the apparent $v0 result is incidental), descend =
 *   fall-through (`beqz -> leaf` out-of-line), clue read SIGNED (`lb` -- plain char is
 *   unsigned on this toolchain). */
extern void chase(unsigned int code)
{
    unsigned int idx = code & 0xff;
    if (*(signed char *)(SQVclue + idx) != 0) {
        chase(*(unsigned char *)(SQVleft + idx));
        chase(*(unsigned char *)(SQVright + idx));
    } else {
        int d = SQVd;                   /* ONE load (the char* store would alias-block CSE) */
        *(char *)d = (char)code;
        SQVd = d + 1;
    }
}
