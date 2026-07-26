/* eaclib/psx/sndpsxz/sdresolv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sdresolv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x8010B75C .. 0x8010B958].  Resolve/release a bank patch's SPU sample data: DMA the sample
 *   into SPU RAM and record the SPU address (or free it).  Ghidra nfs4-f.exe.c (sdresolv) + IDA sigs.
 *
 *   Tags consumed while scanning a patch's resolve header (until 0xfe): 0x88 = sample offset, 0x82 =
 *   channel count, 0x85 = sample byte size, 0x8a = the field that receives the resolved SPU address.
 *   PATCH RESOLVE TABLE (the `patch`/scratch arg): {ramOffset, spuAddr}[] terminated by -1.
 */

extern int iSNDgettag(int *cursor, unsigned int *outId, int *outVal, int *outPtr);  /* sgettag  */
extern int iSNDpsxmalloc(int size);                                                 /* sdmemman */
extern void iSNDpsxfree(void *p);                                                   /* sdmemman */
extern int iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, int prio); /* sdma */
extern int iSNDdmcomplete(int handle);                                              /* sdma */

extern int iSNDplatformresolve(int cursor, int bank, int patch);     /* @0x8010B75C */
extern int iSNDplatformremove(int cursor, int *patch);               /* @0x8010B958 */

struct SNDResolveEntry {
    int offset;
    int spu;
};

/* iSNDplatformresolve @0x8010B75C : load a patch's sample into SPU RAM (unless already resolved), recording
 *   the SPU address in the 0x8a field and the resolve table.  Returns 7 / -6 (out of SPU memory).
 *
 * RESIDUAL 3 diffs, ours 126 / oracle 127 (w33-a6 re-diagnosis -- was filed only as a "126/127 floor").
 * The single missing instruction is a delay-slot NOP, not a missing computation: at the
 * `cur->offset == offset` test the oracle emits `beq v0,s3,found; nop` and only THEN the walker
 * advance `addiu v1,a0,8`; ours puts the advance INTO the branch slot.  The volatile compare load
 * `lw v0,0(a0)` already blocks reorg's fill_simple_delay_slots backward scan, so ours is coming from
 * the EAGER fill stealing the advance out of the FALL-THROUGH thread (legal because `scan` is dead on
 * the taken path).  Retail's reorg did not take it.  The obvious source counter -- moving `scan++`
 * below the compare (`cur = scan; if (...) goto found; scan++;`) -- does produce the nop but changes
 * which register carries `cur` (`addu a0,v1,zero` moves) and nets WORSE: 7 diffs (and 9 with idx++
 * ordered first).  The 3rd diff (`lw v0,4(a0)` vs the oracle's `lw v0,4(v1)` at `found:`) is the same
 * a0/v1 pairing.  Same reorg-steal family as sdpacket's iSNDfillspuwithpackets clusters (which WAS
 * cracked, by a volatile that blocks the SIMPLE fill) -- here the simple fill is already blocked and
 * there is no source-side handle on the EAGER fill.  Permuter/allocno territory. */
extern int iSNDplatformresolve(int cursor, int bank, int patch)
{
    unsigned int  id;
    int           val, ptr;
    int           size = 0;
    int           count = 1;
    int           offset = size;
    int          *spuField = (int *)size; /* the 0x8a field that receives the SPU address */
    int           idx = size;
    int           blocks, scale, buf, dma;
    int          *e;
    struct SNDResolveEntry *scan;
    struct SNDResolveEntry *cur;
    int           end;

    while (iSNDgettag(&cursor, &id, &val, &ptr) != 0 && id != 0xfe) {
        if (id == 0x80)      { /* no-op tag */ }
        else if (id == 0x88) offset   = val;
        else if (id == 0x8a) spuField = (int *)ptr;
        else if (id == 0x82) count    = val;
        else if (id == 0x85) size     = val;
    }
    if (bank != 0) {
        e = (int *)(idx * 8 + patch);               /* find an existing resolve for this offset */
        if (*(volatile int *)e != -1) {
            end = -1;
            scan = (struct SNDResolveEntry *)e;
            do {
                cur = scan++;
                if (*(volatile int *)&cur->offset == offset)
                    goto found;
                idx++;
            } while (*(volatile int *)&cur[1].offset != end);
        }
checked:
        if (*spuField != 0)
            return 7;                              /* already resolved */
        blocks = size / 0x1c;
        if (size != blocks * 0x1c)
            blocks = blocks + 1;
        scale = count << 4;
        blocks = blocks * scale;
        buf = iSNDpsxmalloc(blocks);
        if (buf == 0)
            return -6;
        goto resolve;
found:
        *spuField = cur->spu;
        goto checked;
resolve:
        dma = iSNDdmqueuesplit(bank + offset, (unsigned int)buf, blocks, 1);
        *spuField = buf;
        *(int *)(idx * 8 + patch) = offset;
        *(int *)(idx * 8 + patch + 4) = buf;
        do { } while (iSNDdmcomplete(dma) == 0);
    }
    return 7;
}

/* iSNDplatformremove @0x8010B958 : release a patch's resolved SPU data -- record it in the remove table and
 *   free the SPU block. */
extern int iSNDplatformremove(int cursor, int *patch)
{
    unsigned int  id;
    int           val, ptr;
    int          *spuField = 0;
    int           i;

    while (iSNDgettag(&cursor, &id, &val, &ptr) != 0 && id != 0xfe) {
        if (id == 0x8a)
            spuField = (int *)ptr;
    }
    i = 0;
    if (*patch != -1) {
        do {
            if (patch[i * 2] == *spuField)    /* already removed */
                return 0;
            i++;
        } while (patch[i * 2] != -1);
    }
    patch[i * 2] = *spuField;
    if (*spuField != 0)
        iSNDpsxfree((void *)*spuField);
    return 0;
}
