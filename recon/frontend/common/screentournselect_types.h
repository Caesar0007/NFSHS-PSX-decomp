/* Owner-specific type surface for ScreenTournSelect.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H

/* This owner retains the input-key record but not the foreign player enum. */
#define tPlayer int

/* ScreenMemcard is the nearest exact implemented base graph.  Exclude its
 * memory-card, saved-game, audio-song, and FE3d owner records here. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE

/* These foreign enum tags are absent from this owner graph.  Keep the source
 * constants while the extern boundary below preserves their retail names. */
#define tTrophySize int
#define ts_Medium 1
#define tMenuTextState int
#define textState_Selected 1
#define textState_Hilighted 2
#define tMenuTextType int
#define textType_ScreenInfo 4
#define textType_VideoWall 13
#define textType_Default 14
#define kPlayerBoth -1

typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;

struct tScreenTournamentStandings : public tScreen {
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    bool gotmoney, gotbonus, gotbilled, fDrawMoney;
    bool fCountedDown, fStartCountdownNOW;
    int fCountSpeed;
};

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {};

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
