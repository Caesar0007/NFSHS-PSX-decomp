#if !defined(NFS4_GAME_COMMON_AUDIOCLC_TYPES_H)
#define NFS4_GAME_COMMON_AUDIOCLC_TYPES_H   /* audioclc.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE   /* speech.obj omits Sched_tSchedule */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#endif
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#define NFS4_COLOR_TRK_ANIM   /* retail type order (game/common/color_types.h) */
#define NFS4_AFTER_CAR_AUDIOCLC   /* this object's own types come right after Car_tObj (audioclc_types.h lists the common graph) */
#endif
#ifndef NFS4_GAME_COMMON_COLOR_TYPES_H   /* the parts of the common type graph; the object being compiled has its own types right after Car_tObj */
#define NFS4_GAME_COMMON_COLOR_TYPES_H
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#include "color_p7_sched.h"
#include "color_p8_car.h"
#define NFS4_COLOR_IN_HOOK2
#if defined(NFS4_AFTER_CAR_AUDIOCLC)
#include "audioclc_types.h"
#elif defined(NFS4_AFTER_CAR_AUDIOCMN)
#include "audiocmn_types.h"
#elif defined(NFS4_AFTER_CAR_COPSPEAK)
#include "copspeak_types.h"
#elif defined(NFS4_AFTER_CAR_CARS)
#include "cars_types.h"
#elif defined(NFS4_AFTER_CAR_NFS3)
#include "nfs3_types.h"
#endif
#undef NFS4_COLOR_IN_HOOK2
#include "color_p9_tail.h"
#endif
#define RaceType_HotPursuit 1
#define RaceType_Id5 5
/* The completed s_type enum is absent from audioclc.obj; it survives only in
 * two external C++ function names. */
#ifndef NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS
#define s_type int
#endif
#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#if !defined(NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES) && !defined(NFS4_AUDIOCLC_LATE_SYS)
#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"
#include "shared/SNDSAMPLEFORMAT.h"
#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES   /* retail audioclc.obj: forceFocus_t right after the SND structs */
#include "shared/forceFocus_t.h"
#define NFS4_FORCE_FOCUS_DONE
#endif
#endif

#ifndef NFS4_AUDIOCLC_OMIT_SCHED_SCHEDULE
#include "shared/Sched_tSchedule.h"

#endif

#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#include "shared/Trk_AnimateInst.h"

#endif

#ifndef NFS4_AUDIOCLC_OMIT_SCENE_TYPES
#include "shared/SceneElem.h"



#include "shared/SceneSortedElem.h"
#endif
#if !defined(NFS4_AUDIOCLC_LATE_SYS) && !defined(NFS4_AUDIOCLC_LATE_KERNEL)   /* speech: after the Speech classes; cars/audiocmn: after tfrontEnd (audiocmn_types.h) */
#include "shared/TCB.h"

#include "shared/EXEC.h"




#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"
#endif




#ifdef NFS4_AUDIOCLC_OMIT_FORCE_FOCUS
#define forceFocus_t int
#elif !defined(NFS4_FORCE_FOCUS_DONE)   /* nfs3.obj emits it right after Car_tObj (nfs3_types.h) */




#include "shared/forceFocus_t.h"








#endif
#if !defined(NFS4_AUDIOCLC_LATE_SYS) && !defined(NFS4_AUDIOCLC_KERNPAIR_LATE)   /* nfs3: kernpair after tTexture_ShapeInfo */
#include "shared/kernpair.h"
#endif




#ifndef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#include "audioclc_types_d1.h"
#endif

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#if defined(NFS4_GAME_COMMON_SPEECH_TYPES_H) || defined(NFS4_GAME_COMMON_CARS_TYPES_H) || \
    (defined(NFS4_GAME_COMMON_AUDIOCMN_TYPES_H) && !defined(NFS4_GAME_COMMON_COPSPEAK_TYPES_H))   /* carInfo[var] users keep the struct; audioclc/copspeak.obj record none */
#include "shared/GameSetup_tData.h"
#endif
















#ifndef NFS4_AUDIOCLC_OMIT_CAMERA_VIEW
#include "shared/camera_info.h"




























#endif
#include "audioclc_types_d2.h"
#ifndef NFS4_AUDIOCLC_OMIT_CARLOGIC_OBSERVATIONS
#include "audioclc_types_d3.h"
#endif
#ifndef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#include "audioclc_types_d4.h"
#endif
#if !defined(NFS4_AUDIOCLC_LATE_SYS) && !defined(NFS4_AUDIOCLC_KERNPAIR_LATE)   /* speech_types.h declares KERN after kernpair; nfs3 in its FE pass */
#include "audioclc_types_d5.h"
#endif
#include "audioclc_types_d6.h"

#elif defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_AUDIOCLC_CAR_DONE)   /* second pass: color_types.h AFTER_CAR */
#define NFS4_AUDIOCLC_CAR_DONE
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#endif
