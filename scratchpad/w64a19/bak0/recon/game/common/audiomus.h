/* game/common/audiomus.h — reconstructed from game/common/audiomus.cpp (23 fns) */
#ifndef _GAME_COMMON_AUDIOMUS_H_
#define _GAME_COMMON_AUDIOMUS_H_
#include "../../nfs4_types.h"

void AudioMus_RefreshStatus__Fv(void);   /* :83 */
int AudioMus_Threshold__Fv(void);   /* :146 */
int AudioMus_Buffered__Fv(void);   /* :167 */
void * AudioMus_GetCurrentSong__Fv(void);   /* :196 */
void AudioMus_SwitchSong__Fv(void);   /* :242 */
void AudioMus_Fail__Fi(int errorcode);   /* :285 */
void AudioMus_QueueRequestedSong__Fv(void);   /* :316 */
void AudioMus_SetEntry__FP19AudioMus_tSongEntry(AudioMus_tSongEntry *info);   /* :345 */
void AudioMus_SetCurrentSongInfo__Fv(void);   /* :379 */
int AudioMus_Server__Fii(int mode, int ticks);   /* :407 */
void * AudioMus_GetSongList__FPci(char *pattern, int memtype);   /* :548 */
void AudioMus_InitGlobals__Fv(void);   /* :599 */
void AudioMus_InitDriverGlobals__Fv(void);   /* :611 */
void AudioMus_DriverStartUp__Fii(int buffersize, int spusize);   /* :642 */
void AudioMus_SysStartUp__FiiPc(int buffersize, int spusize, char *songs);   /* :701 */
void AudioMus_DriverCleanUp__Fv(void);   /* :757 */
void AudioMus_SysCleanUp__Fv(void);   /* :777 */
void AudioMus_StopSong__Fi(int fadeticks);   /* :796 */
void AudioMus_BuildPlayList__FiPi(int numplaylistsongs, int *playlist);   /* :836 */
void AudioMus_BuildPattern__FPc(char *pattern);   /* :856 */
int AudioMus_PlaySong__FPc(char *pattern);   /* :875 */
void AudioMus_Volume__Fi(int volume);   /* :961 */
void AudioMus_AutoVolume__Fii(int fadeticks, int volume);   /* :1009 */

#endif /* _GAME_COMMON_AUDIOMUS_H_ */
