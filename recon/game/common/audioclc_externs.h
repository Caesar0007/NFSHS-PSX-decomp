/* game/common/audioclc_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AUDIOCLC_EXTERNS_H_
#define _GAME_COMMON_AUDIOCLC_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

CARDINFO_def *MCRD_getcard(...);
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Car_tObj **Cars_gList;
extern GameSetup_tData   GameSetup_gData;
extern Trk_NewSlice  *BWorldSm_slices;
extern bool Hud_BeTheCop;
extern bool bSirenOn[];
extern camera_info       Camera_gInfo[2];            /* camera.obj */
extern int            Cars_gNumCars;
extern int          gMasterSFXLevel;
extern int       Cars_gNumHumanRaceCars;
extern int   AudioCmn_GetAsyncSfx(int a, int b, bool c);
extern int AudioCmn_PlayerHornOff(int carIndex);
extern int CopSpeak_GetEnginePatch(int type,int timbre);
extern void  AudioCmn_PlayWrongWaySFX(void);
extern void AudioCmn_PlayerHornOn(int carIndex,int Distsq,int iFreqIn,int azimuth,int doppler);
extern void AudioCmn_SFX(int sndPlayer,s_type surface1,s_type surface2,int tweakedForce,int Distsq, int azimuth);
extern void AudioCmn_SetLevels(void);
extern void AudioCmn_SoundCar(Car_tObj *car,int dst,int iFreqIn,int doppler,int azimuth,int trackazim,int relvel, int cardir);
extern void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir);
extern void AudioCmn_TrafficSkidSFX(int sndPlayer,s_type surface1,s_type surface2,int force,int Distsq,int azimuth);
extern void AudioTrk_SoundTrack(Car_tObj *car,int trkazi);
extern void CopSpeak_Server(void);
extern void SirenOff(int sirennum);
extern void SirenOn(int sirennum,int supercop);
extern void Speech_Server(void);
extern void UpdateSiren(int sirennum,int amp,int dop,int azimuth,int supercop);
int AudioCmn_PlaySFX(int a, int b, int c, int d, int e, int f);
void  trap(int code);
void Math_NormalizeVector(coorddef *v);
void freeVoiceChannel(int sndPlayer);

#endif /* _GAME_COMMON_AUDIOCLC_EXTERNS_H_ */
