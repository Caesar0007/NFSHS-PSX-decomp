#include "C:/Temp/nfs4-decomp/recon/game/psx/device.h"
int (*p875_probe_0)(int port) = &Device_VerifyType;
int (*p875_probe_1)(int port) = &Device_Fail;
void (*p875_probe_2)(void) = &Device_Update;
void (*p875_probe_3)(void) = &Device_StartUp;
void (*p875_probe_4)(void) = &Device_SetHardCodedKeys;
int (*p875_probe_5)(u_long param) = &Device_PSXPad;
bool (*p875_probe_6)(int port,u_long param) = &Device_ReadPad;
int (*p875_probe_7)(u_long param) = &Device_PSXPadMulti;
int (*p875_probe_8)(u_long param) = &Device_Analog;
int (*p875_probe_9)(u_long param) = &Device_Null;
