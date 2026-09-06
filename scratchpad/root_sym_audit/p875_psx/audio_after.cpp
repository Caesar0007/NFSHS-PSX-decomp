#include "C:/Temp/nfs4-decomp/recon/game/psx/audio.h"
void (*p875_probe_0)(int buffersize,int spusize) = &Audio_InitDriver;
void (*p875_probe_1)(void) = &Audio_DeInitDriver;
void (*p875_probe_2)(void) = &Audio_CleanUp;
void (*p875_probe_3)(void) = &Audio_FECleanUp;
int (*p875_probe_4)(char * filename,int size,char * pdata,int BankNum) = &AudioCmn_AddBank;
int (*p875_probe_5)(char * filename,int BankNum) = &AudioCmn_LoadBank;
