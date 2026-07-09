/* eaclib/psx/eacpsxz/savegp.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\savegp.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\SAVEGP.ASM (per SYM SLD -- data word
 *                @0x801234E8 = line 7, code @0x800EB080 = line 10). Three XDEF entries that operate
 *                directly on the MIPS $gp (global-pointer / small-data) register, which is not
 *                expressible in portable C++ -- so all three are transcribed VERBATIM as file-scope
 *                __asm__ (byte-identical); the host build gets empty stubs.
 *
 *   PSX interrupt-context $gp swap.  An EA ISR (Clock/CD/timer handler) runs with the interrupted
 *   thread's $gp, which is wrong for the lib's small-data section, so it does:
 *       initgp();                                       // ONCE at boot: record the lib $gp
 *       savegp(&caller_gp); ...work...; restoregp(caller_gp);   // per interrupt
 *
 *     initgp()      @0x800EB080 : g_bootGP = $gp                (lui $at,%hi; sw $gp,%lo($at); jr; nop -- 4)
 *     savegp(out)   @0x800EB090 : *out = $gp; $gp = g_bootGP    (sw; lui/lw the word; jr; nop -- 5)
 *     restoregp(v)  @0x800EB0A4 : $gp = v                       (jr $ra; or $gp,$zero,$a0 in delay slot -- 2)
 *
 *   Both initgp (store) and savegp (load) touch the SAME word g_bootGP @0x801234E8 (a savegp.obj-local
 *   word, SLD line 7 -- runtime-populated by initgp).  initgp references it symbolically
 *   (%hi/%lo(g_bootGP)); the oracle left savegp's reload as a LINKED LITERAL
 *   (`lui $gp,0x8012; lw $gp,0x34E8($gp)` == 0x801234E8) rather than re-symbolizing it, so savegp must
 *   transcribe those literals (32786 / 13544 decimal) to byte-match.  maspsx note: the `lw` displacement
 *   MUST be decimal (13544, not 0x34E8) -- maspsx int()-parses the offset(base) displacement base-10.
 *   (Data-mat/promotion follow-up: g_bootGP is currently an extern -- the linked build owns the word as
 *   `D_801234E8` in an asm/data blob; promoting this TU means defining g_bootGP here and de-duping the blob.)
 */

extern unsigned int g_bootGP;   /* @0x801234E8 : lib/boot $gp; written by initgp, reloaded by savegp */

#if defined(__mips__)

__asm__(
"       .set noreorder\n"
"       .set noat\n"
/* initgp @0x800EB080 : g_bootGP = $gp */
"       .globl initgp\n"
"initgp:\n"
"       lui     $at, %hi(g_bootGP)\n"
"       sw      $gp, %lo(g_bootGP)($at)\n"
"       jr      $ra\n"
"        nop\n"
/* savegp @0x800EB090 : *a0 = $gp; then $gp = g_bootGP (reload the lib gp from 0x801234E8).
 * The oracle keeps this reload as a linked literal (splat did not re-symbolize it), so the address is
 * transcribed as lui 0x8012 / lw 0x34E8 == 0x801234E8. The lw offset is DECIMAL (13544) for maspsx. */
"       .globl savegp\n"
"savegp:\n"
"       sw      $gp, 0($a0)\n"
"       lui     $gp, 32786\n"        /* 0x8012                         */
"       lw      $gp, 13544($gp)\n"   /* 0x34E8 -> 0x801234E8 == g_bootGP */
"       jr      $ra\n"
"        nop\n"
/* restoregp @0x800EB0A4 : $gp = a0 (in the jr delay slot) */
"       .globl restoregp\n"
"restoregp:\n"
"       jr      $ra\n"
"        or     $gp, $zero, $a0\n"
"       .set at\n"
"       .set reorder\n"
);

#else  /* host build -- empty stubs */

extern void initgp(void) {}
extern void savegp(unsigned int *out) { (void)out; }
extern void restoregp(unsigned int gp) { (void)gp; }

#endif
