/* psxcontroller.obj's exact source-visible type surface reconstructed from SYM. */
#if !defined(NFS4_GAME_PSX_PSXCONTROLLER_TYPES_H)
#define NFS4_GAME_PSX_PSXCONTROLLER_TYPES_H
#if !defined(NFS4_GAME_PSX_DRAWC_TYPES_H) && !defined(NFS4_GAME_PSX_HUD_TYPES_H)   /* psxcontroller.obj itself, not drawc/r3dcar/hud */
#define NFS4_PSXCONTROLLER_HOOKS
#endif

#define NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "../common/gmesetup_types.h"
#undef NFS4_GMESETUP_OMIT_OWNER_RECORDS

#include "shared/tPadModuleState.h"







#if defined(NFS4_GAME_PSX_HUD_TYPES_H) || defined(NFS4_GAME_COMMON_R3DCAR_TYPES_H)   /* hud/r3dcar still read GameSetup_tData members */
#include "shared/GameSetup_tData.h"
#endif
















#elif defined(NFS4_PSXCONTROLLER_HOOKS) && !defined(NFS4_PSXCONTROLLER_CV_DONE)   /* draw_leaf CARVERTEX pass */
#define NFS4_PSXCONTROLLER_CV_DONE
#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"
#endif
