/* eaclib/psx/sndpsxz/ssysreal.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\ssysreal.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800F2130 .. 0x800F2150].  Hook the sound service onto the syslib real-time system-task list.
 *   Ghidra nfs4-f.exe.c (ssysreal) + IDA sigs.
 */
extern void SNDSYS_service(void);                               /* ssysserv */
extern void addsystemtask(void *fn, void *a, void *b);          /* eacpsxz systask.obj */
/* Sized extern view keeps this regular-.bss symbol out of the -G4 gp-relative path. */
/* W65-A6: `DAT_80134a6c` was a reloc-referenced UNDEFINED symbol (3 sites) AND a seal-criterion
 * #3 violation (a Ghidra-ism in code).  It is not missing data at all -- 0x80134A6C is INSIDE
 * the initialised image (VA < t_addr+t_size 0x8013E000) and is already defined by the splat
 * blob as `D_80134A6C` (asm/data/data_8010CCD4_r17.data.s, `dlabel D_80134A6C`).  The two
 * spellings differ only in case, i.e. exactly the casing-phantom class (methodology gotcha #17)
 * that an nm frontier count hides as "one more unsealed callee".  Renaming the reference to the
 * blob's exact spelling resolves it and is BYTE-NEUTRAL (only the relocation NAME changes;
 * verify_asm is reloc-name lenient and the TU re-gates 2/2 PASS). */
extern int  D_80134A6C[2];     /* @0x80134A6C : element 0 is the "task installed" flag */

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
    if (D_80134A6C[0] == 0) {
        addsystemtask((void *)iSNDsystemtaskreal, (void *)0, (void *)1);
        D_80134A6C[0] = 1;
    }
    return 0;
}
