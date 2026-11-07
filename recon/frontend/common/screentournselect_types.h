#ifndef NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H   /* Owner-specific type surface for ScreenTournSelect.obj. */
#ifndef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE   /* screentournselect/pinkslips/tracks, not screenpost */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#ifndef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE   /* screentournselect only */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#include "../../game/common/draw_leaf_types.h"
#endif
#endif
#include "fe_player_types.h"   /* ScreenTournSelect keeps the input-key record, not the foreign player enum; ScreenPost keeps both. (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root parameter types */
/* ScreenMemcard is the nearest exact implemented base graph.  Exclude its memory-card, saved-game, audio-song, and FE3d owner records here. */
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
#include "../../game/common/color_types.h"   /* no-op unless NFS4_FE_COLOR_LATE (color.obj graph after the frontend graph) */
/* These foreign enum tags are absent from this owner graph.  Keep the source constants while the extern boundary below preserves their retail names. */
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
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    bool gotmoney, gotbonus, gotbilled, fDrawMoney;
    bool fCountedDown, fStartCountdownNOW;
    int fCountSpeed;
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
    tScreenTournamentStandings();
#endif
#line 64 "C:/nfs4/FRONTEND/COMMON/SCREENPOST.H"
};
#line 100 "screentournselect_types.h"

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#endif
#line 72 "C:/nfs4/FRONTEND/COMMON/SCREENPOST.H"
};
#line 107 "screentournselect_types.h"

#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    /* overrides (retail vtable), declared on every owner surface */
    void DrawBackground();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* implicit ctor (retail declares none: no body block in SYM) */
#line 82 "C:/nfs4/FRONTEND/COMMON/SCREENPOST.H"
};
#line 115 "screentournselect_types.h"
#else
#line 116 "screentournselect_types.h"
#include "screentournselect.h"
#endif
#line 118 "screentournselect_types.h"

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
