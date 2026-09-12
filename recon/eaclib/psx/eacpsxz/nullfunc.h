#ifndef _NULLFUNC_H_
#define _NULLFUNC_H_

#include "eac_types.h"

/* nullfunc.obj exports TWENTY-ONE co-equal names for ONE 2-insn body
 * (`jr $ra; addu $v0,$zero,$zero` == return 0) at 0x800F6114: the PSX release
 * build reduced a pile of window/mouse/shape/FILE/async API entry points to a
 * single do-nothing-return-0 stub.  `setclipwindow` is the canonical name (the
 * one the oracle disassembly labels and the gate verifies). */

extern int setclipwindow(void);   /* @0x800F6114 */
extern int asyncidle(void);       /* @0x800F6114 -- same body; see nsync.c */

/* The remaining 19 co-equal names are EXPORTED SYMBOLS WITH NO CONSUMER in this
 * tree, so no prototype is declared for them here.  Each had its own signature
 * in EA's original headers (`FILE_delete(name)`, `setmousesensitivity(int)`,
 * `savewindow(...)`, ...), and none of it is recoverable: the bodies collapsed
 * onto the shared stub, and there is no call site left to count argument
 * registers at.  A prototype written now would be invention, not
 * reconstruction -- so if a consumer is ever found, take the signature from
 * THAT call site and add it here then.
 *
 *   asynctopupoverride  createshapeadr       createwindowadr   FILE_delete
 *   FILE_handletodevice FILE_nametodevice    FILE_opdevice     FILE_resize
 *   librestoremouse     nullfunction         nullfunctionz     nullwindow
 *   purgekey            removewindow         resetclipwindow   restorewindow
 *   savewindow          setmousesensitivity  shapewindowdefadr
 *
 * All 21 are emitted as real globals by the file-scope __asm__ block in
 * nullfunc.c; `objdump -t` must show every one of them as `.text+0 size 8`. */

#endif
