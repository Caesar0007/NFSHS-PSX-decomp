/* eaclib/psx/sndpsxz/ssysreal.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\ssysreal.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800F2130 .. 0x800F2150].  Hook the sound service onto the syslib real-time system-task list.
 *   Ghidra nfs4-f.exe.c (ssysreal) + IDA sigs.
 */
extern "C" void SNDSYS_service(void);                               /* ssysserv */
extern "C" void addsystemtask(void *fn, void *a, void *b);          /* eacpsxz systask.obj */
extern "C" int  DAT_80134a6c;   /* @0x80134A6C : "real-time task installed" flag */

extern "C" int  iSNDsystemtaskreal(void);   /* @0x800F2130 */
extern "C" void SNDSYS_vectortoreal(void);  /* @0x800F2150 */

/* iSNDsystemtaskreal @0x800F2130 : the per-frame system-task entry -- run the sound service. */
extern "C" int iSNDsystemtaskreal(void)
{
    SNDSYS_service();
    return 0;
}

/* SNDSYS_vectortoreal @0x800F2150 : install iSNDsystemtaskreal as a real-time system task (once). */
extern "C" void SNDSYS_vectortoreal(void)
{
    if (DAT_80134a6c == 0) {
        addsystemtask((void *)iSNDsystemtaskreal, (void *)0, (void *)1);
        DAT_80134a6c = 1;
    }
}
