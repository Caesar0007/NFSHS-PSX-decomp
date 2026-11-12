/* frontend/common/feapp_class.h -- class tFEApplication (FEAPP.H), one definition for every includer (header-truth 4j;
 * moved from feapp_types.h, the owner).  Members are defined in feapp.cpp. */
#ifndef NFS4_FRONTEND_COMMON_FEAPP_CLASS_H
#define NFS4_FRONTEND_COMMON_FEAPP_CLASS_H
#include "shared/tAppCommand.h"
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

    inline u_char GetPlayer() { return (u_char)fPlayer; }
    inline tMenu *CurrentMenu(tPlayer player) { return fCurrentMenu[player]; }
    inline tDialogMessageString *MessagePopup() { return &messagePopup; }
    inline tPlayer CurrentPlayer() { return fPlayer; } inline int BackDepth(tPlayer player) { return backDepth[player]; } inline tScreen *CurrentScreen(int player) { return fCurrentScreen[player]; }   /* called from fedialog/screenmain and femenuoptions */
    void Redraw();
    tFEApplication();
    ~tFEApplication();
    void PerformMenuInitialization();
    void PerformMenuDestruction();
    void DrawHelpIcons();
    void UpdateMusic();
    void SetMenu(short, tMenu *);
    void SetScreen(short, tScreen *);
    void DisplayHelp(short);
    void RunDemoVideo();
    tAppCommand MainLoop(tMenu *);
    tAppCommand RunPostGame();
    tAppCommand RunFrontEnd();
};
#endif
