/* game/psx/audio.h — reconstructed from game/psx/audio.cpp (6 fns) */
#ifndef _GAME_PSX_AUDIO_H_
#define _GAME_PSX_AUDIO_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Audio_InitDriver(int buffersize,int spusize);   /* SYM 392096 @0x800bbb84 */
void Audio_DeInitDriver(void);   /* SYM 3920b9 @0x800bbc64 */
void Audio_CleanUp(void);   /* SYM 3920dd @0x800bbcc0 */
void Audio_FECleanUp(void);   /* SYM 3920fc @0x800bbd1c */
int AudioCmn_AddBank(char * filename,int size,char * pdata,int BankNum);   /* SYM 39211d @0x800bbd64 */
int AudioCmn_LoadBank(char * filename,int BankNum);   /* SYM 392144 @0x800bbe8c */

#endif /* _GAME_PSX_AUDIO_H_ */
