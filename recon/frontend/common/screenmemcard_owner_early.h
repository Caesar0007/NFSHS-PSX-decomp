/* frontend/common/screenmemcard_owner_early.h -- ScreenMemcard.obj owner records that retail emits right after tActiveLine
 * (screendisplay_types.h NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE hook).  Shared one-definition headers only: the later
 * includes in screenmemcard_types.h become no-ops. */
#ifndef NFS4_FRONTEND_COMMON_SCREENMEMCARD_OWNER_EARLY_H
#define NFS4_FRONTEND_COMMON_SCREENMEMCARD_OWNER_EARLY_H
#include "shared/FE3d_zUV.h"
#include "shared/FE3d_zFacet.h"
#include "shared/FE3d_zObj.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "mcrd_productloc.h"
#include "shared/CARDINFO_def.h"
#include "shared/MCRDFILE_def.h"
#include "mcrd_managertask.h"
#include "shared/MCRDFILEHEADER_def.h"
#include "shared/MCRDFILEINFO_def.h"
#define NFS4_SCREENMEMCARD_IN_CLASS_PASS   /* retail: tScreenMemcard right after MCRDFILEINFO_def, before kernpair */
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_IN_CLASS_PASS
#include "felines_kern.h"   /* retail: kernpair/KERN right after tScreenMemcard (NFS4_FELINES_KERNPAIR_LATE) */
#include "shared/kernpair.h"
#include "shared/tDrawShapeExtended.h"
#endif
