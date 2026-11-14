/* gmesetup.obj source-visible types; full supplied type-copy/order audit remains open. */
#if !defined(NFS4_GAME_COMMON_GMESETUP_TYPES_H) && !defined(NFS4_PADS_IN_HOOK)
#define NFS4_GAME_COMMON_GMESETUP_TYPES_H

#ifndef NFS4_GAME_COMMON_COLOR_TYPES_H   /* the parts of the common type graph, listed here: drawc.obj and hud.obj have their own types between them */
#define NFS4_GAME_COMMON_COLOR_TYPES_H
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* the start of the core, listed here: psxcontroller.obj and gmesetup.obj have their own types around the pads */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#ifdef NFS4_PSXCONTROLLER_HOOKS   /* psxcontroller.obj: GameSetup records right before the pads */
#include "gamesetup_leaf_types.h"
#endif
#include "pads_records.h"
#ifndef NFS4_GMESETUP_OMIT_OWNER_RECORDS   /* gmesetup.obj: GameSetup records, FEI_tList, Transformer_* right after PAD_COMMON */
#define NFS4_PADS_IN_HOOK
#include "gmesetup_types.h"
#undef NFS4_PADS_IN_HOOK
#endif
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#include "draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* the draw leaf, listed here: drawc/r3dcar, hud and psxcontroller have their own types in it */
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_b_pixmap.h"
#if defined(NFS4_DRAWC_HOOKS) || defined(NFS4_GAME_COMMON_R3DCAR_TYPES_H)   /* drawc.obj, r3dcar.obj: Draw_tVertex right after Draw_tPixMap */
#include "shared/Draw_tVertex.h"
#endif
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#if defined(NFS4_DRAWC_HOOKS) || defined(NFS4_GAME_COMMON_R3DCAR_TYPES_H)   /* drawc.obj, r3dcar.obj: Draw_CarCache right after Draw_CarVertex */
#include "shared/Draw_CarCache.h"
#elif defined(NFS4_GAME_PSX_HUD_TYPES_H)   /* hud.obj: FLARE_PIECE_DEF, HudPmx_tShape */
#include "../psx/hud_after_carvertex.h"
#elif defined(NFS4_PSXCONTROLLER_HOOKS)   /* psxcontroller.obj: tTexture_ShapeInfo, kernpair */
#include "../psx/psxcontroller_types.h"
#endif
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#ifdef NFS4_DRAWC_HOOKS   /* drawc.obj: Skidmark_*, DrawC_tEnvMap, GameSetup, Udff right after tSaveSurface */
#define NFS4_COLOR_IN_HOOK3
#include "../psx/drawc_types.h"
#undef NFS4_COLOR_IN_HOOK3
#endif
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#ifdef NFS4_DRAWC_HOOKS   /* drawc.obj: forceFocus_t right after BO_tNewtonObj */
#define NFS4_COLOR_IN_HOOK
#include "../psx/drawc_types.h"
#undef NFS4_COLOR_IN_HOOK
#endif
#include "color_p7_sched.h"
#ifdef NFS4_GAME_COMMON_R3DCAR_TYPES_H   /* r3dcar.obj: Transformer_zScene right after Transformer_zOverlay */
#include "shared/Transformer_z.h"
#define NFS4_TRANSFORMER_IN_HOOK
#include "r3dcar_types.h"
#undef NFS4_TRANSFORMER_IN_HOOK
#endif
#include "color_p8_car.h"
#if defined(NFS4_DRAWC_HOOKS)   /* drawc.obj: FLARE_PIECE_DEF, BW_tContext, kernpair right after Car_tObj */
#define NFS4_COLOR_IN_HOOK2
#include "../psx/drawc_types.h"
#undef NFS4_COLOR_IN_HOOK2
#elif defined(NFS4_GAME_PSX_HUD_TYPES_H)   /* hud.obj: forceFocus/AIDataRecord/kernpair/AudioMus right after Car_tObj */
#define NFS4_COLOR_IN_HOOK2
#include "../psx/hud_types.h"
#undef NFS4_COLOR_IN_HOOK2
#endif
#include "color_p9_tail.h"
#endif

#ifndef NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "shared/FEI_tList.h"

#include "shared/Input_tDeviceList.h"





#include "shared/GameSetup_tData.h"















#endif

#ifdef NFS4_GMESETUP_HOOK_BEFORE_FE   /* an includer's own types between Car_tObj and the frontend block (r3dcar.obj) */
#define NFS4_GMESETUP_IN_FE_HOOK
#include NFS4_GMESETUP_HOOK_BEFORE_FE
#undef NFS4_GMESETUP_IN_FE_HOOK
#endif
#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"










#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */












struct tMenuCommand;
struct tMenu;
struct tScreen;

#include "shared/fe_menu_game_surface.h"
































#include "shared/tCarModels.h"























#include "shared/tCarInfo.h"




















#include "shared/tOwnedCarInfo.h"
#include "shared/tCarNameLength.h"




#include "../../frontend/common/fecars_manager.h"   /* class tCarManager: no private copy (header-truth 4k) */













#include "shared/tPersonalities.h"







#include "shared/tfrontEnd.h"















































typedef kernpair KERN;

/* Some object owners retain the shared GameSetup graph but not this callback
 * typedef.  Narrow owner headers may suppress only this row while keeping the
 * remaining canonical surface unchanged. */
#ifndef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_GMESETUP_PADS_DONE)
#define NFS4_GMESETUP_PADS_DONE
#include "gamesetup_leaf_types.h"
#include "shared/GameSetup_tData.h"
#include "shared/FEI_tList.h"
#include "shared/Transformer_z.h"
#endif
