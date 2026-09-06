#include "C:/Temp/nfs4-decomp/recon/game/psx/force.h"
void (*p875_probe_0)(void) = &Force_Vbl;
void (*p875_probe_1)(Car_tObj * car) = &Force_Update;
void (*p875_probe_2)(void) = &Force_StartUp;
void (*p875_probe_3)(void) = &Force_Disable;
int (*p875_probe_4)(Car_tObj * car) = &Force_IsForceOn;
void (*p875_probe_5)(void) = &Force_Pause;
void (*p875_probe_6)(void) = &Force_UnPause;
void (*p875_probe_7)(Car_tObj * car) = &Force_HitSign;
void (*p875_probe_8)(int impulse) = &Force_HitWall;
