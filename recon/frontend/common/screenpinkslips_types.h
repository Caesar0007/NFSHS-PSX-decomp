#ifndef NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_TYPES_H   /* Owner-specific type surface for ScreenPinkSlips.obj. */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#include "screenpinkslips_keys.h"   /* FE_COLOR_LATE, COLOR_BEFORE_CARS, SND/CCOORD16/car keys, mission+TV hook */
/* (ScreenTracks: screentracks_types.h) */
#endif
#define NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
#include "screentournselect_types.h"
#undef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE

#define BOOL int
#define textType_FlybyHelp 1
#define RaceType_HotPursuit 1

struct tMenuCommand;

#include "shared/tRecordBuffer.h"

typedef tRecordBuffer tSaveRecords[187];

#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#include "shared/FLARE_PIECE_DEF.h"
#endif

#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#include "shared/tMissionTierInfo.h"
#include "shared/tMissionInfo.h"
#include "shared/tStageInfo.h"
#include "shared/tAcademyDefinition.h"

#include "screenpinkslips_feapp.h"   /* no-op when the early-dialogs hook already emitted it */






















#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
#include "screenpinkslips.h"
#endif

#ifndef NFS4_SCREENPINKSLIPS_TRACKS_SURFACE
struct ScreenPinkSlips_GlobalMenuDefsCodegenView {
    char _beforeIteratorTrack[0xc88];
    tListIteratorTrack iteratorTrack;
    char _beforeItemTraffic[0xf4c - 0xca0];
    tMenuItemOptionsTwoItemChoice itemTraffic, itemLocalSpeech;
};
#define tGlobalMenuDefs ScreenPinkSlips_GlobalMenuDefsCodegenView
#endif

#endif
