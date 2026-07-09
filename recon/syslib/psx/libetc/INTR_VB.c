/* syslib/psx/libetc/INTR_VB.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra; verified vs disasm, IDA unreliable
 *   for libetc).  obj INTR_VB.obj ; libetc.lib.  Vblank-interrupt setup: startIntrVSync @0x80106534 installs
 *   trapIntrVSync as the IRQ-0 (vblank) handler and returns the per-slot vsync-callback setter; trapIntrVSync
 *   @0x8010658C bumps Vcount and fans out to the 8 registered vblank callbacks.  The @0x801065F8 slot-setter
 *   is renamed _vsync_setcb (Ghidra named it "VSyncCallback" -- collides with the INTR.obj public API; it is
 *   only ever called via the pointer startIntrVSync returns).
 */

/* owning-TU def (extern-declared, never defined; BSS) */
 int vsync_cb[8]; 
extern void  _bzero_w(int *p, int nwords);                /* INTR */
extern void  InterruptCallback(int idx, void (*h)());     /* INTR */
extern void  trapIntrVSync(void);

extern int Vcount = 0;        /* @0x80137D10 */
extern int vsync_cb[8];       /* @0x80137CF0 : 8 vblank callbacks */

extern int _vsync_setcb(int idx, int cb)   /* @0x801065F8 (returned by startIntrVSync) */
{
    int old = vsync_cb[idx];
    if (cb != old) vsync_cb[idx] = cb;
    return old;
}

extern void *startIntrVSync(int priority)   /* @0x80106534 */
{
    *(volatile unsigned int *)0x1F801114 = 0x100;   /* RCnt vblank-timing mode (via the I/O ptr @0x80137D14) */
    Vcount = 0;
    _bzero_w(vsync_cb, 8);
    InterruptCallback(0, trapIntrVSync);
    return (void *)_vsync_setcb;
}

extern void trapIntrVSync(void)   /* @0x8010658C */
{
    int i = 0;
    void (**cb)() = (void (**)())vsync_cb;
    Vcount = Vcount + 1;
    do {
        if (*cb) (*cb)();
        i = i + 1;
        cb = cb + 1;
    } while (i < 8);
}
