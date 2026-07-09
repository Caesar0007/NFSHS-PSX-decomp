typedef int bool;
#define true 1
#define false 0
/* eaclib/psx/eacpsxz/unbtree.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\unbtree.obj ; EACPSXZ.LIB.  1 fn @0x800F55B4.  unbtree -- EA "btree" (dictionary)
 *   decompressor: builds clue/left/right code tables then expands tokens (literal / escaped-literal / tree
 *   node).  Ghidra nfs4-f.exe.c (unbtree) + IDA sig.  Tree nodes are expanded by unref::chase, sharing the
 *   SQVs (src cursor) / SQVd (dst cursor) / SQVclue/left/right (table bases) globals.
 *   The Ghidra goto-into-loop is restructured to equivalent control flow.
 */

/* unbtree.obj-owned cursors/table bases (extern-declared, never defined; BSS) */
 int SQVs, SQVd, SQVclue, SQVleft, SQVright; 
extern int  SQVs;       /* source cursor */
extern int  SQVd;       /* destination cursor */
extern int  SQVclue;    /* clue table base (0=literal, 1=escape, 0xff=node) */
extern int  SQVleft;    /* node left-child table base */
extern int  SQVright;   /* node right-child table base */
extern void chase(unsigned int code);   /* unref.obj */

extern int unbtree(unsigned char *src, unsigned char *dst);   /* @0x800F55B4 */

/* unbtree @0x800F55B4 : decompress `src` into `dst`; returns the (24-bit) uncompressed size.  src==0 just
 *   (re)points the dst cursor and returns 0. */
extern int unbtree(unsigned char *src, unsigned char *dst)
{
    unsigned char clueTbl[256], leftTbl[256], rightTbl[256];
    unsigned char b1, b2, b3, b;
    int           i;
    unsigned int  code;

    SQVclue  = (int)clueTbl;
    SQVleft  = (int)leftTbl;
    SQVright = (int)rightTbl;
    if (src == (unsigned char *)0) {
        SQVd = (int)dst;
        SQVs = 0;
        return 0;
    }
    SQVs = (int)(src + 2);
    if ((unsigned int)*src * 0x100 + src[1] == 0x47fb)   /* skip the optional 0x47FB header */
        SQVs = (int)(src + 5);
    b1 = *(unsigned char *)SQVs;                          /* 24-bit uncompressed size */
    b2 = *(unsigned char *)(SQVs + 1);
    b3 = *(unsigned char *)(SQVs + 2);
    SQVs = SQVs + 3;
    SQVd = (int)dst;

    i = 0;
    do {
        *(unsigned char *)(SQVclue + i) = 0;
        i = i + 1;
    } while (i < 0x100);

    b = *(unsigned char *)SQVs;                           /* the escape code */
    SQVs = SQVs + 1;
    *(unsigned char *)(SQVclue + (unsigned int)b) = 1;

    b = *(unsigned char *)SQVs;                           /* node count */
    SQVs = SQVs + 1;
    if (b != 0) {
        bool more;
        i = 1;
        do {
            code = (unsigned int)*(unsigned char *)SQVs;
            *(unsigned char *)(SQVleft + code)  = *(unsigned char *)(SQVs + 1);
            *(unsigned char *)(SQVright + code) = *(unsigned char *)(SQVs + 2);
            SQVs = SQVs + 3;
            *(unsigned char *)(SQVclue + code) = 0xff;
            more = i < (int)(unsigned int)b;
            i = i + 1;
        } while (more);
    }

    for (;;) {
        unsigned char ch  = *(unsigned char *)SQVs;
        char          clue;
        code = (unsigned int)ch;
        clue = *(char *)(SQVclue + code);
        if (clue == 0) {                                 /* literal */
            SQVs = SQVs + 1;
            *(unsigned char *)SQVd = ch;
            SQVd = SQVd + 1;
        } else if (-1 < clue) {                          /* escape code -> next byte is an escaped literal */
            unsigned char esc = *(unsigned char *)(SQVs + 1);
            if (esc == 0) {
                SQVs = SQVs + 2;
                return (int)(((unsigned int)b1 * 0x100 + b2) * 0x100 + b3);
            }
            SQVs = SQVs + 2;
            *(unsigned char *)SQVd = esc;
            SQVd = SQVd + 1;
        } else {                                         /* tree node -> expand both children */
            SQVs = SQVs + 1;
            chase((unsigned int)*(unsigned char *)(SQVleft + code));
            chase((unsigned int)*(unsigned char *)(SQVright + code));
        }
    }
}
