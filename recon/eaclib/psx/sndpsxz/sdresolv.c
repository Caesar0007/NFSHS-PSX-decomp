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
 *   the SPU address in the 0x8a field and the resolve table.  Returns 7 / -6 (out of SPU memory). */
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
