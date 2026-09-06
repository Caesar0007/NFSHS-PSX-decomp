/* Frozen original recon/game/psx/psxcontroller.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void InGame_ResetPSXController__Fii(int player, int config);   /* :97 */
int InGame_GetPSXPadValue__Fii(int value, int player);   /* :197 */
int InGame_GetDevice__Fi(int control);   /* :338 */
void InGame_SetRamp__Fv(void);   /* :349 */
void (*p875_probe_0)(int player, int config) = &InGame_ResetPSXController__Fii;
int (*p875_probe_1)(int value, int player) = &InGame_GetPSXPadValue__Fii;
int (*p875_probe_2)(int control) = &InGame_GetDevice__Fi;
void (*p875_probe_3)(void) = &InGame_SetRamp__Fv;
