/* frontend/psx/mmeffect_externs.h - reconstructed extern decls (libgpu + render globals)
 * referenced by MMEFFECT.CPP. NOT an original header; added for standalone C++ compile. */
#ifndef _FRONTEND_PSX_MMEFFECT_EXTERNS_H_
#define _FRONTEND_PSX_MMEFFECT_EXTERNS_H_
#include "mmeffect_types.h"

extern "C" int GetTPage(...);
extern "C" void SetDrawMode(...);

/* GPU packet build cursors (byte-addressable), shared with PSXFRONT.CPP */

extern "C" {
/* PsyQ libgpu */
}
/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x800127C8): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

#endif
