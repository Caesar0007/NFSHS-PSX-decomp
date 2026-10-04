/* recon/mod/eaclib/psx/eacpsxz/savegp.c -- ROUTE D override of recon/eaclib/psx/eacpsxz/savegp.c.
 *
 *   Retail's savegp reloads the library $gp from a LINKED LITERAL (lui 0x8012 / lw 0x34E8 == 0x801234E8),
 *   and the byte-exact reconstruction keeps that literal.  Any relink that moves .data therefore restores a
 *   garbage $gp on the first EA interrupt callback (route D pad bisect 2026-10-04: Address Error at the first
 *   gp-relative load in the async-read engine, $gp = 0x0000F450).  This copy addresses g_bootGP symbolically;
 *   everything else is the reconstruction verbatim.  Linked ahead of eacpsxz.lib so the library member is not
 *   pulled (all four of its symbols -- initgp, savegp, restoregp, D_801234E8 -- are defined here).
 */

#include "../../../../eaclib/psx/eaclib_types.h"
#include "../../../../eaclib/psx/eacpsxz/eac_types.h"
#include "../../../../eaclib/psx/eacpsxz/savegp.h"

/* the saved library $gp (written by initgp); the asm below names it by its reconstruction label */
unsigned int g_bootGP __asm__("D_801234E8") = 0;

#if defined(__mips__)

__asm__(
"       .text\n"
"       .set noreorder\n"
"       .set noat\n"
/* initgp : g_bootGP = $gp */
"       .globl initgp\n"
"initgp:\n"
"       lui     $1, %hi(D_801234E8)\n"
"       sw      $28, %lo(D_801234E8)($1)\n"
"       jr      $31\n"
"        nop\n"
/* savegp : *a0 = $gp; $gp = g_bootGP  (route D: symbolic reload, relocates with .data) */
"       .globl savegp\n"
"savegp:\n"
"       sw      $28, 0($4)\n"
"       lui     $28, %hi(D_801234E8)\n"
"       lw      $28, %lo(D_801234E8)($28)\n"
"       jr      $31\n"
"        nop\n"
/* restoregp : $gp = a0 (in the jr delay slot) */
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
