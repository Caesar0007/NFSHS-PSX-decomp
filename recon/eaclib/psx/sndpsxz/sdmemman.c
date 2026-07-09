/* eaclib/psx/sndpsxz/sdmemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\sdmemman.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x8010A550 .. 0x8010A7C8].  SPU local-RAM block allocator -- a sorted free-list of up to 128
 *   {block,size} entries (DAT_80147e38, 4-byte stride) carving the SPU's 512 KB sample area into 64-byte
 *   blocks.  Ghidra nfs4-f.exe.c (sdmemman) + disasm-v3 L<8010A700+> for the unaligned shift loop.
 *
 *   🔴 The shift loop's `entry[dst]=entry[src]` is a lwl/lwr+swl/swr UNALIGNED 4-byte copy (the table sits
 *   on an odd boundary); Ghidra mangled the swl/swr into a bit-twiddle AND emitted a phantom aligned store
 *   -- disasm shows ONE unaligned word copy, so the bit-twiddle is dropped and the plain copy kept.
 */

extern unsigned short snd_spu_engine_ver;     /* min SPU block (reserved low area) */
unsigned short snd_spu_engine_ver;  /* def (owning TU; BSS) */
extern unsigned short snd_spu_block_total;    /* top of the SPU sample area        */
extern unsigned short snd_spu_reverb_mode;    /* reverb-work-area boundary         */
extern unsigned short snd_spu_alloc_count;    /* live allocation count (<= 128)    */
extern int            DAT_80147e38;           /* {block:u16, size:u16}[] alloc table */

extern int iSNDpsxmemconstrain(unsigned int *size, int *avail);   /* @0x8010A550 */
extern int iSNDpsxmalloc(int size);                               /* @0x8010A5CC */

/* iSNDpsxmemconstrain @0x8010A550 : clamp a candidate [block, avail] window to the SPU sample area limits
 *   (floor at snd_spu_engine_ver, ceil at snd_spu_block_total, and at snd_spu_reverb_mode).  Returns the
 *   reverb-bounded available size. */
extern int iSNDpsxmemconstrain(unsigned int *size, int *avail)
{
    int          r;
    unsigned int lo = (unsigned int)snd_spu_engine_ver;
    unsigned int s  = *size;
    if ((int)s < (int)lo) {
        *size = lo;
        *avail = *avail - (lo - s);
        s = *size;
    }
    if ((int)(unsigned int)snd_spu_block_total < (int)(s + *avail))
        *avail = (int)snd_spu_block_total - s;
    r = (int)(unsigned int)snd_spu_reverb_mode - (int)*size;
    if ((int)(unsigned int)snd_spu_reverb_mode < (int)(*size + *avail))
        *avail = r;
    return r;
}

/* iSNDpsxmalloc @0x8010A5CC : allocate `size` bytes (rounded to 64-byte blocks) of SPU local RAM, first-fit
 *   into the gaps of the sorted free-list, inserting the new {block,size} entry in order.  Returns the SPU
 *   byte address (block << 6) or 0 on failure. */
extern int iSNDpsxmalloc(int size)
{
    unsigned int blk, src;
    int          idx = 0;
    int          need;
    unsigned int local_block;
    int          local_avail;

    if (snd_spu_alloc_count < 0x80) {
        need = size + 0x3f >> 6;
        if (snd_spu_alloc_count == 0) {
            local_block = (unsigned int)snd_spu_engine_ver;
            local_avail = (int)snd_spu_block_total - (int)local_block;
        } else {
            int e = 0;
            do {
                if (idx == 0) {
                    local_block = (unsigned int)snd_spu_engine_ver;
                    local_avail = *(unsigned short *)((int)&DAT_80147e38 + e) - (int)local_block;
                } else {
                    local_block = (unsigned int)*(unsigned short *)((int)&snd_spu_block_total + e) +
                                  (unsigned int)*(unsigned short *)((int)&snd_spu_reverb_mode + e);
                    local_avail = *(unsigned short *)((int)&DAT_80147e38 + e) - (int)local_block;
                }
                iSNDpsxmemconstrain(&local_block, &local_avail);
                if (need <= local_avail) {
                    blk = (unsigned int)snd_spu_alloc_count;
                    if (idx < (int)blk) {
                        do {                                   /* shift entries up to open slot `idx` */
                            src = blk - 1;
                            (&DAT_80147e38)[blk] = (&DAT_80147e38)[src];
                            blk = src;
                        } while (idx < (int)src);
                    }
                    goto commit;
                }
                idx++;
                e = idx * 4;
            } while (idx < (int)(unsigned int)snd_spu_alloc_count);
            local_block = (unsigned int)(&snd_spu_block_total)[idx * 2] +
                          (unsigned int)(&snd_spu_reverb_mode)[idx * 2];
            local_avail = (int)snd_spu_block_total - (int)local_block;
        }
        iSNDpsxmemconstrain(&local_block, &local_avail);
        if (need <= local_avail) {
commit:
            *(short *)((int)&DAT_80147e38 + idx * 4 + 2) = (short)need;
            *(unsigned short *)((int)&DAT_80147e38 + idx * 4) = (unsigned short)local_block;
            snd_spu_alloc_count = snd_spu_alloc_count + 1;
            return local_block << 6;
        }
    }
    return 0;
}

/* iSNDpsxfree @0x8010A7C8 : free the SPU block at byte address `ptr` (block == ptr>>6), removing its entry
 *   and compacting the free-list. */
extern void iSNDpsxfree(int ptr)
{
    int idx = 0;
    int e = 0;
    int src;
    if (snd_spu_alloc_count != 0) {
        do {
            if ((unsigned int)*(unsigned short *)((int)&DAT_80147e38 + e) == (unsigned int)(ptr >> 6)) {
                snd_spu_alloc_count = snd_spu_alloc_count - 1;
                while (idx < (int)(unsigned int)snd_spu_alloc_count) {   /* compact entries down */
                    src = idx + 1;
                    (&DAT_80147e38)[idx] = (&DAT_80147e38)[src];
                    idx = src;
                }
                return;
            }
            idx++;
            e = idx * 4;
        } while (idx < (int)(unsigned int)snd_spu_alloc_count);
    }
}
