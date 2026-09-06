/* Frozen original recon/game/psx/trackspec.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void TrackSpec_SetDefault__FP10CTrackSpec(CTrackSpec *spec);   /* :44 */
void TrackSpec_SetUp__Fv(void);   /* :119 */
void read__FPPcPvi(char **handle, void *buf, int bytes);   /* :127 */
void TrackSpec_Read__Fi(int spec_num);   /* :145 */
void TrackSpec_Load__Fii(int weather, int night);   /* :205 */
void (*p875_probe_0)(CTrackSpec *spec) = &TrackSpec_SetDefault__FP10CTrackSpec;
void (*p875_probe_1)(void) = &TrackSpec_SetUp__Fv;
void (*p875_probe_2)(char **handle, void *buf, int bytes) = &read__FPPcPvi;
void (*p875_probe_3)(int spec_num) = &TrackSpec_Read__Fi;
void (*p875_probe_4)(int weather, int night) = &TrackSpec_Load__Fii;
