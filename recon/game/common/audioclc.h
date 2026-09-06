/* game/common/audioclc.h — reconstructed from game/common/audioclc.cpp (18 fns) */
#ifndef _GAME_COMMON_AUDIOCLC_H_
#define _GAME_COMMON_AUDIOCLC_H_
#include "audioclc_types.h"

/* P875: source names/signatures checked against native EXT records and
 * defining exports; compile-only typed references verify the C++ linkage. */

void AudioClc_SndError(int shandle);   /* :113 */
void AudioClc_SetHorn(Car_tObj *car, int state);   /* :214 */
void AudioClc_HonkHorn(Car_tObj *car, int numBeeps, int ticksOn, int ticksOff);   /* :251 */
void AudioClc_InitSource(AudioClc_tSource *s, Car_tObj *car);   /* :279 */
void AudioClc_StartUp(void);   /* :297 */
int AudioClc_CalcDopplerShiftRatio(coorddef *objectPos, coorddef *objectVel);   /* :346 */
int AudioClc_CalcDistance(DRender_tCalcView *view, coorddef *object);   /* :373 */
int AudioClc_CalcAzimuth(DRender_tCalcView *view, coorddef *object);   /* :393 */
int AudioClc_CalcCarDirection(DRender_tCalcView *view, Car_tObj *car);   /* :414 */
int AudioClc_CalcTrackAzimuth(DRender_tCalcView *view, Car_tObj *car);   /* :430 */
void AudioClc_SoundOpponentHorn(int closestIndex, int azimuth, int dop, int dsquare);   /* :450 */
void AudioClc_SilenceOpponentHorn(int closestIndex);   /* :523 */
void AudioClc_SoundCloseCar(int playerIndex, int closestIndex);   /* :531 */
void AudioClc_SoundPlayersCar(int playerIndex);   /* :680 */
void AudioClc_ResetClosest(int closestIndex, Car_tObj *car, int playerIndex);   /* :882 */
void AudioClc_GetClosestCars(int playerIndex, int closestIndex, int numclosest);   /* :921 */
void AudioClc_SoundSpeech(void);   /* :1038 */
void AudioClc_SoundCars(void);   /* :1052 */

#endif /* _GAME_COMMON_AUDIOCLC_H_ */
