/* game/common/audiocmn.h — reconstructed from game/common/audiocmn.cpp (48 fns) */
#ifndef _GAME_COMMON_AUDIOCMN_H_
#define _GAME_COMMON_AUDIOCMN_H_
#include "../../nfs4_types.h"

int AudioCmn_MusicLevel__Fi(int level);   /* :278 */
int AudioCmn_GetTrackRecordLapTime__Fv(void);   /* :283 */
void AudioCmn_InitThunder__Fv(void);   /* :303 */
void AudioCmn_PlayThunder__Fii(int intensity, int azimuth);   /* :310 */
void AudioCmn_UpdateThunder__Fv(void);   /* :320 */
void AudioCmn_InitAsyncSfx__Fv(void);   /* :454 */
void AudioCmn_RemoveAsyncSfx__Fi(int slot);   /* :467 */
void AudioCmn_DeInitAsyncSfx__Fv(void);   /* :493 */
int AudioCmn_RemoveOldestAsyncSfx__Fi(int bank);   /* :501 */
void AudioCmn_LoadAsyncSfx__FiiPvi(int bank, int patch, void *pbank, int size);   /* :534 */
int AudioCmn_GetAsyncSfx__Fiib(int bank, int patch, BOOL checkonly);   /* :620 */
void AudioCmn_Init__Fv(void);   /* :678 */
void AudioCmn_Reset__Fv(void);   /* :749 */
void AudioCmn_DeInit__Fv(void);   /* :911 */
void AudioCmn_SetLevels__Fv(void);   /* :942 */
int AudioCmn_GetTimePhrase__Fi(int time);   /* :955 */
void AudioCmn_CheckState__FP8Car_tObj(Car_tObj *car);   /* :994 */
void AudioCmn_LoadFESamples__Fv(void);   /* :1201 */
void AudioCmn_LoadGameSamples__Fv(void);   /* :1214 */
void AudioCmn_InitChannelArray__Fv(void);   /* :1244 */
int scaleFrequency__Fiii(int sndPlayer, int iSFXnum, int tweakedForce);   /* :1259 */
int ChooseImpactSample__Fi6s_typeT1(int force, int surface1, int surface2);   /* :1296 */
int ChooseLoopedSample__F6s_typeT0(int surface1, int surface2);   /* :1428 */
void AudioCmn_SFX__Fi6s_typeT1iii(int sndPlayer, int surface1, int surface2, int tweakedForce, int Distsq, int azimuth);   /* :1458 */
void freeVoiceChannel__Fi(int sndPlayer);   /* :1580 */
int AudioCmn_PlayDoppleredSound__Fiiiiii(int bhandle, int patchNum, int azimuth, int vol, int bend, int doppler);   /* :1615 */
int AudioCmn_PlaySound__Fiiiii(int bhandle, int patchNum, int azimuth, int vol, int bend);   /* :1716 */
int AudioCmn_PlaySFX__Fiiiiii(int sndPlayer, int iSFXnum, int iFreqIn, int iDopplerIn, int iAmpIn, int azimuth);   /* :1731 */
void AudioCmn_SoundCar__FP8Car_tObjiiiiiii(Car_tObj *car, int dst, int iFreqIn, int doppler, int azimuth, int trackazim, int relvel, int cardir);   /* :1908 */
void AudioCmn_TrafficSFX__Fiiiiiiii(int iChan, int iSFXnum, int freq, int doppler, int dst, int azimuth, int relvel, int dir);   /* :2193 */
void AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii(int sndPlayer, int surface1, int surface2, int force, int Distsq, int azimuth);   /* :2244 */
void AudioCmn_PlayerHornOn__Fiiiii(int carIndex, int Distsq, int iFreqIn, int azimuth, int doppler);   /* :2275 */
int AudioCmn_PlayerHornOff__Fi(int carIndex);   /* :2305 */
void AudioCmn_PlayFESFX__Fi(int SFXnum);   /* :2327 */
void AudioCmn_PlayFESFXVol__Fii(int SFXnum, int vol);   /* :2332 */
void AudioCmn_PlayWrongWaySFX__Fv(void);   /* :2370 */
void AudioCmn_PlayPauseSound__Fi(int patch);   /* :2375 */
void quickSirenOn__Fi(int sirennum);   /* :2412 */
void SuperCopSirenOn__Fi(int sirennum);   /* :2418 */
void SirenOn__Fii(int sirennum, int supercop);   /* :2423 */
void SirenOff__Fi(int sirennum);   /* :2442 */
void UpdateSiren__Fiiiii(int sirennum, int amp, int dop, int azimuth, int supercop);   /* :2454 */
void AudioCmn_Pause__Fv(void);   /* :2511 */
void AudioCmn_UnPause__Fv(void);   /* :2533 */
void AudioCmn_UnPauseAndQuit__Fv(void);   /* :2546 */
void AudioCmn_UnPauseAndRestart__Fv(void);   /* :2577 */
void AudioCmn_InitReverb__Fv(void);   /* :2612 */
void AudioCmn_ReverbOff__Fv(void);   /* :2631 */

#endif /* _GAME_COMMON_AUDIOCMN_H_ */
