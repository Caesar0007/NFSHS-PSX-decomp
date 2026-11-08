#if !defined(NFS4_GAME_COMMON_NFS3_TYPES_H)
#define NFS4_GAME_COMMON_NFS3_TYPES_H   /* nfs3.obj's exact source-visible delta over the shared CopSpeak graph. */
#define NFS4_PADS_HOOK_AFTER "nfs3_types.h"   /* retail nfs3.obj: scheduler + GameSetup records right after PAD_COMMON */
#define NFS4_PADS_HOOK_BEFORE "nfs3_types.h"   /* retail: tNfsSystemInfo right after CCOORD16, before the pads */
#define NFS4_COLOR_HOOK_AFTER_CAR "nfs3_types.h"   /* retail: forceFocus_t, BW_tContext right after Car_tObj */
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
#define NFS4_AUDIOCMN_DECLARE_CAR_MANAGER_METHODS
#include "copspeak_types.h"
#undef NFS4_AUDIOCMN_DECLARE_CAR_MANAGER_METHODS
#undef NFS4_AUDIOCMN_KEEP_INPUT_DEVICE_CALL
#undef NFS4_COPSPEAK_KEEP_BW_CONTEXT
#undef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
typedef enum tTrackClassType {
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
} tTrackClassType;



#include "shared/Sim_tSimSystemVar.h"















struct tMenuCommand;
struct tMenu;
/* this owner defines neither tPlayer nor tInputKeyType: the int spellings it always used */






#include "shared/tCarLineup.h"







#include "shared/tTrackInformation.h"











struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];

    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
};

#include "shared/tTierInfo.h"




#include "shared/tTourneyInfo.h"














#include "shared/tTrackInfo.h"








#include "shared/tTournamentDefinition.h"





#include "shared/tAwardInformation.h"


















#include "shared/tCompetitor.h"








typedef struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65]; short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
#include "shared/tTournamentManager_inl.h"   /* retail in-class inline bodies (see file) */

    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
} tTournamentManager;

#include "shared/tMissionTierInfo.h"



#include "shared/tMissionInfo.h"







#include "shared/tStageInfo.h"









#include "shared/tAcademyDefinition.h"





struct tMissionManager {
    char fNumTiers;
    tAcademyDefinition *fDefinition;

    void Initialize();
    void LoadDescription(bool LoadHotPursuit);
    void ReleaseDescription();
};

#include "shared/TCB.h"   /* retail nfs3.obj: kernel/skidmark types after tMissionManager */
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/tActiveLine.h"





#define tPlayer int
#define tInputKeyType int
#include "frontend/common/fedialog.h"
#undef tPlayer
#undef tInputKeyType







#include "shared/tCredit.h"






struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    bool fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    bool StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;
};

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
enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};
#define NFS4_FORCE_FOCUS_DONE
#include "shared/BW_tContext.h"
#elif defined(NFS4_NFS3_CAR_DONE) && !defined(NFS4_NFS3_FE_DONE)
#define NFS4_NFS3_FE_DONE
#include "speech_class.h"
#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"
typedef kernpair KERN;
#elif defined(NFS4_AUDIOCMN_IN_CAR) && NFS4_AUDIOCMN_IN_CAR == 1
typedef enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
} tCarClassType;
enum tCarNameLength {
    cnl_Medium = 0, cnl_Short = 1, cnl_Long = 2
};
#elif defined(NFS4_AUDIOCMN_IN_CAR) && NFS4_AUDIOCMN_IN_CAR == 2
enum tPersonalities {
    kPersonalityNemesis = 0, kPersonalityBlurrr = 1,
    kPersonalityZippy = 2, kPersonalityJetBoy = 3,
    kPersonalityMenace = 4, kPersonalityCop1 = 5,
    kPersonalityCop2 = 6, kPersonalityCop3 = 7,
    kPersonalityTraffic = 8, kPersonalityNUM = 9
};
#include "shared/tCarLineup.h"
#elif defined(NFS4_NFS3_FE_DONE) && !defined(NFS4_NFS3_LI_DONE)   /* fe_menu_game_surface.h hook 1 */
#define NFS4_NFS3_LI_DONE
struct tListIteratorIndexed : public tListIterator { char *fIndex; };
#elif defined(NFS4_NFS3_LI_DONE) && !defined(NFS4_NFS3_SCR_DONE)   /* hook 2 (tPlayer/tInputKeyType are int inside the surface) */
#define NFS4_NFS3_SCR_DONE
#include "shared/tShapeInformation.h"
struct tMenuCommand;
struct tMenu;
#include "frontend/common/fescreen.h"
#endif
