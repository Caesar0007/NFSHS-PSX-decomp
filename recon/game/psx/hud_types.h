/* hud.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 17-name delta retained by the standalone HUD owner. */
#if !defined(NFS4_GAME_PSX_HUD_TYPES_H)   /* first pass */
#define NFS4_GAME_PSX_HUD_TYPES_H
#define NFS4_DRVIEW_STRUCT_ONLY   /* retail: one TPDEF DRender_tView (shared/DRender_tView.h) */
#define NFS4_PRIM_POLY_F4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_G4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_SPRT   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_F3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_COLOR_SCHED_AFTER_BWSM   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "../psx/hud_after_carvertex.h"   /* retail: FLARE_PIECE_DEF, HudPmx_tShape right after Draw_CarVertex */
#include "psxcontroller_types.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_HUD_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_HUD_EARLY_DONE
#include "shared/forceFocus_t.h"


#include "../common/aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */













#include "shared/kernpair.h"
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tCurrentSong.h"
#endif
#if !defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_HUD_TAIL_DONE)   /* first pass, after psxcontroller_types.h */
#define NFS4_HUD_TAIL_DONE
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
typedef int CarLogic_tObservations[1][3];
#include "shared/Sched_tSchedule.h"

#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




#include "shared/tReplayInterface.h"




#include "shared/DRender_tView.h"





























/* Canonical dashHUD.obj aggregate retained by the retail SYM. */
#include "shared/dashhud_info.h"









/* Canonical overlays.obj BTC record retained by the retail SYM. */
#include "shared/tBTCPerpInfo.h"









#include "shared/camera_info.h"
























#include "shared/FLARE_PIECE_DEF.h"
/* POLY_F3: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_POLY_F3, retail libgpu.h order) */
#include "shared/POLY_F4.h"
#include "shared/POLY_FT4.h"
#include "shared/POLY_G4.h"
#include "shared/POLY_GT4.h"
#include "shared/SPRT.h"
#include "shared/HudPmx_tShape.h"
struct tSmallCoordXY { short x, y; };
#endif
