/* tMenuCommandType -- FEMENU.H, one definition (header-truth 8a) */
#ifndef NFS4_SHARED_TMENUCOMMANDTYPE_H
#define NFS4_SHARED_TMENUCOMMANDTYPE_H
#ifndef NFS4_TMENUCOMMANDTYPE_DEFINED
#define NFS4_TMENUCOMMANDTYPE_DEFINED   /* older headers test this */
#endif
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
#endif
