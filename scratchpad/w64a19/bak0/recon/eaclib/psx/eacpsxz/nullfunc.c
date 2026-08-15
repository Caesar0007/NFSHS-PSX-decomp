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
 *       are emitted as GNU-as symbol assignments `name = setclipwindow` in a file-scope __asm__ instead:
 *       real globals at the same address that do NOT displace setclipwindow as objdump's disasm label.
 */

extern int setclipwindow(void)   /* @0x800F6114 : return 0 */
{
    return 0;
}

/* the 20 other co-equal XDEF names at 0x800F6114 (gcc-2.8.0-safe alias mechanism) */
__asm__(
    "\t.globl setmousesensitivity\n\tsetmousesensitivity = setclipwindow\n"
    "\t.globl nullfunctionz\n\tnullfunctionz = setclipwindow\n"
    "\t.globl restorewindow\n\trestorewindow = setclipwindow\n"
    "\t.globl resetclipwindow\n\tresetclipwindow = setclipwindow\n"
    "\t.globl nullwindow\n\tnullwindow = setclipwindow\n"
    "\t.globl savewindow\n\tsavewindow = setclipwindow\n"
    "\t.globl removewindow\n\tremovewindow = setclipwindow\n"
    "\t.globl purgekey\n\tpurgekey = setclipwindow\n"
    "\t.globl nullfunction\n\tnullfunction = setclipwindow\n"
    "\t.globl createwindowadr\n\tcreatewindowadr = setclipwindow\n"
    "\t.globl createshapeadr\n\tcreateshapeadr = setclipwindow\n"
    "\t.globl FILE_resize\n\tFILE_resize = setclipwindow\n"
    "\t.globl librestoremouse\n\tlibrestoremouse = setclipwindow\n"
    "\t.globl shapewindowdefadr\n\tshapewindowdefadr = setclipwindow\n"
    "\t.globl FILE_delete\n\tFILE_delete = setclipwindow\n"
    "\t.globl FILE_opdevice\n\tFILE_opdevice = setclipwindow\n"
    "\t.globl FILE_nametodevice\n\tFILE_nametodevice = setclipwindow\n"
    "\t.globl FILE_handletodevice\n\tFILE_handletodevice = setclipwindow\n"
    "\t.globl asynctopupoverride\n\tasynctopupoverride = setclipwindow\n"
    "\t.globl asyncidle\n\tasyncidle = setclipwindow\n"
);
