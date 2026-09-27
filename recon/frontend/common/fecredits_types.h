/* Owner-specific type surface for FECredits.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECREDITS_TYPES_H
#define NFS4_FRONTEND_COMMON_FECREDITS_TYPES_H

#include "../../game/common/color_types.h"
#include "fe_core_types.h"

#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

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

#include "shared/tShapeInformation.h"








#include "fescreen_virtual_types.h"
struct tMenu;
#include "fescreen.h"

#include "shared/tActiveLine.h"





#include "shared/tDrawShapeExtended.h"





#include "fedialog.h"







#include "shared/tCredit.h"






struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    bool fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    bool StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;

    void Setup();
    void Init(int);
    void DeInit();
    void RealDeInit();
    void Draw(bool);
    void SetupCurrCredit();
    void DrawCurrCredit();
};

enum tTVState {
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
};

enum tScreenMainState {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
};

#include "shared/tTVConfig.h"










#include "shared/tVideoTransition.h"








#include "shared/tVideo.h"



/* Compiler-layout carrier needed for field offsets; this foreign owner tag is
 * not retained by FECredits.obj's linked SYM. */
struct tScreenMain : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void PreLoad();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    int hVideo, fFrame;
    u_long fStartTicks, fAnimTicks;
    short fAnimLocation;
    tScreenMainState fState;
    tTVConfig tvConfigs[16];
    tScreenMainState tvStates[16];
    tVideoTransition tvTransitions[16];
    bool fTVsInitialized;
    char fTransitionDirection;
    bool fAnimationUploaded;
    short fPreviousAnim, fWarningFade, fPreviousMovie, fCurrentMovie;
    bool bVideoAborted;
    u_long fMovieTicks;
    tShapeInformation fVideoShapes[2];
    int fCurrentSlot, fCurrentBG[2], fNumTVsInTransition;

    void SwapBackground(int);
    bool DoneLoadingBackground();
};

#define cheat_MyMomSaysImCool 21

#endif
