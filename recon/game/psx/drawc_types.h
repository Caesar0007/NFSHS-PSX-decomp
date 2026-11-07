/* DrawC.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 19-name delta retained by the standalone DrawC owner. */
#ifndef NFS4_GAME_PSX_DRAWC_TYPES_H
#define NFS4_GAME_PSX_DRAWC_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
#ifndef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES   /* the standalone owner only */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_G3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_FT3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_COLOR_GS_AFTER_SAVE   /* retail type order (game/common/color_types.h) */
#endif
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "psxcontroller_types.h"
#undef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
typedef int CarLogic_tObservations[1][3];
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];
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
typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;
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

#endif
