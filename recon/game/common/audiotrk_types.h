/* AudioTrk private type projection over the shared color graph (foreign-header visibility not established). */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#ifndef NFS4_GAME_COMMON_AUDIOTRK_TYPES_H
#define NFS4_GAME_COMMON_AUDIOTRK_TYPES_H
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_COLOR_TRK_ANIM   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail audiotrk.obj (GameSetup_gData is read through its word view) */














#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

#include "shared/SNDSYSCAP.h"





#include "shared/SNDSYSSET.h"






#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Trk_AnimateInst.h"





#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"

struct AudioElem {
    coorddef cp;
    u_short nextDelay;
    char patchID, fadeIn;
    short range;
    char minDelay, randomDelay, type;
    signed char chan;
    char minRepeat, randomRepeat;
};
#define NFS4_AUDIOLIST_ELEMS_INLINE   /* CAudioList::Elems() -- retail's CAudioList `this` pair in AudioTrk_PreLoad */
#include "shared/CAudioList.h"
static inline AudioElem *AudioList_Elems(CAudioList *list) { return (AudioElem *)(list + 1); }

#include "shared/FLARE_PIECE_DEF.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"






#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





struct AudioTrk_tAmbientChannel {
    AudioElem *se;
    int handle, slice;
    short patch, repeat;
};
struct AudioTrk_tGlobals { AudioTrk_tAmbientChannel chan[16]; };

#endif
