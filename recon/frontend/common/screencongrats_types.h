/* Owner-specific type surface for ScreenCongrats.obj. */
#if !defined(NFS4_FRONTEND_COMMON_SCREENCONGRATS_TYPES_H) || defined(NFS4_SCREENDISPLAY_IN_HOOK_AFTER_CARCOLOR)
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_CARCOLOR   /* else: the screendisplay_types.h after-car-color hook pass (TV, congrats classes, tRecordBuffer) */
#define NFS4_FRONTEND_COMMON_SCREENCONGRATS_TYPES_H
/* The retail tMenuCommand record captures tMenu as an opaque pointer even though the same owner later emits tMenu's complete body.  Declaring this source-visible command before the shared menu graph reproduces that order. */
#include "fe_input_enums.h"   /* retail: tPlayer, tInputKeyType before tMenuCommandType */
struct tMenu;
#define NFS4_TMENUCOMMANDTYPE_DEFINED
#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */











#include "shared/tMenuCommand.h"
#define NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "screencarselect_types.h"
#undef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#endif
#ifndef NFS4_SCREENCONGRATS_CLASSES_DONE
#include "shared/tTVState.h"   /* retail ScreenCongrats: TV right before the congrats classes */
#include "shared/tTVConfig.h"
enum tTrophyClass {
    kTrophyGold = 0,
    kTrophySilver = 1,
    kTrophyBronze = 2,
    kTrophyCar = 3,
    kTrophyNone = 4
};

enum tSmallSpinningThing {
    kSpinningNone = 0,
    kSpinningGold = 1,
    kSpinningMemCard = 2
};

enum tScreenCongratsMessage {
    kScreenCongrats_Congrats = 0,
    kScreenCongrats_Eliminated = 1
};

/* ScreenCongrats.obj uses these values and ABI names without retaining the
 * foreign enum definitions in its own type graph. */




#include "shared/tMenuTextType.h"   /* the real enum (was constant macros; header-truth 4-C.2) */


struct tScreenCongrats : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void CalculatePrizes();

    virtual void DrawCongratsMessage() = 0;   /* retail slot 11 = __pure_virtual */



    virtual bool GetCar(tCarInfo &);
    tScreenCongratsMessage congratsMessage;
    tTrophyClass trophy;
    tSmallSpinningThing smallSpinningThing;
    int fNumSpinShapes, fNumSmallSpinShapes, fCarPlayer;
    long TotalCash, CashAwarded;
    int framenum, starttick;
    bool InExtraSpin;
    int InExtraSpinTick;
    tCarInfo fCarInfo;
    bool fGotCar;
    int fEnterTick;
    bool fCountedDown, fStartCountdownNOW;
    int fCountSpeed, fSpeechToPlay;
    short fCarX, fCarY;
    float fCarCX, fCarCY;

#line 109 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.H"
};
#line 90 "recon/frontend/common/screencongrats_types.h"

#ifndef NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
#include "cls_tScreenTournamentTrophy.h"   /* class tScreenTournamentTrophy (one definition) */













struct tScreenPinkSlipCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void Initialize();
    void Cleanup();
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    short fWinner;

    /* implicit ctor (retail declares none: no body block in SYM) */
#line 141 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.H"
};
#line 115 "recon/frontend/common/screencongrats_types.h"

#include "cls_tScreenBeTheCopCongrats.h"   /* class tScreenBeTheCopCongrats (one definition) */









#include "cls_tScreenTournamentCongrats.h"   /* class tScreenTournamentCongrats (one definition) */








#else
#include "screencongrats_tt.h"   /* struct tScreenTournamentTrophy; (owner hook NFS4_SCREENCONGRATS_HOOK_TT: the definition here) */
struct tScreenBeTheCopCongrats;
struct tScreenTournamentCongrats;
struct tScreenPinkSlipCongrats : public tScreenCongrats {
    short fWinner;
#ifdef NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
    /* Inferred getter spelling; retail retains this receiver in register3. */
    inline short Winner() { return fWinner; }
#endif
    /* implicit ctor (retail declares none: no body block in SYM) */
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    void CalculatePrizes();
    void Initialize();
    void Cleanup();
#line 141 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.H"
};
#line 148 "recon/frontend/common/screencongrats_types.h"
#endif
#ifdef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_CARCOLOR
#include "shared/tRecordBuffer.h"   /* retail: tRecordBuffer right after the congrats classes */
#endif
#define NFS4_SCREENCONGRATS_CLASSES_DONE
#endif

#endif
