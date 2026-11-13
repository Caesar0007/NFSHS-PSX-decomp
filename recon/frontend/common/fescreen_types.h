#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* Owner-specific type tail for FEScreen.obj. */
#ifndef NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H
#define NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H
#define NFS4_FE_LIST_NO_INDEXED   /* retail FEScreen object: tListIterator + Range only */

struct tMenu;

#include "fe_input_enums.h"   /* retail: tPlayer, tInputKeyType first */
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */












#include "shared/tMenuCommand.h"
#define NFS4_FE_CORE_FELINES_LATE   /* retail FEScreen: frontend core before the MATRIX core */
#define NFS4_FE_CORE_CARS_LATE   /* retail: car tail after the dialogs */
#include "fe_core_types.h"
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "fescreen_transition.h"   /* retail FEScreen.obj: tScreen_TransitionType before tShapeInformation */
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "../../link_stripped.h"
#include "fescreen.h"
#include "shared/tDrawShapeExtended.h"
#include "fedialog.h"
#include "fe_core_cars.h"

#endif
