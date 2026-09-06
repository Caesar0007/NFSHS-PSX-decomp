/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/audiotrk.h"
void (*p875_common_audiotrk_0)(void) = &AudioTrk_Reset;
void (*p875_common_audiotrk_1)(void) = &AudioTrk_StartUp;
void (*p875_common_audiotrk_2)(AudioElem *se,int tck,coorddef *vel,int fade,Car_tObj *car,int trkazi) = &AudioTrk_AddCustomObject;
void (*p875_common_audiotrk_3)(Car_tObj *car,int trkazi) = &AudioTrk_SoundTrack;
int (*p875_common_audiotrk_4)(void) = &AudioTrk_PreLoad;
void (*p875_common_audiotrk_5)(void) = &AudioTrk_CleanUp;
