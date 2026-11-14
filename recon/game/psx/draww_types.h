/* DrawW.obj's exact source-visible type surface reconstructed from SYM.
 * color.obj is an exact 71-record subset; the declarations below are the
 * complete DrawW owner delta, including the independent SDK typedef lane. */
#if !defined(NFS4_GAME_PSX_DRAWW_TYPES_H)   /* first pass */
#define NFS4_GAME_PSX_DRAWW_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* the standalone owner only */
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
/* GameSetup: declared at the end of the third pass below (retail: after Draw_tCtrlSkidmark) */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_SIMPLE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_LINE   /* retail type order (game/common/color_types.h) */
#define NFS4_PRIM_POLY_GT3   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#define NFS4_PRIM_DR_TWIN   /* retail: libgpu primitive right after DISPENV (nfs4_types.h) */
#endif
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this header lists the parts of the common type graph itself (retail record order) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this header lists the draw leaf itself (retail record order) */
#include "../common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../common/draw_leaf_b_pixmap.h"
#include "../common/draw_leaf_c_cache.h"
#include "shared/Draw_DCache.h"   /* own types at this point */
#include "../common/draw_leaf_d_carvertex.h"
#ifdef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* bworld.obj: track object types right after Draw_CarVertex */
#include "../common/bworld_after_carvertex.h"
#endif
#include "../common/color_p0_draw.h"
#ifdef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* bworld.obj: Trk_SFX/Trk_SimObject after Trk_NewSimSlice */
#include "../common/trk_sfx_simobject_late.h"
#endif
#include "../common/color_p1_pregroup.h"
#include "../common/color_p2_group_trk.h"
#include "../common/color_p3_trkobj.h"
#define NFS4_COLOR_IN_HOOK5   /* Chunk right after RelCoord16 (draww) / Group (bworld) */
#include "../psx/draww_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK5 branch */
#undef NFS4_COLOR_IN_HOOK5
#include "../common/color_p4_save.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* draww.obj: tBoundingSphere..Draw_tCtrlSkidmark right after tSaveSurface */
#define NFS4_COLOR_IN_HOOK3
#include "../psx/draww_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK3 branch */
#undef NFS4_COLOR_IN_HOOK3
#endif
#include "../common/color_p5_bwsm.h"
#include "../common/color_p6_bo.h"
#define NFS4_COLOR_IN_HOOK   /* right after the BO types: draww.obj forceFocus_t, bworld.obj its BW_tContext run */
#ifdef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "../common/bworld_types.h"   /* included from bworld_types.h: its NFS4_COLOR_IN_HOOK branch */
#else
#include "../psx/draww_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK branch */
#endif
#undef NFS4_COLOR_IN_HOOK
#include "../common/color_p7_sched.h"
#ifdef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* bworld.obj: AnimScript right after Sched_tSchedule */
#include "shared/AnimScript.h"
#endif
#include "../common/color_p8_car.h"
#include "../common/color_p9_tail.h"
#endif
#if (defined(NFS4_COLOR_IN_HOOK) || defined(NFS4_DRAWW_FF_HERE)) && !defined(NFS4_COLOR_IN_HOOK5) && !defined(NFS4_DRAWW_EARLY_DONE)   /* second pass (owner) / after FLARE_PIECE_DEF (bworld, below) */
#define NFS4_DRAWW_EARLY_DONE
#include "shared/forceFocus_t.h"




#endif
#if defined(NFS4_COLOR_IN_HOOK3) && !defined(NFS4_DRAWW_SAVE_DONE)   /* third pass (owner), from color_types.h */
#define NFS4_DRAWW_SAVE_DONE
#include "shared/tBoundingSphere.h"
#include "shared/Draw_tGiveShelbyMoreCache.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/Draw_tCtrlSkidmark.h"
#include "../common/gamesetup_leaf_types.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK5) && !defined(NFS4_DRAWW_CHUNK_DONE)   /* pass from color_types.h (after RelCoord16) */
#define NFS4_DRAWW_CHUNK_DONE
#include "shared/Chunk.h"   /* one Chunk definition (header-truth 4o) */









#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_COLOR_IN_HOOK3) && !defined(NFS4_COLOR_IN_HOOK5) && !defined(NFS4_DRAWW_TAIL_DONE)   /* first pass, after color_types.h */
#define NFS4_DRAWW_TAIL_DONE
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#define gScratchLastWord   (*(int *)0x1F8003FC)
#include "shared/Trk_ObjectDef.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "shared/Trk_SimpleInst.h"
#endif
#include "shared/Trk_CollideBoomInst.h"
#include "shared/Trk_AnimateInst.h"
#include "shared/Trk_SimObject.h"





#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical bworldSm.obj aggregate (SYM: Trk_NewSlice, size 32). */
#include "shared/Trk_NewSlice.h"






#endif

#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* retail draww: FLARE_PIECE_DEF right before BW_tContext */
#include "shared/FLARE_PIECE_DEF.h"
#endif
#include "shared/BW_tContext.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* retail draww: tBuildEntry right after BW_tContext */
#include "draww_types_d1.h"
#endif




#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* bworld_types.h declares it in its BO pass */

#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4f) */



#endif
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* retail draww: AIDataRecord family and tQuat right after AnimScript */
#include "../common/aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */














#include "shared/tQuat.h"
#endif
#include "shared/SceneElem.h"




#include "shared/SceneSortedElem.h"
#ifdef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES   /* retail bworld: kernel/skidmark/FLARE_PIECE_DEF right after the Scene types */
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/FLARE_PIECE_DEF.h"
#define NFS4_DRAWW_FF_HERE   /* retail bworld: forceFocus_t right after FLARE_PIECE_DEF (second-pass block above) */
#include "draww_types.h"
#endif
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic family, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
#include "../common/object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */











#include "shared/DRender_tView.h"
#include "shared/Draw_DCache.h"







#include "shared/CHorizonSpec.h"



#include "shared/CSkySpec.h"











#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"





#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical gmesetup.obj aggregate (SYM: GameSetup_tData, size 2600). */
#ifdef NFS4_GAME_COMMON_BWORLD_TYPES_H   /* bworld keeps the struct; draww.obj records none */
#include "shared/GameSetup_tData.h"
#endif
















/* Canonical trackspec.obj aggregate (SYM: CTrackSpec, size 264). */
#include "shared/CTrackSpec.h"











/* Canonical camera.obj aggregate (SYM: camera_info, size 272). */
#include "shared/camera_info.h"




























#endif

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* POLY_GT3: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_POLY_GT3, retail libgpu.h order) */





#endif
#include "shared/POLY_GT4.h"






#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* DR_TWIN: declared by nfs4_types.h right after DISPENV (NFS4_PRIM_DR_TWIN, retail libgpu.h order) */
#endif

#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Trk_Line: declared by color_types.h right before Trk_SimObject (NFS4_COLOR_TRK_LINE) */

#include "shared/Draw_tGiveShelbyMoreCache.h"

























#endif

#include "shared/Skidmark_Segment.h"




#include "shared/Skidmark_Chunk.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "shared/Draw_tCtrlSkidmark.h"
#endif
#include "shared/FLARE_PIECE_DEF.h"
#include "shared/Sched_tSchedule.h"
#ifndef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
/* Canonical sim.obj aggregate (SYM: Sim_tSimGlobalVar, size 24). */
#include "shared/Sim_tSimGlobalVar.h"
#include "shared/tBoundingSphere.h"
#include "shared/tQuat.h"
#include "shared/kernpair.h"
#include "draww_types_d2.h"
#endif
#include "draww_types_d3.h"

#endif
