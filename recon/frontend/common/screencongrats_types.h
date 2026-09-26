/* Owner-specific type surface for ScreenCongrats.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENCONGRATS_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENCONGRATS_TYPES_H

/* The retail tMenuCommand record captures tMenu as an opaque pointer even
 * though the same owner later emits tMenu's complete body.  Declaring this
 * source-visible command before the shared menu graph reproduces that order. */
struct tMenu;
#define NFS4_TMENUCOMMANDTYPE_DEFINED
enum tMenuCommandType {
    kMenu_Command_None = 0,
    kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2,
    kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4,
    kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8,
    kMenu_Command_ClearRecords = 9
};

#include "shared/tMenuCommand.h"




#define NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "screencarselect_types.h"
#undef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE

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
#define tTrophySize int
#define ts_Small 0
#define ts_Medium 1
#define ts_Large 2
#define textType_PostGame 10
#define textType_TrackRecords 11

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
#ifdef NFS4_TSCREENCONGRATS_OWNER
    virtual void DrawCongratsMessage() = 0;
#else
    virtual void DrawCongratsMessage();   /* layout-only off the owner surface */
#endif
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

};

#ifndef NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
struct tScreenTournamentTrophy : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    short fShapeCount;
    char fDoUpdate;

    tScreenTournamentTrophy();
};

struct tScreenPinkSlipCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void Initialize();
    void Cleanup();
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    short fWinner;

    tScreenPinkSlipCongrats();
};

struct tScreenBeTheCopCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    tScreenBeTheCopCongrats();
};

struct tScreenTournamentCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    tScreenTournamentCongrats();
};
#else
struct tScreenTournamentTrophy;
struct tScreenBeTheCopCongrats;
struct tScreenTournamentCongrats;
struct tScreenPinkSlipCongrats : public tScreenCongrats {
    short fWinner;
    tScreenPinkSlipCongrats();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    void CalculatePrizes();
    void Initialize();
    void Cleanup();
};
#endif

#endif
