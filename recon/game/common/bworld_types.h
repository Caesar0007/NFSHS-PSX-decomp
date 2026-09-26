/* bworld.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_BWORLD_TYPES_H
#define NFS4_GAME_COMMON_BWORLD_TYPES_H

/* DrawW.obj supplies the exact 106-definition shared graph.  These fourteen
 * completed records belong only to DrawW and are absent from bworld.obj. */
#define NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "../psx/draww_types.h"
#undef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES

#include "shared/Trk_SFX.h"




struct BW_tContextMgr {
    int initialized, count;
    BW_tContext contexts[2];
};

/* Canonical bworldSm.obj aggregate used by this translation unit. */
#include "shared/Trk_NewSlice.h"







/* Canonical camera.obj aggregate used by this translation unit. */
#include "shared/camera_info.h"





























/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















/* Canonical trackspec.obj aggregate used by this translation unit. */
#include "shared/CTrackSpec.h"











#include "shared/Draw_FlareCache.h"

#include "shared/Draw_tGiveShelbyMoreCache.h"


























typedef int CarLogic_tObservations[1][3];
#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5

#endif
