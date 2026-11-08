/* femenudefs_core_late.h -- FEMenuDefs owner hook (NFS4_SCREENDISPLAY_HOOK_BEFORE_LEAF2, with NFS4_CORE_LINEDEF_LATE):
 * retail FEMenuDefs emits tActiveLine, the controller pads, linedef and SHAPETABLEENTRY right after tScreen, before
 * PCOORD16 .. Draw_CarVertex (the nfs4_types.h block, same lines). */
#include "shared/tActiveLine.h"
#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"
#include "shared/linedef.h"
typedef struct linedef LINE;
#define NFS4_HAVE_LINE
#include "shared/SHAPETABLEENTRY.h"
