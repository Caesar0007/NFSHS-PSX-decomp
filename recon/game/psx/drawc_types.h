/* DrawC.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 19-name delta retained by the standalone DrawC owner. */
#if !defined(NFS4_GAME_PSX_DRAWC_TYPES_H)
#define NFS4_GAME_PSX_DRAWC_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES   /* the standalone owner only */
#define NFS4_DRVIEW_STRUCT_ONLY   /* retail: one TPDEF DRender_tView (shared/DRender_tView.h) */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_G3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#define NFS4_DRAWC_R3DCAR_FF_EARLY
#define NFS4_DRAWC_HOOKS
#endif
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "psxcontroller_types.h"
#undef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#include "drawc_types_d1.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"



#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
/* POLY_FT3: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_POLY_FT3, retail libgpu.h order) */




#include "shared/POLY_FT4.h"




#include "shared/POLY_G3.h"



#endif
#include "shared/POLY_GT4.h"






#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/BW_tContext.h"




#endif
#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"



#include "shared/Track_tMaterial.h"
#include "shared/Skidmark_Segment.h"


#include "shared/Skidmark_Chunk.h"
#ifndef NFS4_DRAWC_R3DCAR_FF_EARLY   /* r3dcar.obj: forceFocus_t emitted earlier (r3dcar_types.h, before the frontend block) */
#include "shared/forceFocus_t.h"


#endif
#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/FLARE_PIECE_DEF.h"
#endif
#include "shared/Sched_tSchedule.h"




#include "shared/Draw_tVertex.h"
#include "shared/DRender_tView.h"
#include "shared/Draw_CarCache.h"























#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "shared/DrawC_tEnvMap.h"
#endif
#elif defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_DRAWC_BO_DONE)   /* second pass, color_types.h AFTER_BO */
#define NFS4_DRAWC_BO_DONE
#include "shared/forceFocus_t.h"


#elif defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_DRAWC_CAR_DONE)   /* AFTER_CAR */
#define NFS4_DRAWC_CAR_DONE
#include "shared/FLARE_PIECE_DEF.h"
#include "shared/BW_tContext.h"
#include "shared/kernpair.h"
#elif defined(NFS4_DRAWC_HOOKS) && !defined(NFS4_DRAWC_SAVE_DONE)   /* AFTER_SAVE (plain hook: the owner's first re-entry) */
#define NFS4_DRAWC_SAVE_DONE
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/DrawC_tEnvMap.h"
#include "../common/gamesetup_leaf_types.h"
#include "shared/Udff_tAccessType.h"



#include "drawc_types_d2.h"
#endif
