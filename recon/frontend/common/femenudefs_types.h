/* Owner-specific type surface for FEMenuDefs.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUDEFS_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENUDEFS_TYPES_H

/* FEMenuDefs retains the input-key values but not the foreign tPlayer tag. */
/* (2026-09-19) the real tPlayer enum: FEMenuDefs.obj emits the tBlank* vtables, and with `#define tPlayer int` their
 * ProcessInput slots named the `i`-mangled overloads instead of the overrides. */
#include "fe_player_types.h"
#define RaceType_SingleRace 0
#define RaceType_HotPursuit 1
#define RaceType_PinkSlips 6
#define NFS4_FE_INPUT_NO_PLAYER
/* physadr: the complete SDK type (retail size 4) */
#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FEMENUOPTIONS_SURFACE
#define NFS4_FEMENUDEFS_SURFACE
#define NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
#define NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
#include "screencongrats_types.h"
#undef NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
#undef NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
#undef NFS4_FEMENUOPTIONS_SURFACE
#undef NFS4_FEMENUDEFS_SURFACE
#undef NFS4_FE_CORE_FEMENU_METHODS

#undef NFS4_FE_INPUT_NO_PLAYER

/* These pointer-only foreign classes are used by the reconstructed extern
 * surface but have no completed records in FEMenuDefs.obj. */
#ifndef NFS4_FEMENUDEFS_NO_SCREENMAIN_VIEW
struct FEMenuDefs_ScreenMainCodegenView {
    void SwapBackground(int)
        __asm__("SwapBackground__11tScreenMaini");
};
#define tScreenMain FEMenuDefs_ScreenMainCodegenView
#endif
struct tAllScreens;
struct tScreenAudio;
struct tScreenCarSelectDuel;
struct tScreenControllerConfig;
struct tScreenDisplay;
struct tScreenPinkSlipStandings;
struct tScreenPinkSlips;
struct tScreenPinkSlipsCarSelect;
struct tScreenTournSelect;
struct tScreenTrackInfo;
struct tScreenTrackRecords;
struct tScreenTrackSelect;
struct tScreenTrophyInfo;
#ifndef NFS4_FEMENUDEFS_NO_SCREENTROPHYROOM_VIEW
struct tScreenTrophyRoom;   /* incomplete here: owner object records it; members reached by offset */






#endif

/* SOURCE-REVIEW-UNRESOLVED: remaining foreign aggregate views are partial
 * reconstructions, not certified original types or generic review exemptions. */

#ifndef NFS4_FEMENUDEFS_NO_GAMESETUP_VIEW
struct GameSetup_tData;   /* incomplete here: owner object records it; members reached by offset */




#endif

#include "femenudefs_tail.h"   /* FE3d .. tScreenUserName (moved verbatim; the fedialog.h part stays here) */
















#ifndef NFS4_FEMENUDEFS_NO_DIALOGYESNOTRI
#include "fedialog.h"
#endif






















































#ifndef NFS4_FEMENUDEFS_NO_FEAPPLICATION
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
    inline tDialogMessageString *MessagePopup() { return &messagePopup; }
    inline tPlayer CurrentPlayer() { return fPlayer; }
    void Redraw();
};
#endif

#include "femenudefs_globalmenudefs.h"


































































































































































#endif
