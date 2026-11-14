#if !defined(NFS4_GAME_COMMON_NFS3_TYPES_H)
#define NFS4_GAME_COMMON_NFS3_TYPES_H   /* nfs3.obj's exact source-visible delta over the shared CopSpeak graph. */
#define NFS4_PADS_HOOK_AFTER "nfs3_types.h"   /* retail nfs3.obj: scheduler + GameSetup records right after PAD_COMMON */
#define NFS4_PADS_HOOK_BEFORE "nfs3_types.h"   /* retail: tNfsSystemInfo right after CCOORD16, before the pads */
#define NFS4_AFTER_CAR_NFS3   /* this object's own types come right after Car_tObj (audioclc_types.h lists the common graph) */
#define NFS4_AUDIOCMN_HOOK_BEFORE_FE "nfs3_types.h"   /* retail: Speech classes, tTexture_ShapeInfo, kernpair before the frontend block */
#define NFS4_AUDIOCLC_LATE_KERNEL
#define NFS4_AUDIOCMN_KERNEL_LATER
#define NFS4_AUDIOCLC_KERNPAIR_LATE
#define NFS4_AUDIOCMN_CAR_ORDER "nfs3_types.h"   /* retail: tCarClassType tCarNameLength after tOwnedCarInfo; tPersonalities tCarLineup after tCarManager */
#define NFS4_FE_SURFACE_HOOK "../game/common/nfs3_types.h"   /* retail: tListIteratorIndexed after tListIterator, tScreen after tMenuItemInteractive */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */

#define cheat_Roadster 0
#define kFront_InitialLoad 0

#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_BEFORE_GS   /* retail type order (game/common/color_types.h) */
#define NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#define NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#define NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#define NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#define NFS4_COPSPEAK_KEEP_BW_CONTEXT
#define NFS4_AUDIOCMN_KEEP_INPUT_DEVICE_CALL
#include "copspeak_types.h"
#undef NFS4_AUDIOCMN_KEEP_INPUT_DEVICE_CALL
#undef NFS4_COPSPEAK_KEEP_BW_CONTEXT
#undef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#include "shared/tTrackClassType.h"   /* one tTrackClassType definition (header-truth 4t) */









#include "shared/Sim_tSimSystemVar.h"















struct tMenuCommand;
struct tMenu;
/* this owner defines neither tPlayer nor tInputKeyType: the int spellings it always used */






#include "shared/tCarLineup.h"







#include "shared/tTrackInformation.h"











#include "shared/tTrackManager.h"   /* one tTrackManager definition (header-truth 4t) */









#include "shared/tTierInfo.h"




#include "shared/tTourneyInfo.h"














#include "shared/tTrackInfo.h"








#include "shared/tTournamentDefinition.h"





#include "shared/tAwardInformation.h"


















#include "shared/tCompetitor.h"








#include "../../frontend/common/fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */





















#include "shared/tMissionTierInfo.h"



#include "shared/tMissionInfo.h"







#include "shared/tStageInfo.h"









#include "shared/tAcademyDefinition.h"





#include "shared/tMissionManager.h"   /* one tMissionManager definition (header-truth 4t) */








#include "shared/TCB.h"   /* retail nfs3.obj: kernel/skidmark types after tMissionManager */
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/tActiveLine.h"



#include "shared/tShapeInformation.h"
struct tMenuCommand;
struct tMenu;
#include "frontend/common/fescreen.h"
#include "frontend/common/fedialog.h"









#include "shared/tCredit.h"






#include "shared/tCreditManager.h"   /* one tCreditManager definition (header-truth 4t) */








#include "shared/tRecordBuffer.h"




typedef tRecordBuffer tSaveRecords[187];
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#elif defined(NFS4_PADS_IN_HOOK_BEFORE) && !defined(NFS4_NFS3_PADSB_DONE)
#define NFS4_NFS3_PADSB_DONE
typedef struct tNfsSystemInfo { int userRam; } tNfsSystemInfo;
#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_NFS3_PADS_DONE)
#define NFS4_NFS3_PADS_DONE
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE
#include "gamesetup_leaf_types.h"
#elif defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_NFS3_CAR_DONE)
#define NFS4_NFS3_CAR_DONE
#include "shared/forceFocus_t.h"




#define NFS4_FORCE_FOCUS_DONE
#include "shared/BW_tContext.h"
#elif defined(NFS4_NFS3_CAR_DONE) && !defined(NFS4_NFS3_FE_DONE)
#define NFS4_NFS3_FE_DONE
#include "speech_class.h"
#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"
typedef kernpair KERN;
#elif defined(NFS4_AUDIOCMN_IN_CAR) && NFS4_AUDIOCMN_IN_CAR == 1
#ifndef NFS4_TCARCLASSTYPE_DEFINED
#define NFS4_TCARCLASSTYPE_DEFINED
typedef enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
} tCarClassType;
#endif
#include "shared/tCarNameLength.h"


#elif defined(NFS4_AUDIOCMN_IN_CAR) && NFS4_AUDIOCMN_IN_CAR == 2
#include "shared/tPersonalities.h"






#include "shared/tCarLineup.h"
#elif defined(NFS4_NFS3_FE_DONE) && !defined(NFS4_NFS3_LI_DONE)   /* fe_menu_game_surface.h hook 1 */
#define NFS4_NFS3_LI_DONE

#elif defined(NFS4_NFS3_LI_DONE) && !defined(NFS4_NFS3_SCR_DONE)   /* hook 2 (tPlayer/tInputKeyType are int inside the surface) */
#define NFS4_NFS3_SCR_DONE




#endif
