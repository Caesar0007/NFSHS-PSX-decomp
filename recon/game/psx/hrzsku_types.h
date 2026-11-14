#ifndef NFS4_GAME_PSX_HRZSKU_TYPES_H
#define NFS4_GAME_PSX_HRZSKU_TYPES_H   /* hrzsku.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_PRIM_POLY_FT4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_POLY_G4   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_TILE_1   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#include "../common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../common/draw_leaf_a_pads.h"
#include "../common/draw_leaf_b_pixmap.h"
#include "../common/draw_leaf_c_cache.h"
#include "shared/Draw_DCache.h"   /* own types at this point */
#include "../common/draw_leaf_d_carvertex.h"
#include "../common/draw_leaf_types.h"
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
/* Canonical gmesetup.obj aggregate retained by hrzsku.obj. */
/* GameSetup_tData: not in retail hrzsku.obj (GameSetup_gData is read through its word view) */




















#include "shared/POLY_FT4.h"




#include "shared/POLY_G4.h"




#include "shared/POLY_GT4.h"





/* TILE_1: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_TILE_1, retail libgpu.h order) */

#include "shared/CCOORD16.h"
#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Draw_DCache.h"
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/RelCoord16.h"
#include "../common/gamesetup_leaf_types.h"
#include "hrzsku_caches.h"

#include "shared/Group.h"   /* one Group definition (header-truth 4n) */
#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/tSaveSurface.h"

#include "shared/BWorldSm_Pos.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"




#include "shared/BO_tNewtonObj.h"















#include "shared/forceFocus_t.h"
#include "shared/FLARE_PIECE_DEF.h"
#include "shared/CHorizonSpec.h"
#include "shared/CSkySpec.h"






#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#include "shared/CTrackSpec.h"










#include "shared/kernpair.h"
typedef kernpair KERN;
typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
typedef int (*getcode)();
typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();






struct tHrz_LightningFork { DVECTOR pos; char pmxIndex; };
struct tHrz_Lightning { tHrz_LightningFork forks[16]; int brightness; char numForks; };

struct Draw_FlareCache;

#endif
