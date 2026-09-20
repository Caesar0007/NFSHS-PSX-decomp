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
 */

#include "../eaclib_types.h"
#include "eac_types.h"
#include "savegp.h"

/* savegp.obj .data 0x801234E8 (SAVEGP.ASM line 7; link-order slot addtimer [250] .. fixdsqrt [252]): the saved library $gp.
 * Owned here since 2026-09-20 -- it had been "covered" only by the alignment tail of the non-module snddata.c.  The label
 * keeps its VA spelling because the asm template below names it (an asm-label alias on a C declaration cannot rename a
 * symbol that only appears inside an __asm__ string); the TU is built -G0 so the word is plain .data, as in the asm original. */
unsigned int g_bootGP __asm__("D_801234E8") = 0;   /* @0x801234E8 : lib/boot $gp (written by initgp) */

#if defined(__mips__)

/* ASPSX-DIALECT (w64-a20): the asm below uses NUMERIC registers and no
 * `.set push/pop` -- ASPSX 2.77, the PRODUCTION assembler, rejects ABI
 * register NAMES and push/pop.  $0 zero $1 at $2-3 v0-v1 $4-7 a0-a3
 * $8-15 t0-t7 $16-23 s0-s7 $24-25 t8-t9 $28 gp $29 sp $30 fp $31 ra.
 * Gate-lane object is byte-identical (proven by hash); see
 * scratchpad/w64a20/RECEIPTS.md. */
__asm__(
"       .text\n"                     /* the g_bootGP definition above leaves the assembler in .data */
"       .set noreorder\n"
"       .set noat\n"
/* initgp @0x800EB080 : g_bootGP = $gp */
"       .globl initgp\n"
"initgp:\n"
"       lui     $1, %hi(D_801234E8)\n"
"       sw      $28, %lo(D_801234E8)($1)\n"
"       jr      $31\n"
"        nop\n"
/* savegp @0x800EB090 : *a0 = $gp; then $gp = g_bootGP (reload the lib gp from 0x801234E8).
 * The oracle keeps this reload as a linked literal (splat did not re-symbolize it), so the address is
 * transcribed as lui 0x8012 / lw 0x34E8 == 0x801234E8. The lw offset is DECIMAL (13544) for maspsx. */
"       .globl savegp\n"
"savegp:\n"
"       sw      $28, 0($4)\n"
"       lui     $28, 32786\n"        /* 0x8012                         */
"       lw      $28, 13544($28)\n"   /* 0x34E8 -> 0x801234E8 == g_bootGP */
"       jr      $31\n"
"        nop\n"
/* restoregp @0x800EB0A4 : $gp = a0 (in the jr delay slot) */
"       .globl restoregp\n"
"restoregp:\n"
"       jr      $31\n"
"        or     $28, $0, $4\n"
"       .set at\n"
"       .set reorder\n"
);

#else  /* host build -- empty stubs */

void initgp(void) {}
void savegp(unsigned int *out) { (void)out; }
void restoregp(unsigned int gp) { (void)gp; }

#endif
