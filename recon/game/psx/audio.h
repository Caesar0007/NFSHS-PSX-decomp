/* game/psx/audio.h — reconstructed from game/psx/audio.cpp (6 fns) */
#ifndef _GAME_PSX_AUDIO_H_
#define _GAME_PSX_AUDIO_H_
#include "../../nfs4_types.h"

void Audio_InitDriver__Fii(int buffersize, int spusize);   /* :58 */
void Audio_DeInitDriver__Fv(void);   /* :84 */
void Audio_CleanUp__Fv(void);   /* :133 */
void Audio_FECleanUp__Fv(void);   /* :151 */
int AudioCmn_AddBank__FPciT0i(char *filename, int size, char *pdata, int BankNum);   /* :167 */
int AudioCmn_LoadBank__FPci(char *filename, int BankNum);   /* :217 */

#endif /* _GAME_PSX_AUDIO_H_ */
