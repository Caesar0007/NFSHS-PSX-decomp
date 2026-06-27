/* eaclib/psx/eacpsxz/savegp.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\savegp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   3 fns: initgp@0x800EB080, savegp@0x800EB090, restoregp@0x800EB0A4.  FULL reconstruction; no stubs.
 *
 *   PSX interrupt-context $gp (global-pointer / small-data register) swap.  On entry to an EA ISR
 *   (Clock/CD/timer handlers) the running thread's $gp is wrong for the lib's small-data section, so
 *   the handler does:  savegp(&saved);  ...work...;  restoregp(saved);  and initgp() records the lib
 *   $gp once at boot.
 *
 *   All three functions operate directly on the MIPS $gp register -- not expressible in portable C++.
 *   Oracle:
 *     initgp()    @0x800EB080 : sw $gp,0($at)  [D_801234E8 via lui/sw]; jr $ra; nop  (4 insns)
 *     savegp(out) @0x800EB090 : sw $gp,0($a0); lui $gp,hi; lw $gp,lo($gp); jr $ra; nop (5 insns)
 *     restoregp(v)@0x800EB0A4 : jr $ra; or $gp,$zero,$a0  (2 insns, value in delay slot)
 *
 *   MATCH: direct file-scope __asm__ transcriptions (§G-catalog, the hand-written-assembly route).
 *   The host build gets empty stubs.
 *
 *   D_801234E8 = the saved boot-$gp word (initgp stores to it).
 *   0x8013FA34 = the lib handler-$gp base (savegp loads from it after saving the caller's $gp).
 */

/* ---- owning-TU defs for link-harness ---- */
extern "C" { unsigned int g_bootGP; unsigned int g_handlerGP; }

extern "C" unsigned int g_bootGP;     /* @0x801234E8 (data-mat pass owns) */
extern "C" unsigned int g_handlerGP;  /* @0x8013FA34 lib small-data base  */

#if defined(__mips__)

__asm__(
"       .set noreorder\n"
"       .set noat\n"
/* initgp @0x800EB080 : save current $gp to D_801234E8 */
"       .globl initgp\n"
"initgp:\n"
"       lui     $at, %hi(g_bootGP)\n"
"       sw      $gp, %lo(g_bootGP)($at)\n"
"       jr      $ra\n"
"        nop\n"
/* savegp @0x800EB090 : *a0 = $gp; $gp = *(0x801234E8) (g_bootGP: the lib gp stored by initgp)
 * The literal 0x8012_0000 + 0x34E8 must be hardcoded because the symbol resolves to 0 in the
 * unlinked object (common symbol in .sbss) -- %hi/lo of a .comm sym = reloc-addend-to-0. */
"       .globl savegp\n"
"savegp:\n"
"       sw      $gp, 0($a0)\n"
"       lui     $gp, 32786\n"
"       lw      $gp, 13544($gp)\n"
"       jr      $ra\n"
"        nop\n"
/* restoregp @0x800EB0A4 : $gp = a0 (in delay slot) */
"       .globl restoregp\n"
"restoregp:\n"
"       jr      $ra\n"
"        or     $gp, $zero, $a0\n"
"       .set reorder\n"
"       .set at\n"
);

#else  /* host build -- empty stubs */

extern "C" void initgp(void) {}
extern "C" void savegp(unsigned int *out) { (void)out; }
extern "C" void restoregp(unsigned int gp) { (void)gp; }

#endif
