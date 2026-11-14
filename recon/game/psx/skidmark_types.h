/* Skidmark.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_SKIDMARK_TYPES_H
#define NFS4_GAME_PSX_SKIDMARK_TYPES_H
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "../common/color_p0_draw.h"
#include "../common/color_p1_pregroup.h"
#include "../common/color_p2_group_trk.h"
#include "../common/color_p3_trkobj.h"
#include "../common/color_p4_save.h"
#include "../psx/skidmark_after_save.h"   /* own types at this point of the retail record order */
#include "../common/color_p5_bwsm.h"
#include "../common/color_p6_bo.h"
#include "../common/color_p7_sched.h"
#include "../common/color_p8_car.h"
#include "../common/color_p9_tail.h"
#include "shared/POLY_GT4.h"





#include "shared/DRender_tView.h"




#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/tSkid.h"







#include "shared/Skidmark_Chunk.h"





#include "shared/Draw_tCtrlSkidmark.h"






#endif
