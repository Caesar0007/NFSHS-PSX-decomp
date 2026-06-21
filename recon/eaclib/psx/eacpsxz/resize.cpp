/* eaclib/psx/eacpsxz/resize.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\resize.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   1 fn @0x800F1950 (0x178 bytes): resizememadr -- grow/shrink an EA heap block IN PLACE.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  Part of the EA memstd allocator (see memstd.cpp
 *   for the MemBlock/MemClass model: 16-byte header, user ptr = header+0x10; gMemClassTable[flags&0xF]).
 *
 *   Steps (faithful to the asm):
 *     1. If the next physical block is on the free list (flags&0x4000), FREE_remove it and absorb it
 *        (coalesce forward) so this block's physical span can grow.
 *     2. Clamp the requested size: <8 -> 8 ; ==-1 -> 0x40000000 (grow to max) ; <0 (not -1) -> as-is.
 *     3. Compute the aligned physical payload needed = ((size+tailsize+align+15) & -align) - 0x10,
 *        where tailsize = MEM_tailsize(getblockname(p), flags) (info + name bytes the block carries),
 *        align = class->alignment (class+0x28).  Clamp to the available span (next-header-0x10).
 *     4. Relocate the tail (info/name) via blockmove from p+header[+4] to p+usable.
 *     5. If the leftover slack >= 65 bytes, carve it into a new free block (initmemblock + FREE_add)
 *        and relink the physical ring; otherwise leave the whole span in the block.
 *   Returns the (unchanged) user pointer.
 *
 *   Header byte layout (== memstd): +0 magic(u16) +2 flags(u16, low nibble=class id, 0x4000=on-freelist)
 *                                   +4 usable-size/tail-offset(int) +8 physnext +C physprev.
 */
struct MemBlock;
struct MemClass;

extern "C" MemClass *gMemClassTable[16];                       /* @0x8013E900 */
extern "C" void  FREE_add   (MemClass *cls, MemBlock *node);   /* @0x800E4E70 */
extern "C" void  FREE_remove(MemClass *cls, MemBlock *node);   /* @0x800E4F04 */
extern "C" int   initmemblock(MemBlock *blk, char *name, int size, int tailextra,
                              int flags, MemBlock *physprev, MemBlock *physnext);  /* @0x800E4F2C */
extern "C" int   MEM_tailsize(char *name, int id);             /* @0x800E5030 */
extern "C" char *getblockname(void *p);                        /* @0x800E52E0 */
extern "C" void  blockmove(void *src, void *dst, int n);       /* @0x800E62DC */

extern "C" void *resizememadr(void *userptr, int newsize)      /* @0x800F1950 */
{
    char *hdr = (char *)userptr - 0x10;                         /* s3 = block header */
    unsigned short flags = *(unsigned short *)(hdr + 2);        /* s1 */
    char *next = *(char **)(hdr + 8);                           /* s2 = hdr->physnext */
    MemClass *cls = gMemClassTable[flags & 0xF];                /* s5 */

    /* 1. coalesce forward if the next physical block is free */
    if (*(unsigned short *)(next + 2) & 0x4000) {
        FREE_remove(cls, (MemBlock *)next);
        next = *(char **)(next + 8);                            /* next = next->physnext */
        *(char **)(hdr + 8) = next;                             /* hdr->physnext = next */
    }

    /* 2. clamp requested size (s4 keeps the raw value used as the new tail offset) */
    int usable = newsize;                                       /* s4 */
    int sz     = newsize;                                       /* s0 */
    if (sz < 8) {
        if (sz == -1)      sz = 0x40000000;                     /* grow to max */
        else if (sz >= 0)  sz = 8;                              /* 0..7 -> 8 (negatives kept) */
    }

    /* 3. aligned physical payload needed, clamped to available span */
    char *name  = getblockname(userptr);
    int   tail  = MEM_tailsize(name, flags);
    int   align = *(int *)((char *)cls + 0x28);                 /* class->alignment */
    int   needed = (int)(((unsigned)(sz + tail + align + 15)) & (unsigned)(-align)) - 0x10;
    int   avail  = (int)(next - hdr) - 0x10;
    if (avail < needed) {
        needed = avail;                                        /* can't grow past the span */
        usable = avail - tail;                                 /* s4 = avail - tailsize */
    }

    /* 4. relocate the tail (info/name) to sit right after the new usable region */
    blockmove((char *)userptr + *(int *)(hdr + 4),    /* src = p + old tail offset (hdr[+4]) */
              (char *)userptr + usable,               /* dst = p + new usable size           */
              tail);

    /* 5. split off the leftover as a new free block if it's worth it (>= 65 bytes) */
    if ((avail - needed) >= 0x41) {
        MemBlock *split;
        *(int *)(hdr + 4) = usable;                            /* hdr usable size = new tail offset */
        split = (MemBlock *)((char *)userptr + needed + 0x10);
        initmemblock(split, 0, 0, 0, 0, (MemBlock *)hdr, (MemBlock *)next);
        FREE_add(cls, split);
        *(char **)(next + 0xC) = (char *)split;               /* next->physprev = split */
        *(char **)(hdr  + 8)   = (char *)split;               /* hdr->physnext  = split */
    }
    return userptr;
}
