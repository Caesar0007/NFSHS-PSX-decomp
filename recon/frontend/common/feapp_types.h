/* Owner-specific type surface for FEApp.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEAPP_TYPES_H
#define NFS4_FRONTEND_COMMON_FEAPP_TYPES_H

/* FEApp.obj emits tMenuCommand while tMenu is still opaque. */
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




/* FEApp uses player values without retaining the foreign tPlayer enum.  Input
 * keys are real owner records and must be available before dialog methods. */
/* (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root's parameter types */
#include "fe_input_enums.h"

/* ScreenMemcard is the nearest exact owner graph (160 shared named records).
 * Its memory-card/SDK owner records are excluded by this boundary. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_FEAPP_METHODS
#define NFS4_SCREENDISPLAY_FEAPP_METHODS
#define NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#define NFS4_FE_CORE_FEAPP_METHODS
#include "screenmemcard_types.h"
#undef NFS4_FE_CORE_FEAPP_METHODS
#undef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#undef NFS4_SCREENDISPLAY_FEAPP_METHODS
#undef NFS4_SCREENMEMCARD_FEAPP_METHODS
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE

/* Source spellings whose completed enum records are absent from FEApp.obj. */
#define tMenuTextType int
#define tMenuTextState int
#define textType_FramedInfo 3
#define textState_Selected 1
#define textState_Hilighted 2
#define kScreen_TransitionTypeScreen 2
#define RaceType_SingleRace 0
#define RaceType_PinkSlips 6
#define PinkSlipsNoError 0

#include "shared/DR_AREA.h"




#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"



#include "shared/SNDSAMPLEFORMAT.h"




enum tAppCommand {
    kApp_Command_StartRace = 0,
    kApp_Command_ReStartRace = 1,
    kApp_Command_StartReplay = 2
};

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

};

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
};

struct tScreenUserName : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    tOptionsMenu *callingMenu;
    short fTextFade;
    bool fInTransition;
    char fRowList[10][9];

    void DrawVerticalLine(short, short, short);
    void DrawHorizontalLine(short, short, short);
};

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
    inline tPlayer CurrentPlayer() { return fPlayer; }
    inline void DisplayMessage(int word);
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

/* These three external singletons have no completed tags in FEApp.obj.  The
 * views expose only fields read by this owner at their exact retail offsets. */
struct FeApp_GameSetupCodegenView {
    int _beforeReplayMode[9];
    int replayMode;
};
#define GameSetup_tData FeApp_GameSetupCodegenView

struct FeApp_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    char stateBytes[16];
};
#define tPadModuleState FeApp_PadCodegenView

struct FeApp_GlobalMenuDefsCodegenView {
    tMenuItemGoToMenuNFS4Button itemMainOnePlayerRace;
    tMenuItemGoToMenuNFS4Button itemMainTwoPlayerRace;
    char _beforeMenuMain[0xb0 - 0x58];
    tMenuNFS4 menuMain;
    char _beforeUserName1[0x31b8 - 0x12c];
    tUserNameMenuItem menuItemUserName1;
    tUserNameMenuItem menuItemUserName2;
    char _beforePostGameNames[0x36d0 - 0x32d0];
    tOptionsMenu menuPostGamePlayer1Name;
    tOptionsMenu menuPostGamePlayer2Name;
};
#define tGlobalMenuDefs FeApp_GlobalMenuDefsCodegenView

#endif
