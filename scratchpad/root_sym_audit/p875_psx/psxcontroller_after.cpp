#include "C:/Temp/nfs4-decomp/recon/game/psx/psxcontroller.h"
void (*p875_probe_0)(int player,int config) = &InGame_ResetPSXController;
int (*p875_probe_1)(int value,int player) = &InGame_GetPSXPadValue;
int (*p875_probe_2)(int control) = &InGame_GetDevice;
void (*p875_probe_3)(void) = &InGame_SetRamp;
