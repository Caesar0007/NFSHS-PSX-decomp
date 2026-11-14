/* R3DCar.obj's exact source-visible extension of the shared DrawC graph. */
#if !defined(NFS4_GAME_COMMON_R3DCAR_TYPES_H)
#define NFS4_GAME_COMMON_R3DCAR_TYPES_H
#define NFS4_GMESETUP_HOOK_BEFORE_FE "r3dcar_types.h"   /* retail r3dcar.obj: forceFocus_t TCB EXEC DIRENTRY Skidmark_* right after Car_tObj */
#define NFS4_DRAWC_R3DCAR_FF_EARLY

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






/* R3DCar_tEnvMapInfo: defined in r3dcar.cpp right before R3DCar_EnvMapInfo (INV-A3: retail type-record position) */



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

#elif defined(NFS4_GMESETUP_IN_FE_HOOK) && !defined(NFS4_R3DCAR_FE_DONE)
#define NFS4_R3DCAR_FE_DONE
#include "shared/forceFocus_t.h"


#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#elif defined(NFS4_TRANSFORMER_IN_HOOK) && !defined(NFS4_R3DCAR_TZ_DONE)
#define NFS4_R3DCAR_TZ_DONE
typedef struct Transformer_zScene {
    Transformer_zObj *obj[57];
    Transformer_zOverlay overlay[90];
} Transformer_zScene;
#endif
