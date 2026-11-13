/* Owner-specific type surface for ScreenCarSelect.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENCARSELECT_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENCARSELECT_TYPES_H

/* These identifiers are source spellings/constants only in this owner: its
 * linked SYM emits no completed enum or typedef records for them. */
#define BOOL int
#define uchar unsigned char
#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */







#include "fecheats_cheatcode.h"   /* the real tCheatCode enum (was a macro fake; header-truth 4-C.2) */

#define RaceType_Tournament 2

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
typedef int FEVECTOR[4];
typedef int FEMATRIX[4][4];
#endif

#define NFS4_FE_CORE_SCREENCARSELECT_METHODS
#define NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
#define NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
#include "fedialog_types.h"
#ifdef NFS4_SCREENMEMCARD_MANAGERTASK_EXTERNAL   /* retail: MANAGERTASK in the memcard graph (after CARDINFO_def; nearest owner site) */
#include "mcrd_managertask.h"
#endif
#undef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
#undef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
#undef NFS4_FE_CORE_SCREENCARSELECT_METHODS

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "shared/DR_AREA.h"
#endif

struct DRender_tView;

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct GameSetup_tData;   /* incomplete here: owner object records it; members reached by offset */




#endif

#if !defined(NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE) && !defined(NFS4_SCREENCARSELECT_TAIL_LATE)   /* TAIL_LATE: screencarselect_tail.h */
#include "shared/AudioMus_tSongEntry.h"
#endif

#ifndef NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
#include "shared/tDrawShapeExtended.h"
#else
struct tDrawShapeExtended;
#endif

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "screencarselect_carstat.h"   /* enum tCarStatType (own guarded header: NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER places it for the owner) */






#endif

#include "shared/tVideoWall.h"   /* one tVideoWall definition (header-truth 4t) */






























struct tOverlay {
    RECT location[2];
    short transition, delta, direction, ID;
};

struct tScreenCarSelect : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void DrawVideoWall(short);
    virtual void InitializeVideoWall();
    virtual void UpdateVideoWall(tCarInfo &);
    virtual bool GetCar(tCarInfo &);
    virtual void AllocateAsyncBuffer();
    virtual void FreeAsyncBuffer();
    tOverlay fOverlays[7];
    tOverlay *fCurrentOverlays[4];
    short fState, fPreviousCar, fPreviousCarID, fPreviousCountry;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall[2];
    short fBrightness[2], fDestBrightness[2];
    long fFadeTicks[2];
    bool fTVsInitialized, fInShowroom;
    u_long fShowroomTicks, fSpeechTicks;
    bool fSpeechPlayed;
    int fSplineInterval;
    u_long fCameraRotation;

    tScreenCarSelect();
    ~tScreenCarSelect();
    void DrawOverlay(tOverlay *);
    void SetState(int);
    void CalcSplinePosition(int, int, int, int, u_long, int &, int &, int &, int &, int &);
    void SetBrightness(short, short);
    void UpdateBrightness(short);
    void DrawSliders(tCarInfo &, short, short);
};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "cls_tScreenCarSelectDuel.h"   /* class tScreenCarSelectDuel (one definition) */






















#endif
#ifdef NFS4_SCREENCARSELECT_HOOK_AFTER_DUEL   /* owner records right after tScreenCarSelect(Duel), before tScreenCarSelectTwoPlayer (Front: tScreenCarSelectDuel) */
#include NFS4_SCREENCARSELECT_HOOK_AFTER_DUEL
#endif
#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE   /* closed by the #endif after the anchor */
#line 178 "recon/frontend/common/screencarselect_types.h"
#endif

struct tScreenCarSelectTwoPlayer : public tScreenCarSelect {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void DrawVideoWall(short);
    void InitializeVideoWall();
    void UpdateVideoWall(tCarInfo &);
    bool GetCar(tCarInfo &);
    void AllocateAsyncBuffer();
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void TurnOffVideoWall();
    virtual void SetDialog();
    tDialogBackUpOnly CarDialog;

    /* implicit ctor (retail declares none: no body block in SYM) */
#line 313 "C:/nfs4/FRONTEND/COMMON/SCREENCARSELECT.H"
};
#line 199 "recon/frontend/common/screencarselect_types.h"

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
enum PinkSlipsCarSelectState {
    NoCardInserted = 0,
    CardFailed = 1,
    CardFailedNotFound = 2,
    CardFailedUnformatted = 3,
    NotEnoughCars = 4,
    TooManyCars = 5,
    CardLoadedFine = 6,
    WhoCaresWeBeExiting = 7,
    CardCurrentlyLoading = 8
};

#include "cls_tScreenPinkSlipsCarSelect.h"   /* class tScreenPinkSlipsCarSelect (one definition) */



















#endif
#include "screencarselect_tail.h"   /* color.obj graph after the car-select screens (+ AudioMus for ScreenCarSelect) */
#include "cls_tScreenTournamentStandings.h"   /* class tScreenTournamentStandings: no private copy (header-truth 4v) */



















#include "cls_tScreenTournamentStandings3item.h"   /* class tScreenTournamentStandings3item: no private copy (header-truth 4v) */







#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
/* Remaining foreign menu view needs owning-SYM source restoration. */
#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */






























#endif

#ifdef NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS   /* owner records right after tScreenTournamentStandings3item (FEMenuDefs: femenudefs_tail.h) */
#include NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS
#endif
#endif
