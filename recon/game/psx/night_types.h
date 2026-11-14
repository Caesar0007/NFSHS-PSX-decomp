/* night.obj's exact source-visible type surface reconstructed from SYM.
 * Its shared game graph is the already-exact color.obj surface; the records
 * below are precisely the named delta retained by the standalone night owner. */
#if !defined(NFS4_GAME_PSX_NIGHT_TYPES_H)
#define NFS4_GAME_PSX_NIGHT_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#ifndef NFS4_NIGHT_OMIT_PRIVATE_TYPES   /* the standalone owner only */
#define NFS4_NIGHT_SKID_LATE   /* retail: the Skidmark types after CWorldColor */
#define NFS4_COLOR_HOOK_AFTER_BO_NIGHT_OWNER
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#endif
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this header lists the parts of the common type graph itself (retail record order) */
#include "../common/color_p0_draw.h"
#include "../common/color_p1_pregroup.h"
#include "../common/color_p2_group_trk.h"
#include "../common/color_p3_trkobj.h"
#include "../common/color_p4_save.h"
#include "../common/color_p5_bwsm.h"
#include "../common/color_p6_bo.h"
#define NFS4_COLOR_IN_HOOK   /* the types retail records right after the BO types: night.obj forceFocus_t, render.obj its own run */
#ifdef NFS4_NIGHT_OMIT_PRIVATE_TYPES
#include "../common/render_types.h"   /* included from render_types.h: its NFS4_COLOR_IN_HOOK branch */
#else
#include "../psx/night_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK branch */
#endif
#undef NFS4_COLOR_IN_HOOK
#include "../common/color_p7_sched.h"
#include "../common/color_p8_car.h"
#include "../common/color_p9_tail.h"
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)
/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail night.obj (GameSetup_gData is read through its word view) */
















#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#include "shared/POLY_GT4.h"






#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"



#include "shared/Track_tMaterial.h"
#ifndef NFS4_NIGHT_SKID_LATE
#include "shared/Skidmark_Segment.h"
#endif
#ifndef NFS4_NIGHT_SKID_LATE
#include "shared/Skidmark_Chunk.h"
#endif
#ifndef NFS4_NIGHT_RENDER_LATE   /* render.obj: forceFocus_t via the BO hook, C*Spec late, no CTrackSpec (render_types.h) */
#ifndef NFS4_COLOR_HOOK_AFTER_BO_NIGHT_OWNER
#include "shared/forceFocus_t.h"


#endif

#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"






#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#ifdef NFS4_NIGHT_SKID_LATE
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#endif



#include "shared/CTrackSpec.h"
#endif










#include "shared/camera_info.h"





























#include "shared/Sched_tSchedule.h"




#include "shared/Sim_tSimGlobalVar.h"




#ifndef NFS4_NIGHT_OMIT_PRIVATE_TYPES
struct tCompRGB { char r, g, b; };
struct tNightInitCache { tCompRGB table[257]; };
#endif

typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#elif defined(NFS4_COLOR_IN_HOOK) && defined(NFS4_COLOR_HOOK_AFTER_BO_NIGHT_OWNER) && !defined(NFS4_NIGHT_BO_DONE)   /* second pass: color_types.h AFTER_BO */
#define NFS4_NIGHT_BO_DONE
#include "shared/forceFocus_t.h"


#endif
