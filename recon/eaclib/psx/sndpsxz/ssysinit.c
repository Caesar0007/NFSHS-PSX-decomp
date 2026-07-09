/* eaclib/psx/sndpsxz/ssysinit.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\ssysinit.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800F1D58 .. 0x800F204C].  The SND public-API boot layer: read/write the option block, bring
 *   the whole sound system up (SNDSYS_init) and tear it down (SNDSYS_restore).
 *   Ghidra nfs4-f.exe.c (ssysinit) + IDA sigs / disasm:
 *     SNDSYS_init forwards (membase,memsize) to iSNDmeminit (IDA's 0-arg is wrong); SNDSYS_setopts's
 *     0x80147860 constant RESOLVED to &sndgs (no bare VA); the option block is sndgs[0..0xe].
 */

extern int  sndgs[];
extern int  DAT_80134a68;                  /* output-caps init-once flag */

extern void iSNDplatformoutputcaps(void);  /* slib    */
extern void iSNDplatformoutputset(void);   /* slib    */
extern void iSNDinit(void);                /* slib    */
extern void iSNDrestore(void);             /* slib    */
extern void iSNDmeminit(int membase, int memsize);   /* smemman */
extern int  iSNDmalloc(unsigned int size);           /* smemman */
extern int  iSNDmemrestore(void);                    /* smemman */
extern void iSND100hzserver(void);         /* sserver */
extern void SNDI_mutexalloc(void);         /* sdfx    */
extern void SNDI_mutexfree(void);          /* sdfx    */
extern void SNDstopall(void);              /* sstopall */
extern void *memset(void *dst, int c, int n);        /* C43 (BIOS thunk) */

extern void SNDSYS_getopts(int *opts);     /* @0x800F1D58 */
extern int  SNDSYS_setopts(int opts);      /* @0x800F1E14 */
extern void SNDSYS_init(int membase, int memsize);   /* @0x800F1F10 */
extern int  SNDSYS_restore(void);          /* @0x800F204C */

/* SNDSYS_getopts @0x800F1D58 : copy the live option block sndgs[0..0xe] into the caller's struct (lazily
 *   publishing the platform output caps first, defaulting the reverb-channel count to 0x10). */
extern void SNDSYS_getopts(int *opts)
{
    int i;
    if (DAT_80134a68 == 0) {
        iSNDplatformoutputcaps();
        DAT_80134a68 = 1;
    }
    if (((short *)sndgs)[6] == 0)               /* sndgs[3]._0_2_ : reverb channels */
        ((short *)sndgs)[6] = 0x10;
    for (i = 0; i < 0xf; i++)                    /* sndgs[0..0xe] -> opts[0..0xe] */
        opts[i] = sndgs[i];
}

/* SNDSYS_setopts @0x800F1E14 : apply the writable option fields opts[3..0xe] into sndgs (source may be
 *   unaligned), then re-derive the output configuration. */
extern int SNDSYS_setopts(int opts)
{
    int i;
    for (i = 3; i <= 0xe; i++)                   /* opts[3..0xe] -> sndgs[3..0xe] (unaligned-safe source) */
        sndgs[i] = *(int *)(opts + i * 4);
    iSNDplatformoutputset();
    return 0;
}

/* SNDSYS_init @0x800F1F10 : bring up the sound system from a `memsize`-byte pool at `membase` -- init the
 *   allocator, default the options, allocate the channel + reverb tables, install the 100 Hz server, and
 *   start the SPU (iSNDinit).  No-op if already up. */
extern void SNDSYS_init(int membase, int memsize)
{
    unsigned int nchan;
    int          rv;
    if ((signed char)sndgs[0xf] == 0) {
        iSNDmeminit(membase, memsize);
        nchan = (unsigned int)((unsigned char *)sndgs)[0x11];     /* sndgs[4]._1_1_ */
        if (nchan == 0) {                                          /* no caps yet -> defaults */
            SNDSYS_getopts(sndgs);
            SNDSYS_setopts((int)sndgs);
            nchan = (unsigned int)((unsigned char *)sndgs)[0x11];
        }
        sndgs[0x25] = iSNDmalloc(nchan * 100);                     /* channel pool */
        memset((unsigned char *)sndgs[0x25], 0, (int)((unsigned)((unsigned char *)sndgs)[0x11] * 100));
        sndgs[0x26] = iSNDmalloc((unsigned int)((unsigned short *)sndgs)[6] * 0xc);  /* reverb table */
        memset((unsigned char *)sndgs[0x26], 0, (int)((unsigned)((unsigned short *)sndgs)[6] * 0xc));
        if (sndgs[0x12] == 0)
            sndgs[0x12] = (int)iSND100hzserver;
        SNDI_mutexalloc();
        rv = 0x7f;
        sndgs[0x11] = 0;
        sndgs[0x2b] = 0;
        ((char *)sndgs)[0x3d] = 0x7f;                              /* sndgs[0xf]._1_1_ : master vol */
        iSNDinit();
        if (rv < 0)
            iSNDrestore();
        else
            ((char *)sndgs)[0x3c] = 1;                             /* sndgs[0xf]._0_1_ : audio up */
    }
}

/* SNDSYS_restore @0x800F204C : shut the sound system down -- fire the registered teardown hooks, stop all
 *   voices, restore the SPU, free the mutex + memory.  No-op if not up. */
extern int SNDSYS_restore(void)
{
    if ((signed char)sndgs[0xf] == 0)                             /* audio not up */
        return -10;
    if (sndgs[0x23] != 0) (*(void (*)(void))sndgs[0x23])();
    if (sndgs[0x24] != 0) (*(void (*)(void))sndgs[0x24])();
    if (sndgs[0x21] != 0) (*(void (*)(void))sndgs[0x21])();
    if (sndgs[0x22] != 0) (*(void (*)(void))sndgs[0x22])();
    if (sndgs[0x20] != 0) (*(void (*)(void))sndgs[0x20])();
    SNDstopall();
    if (sndgs[0x1f] != 0) (*(void (*)(unsigned int))sndgs[0x1f])(0xffffffff);
    iSNDrestore();
    ((char *)sndgs)[0x3c] = 0;                                     /* audio down */
    SNDI_mutexfree();
    return iSNDmemrestore();   /* $v0 holds iSNDmemrestore's return on this path (incidental);
                                * the -10 sentinel lives only in the not-up beqz delay slot */
}
