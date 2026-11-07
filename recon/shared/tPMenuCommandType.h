/* tPMenuCommandType -- moved verbatim from game/common/mpause_types.h (INVC 2026-11-08): pausemenu.obj emits it after
 * its frontend block, mpause.obj at the top. */
#ifndef NFS4_SHARED_TPMENUCOMMANDTYPE_H
#define NFS4_SHARED_TPMENUCOMMANDTYPE_H
enum tPMenuCommandType {
    kMPause_NoEvent = 0,
    kMPause_Continue = 1,
    kMPause_Restart = 2,
    kMPause_QuitToGameSetup = 3,
    kMPause_QuitToRaceSummary = 4,
    kMPause_ForfeitToRaceSummary = 5,
    kMPause_GoToMenu = 6,
    kMPause_BackupMenu = 7,
    kMPause_CommandConfirmationFlag = 256
};
#endif
