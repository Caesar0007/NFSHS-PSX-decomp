#ifndef NFS4_GAME_PSX_FE3DMENU_TYPES_H
#define NFS4_GAME_PSX_FE3DMENU_TYPES_H   /* fe3dmenu.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_COLOR_GS_AFTER_SAVE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "shared/Draw_CarCache.h"   /* retail: Draw_CarCache right after Draw_CarVertex */
#define NFS4_COLOR_HOOK_AFTER_SAVE "../psx/fe3dmenu_after_save.h"   /* retail: skidmark records after tSaveSurface */
#define NFS4_COLOR_HOOK_AFTER_BO "../psx/fe3dmenu_after_bo.h"   /* retail: forceFocus_t after the BO types */
#include "../common/color_types.h"
#include "shared/POLY_GT4.h"


#include "shared/DRender_tView.h"




#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"





#include "fe3dmenu_after_bo.h"





#include "shared/Sched_tSchedule.h"




#include "shared/Draw_CarCache.h"

































#endif
