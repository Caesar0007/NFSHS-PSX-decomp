/* game/common/audiocmn.h — reconstructed from game/common/audiocmn.cpp (48 fns) */
#ifndef _GAME_COMMON_AUDIOCMN_H_
#define _GAME_COMMON_AUDIOCMN_H_
#include "../../nfs4_types.h"

/* P875: source names/signatures checked against native EXT records and
 * defining exports; compile-only typed references verify the C++ linkage. */

int AudioCmn_MusicLevel(int level);   /* :278 */
int AudioCmn_GetTrackRecordLapTime(void);   /* :283 */
void AudioCmn_InitThunder(void);   /* :303 */
void AudioCmn_PlayThunder(int intensity, int azimuth);   /* :310 */
void AudioCmn_UpdateThunder(void);   /* :320 */
void AudioCmn_InitAsyncSfx(void);   /* :454 */
void AudioCmn_RemoveAsyncSfx(int slot);   /* :467 */
void AudioCmn_DeInitAsyncSfx(void);   /* :493 */
int AudioCmn_RemoveOldestAsyncSfx(int bank);   /* :501 */
void AudioCmn_LoadAsyncSfx(int bank, int patch, void *pbank, int size);   /* :534 */
int AudioCmn_GetAsyncSfx(int bank, int patch, bool checkonly);   /* :620 */
void AudioCmn_Init(void);   /* :678 */
void AudioCmn_Reset(void);   /* :749 */
void AudioCmn_DeInit(void);   /* :911 */
void AudioCmn_SetLevels(void);   /* :942 */
int AudioCmn_GetTimePhrase(int time);   /* :955 */
void AudioCmn_CheckState(Car_tObj *car);   /* :994 */
void AudioCmn_LoadFESamples(void);   /* :1201 */
void AudioCmn_LoadGameSamples(void);   /* :1214 */
void AudioCmn_InitChannelArray(void);   /* :1244 */
int scaleFrequency(int sndPlayer, int iSFXnum, int tweakedForce);   /* :1259 */
int ChooseImpactSample(int force, s_type surface1, s_type surface2);   /* :1296 */
int ChooseLoopedSample(s_type surface1, s_type surface2);   /* :1428 */
void AudioCmn_SFX(int sndPlayer, s_type surface1, s_type surface2, int tweakedForce, int Distsq, int azimuth);   /* :1458 */
void freeVoiceChannel(int sndPlayer);   /* :1580 */
int AudioCmn_PlayDoppleredSound(int bhandle, int patchNum, int azimuth, int vol, int bend, int doppler);   /* :1615 */
int AudioCmn_PlaySound(int bhandle, int patchNum, int azimuth, int vol, int bend);   /* :1716 */
int AudioCmn_PlaySFX(int sndPlayer, int iSFXnum, int iFreqIn, int iDopplerIn, int iAmpIn, int azimuth);   /* :1731 */
void AudioCmn_SoundCar(Car_tObj *car, int dst, int iFreqIn, int doppler, int azimuth, int trackazim, int relvel, int cardir);   /* :1908 */
void AudioCmn_TrafficSFX(int iChan, int iSFXnum, int freq, int doppler, int dst, int azimuth, int relvel, int dir);   /* :2193 */
void AudioCmn_TrafficSkidSFX(int sndPlayer, s_type surface1, s_type surface2, int force, int Distsq, int azimuth);   /* :2244 */
void AudioCmn_PlayerHornOn(int carIndex, int Distsq, int iFreqIn, int azimuth, int doppler);   /* :2275 */
int AudioCmn_PlayerHornOff(int carIndex);   /* :2305 */
void AudioCmn_PlayFESFX(int SFXnum);   /* :2327 */
void AudioCmn_PlayFESFXVol(int SFXnum, int vol);   /* :2332 */
void AudioCmn_PlayWrongWaySFX(void);   /* :2370 */
void AudioCmn_PlayPauseSound(int patch);   /* :2375 */
void quickSirenOn(int sirennum);   /* :2412 */
void SuperCopSirenOn(int sirennum);   /* :2418 */
void SirenOn(int sirennum, int supercop);   /* :2423 */
void SirenOff(int sirennum);   /* :2442 */
void UpdateSiren(int sirennum, int amp, int dop, int azimuth, int supercop);   /* :2454 */
void AudioCmn_Pause(void);   /* :2511 */
void AudioCmn_UnPause(void);   /* :2533 */
void AudioCmn_UnPauseAndQuit(void);   /* :2546 */
void AudioCmn_UnPauseAndRestart(void);   /* :2577 */
void AudioCmn_InitReverb(void);   /* :2612 */
void AudioCmn_ReverbOff(void);   /* :2631 */

#endif /* _GAME_COMMON_AUDIOCMN_H_ */
