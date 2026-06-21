/* eaclib/psx/sndpsxz/smemman.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\smemman.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x801061A8 .. 0x80106238].  The sound system's main-RAM sub-allocator (the `sndmm` pool the
 *   game hands SNDSYS_init) -- a sorted first-fit free-list of up to 128 {block,size} word entries.
 *   Ghidra nfs4-f.exe.c (smemman) + disasm note: iSNDmalloc's shift loop is a lwl/lwr+swl/swr unaligned
 *   4-byte entry copy (Ghidra mangled the swl/swr into a bit-twiddle + emitted the aligned store -> keep
 *   the plain copy, drop the bit-twiddle), exactly as sdmemman.
 *
 *   Globals: sndmm = pool byte base, DAT_80148784 = live entry count, DAT_80148786 = pool size in WORDS,
 *            DAT_80148788 = high-water mark (words), DAT_8014878c = {block:u16, size:u16}[] entry table.
 */

extern "C" int            sndmm;            /* pool base (byte address) */
extern "C" short          DAT_80148784;     /* live allocation count    */
extern "C" short          DAT_80148786;     /* pool size in words       */
extern "C" int            DAT_80148788;     /* high-water mark (words)   */
extern "C" unsigned short DAT_8014878c;     /* {block,size}[] entry table */
extern "C" void           trap(unsigned int code);

extern "C" int  iSNDmemconstrain(int *block, int *size);   /* @0x801061A8 */
extern "C" int *iSNDmeminit(int membase, int memsize);     /* @0x801061D4 */
extern "C" unsigned int iSNDmemrestore(void);              /* @0x801061F4 */
extern "C" int  iSNDmalloc(int size);                      /* @0x80106238 */

/* iSNDmemconstrain @0x801061A8 : clamp a candidate [block, size] so block+size stays within the pool top. */
extern "C" int iSNDmemconstrain(int *block, int *size)
{
    int avail = (int)(unsigned int)DAT_80148786 - *block;
    if ((int)(unsigned int)DAT_80148786 < *block + *size)
        *size = avail;
    return avail;
}

/* iSNDmeminit @0x801061D4 : (re)initialise the pool over `memsize` bytes at `membase`. */
extern "C" int *iSNDmeminit(int membase, int memsize)
{
    sndmm = membase;
    DAT_80148784 = 0;
    DAT_80148786 = (short)(memsize >> 2);
    DAT_80148788 = 0;
    return &sndmm;
}

/* iSNDmemrestore @0x801061F4 : return pool utilisation percent = high_water*100/poolsize.
 *   The unsigned divide auto-emits the BREAK 0x1c00 div-by-zero guard (oracle 0x80106228),
 *   so the trap only fires when the pool was never initialised (poolsize==0). */
extern "C" unsigned int iSNDmemrestore(void)
{
    return (unsigned int)(DAT_80148788 * 100) / (unsigned int)(unsigned short)DAT_80148786;
}

/* iSNDmalloc @0x80106238 : first-fit allocate `size` bytes (rounded to words) from the sndmm pool,
 *   inserting the new {block,size} entry in sorted order.  Returns the byte address or 0 on failure. */
extern "C" int iSNDmalloc(int size)
{
    int          idx = 0;
    int          need, ret = 0;
    int          local_block;
    unsigned int local_avail;

    if (DAT_80148784 < 0x80) {
        need = size + 3 >> 2;
        if (DAT_80148784 == 0) {                         /* empty pool -> whole thing free */
            local_avail = (unsigned int)DAT_80148786;
            local_block = 0;
            iSNDmemconstrain(&local_block, (int *)&local_avail);
        } else {
            for (;;) {                                   /* scan the gaps between entries */
                if (idx == 0) {
                    local_avail = (unsigned int)(&DAT_8014878c)[0];      /* up to entry[0].block */
                    local_block = 0;
                } else {
                    local_block = (int)(&DAT_8014878c)[(idx - 1) * 2] + (int)(&DAT_8014878c)[(idx - 1) * 2 + 1];
                    local_avail = (unsigned int)(&DAT_8014878c)[idx * 2] - local_block;
                }
                iSNDmemconstrain(&local_block, (int *)&local_avail);
                if ((int)local_avail < need) {
                    idx++;
                    if ((int)(unsigned int)DAT_80148784 <= idx) {        /* past the last entry -> tail gap */
                        local_block = (int)(&DAT_8014878c)[(idx - 1) * 2] + (int)(&DAT_8014878c)[(idx - 1) * 2 + 1];
                        local_avail = (unsigned int)DAT_80148786 - local_block;
                        iSNDmemconstrain(&local_block, (int *)&local_avail);
                        break;
                    }
                    continue;
                }
                {
                    unsigned int u = (unsigned int)DAT_80148784;          /* shift entries up to open slot idx */
                    while (idx < (int)u) {
                        *(unsigned int *)((int)&DAT_8014878c + u * 4) =
                            *(unsigned int *)((int)&DAT_8014878c + (u - 1) * 4);
                        u--;
                    }
                }
                break;
            }
        }
        if (need <= (int)local_avail) {                  /* commit the new entry */
            (&DAT_8014878c)[idx * 2 + 1] = (unsigned short)need;
            (&DAT_8014878c)[idx * 2]     = (unsigned short)local_block;
            DAT_80148784 = DAT_80148784 + 1;
            ret = sndmm + local_block * 4;
            if (DAT_80148788 < local_block + need)
                DAT_80148788 = local_block + need;
        }
    }
    return ret;
}
