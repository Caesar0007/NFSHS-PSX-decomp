/* eaclib/psx/sndpsxz/smemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/4 PASS ***
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

typedef struct SNDMemState {
    int            base;                /* +0x00 pool byte address */
    short          count;               /* +0x04 live allocation count */
    short          poolWords;           /* +0x06 pool size in words */
    int            highWater;           /* +0x08 high-water mark */
    unsigned short entries[256];        /* +0x0c {block,size}[128] */
} SNDMemState;
extern SNDMemState sndmm;
#define DAT_80148784 (sndmm.count)
#define DAT_80148786 (sndmm.poolWords)
#define DAT_80148788 (sndmm.highWater)
#define DAT_8014878c (sndmm.entries[0])
extern void           trap(unsigned int code);

extern void iSNDmemconstrain(int *block, int *size);   /* @0x801061A8 */
extern int *iSNDmeminit(int membase, int memsize);     /* @0x801061D4 */
extern unsigned int iSNDmemrestore(void);              /* @0x801061F4 */
extern int  iSNDmalloc(int size);                      /* @0x80106238 */

/* iSNDmemconstrain @0x801061A8 : clamp a candidate [block, size] so block+size stays within the pool top.
 *   Its true contract is void; the subtraction left in v0 on the clamp path is incidental. */
extern void iSNDmemconstrain(int *block, int *size)
{
    unsigned int top = (unsigned short)DAT_80148786;
    int start = *block;
    if ((int)top < start + *size)
        *size = (int)top - start;
}

/* iSNDmeminit @0x801061D4 : (re)initialise the pool over `memsize` bytes at `membase`. */
extern int *iSNDmeminit(int membase, int memsize)
{
    char *mm;
    sndmm.base = membase;
    mm = (char *)&sndmm;
    *(short *)(mm + 4) = 0;
    *(short *)(mm + 6) = (short)(memsize >> 2);
    *(int *)(mm + 8) = 0;
    return (int *)mm;
}

/* iSNDmemrestore @0x801061F4 : return pool utilisation percent = high_water*100/poolsize.
 *   The unsigned divide auto-emits the BREAK 0x1c00 div-by-zero guard (oracle 0x80106228),
 *   so the trap only fires when the pool was never initialised (poolsize==0). */
extern unsigned int iSNDmemrestore(void)
{
    /* high-water (+8) and poolsize (+6) are fields of the sndmm struct @0x80148780; read both off the
     * single `&sndmm` base (lui;addiu materialized once, CSE'd) to match the oracle's `lw 8(a0)/lhu 6(a0)`
     * rather than two separate absolute DAT_ loads. */
    char          *mm = (char *)&sndmm;
    int            hw = *(int *)(mm + 8);
    unsigned short ps = *(unsigned short *)(mm + 6);
    return (unsigned int)(hw * 100) / (unsigned int)ps;
}

/* iSNDmalloc @0x80106238 : first-fit allocate `size` bytes (rounded to words) from the sndmm pool,
 *   inserting the new {block,size} entry in sorted order.  Returns the byte address or 0 on failure.
 * RAW/ORACLE (2026-07-26, 134->106 detailed diffs): keep the table scan indexed from distinct
 * `sndmm+0xc` entry and `sndmm+8` previous-entry bases, and express the packed shift as memcpy.
 * This restores the oracle's saved-register family and direct lwl/lwr/swl/swr copy sequence. */
extern int iSNDmalloc(int size)
{
    unsigned char *base = (unsigned char *)&sndmm;
    unsigned char *mm;
    unsigned int   count;
    unsigned int   src;
    int            index = 0;
    int            block;
    int            available;

    count = *(unsigned short *)(base + 4);
    if (count >= 0x80)
        goto fail;
    size += 3;
    size >>= 2;
    if (count != 0)
        goto nonempty;
    block = 0;
    available = *(unsigned short *)(base + 6);
constrain:
    iSNDmemconstrain(&block, &available);
    if (size <= available)
        goto commit;
fail:
    return 0;

nonempty:
    {
        unsigned char *entries;
        unsigned char *previous;
        mm = base;
        entries = mm + 0xc;
        previous = mm + 8;
        if (index >= (int)(unsigned int)*(unsigned short *)(mm + 4))
            goto scan_done;
scan:
        {
            unsigned char *entry =
                (unsigned char *)((unsigned int)(index * 4) +
                                  (unsigned int)entries);
            if (index == 0) {
                block = 0;
                available = *(unsigned short *)entry;
            } else {
                unsigned short *prev =
                    (unsigned short *)(previous + index * 4);
                block = (int)prev[0] + (int)prev[1];
                available = *(unsigned short *)entry - block;
            }
            iSNDmemconstrain(&block, &available);
            if (size <= available) {
                count = *(unsigned short *)(mm + 4);
                if (index < (int)count) {
                    do {
                        struct PackedMemSlot {
                            unsigned char pad[0xc];
                            int word;
                        } __attribute__((packed));
                        volatile struct PackedMemSlot *dst =
                            (struct PackedMemSlot *)
                                ((unsigned int)(count * 4) + (unsigned int)mm);
                        src = count - 1;
                        __builtin_memcpy(
                            (void *)&dst->word,
                            (void *)&((struct PackedMemSlot *)
                                          ((unsigned int)(src * 4) +
                                           (unsigned int)mm))->word,
                            4);
                        count = src;
                    } while (index < (int)src);
                }
                goto commit;
            }
        }
        index++;
        if (index < (int)(unsigned int)*(unsigned short *)(mm + 4))
            goto scan;
scan_done:
        {
            unsigned short *prev =
                (unsigned short *)(previous + index * 4);
            block = (int)prev[0] + (int)prev[1];
            available = *(unsigned short *)(mm + 6) - block;
        }
    }
    goto constrain;

commit:
    {
        unsigned char *entries = (unsigned char *)&sndmm + 0xc;
        unsigned short *entry =
            (unsigned short *)(entries + index * 4);
        unsigned char *commitBase = entries - 0xc;
        int result;
        entry[1] = (unsigned short)size;
        entry[0] = (unsigned short)block;
        *(unsigned short *)(commitBase + 4) =
            *(unsigned short *)(commitBase + 4) + 1;
        result = *(int *)commitBase + block * 4;
        if (*(int *)(commitBase + 8) < block + size)
            *(int *)(commitBase + 8) = block + size;
        return result;
    }
}
