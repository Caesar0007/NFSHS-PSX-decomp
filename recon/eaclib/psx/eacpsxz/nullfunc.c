/* eaclib/psx/eacpsxz/nullfunc.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.
 *   Source obj : nfs4\eaclib\psx\nullfunc.obj  (archive EACPSXZ.LIB)
 *   Original   : hand-written MIPS assembly C:\LIB\PSX\NULLFUNC.ASM (per SYM SLD @0x800F6114 line 4).
 *   ONE 2-insn body (`jr $ra; addu $v0,$zero,$zero` == return 0) that TWENTY-ONE co-equal XDEF names
 *   collapse onto: the PSX release build reduced a pile of window/mouse/shape/FILE/async API entry
 *   points to this single do-nothing-return-0 stub.  `setclipwindow` is the oracle/scaffolding canonical
 *   name (INCLUDE_ASM + .s).  (asyncidle is used by nsync.cpp.)
 *
 *   NB two toolchain facts (both verified by nm on the cc1plpsx object):
 *   (1) the stub is a real C `int f(){return 0;}` -> gcc-2.8.0 -O2 emits exactly `jr $ra; move $v0,$zero`
 *       (== the oracle's `addu $v0,$zero,$zero`).
 *   (2) gcc-2.8.0 SILENTLY IGNORES `__attribute__((alias))` (emits nothing) -- so the 20 co-equal names
 *       are emitted from a file-scope __asm__ block instead, as real globals at the same address that
 *       do NOT displace setclipwindow as objdump's disasm label.  They are LABELS, not symbol
 *       assignments: see the ASPSX-DIALECT note on the block below for why.
 */

#include "../eaclib_types.h"
#include "eac_types.h"
#include "nullfunc.h"

/* The 20 other co-equal XDEF names at 0x800F6114.
 *
 * ASPSX-DIALECT (w64-a20): these used to be GNU-as symbol ASSIGNMENTS
 * (`name = setclipwindow`) in a block placed AFTER the function.  ASPSX 2.77 --
 * the production assembler -- has NO symbol-assignment form at all (`=`,
 * `.set a,b`, `equ` and `.equ` are all rejected; w63-a20 probe), so the retail
 * toolchain could not assemble this TU.  It DOES accept two labels at one
 * address, so the names are emitted as real LABELS instead.
 * Re-confirmed 2026-09-12 straight on PSSN/ASPSX.EXE: two labels at one address
 * assemble silently, `alias = base` gives `Op-code not recognised`.  DO NOT
 * revert this block to the assignment form.
 *
 * The literals are ESCAPED (`\t`, `\n`), not carrying raw tab/newline bytes:
 * gcc-2.8 takes a newline inside a string literal as a legacy GNU extension,
 * but it is invalid C89 and every modern front end rejects it outright
 * (`missing terminating " character`).  The string VALUE is the same, so the
 * object is byte-identical either way (verified 2026-09-12).
 *
 * 🔴 WHY THIS IS SAFE HERE AND NOT IN GENERAL: CC1PSX emits a file-scope
 * __asm__ block BEFORE EVERY FUNCTION BODY in the TU (measured: in isqrttbl.c a
 * block written between two definitions still lands ahead of BOTH bodies).  So
 * a label emitted this way attaches to whichever function is emitted FIRST --
 * which is correct here only because setclipwindow is the ONLY function in this
 * TU.  ⚠️ IF A SECOND FUNCTION IS EVER ADDED, THESE LABELS MAY ATTACH TO IT:
 * re-check `objdump -t` (all 21 names must read `.text+0 size 8`).
 * Verified today: the (addr,size,name) symbol set and the disassembly are
 * unchanged on the gate lane, and the production object is byte-identical with
 * the dialect shim ON and OFF.
 *
 * (`__attribute__((alias))` is not an option: gcc-2.8.0 silently ignores it.)
 */
__asm__(
    "\t.text\n"
    "\t.globl setmousesensitivity\nsetmousesensitivity:\n"
    "\t.globl nullfunctionz\nnullfunctionz:\n"
    "\t.globl restorewindow\nrestorewindow:\n"
    "\t.globl resetclipwindow\nresetclipwindow:\n"
    "\t.globl nullwindow\nnullwindow:\n"
    "\t.globl savewindow\nsavewindow:\n"
    "\t.globl removewindow\nremovewindow:\n"
    "\t.globl purgekey\npurgekey:\n"
    "\t.globl nullfunction\nnullfunction:\n"
    "\t.globl createwindowadr\ncreatewindowadr:\n"
    "\t.globl createshapeadr\ncreateshapeadr:\n"
    "\t.globl FILE_resize\nFILE_resize:\n"
    "\t.globl librestoremouse\nlibrestoremouse:\n"
    "\t.globl shapewindowdefadr\nshapewindowdefadr:\n"
    "\t.globl FILE_delete\nFILE_delete:\n"
    "\t.globl FILE_opdevice\nFILE_opdevice:\n"
    "\t.globl FILE_nametodevice\nFILE_nametodevice:\n"
    "\t.globl FILE_handletodevice\nFILE_handletodevice:\n"
    "\t.globl asynctopupoverride\nasynctopupoverride:\n"
    "\t.globl asyncidle\nasyncidle:\n"
);

int setclipwindow(void)   /* @0x800F6114 : return 0 */
{
    return 0;
}
