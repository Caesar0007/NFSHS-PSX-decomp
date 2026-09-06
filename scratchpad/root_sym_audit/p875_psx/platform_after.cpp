#include "C:/Temp/nfs4-decomp/recon/game/psx/platform.h"
void (*p875_probe_0)(void) = &Platform_InitMemory;
char * (*p875_probe_1)(int size,char * string) = &Platform_ReserveMemory;
char * (*p875_probe_2)(int size,char * string) = &Platform_TempReserveMemory;
void (*p875_probe_3)(void) = &Platform_SysStartUp;
void (*p875_probe_4)(void) = &Platform_DebuggerPollHost;
void (*p875_probe_5)(void) = &nfs2eacinit;
void (*p875_probe_6)(void) = &Platform_ResetDCTBuffer;
char * (*p875_probe_7)(int size,char * string) = &Platform_GetDCTBuffer;
