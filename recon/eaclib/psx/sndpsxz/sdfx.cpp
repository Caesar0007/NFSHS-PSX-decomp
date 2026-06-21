/* eaclib/psx/sndpsxz/sdfx.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\sdfx.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   6 fns @[0x801001EC .. 0x80100584].  SPU reverb (FX) setup + the audio mutex (no-op on the 1-thread PSX).
 *   Ghidra nfs4-f.exe.c (sdfx) + disasm-v3 L<80100500+> for the iSNDdmqueue 5-arg reverb-RAM clear.
 *   (IDA mis-tagged the 4 mutex stubs as PsyQ SsUtVibrate*; they are empty no-ops.)
 *
 *   Reverb preset table snd_reverb_table[]: 0x42-byte coefficient blocks indexed by `mode` (1..9); block[0]
 *   is the work-area size, block[1..0x20] the 0x20 SPU reverb coefficient registers (SPUctrl+0x1c0..).
 */

extern "C" int            sndgs[];
extern "C" int            DAT_8014791c;          /* current fx mode    */
extern "C" int            DAT_80147e2c;          /* SPU control reg base (address) */
extern "C" short          snd_spu_reverb_mode;   /* reverb work-area boundary (sdmemman) */
extern "C" unsigned char  snd_reverb_table[];    /* reverb preset coefficient table (data-mat #75) */
unsigned char snd_reverb_table[512] = {0};  /* def (owning TU; FIXME nonzero rodata byte-exact pending - #75) */

extern "C" unsigned int iSNDpsxeffectoff(int mask);            /* spatkey */
extern "C" int          iSNDpsxeffectvol(int left, int right); /* spatkey */
extern "C" void blockmove(int *src, int *dst, int n);         /* blkmov  */
extern "C" int  blockclear(int buf, int len);                 /* blkfill (2-arg per IDA; Ghidra dropped both) */
extern "C" int  iSNDdmqueue(int ram, unsigned int spu, int len, unsigned char prio, unsigned char flag); /* sdma */
extern "C" int  iSNDdmcomplete(int handle);                   /* sdma */

extern "C" void SNDI_mutexalloc(void);                         /* @0x801001EC */
extern "C" void SNDI_mutexfree(void);                          /* @0x801001F4 */
extern "C" void SNDI_mutexlock(void);                          /* @0x801001FC */
extern "C" void SNDI_mutexunlock(void);                        /* @0x80100204 */
extern "C" unsigned int iSNDpsxfxinit(int mode);               /* @0x8010020C */
extern "C" int          iSNDplatformfxinit(int reserved, int mode); /* @0x80100584 */

/* --- audio mutex: the PSX is single-threaded, so these are no-ops --- */
extern "C" void SNDI_mutexalloc(void)  { }
extern "C" void SNDI_mutexfree(void)   { }
extern "C" void SNDI_mutexlock(void)   { }
extern "C" void SNDI_mutexunlock(void) { }

/* iSNDpsxfxinit @0x8010020C : load the reverb preset `mode` into the SPU -- program the 0x20 reverb
 *   coefficient registers, set the reverb work-area base, DMA-clear the reverb RAM, then enable reverb.
 *   Modes 5/10/20/30/40/50/100/110/120 map to preset indices; modes 7/8 scale a few taps by sndgs depth. */
extern "C" unsigned int iSNDpsxfxinit(int mode)
{
    unsigned char scratch[256];
    short         rv[0x21];
    unsigned char *src;
    int           i, work;
    unsigned int  ctl;

    if (mode != 0) {
        if      (mode == 5)    mode = 1;
        else if (mode == 10)   mode = 2;
        else if (mode == 0x14) mode = 3;
        else if (mode == 0x1e) mode = 4;
        else if (mode == 0x28) mode = 5;
        else if (mode == 0x32) mode = 6;
        else if (mode == 100)  mode = 9;
        else if (mode == 0x6e) mode = 8;
        else if (mode == 0x78) mode = 7;
    }
    src = &snd_reverb_table[mode * 0x42];
    snd_spu_reverb_mode = (short)((int)(0x10000 - (unsigned int)*(unsigned short *)src) >> 3);
    iSNDpsxeffectoff(0xffffff);
    iSNDpsxeffectvol(0, 0);
    blockmove((int *)src, (int *)rv, 0x42);

    if ((unsigned int)(mode - 7U) < 2) {                  /* presets 7/8: scale taps by reverb depth */
        rv[0xb] = (short)((sndgs[0x29] * 0x2000) / 0x7f) - rv[1];
        rv[0xc] = (short)((sndgs[0x29] * 0x1000) / 0x7f) - rv[2];
        rv[0xd] = rv[0xe] + (short)((sndgs[0x29] * 0x1000) / 0x7f);
        rv[0x11] = rv[0x12] + (short)((sndgs[0x29] * 0x1000) / 0x7f);
        rv[0x1b] = rv[0x1d] + (short)((sndgs[0x29] * 0x1000) / 0x7f);
        rv[0x1c] = rv[0x1e] + (short)((sndgs[0x29] * 0x1000) / 0x7f);
        rv[8] = (short)((sndgs[0x2a] * 0x8100) / 0x7f);
    }

    *(unsigned short *)(DAT_80147e2c + 0x1aa) = *(unsigned short *)(DAT_80147e2c + 0x1aa) & 0xff7f;  /* reverb off while loading */
    for (i = 0; i < 0x20; i++)                            /* 0x20 reverb coefficient regs */
        *(unsigned short *)(i * 2 + DAT_80147e2c + 0x1c0) = (unsigned short)rv[1 + i];
    work = 0x10000 - (unsigned short)rv[0];
    *(short *)(DAT_80147e2c + 0x1a2) = (short)work;        /* reverb work-area start address */

    blockclear((int)scratch, 0x100);                      /* zero the 256-byte DMA scratch */
    i = 0;                                                /* DMA-clear SPU reverb RAM in 0x20-word runs */
    while (i < 0x10000) {
        int chunk = 0x10000 - i;
        if (0x20 < chunk) chunk = 0x20;
        int h = iSNDdmqueue((int)scratch, (unsigned int)(i << 3), chunk << 3, 1, 0);
        i += 0x20;
        do { } while (iSNDdmcomplete(h) == 0);
    }

    ctl = *(unsigned short *)(DAT_80147e2c + 0x1aa) | 0x80;   /* reverb enable */
    *(short *)(DAT_80147e2c + 0x1aa) = (short)ctl;
    return ctl;
}

/* iSNDplatformfxinit @0x80100584 : record the requested fx `mode` and, if audio is up, apply it now. */
extern "C" int iSNDplatformfxinit(int reserved, int mode)
{
    (void)reserved;
    DAT_8014791c = mode;
    if ((char)sndgs[0xf] != 0)
        iSNDpsxfxinit(mode);
    return 0;
}
