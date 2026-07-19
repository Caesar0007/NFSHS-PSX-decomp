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
extern int iSNDdmqueuesplit(int dst_spu, unsigned int src_ram, int len, unsigned char prio); /* sdma */
extern int iSNDdmcomplete(int handle);                                              /* sdma */

extern int iSNDplatformresolve(int cursor, int bank, int patch);     /* @0x8010B75C */
extern int iSNDplatformremove(int cursor, int *patch);               /* @0x8010B958 */

/* iSNDplatformresolve @0x8010B75C : load a patch's sample into SPU RAM (unless already resolved), recording
 *   the SPU address in the 0x8a field and the resolve table.  Returns 7 / -6 (out of SPU memory). */
extern int iSNDplatformresolve(int cursor, int bank, int patch)
{
    unsigned int  id;
    int           val, ptr;
    int           offset = 0, count = 1, size = 0;
    int          *spuField = 0;       /* the 0x8a field that receives the SPU address */
    int           idx = 0, blocks, need, buf, dma;
    int          *e;

    while (iSNDgettag(&cursor, &id, &val, &ptr) != 0 && id != 0xfe) {
        if (id == 0x80)      { /* no-op tag */ }
        else if (id == 0x88) offset   = val;
        else if (id == 0x8a) spuField = (int *)ptr;
        else if (id == 0x82) count    = val;
        else if (id == 0x85) size     = val;
    }
    if (bank != 0) {
        e = (int *)(idx * 8 + patch);               /* find an existing resolve for this offset */
        while (*e != -1) {
            if (*e == offset) { *spuField = e[1]; break; }
            idx++;
            e = e + 2;
        }
        if (*spuField != 0)
            return 7;                              /* already resolved */
        blocks = size / 0x1c;
        if (size != blocks * 0x1c)
            blocks = blocks + 1;
        need = blocks * count * 0x10;
        buf = iSNDpsxmalloc(need);
        if (buf == 0)
            return -6;
        dma = iSNDdmqueuesplit(bank + offset, (unsigned int)buf, need, 1);
        e = (int *)(idx * 8 + patch);
        *spuField = buf;
        e[0] = offset;
        e[1] = buf;
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
    int          *e;
    int           sf, v;

    while (iSNDgettag(&cursor, &id, &val, &ptr) != 0 && id != 0xfe) {
        if (id == 0x8a)
            spuField = (int *)ptr;
    }
    i = 0;
    if (*patch != -1) {
        e = patch;
        v = *e;
        sf = *spuField;
        do {
            if (v == sf)                      /* already removed */
                return 0;
            e = e + 2;
            v = *e;
            i++;
        } while (v != -1);
    }
    patch[i * 2] = *spuField;
    if (*spuField != 0)
        iSNDpsxfree((void *)*spuField);
    return 0;
}
