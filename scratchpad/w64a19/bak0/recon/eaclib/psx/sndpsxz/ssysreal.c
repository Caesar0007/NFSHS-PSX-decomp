/* eaclib/psx/sndpsxz/ssysreal.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\ssysreal.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800F2130 .. 0x800F2150].  Hook the sound service onto the syslib real-time system-task list.
 *   Ghidra nfs4-f.exe.c (ssysreal) + IDA sigs.
 */
extern void SNDSYS_service(void);                               /* ssysserv */
extern void addsystemtask(void *fn, void *a, void *b);          /* eacpsxz systask.obj */
/* Sized extern view keeps this regular-.bss symbol out of the -G4 gp-relative path. */
extern int  DAT_80134a6c[2];   /* @0x80134A6C : element 0 is the "task installed" flag */

extern int  iSNDsystemtaskreal(void);   /* @0x800F2130 */
extern int  SNDSYS_vectortoreal(void);  /* @0x800F2150 */

/* iSNDsystemtaskreal @0x800F2130 : the per-frame system-task entry -- run the sound service. */
extern int iSNDsystemtaskreal(void)
{
    SNDSYS_service();
    return 0;
}

/* SNDSYS_vectortoreal @0x800F2150 : install iSNDsystemtaskreal as a real-time system task (once). */
extern int SNDSYS_vectortoreal(void)
{
    if (DAT_80134a6c[0] == 0) {
        addsystemtask((void *)iSNDsystemtaskreal, (void *)0, (void *)1);
        DAT_80134a6c[0] = 1;
    }
    return 0;
}
