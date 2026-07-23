/* eaclib/psx/sndpsxz/sdmemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 0/3 PASS ***
 *   Source obj : nfs4\eaclib\psx\sdmemman.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x8010A550 .. 0x8010A7C8].  SPU local-RAM block allocator -- a sorted free-list of up to 128
 *   {block,size} entries (DAT_80147e38, 4-byte stride) carving the SPU's 512 KB sample area into 64-byte
 *   blocks.  Ghidra nfs4-f.exe.c (sdmemman) + disasm-v3 L<8010A700+> for the unaligned shift loop.
 *
 *   🔴 The shift loop's `entry[dst]=entry[src]` is a lwl/lwr+swl/swr UNALIGNED 4-byte copy (the table sits
 *   on an odd boundary); Ghidra mangled the swl/swr into a bit-twiddle AND emitted a phantom aligned store
 *   -- disasm shows ONE unaligned word copy, so the bit-twiddle is dropped and the plain copy kept.
 */

/* MATCH: engine_ver/block_total/reverb_mode/alloc_count are NOT separate linked globals -- the oracle
 * (iSNDpsxmemconstrain, byte-exact) materializes ONE `sndpd` base (lui/addiu) and reads them all as
 * fixed displacements off it (0x518/0x51A/0x51C/0x51E). Modeled as sndpd+offset macros, same lever as
 * sdma.c. The alloc table lives right after reverb_mode @ sndpd+0x520 (4-byte {block:u16,size:u16}
 * stride); iSNDpsxmalloc's oracle addresses it via its OWN independently-relocated symbol at the
 * array-indexed sites, but that symbol's VA == sndpd+0x520 -- same storage, different materialization.
 *
 * SPLIT-STORAGE FIX (wave-22 a1): this file previously `extern`-declared snd_spu_block_total/
 * snd_spu_reverb_mode/snd_spu_alloc_count/DAT_80147e38 as their OWN standalone globals, owned by
 * sdmemlu.c (with mismatched shapes between the two files' decls -- flagged by scratch/
 * extern_audit_report.txt: DAT_80147e38 as `unsigned short` here vs `int` there, no owner def either
 * place). That is a genuine aliasing/link bug: sdmemlu.c has been converted to the sndpd-relative
 * model (see its banner) and no longer provides that storage, so these externs would now be
 * UNDEFINED REFERENCES. Converted to the same SNDPD_* macro-view convention used by
 * iSNDpsxmemconstrain above, so this file's own reads/writes of the free-list genuinely alias with
 * slib.c's iSNDinit (writer) and sdmemlu.c's SNDmemlargestunused (reader) -- all three now compute
 * addresses off the same `sndpd` base instead of three disconnected storage locations. */
extern unsigned char sndpd[];                 /* voice/queue state base @0x80147918 (shared, sdma.c) */
#define SNDPD_ENGINEVER   (*(unsigned short *)(sndpd + 0x51A))  /* min SPU block (reserved low area) */
#define SNDPD_BLOCKTOTAL  (*(unsigned short *)(sndpd + 0x51C))  /* top of the SPU sample area */
#define SNDPD_REVERBMODE  (*(unsigned short *)(sndpd + 0x51E))  /* reverb-work-area boundary */
#define SNDPD_ALLOCCOUNT  (*(unsigned short *)(sndpd + 0x518))  /* # of live SPU allocations */
/* legacy names kept as macro aliases so the function bodies below need no rewrite beyond dropping
 * their `extern` decls -- lvalue macro-view recipe: NAME, &NAME, and (&NAME)[i] all keep working. */
#define snd_spu_block_total  SNDPD_BLOCKTOTAL
#define snd_spu_reverb_mode  SNDPD_REVERBMODE
#define snd_spu_alloc_count  SNDPD_ALLOCCOUNT
#define DAT_80147e38          (*(int *)(sndpd + 0x520))          /* {block:u16, size:u16}[] alloc table */

extern void iSNDpsxmemconstrain(unsigned int *size, int *avail);  /* @0x8010A550 */
extern int iSNDpsxmalloc(int size);                               /* @0x8010A5CC */

/* iSNDpsxmemconstrain @0x8010A550 : clamp a candidate [block, avail] window to the SPU sample area limits
 *   (floor at engine_ver, ceil at block_total, and at reverb_mode).  Returns the reverb-bounded
 *   available size. */
extern void iSNDpsxmemconstrain(unsigned int *size, int *avail)
{
    unsigned char *pd = sndpd;
    unsigned short lo;
    unsigned int s, diff;
    lo = *(unsigned short *)(pd + 0x51a);
    s = *size;
    diff = (unsigned int)lo - s;
    if ((int)s < (int)lo) {
        *size = lo;
        *avail = *avail - diff;
        s = *size;
    }
    if ((int)(unsigned int)*(unsigned short *)(pd + 0x51c) < (int)(s + *avail))
        *avail = (int)*(unsigned short *)(pd + 0x51c) - s;
    if ((int)(unsigned int)*(unsigned short *)(pd + 0x51e) < (int)(*size + *avail))
        *avail = (int)*(unsigned short *)(pd + 0x51e) - (int)*size;
}

/* iSNDpsxmalloc @0x8010A5CC : allocate `size` bytes (rounded to 64-byte blocks) of SPU local RAM, first-fit
 *   into the gaps of the sorted free-list, inserting the new {block,size} entry in order.  Returns the SPU
 *   byte address (block << 6) or 0 on failure. */
extern int iSNDpsxmalloc(int size)
{
    /* MATCH: the oracle materializes `&sndpd` as its literal 2nd instruction (before even the callee-save
     * spills) and keeps it live in a persistent register (v1, then copied to s1) for the WHOLE function --
     * every alloc_count/engine_ver/block_total/table access below is a small fixed displacement off it.
     * The SNDPD_ and snd_spu_ macros each independently expand to `sndpd + CONST`, which re-materializes
     * its own %hi/%lo(sndpd) symbol at every use site instead of sharing one base register (same class
     * of gap as SNDmemlargestunused/iSNDpsxfxinit) -- write this function's body directly off `pd`. */
    unsigned char *pd = sndpd;
    unsigned int blk, src;
    int          idx = 0;
    int          need;
    unsigned int local_block;
    int          local_avail;
    unsigned short count = *(unsigned short *)(pd + 0x518);

    if (count < 0x80) {
        need = size + 0x3f >> 6;
        if (count == 0) {
            local_block = (unsigned int)*(unsigned short *)(pd + 0x51A);
            local_avail = (int)*(unsigned short *)(pd + 0x51C) - (int)local_block;
        } else {
            do {
                if (idx == 0) {
                    local_block = (unsigned int)*(unsigned short *)(pd + 0x51A);
                    local_avail = *(unsigned short *)(pd + 0x520 + idx * 4) - (int)local_block;
                } else {
                    unsigned short *prev = (unsigned short *)(pd + 0x51C) + idx * 2;   /* virtual entry[idx-1] */
                    local_block = (unsigned int)prev[0] + (unsigned int)prev[1];
                    local_avail = *(unsigned short *)(pd + 0x520 + idx * 4) - (int)local_block;
                }
                iSNDpsxmemconstrain(&local_block, &local_avail);
                if (need <= local_avail) {
                    blk = (unsigned int)*(unsigned short *)(pd + 0x518);
                    if (idx < (int)blk) {
                        do {                                   /* shift entries up to open slot `idx` */
                            src = blk - 1;
                            ((int *)(pd + 0x520))[blk] = ((int *)(pd + 0x520))[src];
                            blk = src;
                        } while (idx < (int)src);
                    }
                    goto commit;
                }
                idx++;
            } while (idx < (int)(unsigned int)*(unsigned short *)(pd + 0x518));
            {
                unsigned short *prev = (unsigned short *)(pd + 0x51C) + idx * 2;
                local_block = (unsigned int)prev[0] + (unsigned int)prev[1];
                local_avail = (int)*(unsigned short *)(pd + 0x51C) - (int)local_block;
            }
        }
        iSNDpsxmemconstrain(&local_block, &local_avail);
        if (need <= local_avail) {
commit:
            *(short *)(pd + 0x520 + idx * 4 + 2) = (short)need;
            *(unsigned short *)(pd + 0x520 + idx * 4) = (unsigned short)local_block;
            *(unsigned short *)(pd + 0x518) = *(unsigned short *)(pd + 0x518) + 1;
            return local_block << 6;
        }
    }
    return 0;
}

/* iSNDpsxfree @0x8010A7C8 : free the SPU block at byte address `ptr` (block == ptr>>6), removing its entry
 *   and compacting the free-list.
 *   BUG FIX (wave-22 a1): the oracle epilogues return 0 (found+compacted) or -8 (not found in the
 *   table) in $v0 -- this was reconstructed `void`, a Ghidra-style dropped-return (methodology §3.2).
 *   All current callers (sdata.c, sdpacket.c, sdresolv.c) discard the result, so this is a pure type
 *   correction (declares the true signature; codegen for a non-void return differs from void even when
 *   the value goes unused) -- not a behavior change for any caller. Their stale `void`/`(void*)`-arg
 *   forward decls elsewhere are harmless under C linkage (no signature-based mangling) and are OUT OF
 *   SCOPE for this file to retarget. */
extern int iSNDpsxfree(int ptr)
{
    /* MATCH: same early &sndpd materialization lever as iSNDpsxmalloc/SNDmemlargestunused/iSNDpsxfxinit. */
    int idx = 0;
    unsigned char *pd = sndpd;
    ptr >>= 6;
    if (*(unsigned short *)(pd + 0x518) != 0) {
        unsigned char *table = pd + 0x520;
        unsigned char *base = pd;
        do {
            if ((unsigned int)*(unsigned short *)(table + idx * 4) == (unsigned int)ptr) {
                unsigned short remaining =
                    *(unsigned short *)(base + 0x518) - 1;
                *(unsigned short *)(base + 0x518) = remaining;
                if (idx < (int)(unsigned int)remaining) {
                  do {
                    struct PackedAllocSlot {
                        unsigned char pad[0x520];
                        int word;
                    } __attribute__((packed));
                    volatile struct PackedAllocSlot *dst =
                        (struct PackedAllocSlot *)(base + idx * 4);
                    int next = idx + 1;
                    dst->word = ((struct PackedAllocSlot *)(base + next * 4))->word;
                    idx = next;
                  } while (idx < (int)(unsigned int)*(volatile unsigned short *)(base + 0x518));
                }
                return 0;
            }
            idx++;
        } while (idx < (int)(unsigned int)*(unsigned short *)(base + 0x518));
    }
    return -8;
}
