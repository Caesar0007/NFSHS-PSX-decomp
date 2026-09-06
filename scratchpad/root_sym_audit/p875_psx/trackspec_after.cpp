#include "C:/Temp/nfs4-decomp/recon/game/psx/trackspec.h"
void (*p875_probe_0)(CTrackSpec * spec) = &TrackSpec_SetDefault;
void (*p875_probe_1)(void) = &TrackSpec_SetUp;
void (*p875_probe_2)(char ** handle,void * buf,int bytes) = &read;
void (*p875_probe_3)(int spec_num) = &TrackSpec_Read;
void (*p875_probe_4)(int weather,int night) = &TrackSpec_Load;
