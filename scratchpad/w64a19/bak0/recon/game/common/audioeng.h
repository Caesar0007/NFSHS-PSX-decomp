/* game/common/audioeng.h — reconstructed from game/common/audioeng.cpp (9 fns) */
#ifndef _GAME_COMMON_AUDIOENG_H_
#define _GAME_COMMON_AUDIOENG_H_
#include "../../nfs4_types.h"

void AudioEng_Set__Fiiiiiiii(int player, int vol, int esp, int gas, int cam, int dop, int azi, int dir);   /* :205 */
void AudioEng_Update__Fv(void);   /* :266 */
void AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef(char *filename, char *name, int handle, long offset, long size, AudioEng_tDef **ed);   /* :460 */
int AudioEng_StartUp__FiPc(int player, char *carname);   /* :478 */
void AudioEng_StartServer__Fv(void);   /* :660 */
void AudioEng_StopServer__Fv(void);   /* :667 */
void AudioEng_Pause__Fv(void);   /* :674 */
void AudioEng_Resume__Fv(void);   /* :702 */
void AudioEng_CleanUp__Fv(void);   /* :708 */

#endif /* _GAME_COMMON_AUDIOENG_H_ */
