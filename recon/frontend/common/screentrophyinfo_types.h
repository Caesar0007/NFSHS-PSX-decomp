#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H   /* Owner-specific type surface for ScreenTrophyInfo.obj. */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_LIST_NO_RANGE_INDEXED   /* retail ScreenTrophyInfo object: tListIterator, Indexed, Range */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: menu core (tMenuCommandType..tScreen) BEFORE the MATRIX core */
#define NFS4_FE_CORE_CARS_LATE    /* cars after the screen records, then tracks, then color */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_core_types.h"
struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(void *);
};
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
struct tMenu;
#include "fescreen.h"
#include "screentrophyinfo.h"
#include "shared/tDrawShapeExtended.h"
#include "fe_core_cars.h"
/* ScreenTrophyInfo retains the tournament/track layouts, but not the foreign tPlayer method surface carried by FETracks. */
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
/* Source spellings/constants that do not create records in this owner. */
#define byte unsigned char
#define uint unsigned int
#define ts_Large 2
#define textState_Hilighted 2
#define textType_ScreenInfo 4
struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65];
    short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
    /* ORIGINAL-NAME-UNRESOLVED: inferred receiver-free definition accessor. */
    tTournamentDefinition *Definition() { return fDefinition; }
};
#ifndef NFS4_FE_COLOR_LATE   /* The retail owner contains color.obj's complete 71-record graph (after the tracks). */
#include "../../game/common/color_types.h"
#endif
/* These menu records are retained by the original screen header even though this implementation does not instantiate them directly. */
struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
};

struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;
};








/* ScreenTrophyRoom is only an external pointer here; the two fields this owner reads are `tier` and `fRealCurrentTourn`,
 * at the offsets the retail SYM records for the class (size 344). */
#include "screentrophyroom.h"
#endif
