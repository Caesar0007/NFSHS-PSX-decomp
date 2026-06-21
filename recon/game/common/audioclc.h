/* game/common/audioclc.h — reconstructed from game/common/audioclc.cpp (18 fns) */
#ifndef _GAME_COMMON_AUDIOCLC_H_
#define _GAME_COMMON_AUDIOCLC_H_
#include "../../nfs4_types.h"

void AudioClc_SndError__Fi(int shandle);   /* :113 */
void AudioClc_SetHorn__FP8Car_tObji(Car_tObj *car, int state);   /* :214 */
void AudioClc_HonkHorn__FP8Car_tObjiii(Car_tObj *car, int numBeeps, int ticksOn, int ticksOff);   /* :251 */
void AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj(AudioClc_tSource *s, Car_tObj *car);   /* :279 */
void AudioClc_StartUp__Fv(void);   /* :297 */
int AudioClc_CalcDopplerShiftRatio__FP8coorddefT0(coorddef *objectPos, coorddef *objectVel);   /* :346 */
int AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef(DRender_tCalcView *view, coorddef *object);   /* :373 */
int AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef(DRender_tCalcView *view, coorddef *object);   /* :393 */
int AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj(DRender_tCalcView *view, Car_tObj *car);   /* :414 */
int AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj(DRender_tCalcView *view, Car_tObj *car);   /* :430 */
void AudioClc_SoundOpponentHorn__Fiiii(int closestIndex, int azimuth, int dop, int dsquare);   /* :450 */
void AudioClc_SilenceOpponentHorn__Fi(int closestIndex);   /* :523 */
void AudioClc_SoundCloseCar__Fii(int playerIndex, int closestIndex);   /* :531 */
void AudioClc_SoundPlayersCar__Fi(int playerIndex);   /* :680 */
void AudioClc_ResetClosest__FiP8Car_tObji(int closestIndex, Car_tObj *car, int playerIndex);   /* :882 */
void AudioClc_GetClosestCars__Fiii(int playerIndex, int closestIndex, int numclosest);   /* :921 */
void AudioClc_SoundSpeech__Fv(void);   /* :1038 */
void AudioClc_SoundCars__Fv(void);   /* :1052 */

#endif /* _GAME_COMMON_AUDIOCLC_H_ */
