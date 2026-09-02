/* eaclib/psx/eacpsxz/unbtree.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\unbtree.obj ; EACPSXZ.LIB.  1 fn @0x800F55B4.  unbtree -- EA "btree" (dictionary)
 *   decompressor: builds clue/left/right code tables then expands tokens (literal / escaped-literal / tree
 *   node).  Ghidra nfs4-f.exe.c (unbtree) + IDA sig.  Tree nodes are expanded by unref::chase, sharing the
 *   SQVs (src cursor) / SQVd (dst cursor) / SQVclue/left/right (table bases) globals.
 *   The Ghidra goto-into-loop is restructured to equivalent control flow.
 *
 *   STATUS (2026-07-26): PASS 132/132. The final 100-diff coloring cascade was structural: accumulate
 *   the optional header in one variable, preserve the size-reader's shared p[0]/p[1] base, express the
 *   node loop as `while (i < nodeCount) { ++i; ... }`, and reuse one function-scope `code` across node
 *   construction and token decoding. The final cursor idiom is pointer-typed `*SQVd++ = code`.
 *   Raw nfs4-f.exe E5DB4..E5FC3 SHA-256:
 *   84a0c077a7492393c55e04790f17fa8b6ea1ea330f655ab3a5113e20a5f0f1c8.
 */

/* unbtree.obj-owned cursors/table bases: tentative-defined here (mergeable .comm with unref.c's
 * SQVd/SQVclue/SQVleft/SQVright tentative defs; the linker folds them). Needed so THIS TU knows their
 * size and keeps them -G4 gp-relative (an `extern` decl alone loses gp-rel -- verified: FAIL 220). */
signed char *SQVclue;    /* @0x8013DEC8: clue table base (0=literal, 1=escape, -1=node) */
unsigned char *SQVleft;  /* @0x8013DECC: node left-child table base */
unsigned char *SQVright; /* @0x8013DED0: node right-child table base */
unsigned char *SQVs;     /* @0x8013DED4: source cursor */
unsigned char *SQVd;     /* @0x8013DED8: destination cursor */
extern void chase(unsigned int code);   /* unref.obj */

extern int unbtree(unsigned char *src, unsigned char *dst);   /* @0x800F55B4 */

/* unbtree @0x800F55B4 : decompress `src` into `dst`; returns the (24-bit) uncompressed size.  src==0 just
 *   (re)points the dst cursor and returns 0.
 *   MATCH: SQVs/SQVd are stored from the raw a0/a1 args UNCONDITIONALLY, before the src==0 test (the
 *   null-return relies on SQVs==src==0 already); the header peek indexes src[0]/src[1] directly (not a
 *   walking cursor) while every later byte read is a genuine "*p; p++; SQVs=p;" cursor step, so the
 *   compiler CSEs consecutive reads off the same live pointer instead of reloading the SQVs global. */
extern int unbtree(unsigned char *src, unsigned char *dst)
{
    unsigned char clueTbl[256], leftTbl[256], rightTbl[256];
    int           size = 0;   /* $s1: 24-bit uncompressed size, init 0 for the null path; SINGLE exit
                                 returns it (oracle keeps it in a saved reg all the way through, saves
                                 $s1 first in the prologue, zeroes it in the beqz delay slot). */
    int           i;
    unsigned int  code;

    SQVclue  = (signed char *)clueTbl;
    SQVleft  = leftTbl;
    SQVs     = src;
    SQVd     = dst;
    SQVright = rightTbl;
    if (src != (unsigned char *)0) {
        {
            unsigned int header;
            header = src[0];
            SQVs = src + 1;
            header = (header << 8) + src[1];
            SQVs = src + 2;
            if (header == 0x47fb)                    /* skip the optional 0x47FB header */
                SQVs = src + 5;
        }
        {
            unsigned char *p = SQVs;      /* 24-bit uncompressed size, accumulated
                                                              straight into `size` ($s1) byte-by-byte */
            size = p[0];              p = p + 1;  SQVs = p;
            size = (size << 8) + p[0];              SQVs = p + 1;
            size = (size << 8) + p[1];              SQVs = p + 2;
        }

        i = 0;
        do {
            SQVclue[i] = 0;
            i = i + 1;
        } while (i < 0x100);

        {
            unsigned char *p = SQVs;
            unsigned int   esc;
            esc = *p;  p = p + 1;  SQVs = p;      /* the escape code */
            SQVclue[esc] = 1;
        }

        {
            unsigned char *p = SQVs;
            unsigned int   nodeCount;
            nodeCount = *p;  p = p + 1;  SQVs = p; /* node count */
            i = 0;
            while (i < (int)nodeCount) {
                unsigned char *pp;
                i = i + 1;
                pp = SQVs;
                code = *pp;
                pp = pp + 1;
                SQVs = pp;
                SQVleft[code] = pp[0];
                SQVs = pp + 1;
                SQVright[code] = pp[1];
                SQVs = pp + 2;
                SQVclue[code] = -1;   /* node mark: signed -1 (li -1), not 0xff (li 255) */
            }
        }

        for (;;) {
            unsigned char *p  = SQVs;
            signed char    clue;
            code = *p;
            p = p + 1;
            SQVs = p;
            clue = SQVclue[code];
            if (clue == 0) {                                  /* literal */
            } else if (clue >= 0) {                            /* escape code -> next byte is an escaped literal */
                code = *p;
                SQVs = p + 1;
                if (code == 0)
                    break;                                     /* end-of-stream -> fall to the single exit */
            } else {                                           /* tree node -> expand both children */
                chase((unsigned int)SQVleft[code]);
                chase((unsigned int)SQVright[code]);
                continue;
            }
            *SQVd++ = code;
        }
    }
    return size;
}
