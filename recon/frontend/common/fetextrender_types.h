/* Owner-specific type surface for FETextRender.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETEXTRENDER_TYPES_H
#define NFS4_FRONTEND_COMMON_FETEXTRENDER_TYPES_H
#ifndef NFS4_FE_COLOR_LATE
#include "../../game/common/color_types.h"
#endif
#include "shared/tMenuTextType.h"   /* one tMenuTextType definition (header-truth 4-C.1) */


















#include "shared/tMenuTextState.h"   /* one tMenuTextState definition (header-truth 4-C.1) */






#define NFS4_FE_CORE_NO_CAR_TYPES
#include "fe_core_types.h"
#undef NFS4_FE_CORE_NO_CAR_TYPES

#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER

#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
struct tMenu;
#include "fescreen.h"
#include "shared/tActiveLine.h"
#include "fedialog.h"

#include "feapp_class.h"   /* class tFEApplication: no private copy (header-truth 4j) */






















#endif
