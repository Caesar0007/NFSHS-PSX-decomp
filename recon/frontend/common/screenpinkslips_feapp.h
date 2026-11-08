/* screenpinkslips_feapp.h -- tFEApplication as ScreenPinkSlips/ScreenTracks retain it (moved verbatim from
   screenpinkslips_types.h); retail: right after the early dialogs (NFS4_SCREENDISPLAY_HOOK_AFTER_EARLY_DIALOGS). */
#ifndef NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_FEAPP_H
#define NFS4_FRONTEND_COMMON_SCREENPINKSLIPS_FEAPP_H
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

    tMenu *CurrentMenu(int player) { return fCurrentMenu[player]; }
};
#endif
