/* Frozen original recon/game/psx/audio.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Audio_InitDriver__Fii(int buffersize, int spusize);   /* :58 */
void Audio_DeInitDriver__Fv(void);   /* :84 */
void Audio_CleanUp__Fv(void);   /* :133 */
void Audio_FECleanUp__Fv(void);   /* :151 */
int AudioCmn_AddBank__FPciT0i(char *filename, int size, char *pdata, int BankNum);   /* :167 */
int AudioCmn_LoadBank__FPci(char *filename, int BankNum);   /* :217 */
void (*p875_probe_0)(int buffersize, int spusize) = &Audio_InitDriver__Fii;
void (*p875_probe_1)(void) = &Audio_DeInitDriver__Fv;
void (*p875_probe_2)(void) = &Audio_CleanUp__Fv;
void (*p875_probe_3)(void) = &Audio_FECleanUp__Fv;
int (*p875_probe_4)(char *filename, int size, char *pdata, int BankNum) = &AudioCmn_AddBank__FPciT0i;
int (*p875_probe_5)(char *filename, int BankNum) = &AudioCmn_LoadBank__FPci;
