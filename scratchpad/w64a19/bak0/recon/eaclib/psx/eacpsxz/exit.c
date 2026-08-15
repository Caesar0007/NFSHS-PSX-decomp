/* eaclib/psx/eacpsxz/exit.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\exit.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   1 fn @0x800F1CF8 (0x60 bytes): addexit -- register an at-exit cleanup callback.
 *   FULL reconstruction (disasm-v3 MIPS); NOT a stub.  EA shutdown service.
 *
 *   gExitFuncs[32] @0x801349E8 is a fixed 32-slot table of cleanup callbacks (run at shutdown).
 *   addexit(fn) is idempotent: if `fn` is already registered it returns; otherwise it drops `fn`
 *   into the first empty (NULL) slot.  (Same registry shape as addtimer's 8-slot table.)
 */

/* owning-TU def (extern-declared, never defined; BSS) */
 void (*gExitFuncs[32])(void); 
extern void (*gExitFuncs[32])(void);   /* @0x801349E8 (data-mat pass owns) */

extern void addexit(void (*fn)(void))  /* @0x800F1CF8 */
{
    int i;
    for (i = 0; i < 32; i++)               /* already registered? -> done */
        if (gExitFuncs[i] == fn)
            return;
    for (i = 0; i < 32; i++)              /* else first empty slot */
        if (gExitFuncs[i] == 0) {
            gExitFuncs[i] = fn;
            return;
        }
}
