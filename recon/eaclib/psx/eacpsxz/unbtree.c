/* eaclib/psx/eacpsxz/unbtree.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   obj nfs4\eaclib\psx\unbtree.obj ; EACPSXZ.LIB.  1 fn @0x800F55B4.  unbtree -- EA "btree" (dictionary)
 *   decompressor: builds clue/left/right code tables then expands tokens (literal / escaped-literal / tree
 *   node).  Ghidra nfs4-f.exe.c (unbtree) + IDA sig.  Tree nodes are expanded by unref::chase, sharing the
 *   SQVs (src cursor) / SQVd (dst cursor) / SQVclue/left/right (table bases) globals.
 *   The Ghidra goto-into-loop is restructured to equivalent control flow.
 *
 *   STATUS (2026-07-19): FAIL 100 diffs, INSTRUCTION-COUNT-EXACT (132/132). Progression 166 (orig)
 *   -> 116 (w16-a4: `signed char clue` for the `lb` sign-read, unconditional SQVs=src/SQVd=dst before
 *   the null-check, genuine "*p;p++;SQVs=(int)p;" cursor reads, `unsigned int` ch/esc/wb dropping 2
 *   `andi ...,0xff` masks) -> 100 via the NFS2 PC-beta Watcom reference (nfsw.exe unbtree.obj/_unbtree.c,
 *   FUN_004a4d34): (a) SINGLE EXIT returning `size` -- `int size=0;` inited at the top so the null path
 *   falls through returning it (was a literal `return 0;` + a mid-loop `return size;`, two exits, which
 *   blocked gcc from keeping size in $s1); this removed the 2 extra insns and made the count exact.
 *   (b) size accumulated byte-by-byte STRAIGHT into `size` (`size=*p; size=(size<<8)+*p; ...`) so the
 *   first byte lands directly in $s1, matching the oracle's `lbu s1; sll; addu s1`. (c) node mark
 *   `*(signed char*)(SQVclue+code) = -1;` (li -1 / addiu) not `= 0xff` (li 255 / ori) -- the signed-char
 *   class on the STORE side. RESIDUAL 100 (pure coloring): gcc copies src a0->$a2 at entry and threads
 *   the header-peek off $a2 while the oracle keeps src in $a0 throughout; this ~1-reg divergence shifts
 *   register names across the whole body. a4's permuter run (permuter_work/unbtree, -j4, ~600 iters)
 *   plateaued at 970/1000. Documented near-miss -- a longer permuter grind or RTL-level tracing needed.
 */

/* unbtree.obj-owned cursors/table bases: tentative-defined here (mergeable .comm with unref.c's
 * SQVd/SQVclue/SQVleft/SQVright tentative defs; the linker folds them). Needed so THIS TU knows their
 * size and keeps them -G4 gp-relative (an `extern` decl alone loses gp-rel -- verified: FAIL 220). */
int SQVs;       /* source cursor */
int SQVd;       /* destination cursor */
int SQVclue;    /* clue table base (0=literal, 1=escape, 0xff=node) */
int SQVleft;    /* node left-child table base */
int SQVright;   /* node right-child table base */
extern void chase(unsigned int code);   /* unref.obj */

extern int unbtree(unsigned char *src, unsigned char *dst);   /* @0x800F55B4 */

/* unbtree @0x800F55B4 : decompress `src` into `dst`; returns the (24-bit) uncompressed size.  src==0 just
 *   (re)points the dst cursor and returns 0.
 *   MATCH: SQVs/SQVd are stored from the raw a0/a1 args UNCONDITIONALLY, before the src==0 test (the
 *   null-return relies on SQVs==src==0 already); the header peek indexes src[0]/src[1] directly (not a
 *   walking cursor) while every later byte read is a genuine "*p; p++; SQVs=(int)p;" cursor step, so the
 *   compiler CSEs consecutive reads off the same live pointer instead of reloading the SQVs global. */
extern int unbtree(unsigned char *src, unsigned char *dst)
{
    unsigned char clueTbl[256], leftTbl[256], rightTbl[256];
    int           size = 0;   /* $s1: 24-bit uncompressed size, init 0 for the null path; SINGLE exit
                                 returns it (oracle keeps it in a saved reg all the way through, saves
                                 $s1 first in the prologue, zeroes it in the beqz delay slot). */
    int           i;

    SQVclue  = (int)clueTbl;
    SQVleft  = (int)leftTbl;
    SQVs     = (int)src;
    SQVd     = (int)dst;
    SQVright = (int)rightTbl;
    if (src != (unsigned char *)0) {
        {
            unsigned int b1, b2;
            b1 = src[0];
            SQVs = (int)(src + 1);
            b2 = src[1];
            SQVs = (int)(src + 2);
            if (((b1 << 8) + b2) == 0x47fb)          /* skip the optional 0x47FB header */
                SQVs = (int)(src + 5);
        }
        {
            unsigned char *p = (unsigned char *)SQVs;      /* 24-bit uncompressed size, accumulated
                                                              straight into `size` ($s1) byte-by-byte */
            size = *p;                p = p + 1;  SQVs = (int)p;
            size = (size << 8) + *p;  p = p + 1;  SQVs = (int)p;
            size = (size << 8) + *p;  p = p + 1;  SQVs = (int)p;
        }

        i = 0;
        do {
            *(unsigned char *)(SQVclue + i) = 0;
            i = i + 1;
        } while (i < 0x100);

        {
            unsigned char *p = (unsigned char *)SQVs;
            unsigned int   esc;
            esc = *p;  p = p + 1;  SQVs = (int)p;      /* the escape code */
            *(unsigned char *)(SQVclue + esc) = 1;
        }

        {
            unsigned char *p = (unsigned char *)SQVs;
            unsigned int   nodeCount;
            nodeCount = *p;  p = p + 1;  SQVs = (int)p; /* node count */
            if (nodeCount != 0) {
                int more;
                i = 1;
                do {
                    unsigned char *pp   = (unsigned char *)SQVs;
                    unsigned int   code = pp[0];
                    *(unsigned char *)(SQVleft + code) = pp[1];
                    SQVs = (int)(pp + 2);
                    *(unsigned char *)(SQVright + code) = pp[2];
                    SQVs = (int)(pp + 3);
                    *(signed char *)(SQVclue + code) = -1;   /* node mark: signed -1 (li -1), not 0xff (li 255) */
                    more = i < (int)nodeCount;
                    i = i + 1;
                } while (more);
            }
        }

        for (;;) {
            unsigned char *p  = (unsigned char *)SQVs;
            unsigned int   ch = *p;
            signed char    clue;
            unsigned int   wb;
            SQVs = (int)(p + 1);
            clue = *(signed char *)(SQVclue + ch);
            if (clue == 0) {                                  /* literal */
                wb = ch;
            } else if (clue > 0) {                             /* escape code -> next byte is an escaped literal */
                unsigned int esc = p[1];
                SQVs = (int)(p + 2);
                if (esc == 0)
                    break;                                     /* end-of-stream -> fall to the single exit */
                wb = esc;
            } else {                                           /* tree node -> expand both children */
                chase((unsigned int)*(unsigned char *)(SQVleft + ch));
                chase((unsigned int)*(unsigned char *)(SQVright + ch));
                continue;
            }
            *(unsigned char *)SQVd = wb;
            SQVd = SQVd + 1;
        }
    }
    return size;
}
