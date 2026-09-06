/* Frozen original recon/game/psx/overlays.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void OptionsBarThing__Fiiii(int x, int y, int w, int h);   /* :39 */
void RaceSummary__Fv(void);   /* :53 */
void RaceStatistics__Fv(void);   /* :165 */
void Hud_BTCStats__Fsb(short player, BOOL postgame);   /* :326 */
void Hud_RenderStatsView__Fv(void);   /* :450 */
void (*p875_probe_0)(int x, int y, int w, int h) = &OptionsBarThing__Fiiii;
void (*p875_probe_1)(void) = &RaceSummary__Fv;
void (*p875_probe_2)(void) = &RaceStatistics__Fv;
void (*p875_probe_3)(short player, BOOL postgame) = &Hud_BTCStats__Fsb;
void (*p875_probe_4)(void) = &Hud_RenderStatsView__Fv;
