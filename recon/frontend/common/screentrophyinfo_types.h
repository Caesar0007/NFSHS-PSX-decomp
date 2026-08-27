/* Owner-specific type surface for ScreenTrophyInfo.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H

/* The retail owner contains color.obj's complete 71-record graph. */
#include "../../game/common/color_types.h"

/* ScreenTrophyInfo retains the tournament/track layouts, but not the foreign
 * tPlayer method surface carried by FETracks. */
#define NFS4_FE_TRACK_NO_PLAYER
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
};

/* These menu records are retained by the original screen header even though
 * this implementation does not instantiate them directly. */
struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(void *);
};

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
};

struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;
};

struct tShapeInformation {
    tTexture_ShapeInfo *fShapes;
    char *fFile, *fDestFile;
    unsigned int async_handle;
    u_short fNumShapes, fFlags;
    char fFilename[16];
    bool fLoadCancelled;
};

struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
    __vtbl_ptr_type (*_vf)[10];

    inline int &TrophyRoomTierView() {
        return *(int *)((char *)this + 0xd0);
    }
    inline short *TrophyRoomCurrentView() {
        return (short *)((char *)this + 0xd4);
    }
};

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

struct tScreenTrophyInfo : public tScreen {
    int BannerCol;

    void GetShapeInfo(short &numPermShapes, short &numSwapShapes,
                      char **permFileName, char **swapFileName);
    void DrawBackground();
};

/* ScreenTrophyRoom is only an external pointer here.  Its two accessed tail
 * fields are exposed through the storage-neutral tScreen inline views above,
 * avoiding a foreign debug record in this owner. */
#define tScreenTrophyRoom tScreen

#endif
