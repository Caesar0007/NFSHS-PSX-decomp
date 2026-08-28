/* Owner-specific type surface for ScreenTournSelect.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H

/* ScreenTournSelect retains the input-key record but not the foreign player
 * enum.  ScreenPost retains both records. */
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#include "fe_player_types.h"
#else
#define tPlayer int
#endif

/* ScreenMemcard is the nearest exact implemented base graph.  Exclude its
 * memory-card, saved-game, audio-song, and FE3d owner records here. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE
#ifdef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
#define NFS4_SCREENMEMCARD_PINKSLIPS_SURFACE
#endif
#include "screenmemcard_types.h"
#ifdef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
#undef NFS4_SCREENMEMCARD_PINKSLIPS_SURFACE
#endif
#undef NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE

/* These foreign enum tags are absent from this owner graph.  Keep the source
 * constants while the extern boundary below preserves their retail names. */
#ifndef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#define tTrophySize int
#define ts_Medium 1
#endif
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
typedef enum tMenuTextState {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
} tMenuTextState;
typedef enum tMenuTextType {
    textType_Title = 0,
    textType_FlybyHelp = 1,
    textType_BorderInfo = 2,
    textType_FramedInfo = 3,
    textType_ScreenInfo = 4,
    textType_ScreenInfoHeader = 5,
    textType_Options = 6,
    textType_FramedMoney = 7,
    textType_PopUpText = 8,
    textType_PopUpTitle = 9,
    textType_PostGame = 10,
    textType_TrackRecords = 11,
    textType_UserNameMenu = 12,
    textType_VideoWall = 13,
    textType_NumTypes = 14,
    textType_Default = 14
} tMenuTextType;
#else
#if !defined(NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE) || \
    defined(NFS4_SCREENPINKSLIPS_TRACKS_SURFACE)
#define tMenuTextState int
#else
typedef enum tMenuTextState {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
} tMenuTextState;
#endif
#ifndef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
#define textState_Selected 1
#define textState_Hilighted 2
#endif
#define tMenuTextType int
#define textType_ScreenInfo 4
#define textType_VideoWall 13
#define textType_Default 14
#endif
#define kPlayerBoth -1

#ifndef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;
#endif

#ifndef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
struct tScreenTournamentStandings : public tScreen {
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    bool gotmoney, gotbonus, gotbilled, fDrawMoney;
    bool fCountedDown, fStartCountdownNOW;
    int fCountSpeed;
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
    tScreenTournamentStandings();
    void Initialize();
    void Cleanup();
    void GetShapeInfo(short &, short &, char **, char **);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void DrawBackground();
#endif
};

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
    void GetShapeInfo(short &, short &, char **, char **);
#endif
};

#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    tScreenPinkSlipStandings();
    void DrawBackground();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};
#else
struct tScreenTournSelect : public tScreen {
    int hVideo, fFrame;
    tTVConfig tvConfigs[8];
    tTVConfig trophyTV[4];
    short fPreviousMovie, fCurrentMovie;
    u_long fStartTicks, fTVTicks;
    short fTransitionDirection;
    char fPreviousTrophy;
    bool fTVsInitialized;
    int PreCalculatedTournamentY, fPrevi;

    tScreenTournSelect();
    ~tScreenTournSelect();
    void GetShapeInfo(short &, short &, char **, char **);
    void Initialize();
    void Cleanup();
    void UpdateVideoWall(tTourneyInfo *);
    void DrawVideoWall();
    void DrawBackground();
    void DrawForeground();
};
#endif

/* tGlobalMenuDefs is owned by FEMenuDefs.obj and has no completed tag here.
 * This exact-offset view exposes only the two iterators read by this owner. */
struct ScreenTournSelect_GlobalMenuDefsCodegenView {
    char _beforeIteratorTournament[0x6a8];
    tListIteratorTournament iteratorTournament;
    char _beforeIteratorSpecialEvent[0x78c - 0x6bc];
    tListIteratorTournament iteratorSpecialEvent;
};
#define tGlobalMenuDefs ScreenTournSelect_GlobalMenuDefsCodegenView
#endif

#endif
