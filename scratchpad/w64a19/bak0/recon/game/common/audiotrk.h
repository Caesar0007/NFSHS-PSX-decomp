/* game/common/audiotrk.h — reconstructed from game/common/audiotrk.cpp (6 fns) */
#ifndef _GAME_COMMON_AUDIOTRK_H_
#define _GAME_COMMON_AUDIOTRK_H_
#include "../../nfs4_types.h"

void AudioTrk_Reset__Fv(void);   /* :59 */
void AudioTrk_StartUp__Fv(void);   /* :88 */
void AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji(AudioElem *se, int tck, coorddef *vel, int fade, Car_tObj *car, int trkazi);   /* :135 */
void AudioTrk_SoundTrack__FP8Car_tObji(Car_tObj *car, int trkazi);   /* :310 */
int AudioTrk_PreLoad__Fv(void);   /* :478 */
void AudioTrk_CleanUp__Fv(void);   /* :534 */

#endif /* _GAME_COMMON_AUDIOTRK_H_ */
