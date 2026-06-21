/* eaclib/psx/eacpsxz/savegp.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\savegp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   3 fns: initgp@0x800EB080, savegp@0x800EB090, restoregp@0x800EB0A4.  FULL reconstruction; no stubs.
 *
 *   PSX interrupt-context $gp (global-pointer / small-data register) swap.  On entry to an EA ISR
 *   (Clock/CD/timer handlers) the running thread's $gp is wrong for the lib's small-data section, so
 *   the handler does:  savegp(&saved);  ...work...;  restoregp(saved);  and initgp() records the lib
 *   $gp once at boot.  asm:
 *     initgp()        : g_bootGP   = $gp                 (@0x801234E8)
 *     savegp(out)     : *out = $gp ; $gp = g_handlerGP   (@0x8013FA34, the lib small-data base)
 *     restoregp(gp)   : $gp = gp
 *
 *   $gp is not a user-visible register in portable C++ (the PsyCross/PC target has no MIPS $gp), so the
 *   value-swap is modelled here with a single g_gpContext word: the save/restore PAIRING and the values
 *   moved are preserved exactly, which is all the call sites depend on.  On a real MIPS rebuild these
 *   become the documented mfgp/mtgp sequences.
 */

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
extern "C" { unsigned int g_bootGP; unsigned int g_handlerGP; }

extern "C" unsigned int g_bootGP;        /* @0x801234E8 (data-mat pass owns) */
extern "C" unsigned int g_handlerGP;     /* @0x8013FA34 lib small-data base  */
unsigned int g_gpContext = 0;            /* models the live $gp register      */

extern "C" void initgp(void)             /* @0x800EB080 */
{
    g_bootGP = g_gpContext;
}

extern "C" void savegp(unsigned int *out) /* @0x800EB090 */
{
    *out = g_gpContext;
    g_gpContext = g_handlerGP;
}

extern "C" void restoregp(unsigned int gp) /* @0x800EB0A4 */
{
    g_gpContext = gp;
}
