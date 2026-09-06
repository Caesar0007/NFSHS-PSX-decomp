/* game/common/audiomus.h — reconstructed from game/common/audiomus.cpp (23 fns) */
#ifndef _GAME_COMMON_AUDIOMUS_H_
#define _GAME_COMMON_AUDIOMUS_H_
#include "../../nfs4_types.h"

/* P875: source names/signatures checked against native EXT records and
 * defining exports; compile-only typed references verify the C++ linkage. */

void AudioMus_RefreshStatus(void);   /* :83 */
int AudioMus_Threshold(void);   /* :146 */
int AudioMus_Buffered(void);   /* :167 */
AudioMus_tCurrentSong * AudioMus_GetCurrentSong(void);   /* :196 */
void AudioMus_SwitchSong(void);   /* :242 */
void AudioMus_Fail(int errorcode);   /* :285 */
void AudioMus_QueueRequestedSong(void);   /* :316 */
void AudioMus_SetEntry(AudioMus_tSongEntry *info);   /* :345 */
void AudioMus_SetCurrentSongInfo(void);   /* :379 */
int AudioMus_Server(int mode, int ticks);   /* :407 */
AudioMus_tSongList * AudioMus_GetSongList(char *pattern, int memtype);   /* :548 */
void AudioMus_InitGlobals(void);   /* :599 */
void AudioMus_InitDriverGlobals(void);   /* :611 */
void AudioMus_DriverStartUp(int buffersize, int spusize);   /* :642 */
void AudioMus_SysStartUp(int buffersize, int spusize, char *songs);   /* :701 */
void AudioMus_DriverCleanUp(void);   /* :757 */
void AudioMus_SysCleanUp(void);   /* :777 */
void AudioMus_StopSong(int fadeticks);   /* :796 */
void AudioMus_BuildPlayList(int numplaylistsongs, int *playlist);   /* :836 */
void AudioMus_BuildPattern(char *pattern);   /* :856 */
int AudioMus_PlaySong(char *pattern);   /* :875 */
void AudioMus_Volume(int volume);   /* :961 */
void AudioMus_AutoVolume(int fadeticks, int volume);   /* :1009 */

#endif /* _GAME_COMMON_AUDIOMUS_H_ */
