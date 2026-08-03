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
    int size;
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
     * MATCH (w33-a4: 14 -> 2).  The w32 verdict "cse's make_regs_eqv cannot be steered from
     * the source" had the mechanism right and the conclusion wrong.  make_regs_eqv makes the
     * COPY (`new`) canonical iff `new` lives past the cse basic block AND its last use is LATER
     * than the source reg's last use.  Retail's clamped variable does outlive the raw one --
     * because it IS the same variable as `needed` and as the split offset (IDA: v9/v12/v14 all
     * $s0).  So: keep the raw request in `usable` ($s4, copied straight from $a1 -- the param is
     * then single-use and never needs a home copy), and give the clamp its own local `size`
     * that is then REUSED for the aligned-payload result and for the split offset.  With that
     * one variable spanning to the end of the function the three clamp compares canonicalise
     * onto $s0 exactly like retail (`addu s0,s4,zero` before `slti v0,s0,8`).
     * RESIDUAL 2 (count-exact 94/94): a single sched1 tie right after the MEM_tailsize call --
     * retail emits `addu a2,v0,zero` (tail) then `lw v1,0x28(s5)` (align), ours the reverse.
     * Heights: the copy is 1+height(`addu v0,s0,a2`)=6, the load is loadcost+height(`addiu
     * a0,v1,15`)=7, so the load wins on priority (and would also win the class tie-break: it is
     * independent of the call, the copy is data-dependent on it).  Tried, all >=2: embedding the
     * load in the alignpad statement, splitting `size += tail` (6), dropping the `tail` local
     * (29 and 93/94).  Raising it needs `tail` to gain an in-block use, which retail does not
     * have either -- a genuine one-instruction scheduler tie.
     * ==== w47-a5: PASS 94/94.  The w34-a3 STRONG-floor verdict below is REFUTED. ====
     * Its reasoning is entirely correct as far as it goes -- both candidates feed the same join
     * insn, so no reassociation can make the register copy out-prioritise the load.  The error
     * is the implicit premise that the only way to win a ready-list tie is to WIN it.  A
     * zero-insn USE FENCE on `tail` right after the MEM_tailsize call is a scheduling BARRIER:
     * the copy cannot sink past it and the align load cannot float above it, so priority never
     * gets a vote.  Cost: 0 instructions (`tail` is already register-resident).  This is the
     * w45 fence FIXPOINT law; the same one-line lever also cleared cdfs CD_Read and stream
     * restartstream this wave -- every 'sched1/sched2 ready-list tie' floor in this cluster
     * should be re-tested with it before being quoted again.
     * ---- superseded w34-a3 verdict ----
     * w34-a3 RE-VERDICT: STRONG floor (>=3 further alternate forms, all worse, none flipping the
     * tie).  The barrier is structural, not a spelling: both candidates feed the SAME join insn
     * (`addu v0,size,tail` / `addiu a0,align,15` -> `addu v0,v0,a0`), so any reassociation that
     * deepens `tail`'s chain deepens `align`'s by the same amount, and the load keeps its
     * load-cost lead over a register copy.  Measured: `(tail + alignpad) + size` 8 diffs,
     * split `size = size + tail;` then the mask 6, a separate `int negalign = -align;` 4 --
     * all at an unchanged 94/94.  Flipping it needs the load's chain to be SHORTER than the
     * copy's, which is impossible while `alignpad` is derived from that load. */

    /* 1. coalesce forward if the next physical block is free */
    if (*(unsigned short *)(next + 2) & 0x4000) {
        FREE_remove(cls, (MemBlock *)next);
        next = *(char **)(next + 8);                            /* next = next->physnext */
        *(char **)(hdr + 8) = next;                             /* hdr->physnext = next */
    }

    /* 2. clamp the requested size IN THE PARAMETER (usable keeps the raw value used as
     * the new tail offset) */
    size = usable;
    if (size < 8) {
        if (size == -1)      size = 0x40000000;                 /* grow to max */
        else if (size >= 0)  size = 8;                          /* 0..7 -> 8 (negatives kept) */
    }

    /* 3. aligned physical payload needed, clamped to available span */
    name = getblockname(userptr);
    tail = MEM_tailsize(name, flags);
    __asm__("" : : "r"(tail));   /* w47-a5 sched fixpoint: pin the return copy above the align load */
    align = *(int *)((char *)cls + 0x28);
    alignpad = align + 15;                            /* MATCH: its own statement -- inside one
                                                       * expression gcc reassociates the +15 onto
                                                       * (sz+tail) (`addiu v0,v0,15`); the oracle
                                                       * adds it to align (`addiu a0,v1,15`) and
                                                       * keeps align itself live for `negu v1,v1` */
    size = (int)(((unsigned)(size + tail) + (unsigned)alignpad) & (unsigned)(-align)) - 0x10;
    avail = (int)(next - hdr) - 0x10;
    if (avail < size) {
        size = avail;                                          /* can't grow past the span */
        usable = avail - tail;                                 /* s4 = avail - tailsize */
    }

    /* 4. relocate the tail (info/name) to sit right after the new usable region */
    blockmove((char *)userptr + *(int *)(hdr + 4),    /* src = p + old tail offset (hdr[+4]) */
              (char *)userptr + usable,               /* dst = p + new usable size           */
              tail);
    *(int *)(hdr + 4) = usable;                       /* new tail offset, split or not */

    /* 5. split off the leftover as a new free block if it's worth it (>= 65 bytes) */
    if ((avail - size) >= 0x41) {
        MemBlock *split;
        size += 0x10;                                 /* MATCH: advanced IN PLACE (oracle
                                                       * `addiu s0,s0,0x10; addu s0,s6,s0` --
                                                       * `userptr + needed + 0x10` in one
                                                       * expression associates the other way) */
        split = (MemBlock *)((char *)userptr + size);
        initmemblock(split, 0, 0, 0, 0, (MemBlock *)hdr, (MemBlock *)next);
        FREE_add(cls, split);
        *(char **)(next + 0xC) = (char *)split;               /* next->physprev = split */
        *(char **)(hdr  + 8)   = (char *)split;               /* hdr->physnext  = split */
    }
    return userptr;
}
