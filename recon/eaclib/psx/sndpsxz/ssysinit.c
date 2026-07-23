/* eaclib/psx/sndpsxz/ssysinit.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 ***
 *   Source obj : nfs4\eaclib\psx\ssysinit.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800F1D58 .. 0x800F204C].  The SND public-API boot layer: read/write the option block, bring
 *   the whole sound system up (SNDSYS_init) and tear it down (SNDSYS_restore).
 *   Ghidra nfs4-f.exe.c (ssysinit) + IDA sigs / disasm:
 *     SNDSYS_init forwards (membase,memsize) to iSNDmeminit (IDA's 0-arg is wrong); SNDSYS_setopts's
 *     0x80147860 constant RESOLVED to &sndgs (no bare VA); the option block is sndgs[0..0xe].
 */

extern int  sndgs[];
extern int  DAT_80134a68[];                /* output-caps flag; owned by snddata.c (array view forces
                                             * the oracle's retained absolute address, not GP-relative) */

extern int  iSNDplatformoutputcaps(void);  /* slib -- MATCH: non-void, $v0 threads through as
                                             * SNDSYS_getopts's own return value (see below) */
extern void iSNDplatformoutputset(void);   /* slib    */
extern int  iSNDinit(void);                /* slib -- returns the platform bring-up status */
extern int  iSNDrestore(void);             /* slib    */
extern void iSNDmeminit(int membase, int memsize);   /* smemman */
extern int  iSNDmalloc(unsigned int size);           /* smemman */
extern int  iSNDmemrestore(void);                    /* smemman */
extern void iSND100hzserver(void);         /* sserver */
extern void SNDI_mutexalloc(void);         /* sdfx    */
extern void SNDI_mutexfree(void);          /* sdfx    */
extern void SNDstopall(void);              /* sstopall */
extern void *memset(void *dst, int c, int n);        /* C43 (BIOS thunk) */

extern int  SNDSYS_getopts(int *opts);     /* @0x800F1D58 */
extern int  SNDSYS_setopts(int opts);      /* @0x800F1E14 */
extern int  SNDSYS_init(int membase, int memsize);   /* @0x800F1F10 */
extern int  SNDSYS_restore(void);          /* @0x800F204C */

struct SndOptsBlock15 { int w[15]; };   /* naturally aligned (both sndgs and opts are real int* here --
                                          * no runtime alignment check, unlike SNDSYS_setopts below) */

/* SNDSYS_getopts @0x800F1D58 : copy the live option block sndgs[0..0xe] into the caller's struct (lazily
 *   publishing the platform output caps first, defaulting the reverb-channel count to 0x10).
 *   MATCH: non-void -- $v0 at exit is iSNDplatformoutputcaps()'s return (or 0 if that path wasn't
 *   taken), threaded through a local exactly like the §3.2 Ghidra void-return-bug class; the header's
 *   `void` prototype is the same incidental-vs-real-return question, resolved here from the oracle
 *   (`addu a1,zero,zero` init -> `addu a1,v0,zero` on the call path -> `addu v0,a1,zero` at exit). */
extern int SNDSYS_getopts(int *opts)
{
    int r = 0;
    unsigned char *base;
    if (DAT_80134a68[0] == 0) {
        r = iSNDplatformoutputcaps();
        DAT_80134a68[0] = 1;
    }
    base = (unsigned char *)sndgs;
    if (*(unsigned short *)(base + 0xc) == 0)    /* sndgs[3]._0_2_ : reverb channels */
        *(short *)(base + 0xc) = 0x10;
    *(struct SndOptsBlock15 *)opts = *(struct SndOptsBlock15 *)base; /* sndgs[0..0xe] -> opts[0..0xe] */
    return r;
}

extern int D_80147898[];   /* a separate (non-sndgs) global; opts[14]'s destination */

/* SNDSYS_setopts @0x800F1E14 : apply the writable option fields opts[3..13] into sndgs (source may be
 *   unaligned -- gcc emits its inline lwl/lwr-vs-lw/sw runtime-alignment-checked block-copy), opts[14]
 *   goes to the separate D_80147898 global (NOT sndgs[14]), then re-derive the output configuration.
 *   MATCH: an 11-int (0x2C byte) struct-copy through a PACKED (alignment-1) type -- gcc only emits the
 *   oracle's runtime (v1|a1)&3 alignment test when the source's DECLARED alignment is uncertain; a plain
 *   `int[11]` struct has known 4-byte alignment and gcc skips the check (tried, 32 insns/no check). A
 *   real memcpy() call (BIOS thunk) is also wrong -- the oracle has no `jal` at all. Routing the
 *   destination through a bare `sndgs` byte pointer preserves the explicit +0x0c add; the array-shaped
 *   D_80147898 declaration then lets its store fill outputset's jal delay slot. */
struct SndOptsBlock { int w[11]; } __attribute__((packed));

extern int SNDSYS_setopts(int opts)
{
    char *base = (char *)sndgs;
    *(struct SndOptsBlock *)(base + 0xC) = *(struct SndOptsBlock *)(opts + 0xC);
    D_80147898[0] = *(int *)(opts + 0x38);
    iSNDplatformoutputset();
    return 0;
}

/* SNDSYS_init @0x800F1F10 : bring up the sound system from a `memsize`-byte pool at `membase` -- init the
 *   allocator, default the options, allocate the channel + reverb tables, install the 100 Hz server, and
 *   start the SPU (iSNDinit). MATCH (79/79): returns the platform status on failure after cleanup,
 *   otherwise zero; no-op with zero when already up. */
extern int SNDSYS_init(int membase, int memsize)
{
    unsigned int nchan;
    int          rv;
    unsigned char *base = (unsigned char *)sndgs;

    if (*(signed char *)(base + 0x3c) != 0)
        return 0;

    iSNDmeminit(membase, memsize);
    nchan = (unsigned int)base[0x11];                              /* sndgs[4]._1_1_ */
    if (nchan == 0) {                                              /* no caps yet -> defaults */
        SNDSYS_getopts((int *)base);
        SNDSYS_setopts((int)base);
        nchan = (unsigned int)base[0x11];
    }
    ((int *)base)[0x25] = iSNDmalloc(nchan * 100);                 /* channel pool */
    memset((unsigned char *)((int *)base)[0x25], 0, (int)((unsigned)base[0x11] * 100));
    ((int *)base)[0x26] = iSNDmalloc((unsigned int)((unsigned short *)base)[6] * 0xc); /* reverb table */
    memset((unsigned char *)((int *)base)[0x26], 0,
           (int)((unsigned)((unsigned short *)base)[6] * 0xc));
    if (((int *)base)[0x12] == 0)
        ((int *)base)[0x12] = (int)iSND100hzserver;
    SNDI_mutexalloc();
    ((int *)base)[0x11] = 0;
    ((int *)base)[0x2b] = 0;
    base[0x3d] = 0x7f;                                             /* master vol */
    rv = iSNDinit();
    if (rv < 0) {
        iSNDrestore();
        return rv;
    }
    base[0x3c] = 1;                                                /* audio up */
    return 0;
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
