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
 *        The header's usable-size/tail offset is updated even when no split is needed.
 *     5. If the leftover slack >= 65 bytes, carve it into a new free block (initmemblock + FREE_add)
 *        and relink the physical ring; otherwise leave the whole span in the block.
 *   Returns the (unchanged) user pointer.
 *
 *   Header byte layout (== memstd): +0 magic(u16) +2 flags(u16, low nibble=class id, 0x4000=on-freelist)
 *                                   +4 usable-size/tail-offset(int) +8 physnext +C physprev.
 */
struct MemBlock;
typedef struct MemBlock MemBlock;
struct MemClass;
typedef struct MemClass MemClass;

extern MemClass *gMemClassTable[16];                       /* @0x8013E900 */
extern void  FREE_add   (MemClass *cls, MemBlock *node);   /* @0x800E4E70 */
extern void  FREE_remove(MemClass *cls, MemBlock *node);   /* @0x800E4F04 */
extern int   initmemblock(MemBlock *blk, char *name, int size, int tailextra,
                              int flags, MemBlock *physprev, MemBlock *physnext);  /* @0x800E4F2C */
extern int   MEM_tailsize(char *name, int id);             /* @0x800E5030 */
extern char *getblockname(void *p);                        /* @0x800E52E0 */
extern void  blockmove(void *src, void *dst, int n);       /* @0x800E62DC */

extern void *resizememadr(void *userptr, int newsize)      /* @0x800F1950 */
{
    int avail;
    int needed;
    int align;
    int alignpad;
    char * name;
    int tail;
    char *hdr = (char *)userptr - 0x10;                         /* s3 = block header */
    unsigned flags = *(unsigned short *)(hdr + 2);              /* s1 (u_int: avoid a redundant andi 0xffff) */
    char *next = *(char **)(hdr + 8);                           /* s2 = hdr->physnext */
    MemClass *cls = gMemClassTable[flags & 0xF];                /* s5 */
    int usable = newsize;                                       /* s4: the RAW requested size */
    /* MATCH (52 -> 14 diffs, w32-a4). The long-documented "3-way s2/s3/s4 rotation floor"
     * was NOT an allocator tie-break: cc1 -dl/-dg showed it was driven purely by the
     * REF COUNT of the raw-size variable. IDA's register table for sub_800F1950 is the
     * ground truth: v3=$s3 hdr, v5=$s2 next, v7=$s5 cls, the raw/usable size=$s4, and
     * v9/v12/v14=$s0 (clamped size -> needed -> split ptr) with v4/v13=$s1 (flags reused
     * for avail). Writing the clamp on a variable that cse canonicalises back onto the
     * RAW-size variable gives that variable 8 refs (5 + the 3 comparison uses) ->
     * priority 3*8/50 = 0.48, which beats next (3*9/67) and hdr (3*9/69) in the allocno
     * order and rotates all three registers. Clamping the PARAMETER in place and keeping
     * the raw value in its own local splits the refs the way retail's allocno table shows
     * (raw size 5 refs -> allocated after next/hdr -> lands in $s4).
     * RESIDUAL 14 (count-exact 94/94), all in the first 20 insns: cc1 canonicalises the
     * three clamp comparisons onto the raw-size register ($s4) where the oracle tests the
     * clamped one ($s0), and clamping the param costs one extra prologue home-copy
     * (`addu s0,a1,zero`) the oracle does not need. The dual is exactly as bad (see the
     * git log: raw-in-parameter = correct copy shape but 48 diffs from the rotation);
     * gcc-2.8 cse's make_regs_eqv cannot be steered here from the source -- the copy's
     * `new` reg is defined inside the cse block and the raw variable outlives it, so the
     * clamped variable never becomes canonical. */

    /* 1. coalesce forward if the next physical block is free */
    if (*(unsigned short *)(next + 2) & 0x4000) {
        FREE_remove(cls, (MemBlock *)next);
        next = *(char **)(next + 8);                            /* next = next->physnext */
        *(char **)(hdr + 8) = next;                             /* hdr->physnext = next */
    }

    /* 2. clamp the requested size IN THE PARAMETER (usable keeps the raw value used as
     * the new tail offset) */
    if (newsize < 8) {
        if (newsize == -1)      newsize = 0x40000000;           /* grow to max */
        else if (newsize >= 0)  newsize = 8;                    /* 0..7 -> 8 (negatives kept) */
    }

    /* 3. aligned physical payload needed, clamped to available span */
    name = getblockname(userptr);
    tail = MEM_tailsize(name, flags);
    align = *(int *)((char *)cls + 0x28);
    alignpad = align + 15;                            /* MATCH: its own statement -- inside one
                                                       * expression gcc reassociates the +15 onto
                                                       * (sz+tail) (`addiu v0,v0,15`); the oracle
                                                       * adds it to align (`addiu a0,v1,15`) and
                                                       * keeps align itself live for `negu v1,v1` */
    needed = (int)(((unsigned)(newsize + tail) + (unsigned)alignpad) & (unsigned)(-align)) - 0x10;
    avail = (int)(next - hdr) - 0x10;
    if (avail < needed) {
        needed = avail;                                        /* can't grow past the span */
        usable = avail - tail;                                 /* s4 = avail - tailsize */
    }

    /* 4. relocate the tail (info/name) to sit right after the new usable region */
    blockmove((char *)userptr + *(int *)(hdr + 4),    /* src = p + old tail offset (hdr[+4]) */
              (char *)userptr + usable,               /* dst = p + new usable size           */
              tail);
    *(int *)(hdr + 4) = usable;                       /* new tail offset, split or not */

    /* 5. split off the leftover as a new free block if it's worth it (>= 65 bytes) */
    if ((avail - needed) >= 0x41) {
        MemBlock *split;
        needed += 0x10;                               /* MATCH: advanced IN PLACE (oracle
                                                       * `addiu s0,s0,0x10; addu s0,s6,s0` --
                                                       * `userptr + needed + 0x10` in one
                                                       * expression associates the other way) */
        split = (MemBlock *)((char *)userptr + needed);
        initmemblock(split, 0, 0, 0, 0, (MemBlock *)hdr, (MemBlock *)next);
        FREE_add(cls, split);
        *(char **)(next + 0xC) = (char *)split;               /* next->physprev = split */
        *(char **)(hdr  + 8)   = (char *)split;               /* hdr->physnext  = split */
    }
    return userptr;
}
