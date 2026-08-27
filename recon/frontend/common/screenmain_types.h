/* Owner-specific type surface for ScreenMain.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENMAIN_TYPES_H

/* ScreenMain retains tInputKeyType but not the foreign tPlayer tag. */
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER

/* Reuse ScreenDisplay's exact shared frontend graph without its owner class
 * or foreign-global compiler view. */
#define NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
#include "screendisplay_types.h"
#undef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS

/* Source spellings whose tags are not retained by ScreenMain.obj. */
#define tPlayer int
#define tMenuCommand int
#define uchar unsigned char
#define RaceType_SingleRace 0
#define RaceType_PinkSlips 6

typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;

/* Scratchpad render cursors are address macros, not object globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct POLY_G4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, pad1;
    short x1, y1;
    u_char r2, g2, b2, pad2;
    short x2, y2;
    u_char r3, g3, b3, pad3;
    short x3, y3;
};

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

struct tDialogHelp : public tDialogBase {
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
};

struct tDialogMessageStringWithTimeout : public tDialogMessageString {};
struct tDialogNoInputMessage : public tDialogMessageString {};

struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2];
};

struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    bool fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    bool StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;
};

struct tVertex {
    short x, y;
};

struct tVideoWallConfig {
    short numVideos, flags;
    tVideo *videos[4];
};

struct tScreenMain : public tScreen {
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
    void SetState(tScreenMainState);
    void InitDynamicImages();
    void ProcessInput(int, tInputKeyType &, int &)
        asm("ProcessInput__11tScreenMain7tPlayerR13tInputKeyTypeR12tMenuCommand");
    void DrawDropShadow();
    void DrawVideoLines();
    void DrawBackground();
    void GetShapeInfo(short &, short &, char **, char **);
    void PreLoad();
    void Initialize();
    void Cleanup();
};

/* ScreenMain reads three fields from the foreign FEMenuDefs aggregate. */
struct ScreenMain_GlobalMenuDefsCodegenView {
    char _beforeItemTwoPlayerPinkSlips[0x8f4];
    tMenuItemGoToMenuNFS4Button itemTwoPlayerPinkSlips;
    char _beforeMenuPinkSlipSelect[0x100];
    tMenuNFS4 menuPinkSlipSelect;
    char _beforeMenuCredits[0x2f54];
    tMenuBlank menuCredits;
};
#define tGlobalMenuDefs ScreenMain_GlobalMenuDefsCodegenView

#endif
