/* eaclib/psx/eacpsxz/addtimer.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\addtimer.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   2 fns: addtimer@0x800EAFE8, deltimer@0x800EB048.  FULL reconstruction (disasm-v3 MIPS); no stubs.
 *
 *   EA per-frame timer-callback registry: an 8-slot table of function pointers, tmrsub[8]
 *   @0x8012360C, scanned every tick by tmrint/inittimer.  addtimer(fn) registers `fn` (idempotent:
 *   if already present it returns; else it drops `fn` into the first empty slot).  deltimer(fn) clears
 *   the slot holding `fn`.  Both walk all 8 slots; neither returns a meaningful value.
 */

/* owning-TU def (extern-declared, never defined; BSS) */
 int (*tmrsub[8])(void); /* @0x8012360C: retail SYM/MAP public timer callback table */

extern int (*tmrsub[8])(void);

extern void addtimer(int (*fn)(void))   /* @0x800EAFE8 */
{
    int i;
    for (i = 0; i < 8; i++)              /* already registered? -> done */
        if (tmrsub[i] == fn)
            return;
    for (i = 0; i < 8; i++)             /* else first empty slot */
        if (tmrsub[i] == 0) {
            tmrsub[i] = fn;
            return;
        }
}

extern void deltimer(int (*fn)(void))   /* @0x800EB048 */
{
    int i;
    for (i = 0; i < 8; i++)
        if (tmrsub[i] == fn) {
            tmrsub[i] = 0;
            return;
        }
}
