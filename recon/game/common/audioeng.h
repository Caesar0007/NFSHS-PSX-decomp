/* game/common/audioeng.h — reconstructed from game/common/audioeng.cpp (9 fns) */
#ifndef _GAME_COMMON_AUDIOENG_H_
#define _GAME_COMMON_AUDIOENG_H_
#include "../../nfs4_types.h"

/* P874: source names; C++ supplies the native GCC-v2 linkage mangling. */

void AudioEng_Set(int player, int vol, int esp, int gas, int cam, int dop, int azi, int dir);   /* :205 */
void AudioEng_Update(void);   /* :266 */
void AudioEng_LoadDef(char *filename, char *name, int handle, long offset, long size, AudioEng_tDef **ed);   /* :460 */
int AudioEng_StartUp(int player, char *carname);   /* :478 */
void AudioEng_StartServer(void);   /* :660 */
void AudioEng_StopServer(void);   /* :667 */
void AudioEng_Pause(void);   /* :674 */
void AudioEng_Resume(void);   /* :702 */
void AudioEng_CleanUp(void);   /* :708 */

#endif /* _GAME_COMMON_AUDIOENG_H_ */
