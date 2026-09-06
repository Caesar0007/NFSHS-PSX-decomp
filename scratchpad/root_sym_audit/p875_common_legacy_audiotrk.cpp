/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_audiotrk.h"
void (*p875_common_audiotrk_0)(void) = &AudioTrk_Reset__Fv;
void (*p875_common_audiotrk_1)(void) = &AudioTrk_StartUp__Fv;
void (*p875_common_audiotrk_2)(AudioElem *se, int tck, coorddef *vel, int fade, Car_tObj *car, int trkazi) = &AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji;
void (*p875_common_audiotrk_3)(Car_tObj *car, int trkazi) = &AudioTrk_SoundTrack__FP8Car_tObji;
int (*p875_common_audiotrk_4)(void) = &AudioTrk_PreLoad__Fv;
void (*p875_common_audiotrk_5)(void) = &AudioTrk_CleanUp__Fv;
