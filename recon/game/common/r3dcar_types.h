/* R3DCar.obj's exact source-visible extension of the shared DrawC graph. */
#ifndef NFS4_GAME_COMMON_R3DCAR_TYPES_H
#define NFS4_GAME_COMMON_R3DCAR_TYPES_H

#define NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "../psx/drawc_types.h"
#undef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES

/* Retail exposes these fixed scratchpad cells as lvalues, not storage owned by
 * R3DCar.obj. Keep the address-bearing source expressions without importing
 * the broad project type header. */
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#define gScratchLastWord   (*(int *)0x1F8003FC)

struct Texture_pal8bit;

#include "shared/AudioMus_tSongEntry.h"





struct Transformer_zScene {
    Transformer_zObj *obj[57];
    Transformer_zOverlay overlay[90];
};

struct R3DCar_tEnvMapInfo {
    int eScaleX, eScaleY, rideHeight, upgradeHeight;
};

/* Canonical AITune.obj aggregate used by this translation unit. */
#include "shared/AITune_tTrackInfo.h"



/* Canonical camera.obj aggregate used by this translation unit. */
#include "shared/camera_info.h"





























/* Canonical sim.obj aggregates used by this translation unit. */
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




/* Canonical replay.obj aggregate used by this translation unit. */
#include "shared/tReplayInterface.h"



/* Canonical DrawC.obj aggregate used by this translation unit. */
#include "shared/DrawC_tEnvMap.h"



typedef int Input_tDeviceCall();

#endif
