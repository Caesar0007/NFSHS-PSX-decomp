/* femenudefs_tail.h -- moved from femenudefs_types.h (FEMenuDefs/Front owner surface): FE3d, Force_tGlobal, AudioMus,
 * MCRDFILE, tScreenMemcard, tScreenUserName (front retail order; mission records: femenudefs_mission.h).  FEMenuDefs includes it right after the
 * tournament standings (NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS); femenudefs_types.h includes it in place (no-op then). */
#ifndef NFS4_FRONTEND_COMMON_FEMENUDEFS_TAIL_H
#define NFS4_FRONTEND_COMMON_FEMENUDEFS_TAIL_H


typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

#include "shared/FE3d_zUV.h"
#include "shared/FE3d_zFacet.h"
#include "shared/FE3d_zObj.h"
#include "shared/Force_tGlobal.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"


#include "shared/MCRDFILE_def.h"


typedef MCRDFILE_def MCRDFILE;

typedef short tArrowLocation[6];
typedef short tTextLocation[5];


#include "cls_tScreenMemcard.h"   /* class tScreenMemcard: no private copy (header-truth 4v) */





























#include "cls_tScreenUserName.h"   /* class tScreenUserName: no private copy (header-truth 4v) */













#endif
