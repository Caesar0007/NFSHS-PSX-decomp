/* eaclib/psx/pad.h - reconstructed declarations for PAD.C (compiled as pad.cpp) */
#ifndef _EACLIB_PSX_PAD_H_
#define _EACLIB_PSX_PAD_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* PAD.C is a C source (D:\nfs4\EACLIB\PSX\PAD.C) - its 4 exported symbols are UNMANGLED
 * in the SYM (padinit / PAD_restore / PAD_state / PAD_update). When compiled as C++ we
 * keep C linkage via extern "C" so the symbol names stay identical to the SYM.
 * (PAD_convert is SYM class STAT = file-local static -> declared inside pad.cpp, not here.)
 * Return types are SYM-faithful: padinit/PAD_restore = void (SYM FCN VOID; the earlier
 * 'int' came from a decompiler $v0-liveness artifact, not a real source local). */
#ifdef __cplusplus
extern "C" {
#endif

void    padinit(void);          /* :66  EXT FCN VOID   */
void    PAD_restore(void);      /* :83  EXT FCN VOID   */
u_short PAD_state(int padID);   /* :172 EXT FCN USHORT */
void    PAD_update(void);       /* :320 EXT FCN VOID   */

#ifdef __cplusplus
}
#endif

/* ---- pad.obj data globals (eaclib/psx, from canonical Globals) ---- */
extern PAD_COMMON      Padglobal[2];    /* 0x8013e8f0  per-port pad buffers   */
extern tPadModuleState gPadinfo;        /* 0x8013e89c  module state (84 B)    */

#endif /* _EACLIB_PSX_PAD_H_ */
