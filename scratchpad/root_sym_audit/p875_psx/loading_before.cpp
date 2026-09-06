/* Frozen original recon/game/psx/loading.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Loading_DrawLoadingScreen__Fv(void);   /* :15 */
void Loading_UpdateLoadingScreen__Fi(int checkpoint);   /* :60 */
void Loading_GetInitialMemory__Fv(void);   /* :105 */
void (*p875_probe_0)(void) = &Loading_DrawLoadingScreen__Fv;
void (*p875_probe_1)(int checkpoint) = &Loading_UpdateLoadingScreen__Fi;
void (*p875_probe_2)(void) = &Loading_GetInitialMemory__Fv;
