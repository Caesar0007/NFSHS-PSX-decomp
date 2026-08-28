/* Owner-specific type surface for FeMenuOptions.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUOPTIONS_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENUOPTIONS_TYPES_H

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
struct tMenuCommand {
    tMenuCommandType type;
    tMenu *nextMenu;
};

#define NFS4_EA_PSX_INCOMPLETE_PHYSADR
#define NFS4_FEMENUOPTIONS_SURFACE
#define NFS4_FE_CORE_FEMENU_METHODS
#include "screencontroller_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS
#undef NFS4_FEMENUOPTIONS_SURFACE
#undef NFS4_EA_PSX_INCOMPLETE_PHYSADR

/* Replace ScreenController's narrow foreign views with the records and exact
 * member slices required by FeMenuOptions. */
#undef tFEApplication
#undef tGlobalMenuDefs

/* These enum tags are not retained by FeMenuOptions.obj. */
#define tMenuTextState int
#define textState_Unselected 0
#define textState_Selected 1
#define textState_Hilighted 2
#define tMenuTextType int
#define textType_Options 6

struct DR_AREA {
    u_long tag;
    u_long code[2];
};

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

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct AudioMus_tSongList {
    int numsongs, currentsong;
    AudioMus_tSongEntry song[0];
};

/* The linked owner retains this public array typedef while attributing the
 * already-seen element body elsewhere. */
struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];

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

struct FeMenuOptions_ScreenAudioCodegenView {
    char _beforeSelectedSong[116];
    short fSelectedSong;
    char _beforeSongList[2];
    AudioMus_tSongList *songlist;
};
#define tScreenAudio FeMenuOptions_ScreenAudioCodegenView

struct FeMenuOptions_GlobalMenuDefsCodegenView {
    char _beforeMenuPlayList[0x2758];
    tInsideBoxSongMenu menuPlayListMenu;
};
#define tGlobalMenuDefs FeMenuOptions_GlobalMenuDefsCodegenView

#endif
