/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/audiomus.h"
void (*p875_common_audiomus_0)(void) = &AudioMus_RefreshStatus;
int (*p875_common_audiomus_1)(void) = &AudioMus_Threshold;
int (*p875_common_audiomus_2)(void) = &AudioMus_Buffered;
AudioMus_tCurrentSong * (*p875_common_audiomus_3)(void) = &AudioMus_GetCurrentSong;
void (*p875_common_audiomus_4)(void) = &AudioMus_SwitchSong;
void (*p875_common_audiomus_5)(int errorcode) = &AudioMus_Fail;
void (*p875_common_audiomus_6)(void) = &AudioMus_QueueRequestedSong;
void (*p875_common_audiomus_7)(AudioMus_tSongEntry *info) = &AudioMus_SetEntry;
void (*p875_common_audiomus_8)(void) = &AudioMus_SetCurrentSongInfo;
int (*p875_common_audiomus_9)(int mode,int ticks) = &AudioMus_Server;
AudioMus_tSongList * (*p875_common_audiomus_10)(char *pattern,int memtype) = &AudioMus_GetSongList;
void (*p875_common_audiomus_11)(void) = &AudioMus_InitGlobals;
void (*p875_common_audiomus_12)(void) = &AudioMus_InitDriverGlobals;
void (*p875_common_audiomus_13)(int buffersize,int spusize) = &AudioMus_DriverStartUp;
void (*p875_common_audiomus_14)(int buffersize,int spusize,char *songs) = &AudioMus_SysStartUp;
void (*p875_common_audiomus_15)(void) = &AudioMus_DriverCleanUp;
void (*p875_common_audiomus_16)(void) = &AudioMus_SysCleanUp;
void (*p875_common_audiomus_17)(int fadeticks) = &AudioMus_StopSong;
void (*p875_common_audiomus_18)(int numplaylistsongs,int *playlist) = &AudioMus_BuildPlayList;
void (*p875_common_audiomus_19)(char *pattern) = &AudioMus_BuildPattern;
int (*p875_common_audiomus_20)(char *pattern) = &AudioMus_PlaySong;
void (*p875_common_audiomus_21)(int volume) = &AudioMus_Volume;
void (*p875_common_audiomus_22)(int fadeticks,int volume) = &AudioMus_AutoVolume;
