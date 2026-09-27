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
/* (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root's parameter types */
#include "fe_player_types.h"
struct tMenuCommand;
#define uchar unsigned char
#define RaceType_SingleRace 0
#define RaceType_PinkSlips 6

typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;

/* Scratchpad render cursors are address macros, not object globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/POLY_G4.h"
#include "shared/tDrawShapeExtended.h"
#include "fedialog.h"

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

    int BackDepth(int player) { return backDepth[player]; }
    tMenu *CurrentMenu(int player) { return fCurrentMenu[player]; }
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

#include "screenmain.h"

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
