/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/audioclc.h"
void (*p875_common_audioclc_0)(int shandle) = &AudioClc_SndError;
void (*p875_common_audioclc_1)(Car_tObj *car,int state) = &AudioClc_SetHorn;
void (*p875_common_audioclc_2)(Car_tObj *car,int numBeeps,int ticksOn,int ticksOff) = &AudioClc_HonkHorn;
void (*p875_common_audioclc_3)(AudioClc_tSource *s,Car_tObj *car) = &AudioClc_InitSource;
void (*p875_common_audioclc_4)(void) = &AudioClc_StartUp;
int (*p875_common_audioclc_5)(coorddef *objectPos,coorddef *objectVel) = &AudioClc_CalcDopplerShiftRatio;
int (*p875_common_audioclc_6)(DRender_tCalcView *view,coorddef *object) = &AudioClc_CalcDistance;
int (*p875_common_audioclc_7)(DRender_tCalcView *view,coorddef *object) = &AudioClc_CalcAzimuth;
int (*p875_common_audioclc_8)(DRender_tCalcView *view,Car_tObj *car) = &AudioClc_CalcCarDirection;
int (*p875_common_audioclc_9)(DRender_tCalcView *view,Car_tObj *car) = &AudioClc_CalcTrackAzimuth;
void (*p875_common_audioclc_10)(int closestIndex,int azimuth,int dop,int dsquare) = &AudioClc_SoundOpponentHorn;
void (*p875_common_audioclc_11)(int closestIndex) = &AudioClc_SilenceOpponentHorn;
void (*p875_common_audioclc_12)(int playerIndex,int closestIndex) = &AudioClc_SoundCloseCar;
void (*p875_common_audioclc_13)(int playerIndex) = &AudioClc_SoundPlayersCar;
void (*p875_common_audioclc_14)(int closestIndex,Car_tObj *car,int playerIndex) = &AudioClc_ResetClosest;
void (*p875_common_audioclc_15)(int playerIndex,int closestIndex,int numclosest) = &AudioClc_GetClosestCars;
void (*p875_common_audioclc_16)(void) = &AudioClc_SoundSpeech;
void (*p875_common_audioclc_17)(void) = &AudioClc_SoundCars;
