#ifndef NFS4_GAME_COMMON_CAMERA_TYPES_H
#define NFS4_GAME_COMMON_CAMERA_TYPES_H   /* Camera private type projection; owner-derived foreign bodies are noted below. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_COLOR_TRK_ANIM   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#define RaceType_HotPursuit 1
#define RaceType_Id5 5
/* Owner-derived bworldSm type: SYM1cec71..1cedc3,32 bytes. Camera's
 * surviving type stream does not preserve this foreign body; its original
 * header visibility remains a source-recovery question, not a sealed claim. */
#include "shared/Trk_NewSlice.h"






/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















struct Sched_tSchedule;
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




#include "shared/tReplayInterface.h"




/* Owner-derived replay type (SYM326706..32678F); camera.obj's own type
 * stream does not retain this foreign body. This is not a caller-graph seal. */
#include "shared/tReplayCameraModes.h"



#include "shared/forceFocus_t.h"





#include "shared/Sched_tSchedule.h"





#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

#include "shared/Trk_AnimateInst.h"





#include "shared/DRender_tView.h"




#include "shared/camera_info.h"





























struct camera_flags {
    coorddef arm;
    int pitch : 1;
    int jostling : 1;
    int tracking : 1;
    int checkwalls : 1;
    int noLookBack : 1;
    int checkcollisions : 1;
};

#include "shared/Camera_tCamSlot.h"
#include "aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */




























#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"
#include "shared/kernpair.h"   /* retail camera.obj: kernpair after the Skidmark types */





typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef camera_info Camera_tInfo;
typedef camera_flags Camera_tFlags;

#endif
