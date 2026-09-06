/* game/common/audiotrk.h — reconstructed from game/common/audiotrk.cpp (6 fns) */
#ifndef _GAME_COMMON_AUDIOTRK_H_
#define _GAME_COMMON_AUDIOTRK_H_
#include "../../nfs4_types.h"

/* P875: source names/signatures checked against native EXT records and
 * defining exports; compile-only typed references verify the C++ linkage. */

void AudioTrk_Reset(void);   /* :59 */
void AudioTrk_StartUp(void);   /* :88 */
void AudioTrk_AddCustomObject(AudioElem *se, int tck, coorddef *vel, int fade, Car_tObj *car, int trkazi);   /* :135 */
void AudioTrk_SoundTrack(Car_tObj *car, int trkazi);   /* :310 */
int AudioTrk_PreLoad(void);   /* :478 */
void AudioTrk_CleanUp(void);   /* :534 */

#endif /* _GAME_COMMON_AUDIOTRK_H_ */
