/* eaclib/psx/sndpsxz/ssysreal.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\ssysreal.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800F2130 .. 0x800F2150].  Hook the sound service onto the syslib real-time system-task list.
 *   Ghidra nfs4-f.exe.c (ssysreal) + IDA sigs.
 */
#include "../eacpsxz/systask.h"
#include "ssysreal.h"
#include "ssysserv.h"

/* iSNDsystemtaskreal @0x800F2130 : the per-frame system-task entry -- run the sound service. */
int iSNDsystemtaskreal(void)
{
    SNDSYS_service();
    return 0;
}

/* SNDSYS_vectortoreal @0x800F2150 : install iSNDsystemtaskreal as a real-time system task (once). */
int SNDSYS_vectortoreal(void)
{
    if (!D_80134A6C[0]) {
        addsystemtask((unsigned int (*)(int, int))iSNDsystemtaskreal, 0, 1);
        D_80134A6C[0] = 1;
    }
    return 0;
}

/* ssysreal.obj .data 0x80134A6C, owned here since 2026-09-19 (gprefs.py: SNDSYS_vectortoreal is the only user). */
int D_80134A6C[1] __attribute__((section(".data"))) = { 0 };
