/* flare.obj's exact source-visible type surface reconstructed from SYM.
 * Its shared game graph is the already-exact color.obj surface; the records
 * below are precisely the named delta retained by the standalone flare owner. */
#if !defined(NFS4_GAME_PSX_FLARE_TYPES_H)   /* first pass */
#define NFS4_GAME_PSX_FLARE_TYPES_H
#define NFS4_PRIM_POLY_F4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_G3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_G4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_LINE_G2   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_COLOR_GROUP_LATE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CACHEHEADER "shared/Draw_FlareCache.h"   /* retail: Draw_FlareCache right after Draw_tCacheHeader */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "../common/color_p0_draw.h"
#include "../common/color_p1_pregroup.h"
#include "../common/color_p2_group_trk.h"
#include "../common/color_p3_trkobj.h"
#include "../common/color_p4_save.h"
#include "../common/color_p5_bwsm.h"
#include "../common/color_p6_bo.h"
#define NFS4_COLOR_IN_HOOK
#include "../psx/flare_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK branch */
#undef NFS4_COLOR_IN_HOOK
#include "../common/color_p7_sched.h"
#include "../common/color_p8_car.h"
#include "../common/color_p9_tail.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_FLARE_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_FLARE_EARLY_DONE
#include "shared/forceFocus_t.h"


typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE   /* color_types.h: the scheduler types are already declared */
#include "shared/FLARE_PIECE_DEF.h"
#include "shared/FLARE_DEF.h"
#include "shared/CHorizonSpec.h"
#include "shared/CSkySpec.h"
#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_FLARE_TAIL_DONE)   /* first pass, after color_types.h */
#define NFS4_FLARE_TAIL_DONE
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
/* Canonical gmesetup.obj aggregate retained by flare.obj. */
/* GameSetup_tData: not in retail flare.obj (GameSetup_gData is read through its word view) */











#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#include "shared/POLY_F4.h"



#include "shared/POLY_FT4.h"




#include "shared/POLY_G3.h"



#include "shared/POLY_G4.h"




#include "shared/LINE_G2.h"




#include "shared/DRender_tView.h"
#include "shared/Draw_FlareCache.h"
#include "shared/Sched_tSchedule.h"



#include "shared/Sim_tSimGlobalVar.h"











typedef struct Flare_tInfo { u_long chalo,cbeam; int scale,flags; } Flare_tInfo;












#include "shared/CTrackSpec.h"

#endif