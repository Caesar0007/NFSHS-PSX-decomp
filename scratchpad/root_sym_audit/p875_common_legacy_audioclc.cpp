/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_audioclc.h"
void (*p875_common_audioclc_0)(int shandle) = &AudioClc_SndError__Fi;
void (*p875_common_audioclc_1)(Car_tObj *car, int state) = &AudioClc_SetHorn__FP8Car_tObji;
void (*p875_common_audioclc_2)(Car_tObj *car, int numBeeps, int ticksOn, int ticksOff) = &AudioClc_HonkHorn__FP8Car_tObjiii;
void (*p875_common_audioclc_3)(AudioClc_tSource *s, Car_tObj *car) = &AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj;
void (*p875_common_audioclc_4)(void) = &AudioClc_StartUp__Fv;
int (*p875_common_audioclc_5)(coorddef *objectPos, coorddef *objectVel) = &AudioClc_CalcDopplerShiftRatio__FP8coorddefT0;
int (*p875_common_audioclc_6)(DRender_tCalcView *view, coorddef *object) = &AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef;
int (*p875_common_audioclc_7)(DRender_tCalcView *view, coorddef *object) = &AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef;
int (*p875_common_audioclc_8)(DRender_tCalcView *view, Car_tObj *car) = &AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj;
int (*p875_common_audioclc_9)(DRender_tCalcView *view, Car_tObj *car) = &AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj;
void (*p875_common_audioclc_10)(int closestIndex, int azimuth, int dop, int dsquare) = &AudioClc_SoundOpponentHorn__Fiiii;
void (*p875_common_audioclc_11)(int closestIndex) = &AudioClc_SilenceOpponentHorn__Fi;
void (*p875_common_audioclc_12)(int playerIndex, int closestIndex) = &AudioClc_SoundCloseCar__Fii;
void (*p875_common_audioclc_13)(int playerIndex) = &AudioClc_SoundPlayersCar__Fi;
void (*p875_common_audioclc_14)(int closestIndex, Car_tObj *car, int playerIndex) = &AudioClc_ResetClosest__FiP8Car_tObji;
void (*p875_common_audioclc_15)(int playerIndex, int closestIndex, int numclosest) = &AudioClc_GetClosestCars__Fiii;
void (*p875_common_audioclc_16)(void) = &AudioClc_SoundSpeech__Fv;
void (*p875_common_audioclc_17)(void) = &AudioClc_SoundCars__Fv;
