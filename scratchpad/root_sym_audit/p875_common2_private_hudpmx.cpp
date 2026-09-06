/* Expected compile failure: this native STAT function is not public. */
#include "C:/Temp/nfs4-decomp/recon/game/common/hudpmx.h"
void (*p875_common2_private_hudpmx)(char *n, HudPmx_tShape *s) = &HudPmx_LoadShape;
