/* eaclib/psx/sndpsxz/smemman.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
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
 *   inserting the new {block,size} entry in sorted order.  Returns the byte address or 0 on failure. */
extern int iSNDmalloc(int size)
{
    typedef struct SNDMemEntry {
        unsigned short block;
        unsigned short size;
    } SNDMemEntry;
    int words = size;
    SNDMemState *mm = &sndmm;
    int index = 0;
    int block;
    int available;
    SNDMemEntry *entries;
    int result;

    if ((unsigned short)mm->count >= 0x80)
        return 0;
    words = (words + 3) >> 2;
    if ((unsigned short)mm->count == 0) {
        block = 0;
        available = (unsigned short)mm->poolWords;
        iSNDmemconstrain(&block, &available);
        if (available < words)
            return 0;
        goto commit;
    }

    entries = (SNDMemEntry *)((char *)mm + 0xc);
    while (index < (unsigned short)mm->count) {
        if (index == 0) {
            block = 0;
            available = entries[index].block;
        } else {
            block = entries[index - 1].block + entries[index - 1].size;
            available = entries[index].block - block;
        }
        iSNDmemconstrain(&block, &available);
        if (available >= words) {
            int count = (unsigned short)mm->count;
            while (index < count) {
                entries[count] = entries[count - 1];
                count--;
            }
            goto commit;
        }
        index++;
    }

    block = entries[index - 1].block + entries[index - 1].size;
    available = (unsigned short)mm->poolWords - block;
    iSNDmemconstrain(&block, &available);
    if (available < words)
        return 0;

commit:
    entries = (SNDMemEntry *)((char *)mm + 0xc);
    entries[index].size = (unsigned short)words;
    entries[index].block = (unsigned short)block;
    mm->count = mm->count + 1;
    result = mm->base + block * 4;
    if (mm->highWater < block + words)
        mm->highWater = block + words;
    return result;
}
