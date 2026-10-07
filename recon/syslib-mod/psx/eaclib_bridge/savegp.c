/* Route-D relocation bridge for EACLIB's GP trampoline.
 *
 * This does not change EACLIB's calling convention or callback behaviour.
 * The retail object encodes the linked address of g_bootGP as a literal, which
 * becomes stale when syslib-mod changes the resident layout.  Defining the
 * same four exports ahead of EACPSXZ.LIB lets the linker resolve that private
 * state symbol at its new address while leaving the EACLIB sources untouched.
 */

#include "../../../eaclib/psx/eaclib_types.h"
#include "../../../eaclib/psx/eacpsxz/eac_types.h"
#include "../../../eaclib/psx/eacpsxz/savegp.h"

unsigned int g_bootGP __asm__("D_801234E8") = 0;

#if defined(__mips__)

__asm__(
"       .text\n"
"       .set noreorder\n"
"       .set noat\n"
"       .globl initgp\n"
"initgp:\n"
"       lui     $1, %hi(D_801234E8)\n"
"       sw      $28, %lo(D_801234E8)($1)\n"
"       jr      $31\n"
"        nop\n"
"       .globl savegp\n"
"savegp:\n"
"       sw      $28, 0($4)\n"
"       lui     $28, %hi(D_801234E8)\n"
"       lw      $28, %lo(D_801234E8)($28)\n"
"       jr      $31\n"
"        nop\n"
"       .globl restoregp\n"
"restoregp:\n"
"       jr      $31\n"
"        or     $28, $0, $4\n"
"       .set at\n"
"       .set reorder\n"
);

#else

void initgp(void) {}
void savegp(unsigned int *out) { (void)out; }
void restoregp(unsigned int gp) { (void)gp; }

#endif
