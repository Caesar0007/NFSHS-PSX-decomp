/* frontend/psx/mmeffect_externs.h - reconstructed extern decls (libgpu + render globals)
 * referenced by MMEFFECT.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MMEFFECT_EXTERNS_H_
#define _FRONTEND_PSX_MMEFFECT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* GPU packet build cursors (byte-addressable), shared with PSXFRONT.CPP */
extern u_char *Render_gPacketPtr;    /* GPU packet build cursor (byte-arith) */
extern u_char *Render_gPalettePtr;   /* GPU packet build cursor (byte-arith) */

extern "C" {
/* PsyQ libgpu */
}
#endif
