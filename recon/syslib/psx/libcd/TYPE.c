/* TYPE.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libcd.lib(TYPE.OBJ) [auth: nfs4-v7-funcs-only.xlsx -> nfs4\syslib\psx\TYPE.obj].
 *   The PsyQ libcd disc-status / disc-type probe.  Surfaced by the whole-tree link harness
 *   (declared in lib/libfns.h, called by cdfs.cpp + audiomus.cpp, never defined -- the
 *   EXE SLD marker mis-attributed these to RANDOM.ASM; the xlsx obj map is authoritative).
 *
 *     int CdDiskReady(int mode)  @0x800E8448  -- poll the drive until the disc is stable.
 *     int CdGetDiskType(void)    @0x800E8584  -- classify the disc (data vs audio via the
 *                                                ISO9660 "CD001" magic at sector 16).
 *
 *   Faithful to the MIPS control-flow (goto-structured where the asm uses irregular
 *   branches).  CD commands: 1=CdlNop, 9=CdlPause, 19=CdlGetTN(0x13), 27=CdlReadS(0x1B). */

extern int  CdControlB(unsigned char com, unsigned char *p, unsigned char *r); /* SYS.obj @0x800F7B24 */
extern int  CdControl (unsigned char com, unsigned char *p, unsigned char *r); /* SYS.obj @0x800F78B4 */
extern void CdIntToPos(int i, unsigned char *p);                               /* SYS.obj @0x800F7CF4 */
extern int  CdReady   (int mode, unsigned char *r);                            /* SYS.obj @0x800F786C */
extern int  CdGetSector(void *madr, int size);                                 /* SYS.obj @0x800F7C70 */
extern void VSync(int mode);                                                   /* libetc @0x800F231C */
extern int  printf(const char *fmt, ...);                                      /* libc   @0x801028AC */
extern int  strncmp(const char *a, const char *b, int n);                      /* libc   @0x800EB1D0 */

/* @0x800E8448 : wait for a stable disc.  Returns 16 (shell-open/error), 2 (ready) or 5. */
extern int CdDiskReady(int mode)
{
    unsigned char result[8];
    int cc;
    int i;

    CdControlB(1, 0, result);                       /* CdlNop -> status */
    if (result[0] & 0x10) return 16;                /* shell open / error */

    cc = CdControlB(19, 0, result);                 /* CdlGetTN */
    if (mode == 1) {
        if (result[0] != 2) return 5;
        if (cc != 0) return 2;
        return 5;
    }

    for (i = 0; i < 10; i++) {
        if (result[0] & 2) {
            if (result[0] == 2 && cc != 0) return 2;
        retry:                                      /* @0x800E84EC */
            VSync(30);
            cc = CdControlB(19, 0, result);         /* CdlGetTN */
            if (result[0] & 0x10) return 16;
            if (result[0] != 2) goto retry;
            if (cc == 0)        goto retry;
            return 2;
        }
        VSync(30);
        cc = CdControlB(19, 0, result);             /* CdlGetTN */
        if (result[0] & 0x10) return 16;
    }
    return 5;
}

/* @0x800E8584 : classify the disc.  Returns 16 (error), 2 (ISO9660 data), 1 (other/no
 *               magic / command error) or the audio bit ((result[0] & 2) != 0). */
extern int CdGetDiskType(void)
{
    unsigned char locp[8];                          /* sp+0x10  */
    unsigned char sector[2048];                     /* sp+0x18  */
    unsigned char result[8];                        /* sp+0x818 */
    int rdy, i;

    CdControl(1, 0, result);                        /* CdlNop -> status */
    if (result[0] & 0x10) return 16;

    CdIntToPos(16, locp);                           /* position of sector 16 (ISO PVD) */
    CdControl(27, locp, 0);                          /* CdlReadS from locp */

    for (i = 0; i < 10; i++) {
        rdy = CdReady(0, result);
        if (rdy == 1) break;
        CdControl(27, locp, 0);                      /* CdlReadS retry */
    }

    if (rdy == 1) {
        CdControl(9, 0, 0);                          /* CdlPause */
        CdGetSector(sector, 512);                    /* 512 words = 2048 bytes */
        if (strncmp((char *)sector + 1, "CD001", 5) != 0) return 1;
        return 2;                                    /* ISO9660 data disc */
    }

    if (result[0] & 0x10) return 16;
    if ((result[0] & 1) && (result[1] & 0x40)) {
        printf("Command Error: ");
        return 1;
    }
    return (result[0] & 2) != 0;
}
