/* Owner-specific type surface for ScreenTrophyRoom.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H

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

/* This owner retains both frontend input enums. */
#include "fe_input_enums.h"

/* Reuse the exact shared graph while excluding memory-card, saved-game,
 * FE3d, and dialog-only records.  AudioMus_tSongEntry remains present. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE

/* Foreign enum tags absent from this owner remain source constants. */
#define tTrophySize int
#define ts_Small 0
#define ts_Medium 1
#define tMenuTextState int
#define textState_Hilighted 2
#define tMenuTextType int
#define textType_ScreenInfo 4

struct tScreenTrophyRoom : public tScreen {
    tShapeInformation fTrophyShapes;
    short fNumTrophies;
    int startTicks;
    short fShapeCount;
    bool fLoadingTrophy;
    char fPreviousTrophy, fDoUpdate;
    bool fClearScreen;
    char fBrightness;
    u_long fStartTicks;
    short fTextInfo[16];
    char thisisuseless;
    int tier;
    short fRealCurrentTourn[2];
    short fTrophyList[64];

    tScreenTrophyRoom();
    ~tScreenTrophyRoom();
    void GetShapeInfo(short &, short &, char **, char **);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void PreLoad();
    void Initialize();
    void Cleanup();
    void DrawBackground();
    void LoadTrophy();
};

/* Foreign singleton tags are absent; expose only the priced members. */
struct ScreenTrophyRoom_GlobalMenuDefsCodegenView {
    char _beforeMenuTrophyInfo[0x200];
    tMenuBlank menuTrophyInfo;
};
#define tGlobalMenuDefs ScreenTrophyRoom_GlobalMenuDefsCodegenView

struct ScreenTrophyRoom_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    char stateBytes[16];
};
#define tPadModuleState ScreenTrophyRoom_PadCodegenView

#endif
