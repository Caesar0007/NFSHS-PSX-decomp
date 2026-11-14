/* AudioTrk private type projection over the shared color graph (foreign-header visibility not established). */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#if !defined(NFS4_GAME_COMMON_AUDIOTRK_TYPES_H)
#define NFS4_GAME_COMMON_AUDIOTRK_TYPES_H
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_COLOR_TRK_ANIM   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#define NFS4_CORE_CCOORD16
#define NFS4_CORE_FULL
#define NFS4_CORE_EA
#define NFS4_TYPES_H   /* this object lists the root type graph itself (retail record order) */
#include "nfs4_core_0_kernel.h"
#include "nfs4_core_1_gpu.h"
#include "nfs4_core_2_shape.h"
#include "nfs4_core_3_cd.h"
#include "game/common/audiotrk_types.h"   /* own types at this point */
#include "nfs4_core_4_tail.h"
#undef NFS4_CORE_EA
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#define NFS4_COLOR_IN_BWSM
#include "audiotrk_types.h"   /* this header again: its NFS4_COLOR_IN_BWSM branch */
#undef NFS4_COLOR_IN_BWSM
#include "color_p6_bo.h"
#include "color_p7_sched.h"
#include "color_p8_car.h"
#include "color_p9_tail.h"
/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail audiotrk.obj (GameSetup_gData is read through its word view) */
#include "shared/POLY_GT4.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/Sched_tSchedule.h"
/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"
#include "shared/Trk_AnimateInst.h"
#define NFS4_AUDIOTRK_A_DONE
#endif
#if defined(NFS4_GAME_COMMON_AUDIOTRK_TYPES_H) && !defined(NFS4_AUDIOTRK_A_DONE) && !defined(NFS4_AUDIOTRK_CD_DONE) && !defined(NFS4_COLOR_IN_BWSM)
#define NFS4_AUDIOTRK_CD_DONE   /* second pass: nfs4_types.h NFS4_CORE_HOOK_AFTER_CD */
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE
#endif














































#if defined(NFS4_COLOR_IN_BWSM) && !defined(NFS4_AUDIOTRK_BWSM_DONE)   /* second pass: color_types.h NFS4_COLOR_HOOK_AFTER_BWSM */
#define NFS4_AUDIOTRK_BWSM_DONE
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
typedef struct {
    coorddef cp;
    u_short nextDelay;
    char patchID, fadeIn;
    short range;
    char minDelay, randomDelay, type;
    signed char chan;
    char minRepeat, randomRepeat;
} AudioElem;
#define NFS4_AUDIOLIST_ELEMS_INLINE   /* CAudioList::Elems() -- retail's CAudioList `this` pair in AudioTrk_PreLoad */
#include "shared/CAudioList.h"
static inline AudioElem *AudioList_Elems(CAudioList *list) { return (AudioElem *)(list + 1); }
#endif
#if defined(NFS4_AUDIOTRK_A_DONE) && !defined(NFS4_AUDIOTRK_B_DONE)
#include "shared/FLARE_PIECE_DEF.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"
#define NFS4_AUDIOTRK_B_DONE


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
