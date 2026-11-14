/* audiocmn.obj's exact source-visible delta over the shared AudioClc graph. */
#if !defined(NFS4_GAME_COMMON_AUDIOCMN_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_AUDIOCMN_TYPES_H
#ifndef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES   /* the standalone owner only */
#define NFS4_CORE_SND_FIRST   /* retail: SND* structs ahead of the core (nfs4_types.h) */
#define NFS4_AUDIOCLC_LATE_KERNEL   /* retail: TCB..Skidmark right after tfrontEnd (below) */
#define NFS4_AUDIOCLC_KERNPAIR_LATE   /* retail: kernpair after tTexture_ShapeInfo (below) */
#define NFS4_AFTER_CAR_AUDIOCMN   /* this object's own types come right after Car_tObj (audioclc_types.h lists the common graph) */
#endif
#define NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS
#define NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#define NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#define NFS4_AUDIOCMN_DEFINED_OMIT_INPUT_DEVICE_CALL
#include "audioclc_types.h"

#ifdef NFS4_AUDIOCMN_DEFINED_OMIT_INPUT_DEVICE_CALL
#undef NFS4_AUDIOCMN_DEFINED_OMIT_INPUT_DEVICE_CALL
#undef NFS4_AUDIOCLC_OMIT_INPUT_DEVICE_CALL
#endif
#undef NFS4_AUDIOCLC_OMIT_AUDIOCLC_ONLY_TYPES
#undef NFS4_AUDIOCLC_OMIT_S_TYPE_ALIAS
#endif
#if defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES) && !defined(NFS4_AUDIOCMN_EARLY_DONE)   /* owner pass from color_types.h (after Car_tObj) */
#define NFS4_AUDIOCMN_EARLY_DONE
#include "shared/SndBnk_t.h"
#include "audiocmn_types_d1.h"
#include "shared/AudioMus_tSongEntry.h"
#endif
#if !defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_AUDIOCMN_TAIL_DONE)   /* first pass, after audioclc_types.h */
#define NFS4_AUDIOCMN_TAIL_DONE


#include "shared/SNDPLAYOPTS.h"






#include "shared/AudioMus_tSongEntry.h"





#if !defined(NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST) && defined(NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES)   /* audiocmn itself: after tfrontEnd (below) */
#include "shared/CopSpeak_tRequest.h"
#endif











#include "shared/Sim_tSimGlobalVar.h"



#include "shared/tReplayInterface.h"
#ifdef NFS4_GAME_COMMON_NFS3_TYPES_H   /* an includer's own types right before the frontend block (nfs3.obj: Speech classes, tTexture, kernpair) */
#include "nfs3_types.h"
#endif
#include "shared/tTexture_ShapeInfo.h"
#if defined(NFS4_AUDIOCLC_KERNPAIR_LATE) && (!defined(NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES) || defined(NFS4_COPSPEAK_KERNPAIR_AFTER_TEX))   /* retail audiocmn/copspeak: kernpair right after tTexture_ShapeInfo */
#include "shared/kernpair.h"
#include "audiocmn_types_d2.h"
#endif










#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (was a reduced enumerator list; header-truth 8a) */







struct tMenuCommand;
struct tMenu;
struct tScreen;

#include "shared/fe_menu_game_surface.h"






























#include "shared/tCarModels.h"




















#include "shared/tCarInfo.h"
#include "shared/tOwnedCarInfo.h"
#ifdef NFS4_GAME_COMMON_NFS3_TYPES_H
#define NFS4_AUDIOCMN_IN_CAR 1
#include "nfs3_types.h"
#undef NFS4_AUDIOCMN_IN_CAR
#else   /* retail (every object): tCarNameLength right after tOwnedCarInfo, tPersonalities right after tCarManager */
#include "shared/tCarNameLength.h"


#endif
#include "../../frontend/common/fecars_manager.h"   /* class tCarManager: no private copy (header-truth 4k) */



















#ifdef NFS4_GAME_COMMON_NFS3_TYPES_H
#define NFS4_AUDIOCMN_IN_CAR 2
#include "nfs3_types.h"
#undef NFS4_AUDIOCMN_IN_CAR
#else
#include "shared/tPersonalities.h"






#endif













#include "shared/tfrontEnd.h"
#ifndef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES   /* retail audiocmn: CopSpeak_tRequest right after tfrontEnd */
#include "shared/CopSpeak_tRequest.h"
#endif
#if defined(NFS4_AUDIOCLC_LATE_KERNEL) && !defined(NFS4_AUDIOCMN_KERNEL_LATER)   /* retail cars/audiocmn: the kernel/skidmark types right after tfrontEnd */
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#endif
#ifndef NFS4_AUDIOCMN_OMIT_OWNER_ONLY_TYPES   /* retail: after the kernel/skidmark types */
#include "audiocmn_types_d3.h"
#endif






















/* Header typedef rows retained by audiocmn.obj. The record-buffer body is a
 * compiler carrier for the public array typedef; the linked owner attributes
 * that completed tag elsewhere. */
#ifndef NFS4_AUDIOCMN_OMIT_SAVE_RECORDS
#include "shared/tRecordBuffer.h"
#include "audiocmn_types_d4.h"
#endif
#include "audiocmn_types_d5.h"

#endif
