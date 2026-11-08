#if !defined(NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H) || (defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE) && defined(NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE) && !defined(NFS4_SCREENTOURNSELECT_PASS2_DONE))   /* ScreenPost: 2nd pass via the OWNER_AFTER_ACTIVELINE hook */
#define NFS4_FRONTEND_COMMON_SCREENTOURNSELECT_TYPES_H   /* Owner-specific type surface for ScreenTournSelect.obj. */
#ifndef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE   /* screentournselect/pinkslips/tracks, not screenpost */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#ifndef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE   /* screentournselect only */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#include "../../game/common/draw_leaf_types.h"
#include "screentournselect_keys.h"   /* DIALOGS_EARLY, car keys, tScreenTournSelect hook (tournselect only) */
#endif
#endif
#ifndef NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE   /* skipped in ScreenPost's 2nd pass (nested inside screenmemcard_types.h below) */
#include "fe_player_types.h"   /* ScreenTournSelect keeps the input-key record, not the foreign player enum; ScreenPost keeps both. (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root parameter types */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE
#ifdef NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE
#define NFS4_SCREENMEMCARD_PINKSLIPS_SURFACE
#endif
#include "screenmemcard_types.h"   /* ScreenMemcard is the nearest exact implemented base graph.  Exclude its memory-card, saved-game, audio-song, and FE3d owner records here. */
#undef NFS4_SCREENMEMCARD_PINKSLIPS_SURFACE   /* defined above for the pinkslips surface only */
#undef NFS4_SCREENMEMCARD_TOURNSELECT_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE
#include "../../game/common/color_types.h"   /* no-op unless NFS4_FE_COLOR_LATE (color.obj graph after the frontend graph) */
#ifndef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE   /* These foreign enum tags are absent from this owner graph.  Keep the source constants while the extern boundary below preserves their retail names. */
#define tTrophySize int
#define ts_Medium 1
#endif
#endif
#if defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE) && !defined(NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE)   /* no 2nd pass: enums here */
#include "screenpost_menutext.h"























#elif !defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE)
#if !defined(NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE) || \
    defined(NFS4_SCREENPINKSLIPS_TRACKS_SURFACE)
#define tMenuTextState int
#else
#include "screenpinkslips_menutextstate.h"   /* no-op when already emitted before tActiveLine */





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

#if !defined(NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE) && !(defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE) && defined(NFS4_SCREENTOURNSELECT_PASS2_DONE))
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
#endif
#if defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE) && defined(NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE) && !defined(NFS4_SCREENTOURNSELECT_PASS2_DONE)   /* ScreenPost 2nd pass tail */
#include "shared/kernpair.h"
#include "shared/tDrawShapeExtended.h"
#include "screenpost_menutext.h"
#endif
#if !defined(NFS4_SCREENTOURNSELECT_PINKSLIPS_SURFACE) && !(defined(NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE) && defined(NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE) && !defined(NFS4_SCREENTOURNSELECT_PASS2_DONE))   /* view: not in the ScreenPost 2nd pass */
/* tGlobalMenuDefs is owned by FEMenuDefs.obj (no completed tag here); this exact-offset view exposes only the two iterators read by this owner. */
struct ScreenTournSelect_GlobalMenuDefsCodegenView {
    char _beforeIteratorTournament[0x6a8];
    tListIteratorTournament iteratorTournament;
    char _beforeIteratorSpecialEvent[0x78c - 0x6bc];
    tListIteratorTournament iteratorSpecialEvent;
};
#define tGlobalMenuDefs ScreenTournSelect_GlobalMenuDefsCodegenView
#endif
#define NFS4_SCREENTOURNSELECT_PASS2_DONE   /* end of a pass: ScreenPost's nested 2nd pass ends before pass 1 resumes */
#endif
