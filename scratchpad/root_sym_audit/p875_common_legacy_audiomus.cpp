/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_audiomus.h"
void (*p875_common_audiomus_0)(void) = &AudioMus_RefreshStatus__Fv;
int (*p875_common_audiomus_1)(void) = &AudioMus_Threshold__Fv;
int (*p875_common_audiomus_2)(void) = &AudioMus_Buffered__Fv;
void * (*p875_common_audiomus_3)(void) = &AudioMus_GetCurrentSong__Fv;
void (*p875_common_audiomus_4)(void) = &AudioMus_SwitchSong__Fv;
void (*p875_common_audiomus_5)(int errorcode) = &AudioMus_Fail__Fi;
void (*p875_common_audiomus_6)(void) = &AudioMus_QueueRequestedSong__Fv;
void (*p875_common_audiomus_7)(AudioMus_tSongEntry *info) = &AudioMus_SetEntry__FP19AudioMus_tSongEntry;
void (*p875_common_audiomus_8)(void) = &AudioMus_SetCurrentSongInfo__Fv;
int (*p875_common_audiomus_9)(int mode, int ticks) = &AudioMus_Server__Fii;
void * (*p875_common_audiomus_10)(char *pattern, int memtype) = &AudioMus_GetSongList__FPci;
void (*p875_common_audiomus_11)(void) = &AudioMus_InitGlobals__Fv;
void (*p875_common_audiomus_12)(void) = &AudioMus_InitDriverGlobals__Fv;
void (*p875_common_audiomus_13)(int buffersize, int spusize) = &AudioMus_DriverStartUp__Fii;
void (*p875_common_audiomus_14)(int buffersize, int spusize, char *songs) = &AudioMus_SysStartUp__FiiPc;
void (*p875_common_audiomus_15)(void) = &AudioMus_DriverCleanUp__Fv;
void (*p875_common_audiomus_16)(void) = &AudioMus_SysCleanUp__Fv;
void (*p875_common_audiomus_17)(int fadeticks) = &AudioMus_StopSong__Fi;
void (*p875_common_audiomus_18)(int numplaylistsongs, int *playlist) = &AudioMus_BuildPlayList__FiPi;
void (*p875_common_audiomus_19)(char *pattern) = &AudioMus_BuildPattern__FPc;
int (*p875_common_audiomus_20)(char *pattern) = &AudioMus_PlaySong__FPc;
void (*p875_common_audiomus_21)(int volume) = &AudioMus_Volume__Fi;
void (*p875_common_audiomus_22)(int fadeticks, int volume) = &AudioMus_AutoVolume__Fii;
