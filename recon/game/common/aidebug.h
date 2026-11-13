/* game/common/aidebug.h -- PARTIALLY RESTORED retail type/include surface.
 * Genuine shared game definitions recover the complete Car_tObj body and
 * other supplied records. Full include/type provenance is still UNRESTORED,
 * including the remaining Car_tObj typedef occurrences. No duplicate aliases
 * are manufactured merely to match a count. The data-only owner does not
 * use Group's inferred count setter,so only its declaration is exposed.
 * Ordered-body audit corrects the old Counter-regrouped body count:the
 * previous graph has70 literal-exact bodies,not67. Genuine shared leaf
 * definitions below restore further supplied bodies;do not pad repeats.
 * Five extra rows are anonymous-identity differences with structural evidence;
 * the opaque Udff_tHandle size and private-type emission remain unresolved.
 * The canonical core's four _physadr body records are absent from retail,
 * whose pointer typedef nevertheless retains referent size4. Preserve that
 * known type size;the original debug-emission context remains review work.
 * Original include spellings are not uniquely retained. Receipt:
 * build/nc12/aidebug_ai_source_20261030/final-proof.json. */
#ifndef _GAME_COMMON_AIDEBUG_H_
#define _GAME_COMMON_AIDEBUG_H_
#define NFS4_CRIMETYPE_PLAIN_ENUM
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#include "shared/MATRIX.h"
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

/* These complete definitions are supplied by aidebug.obj's retail FILE block.
 * Reuse their shared source producers;the original include spellings/order
 * are not uniquely retained. They add no code or owned data. */
#include "shared/POLY_GT4.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_AIDEBUG_AI_GRAPH_ONLY   /* aih_hierarchy_types.h (included below for the AI class graph): skip BrakeInfo/ModelConfig */
typedef int CarLogic_tObservations[1][3];   /* formerly via aidelaycar_types.h; retail aidebug.obj records it */
#include "shared/fontblit_typedefs.h"   /* retail aidebug.obj: fontblit/getcode/fontblitbegin/fontblitend/adjustchar after CarLogic_tObservations */






/* Supplied AI data declarations,without importing unrelated state classes
 * or their inline construction/vtable references. AIDelayCar's existing
 * owner header supplies its actual class and observation-array typedef. */
#include "aicop_info_types.h"   /* retail aidebug.obj: copLevel/copGame/copType/crimeType + the perp info records */
#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_offroad_t.h"
#include "shared/trigger_trafficAccident_t.h"
#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"
#include "shared/trigger_t.h"
#include "aih_hierarchy_types.h"   /* retail aidebug.obj records the AI class graph (AIDelayCar, AIState_Base/Normal/NonActive, AIHigh_Base..BTC_Cop): the real hierarchy header, not only aidelaycar_types.h */
#include "shared/cruiseMode_t.h"
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"
#include "shared/stateType_t.h"
#include "shared/Wingman_Role.h"
#include "shared/AIHigh_tAttackMode.h"
#include "shared/blockadeMode_t.h"
#include "shared/AIHigh_tDriveAwayMode.h"
#include "frontend/common/felines_kern.h"   /* kernpair + the KERN typedef (retail aidebug.obj records both) */
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"
#include "shared/Skidmark_Chunk.h"
#include "shared/BW_tContext.h"
#include "shared/FLARE_PIECE_DEF.h"
#endif /* _GAME_COMMON_AIDEBUG_H_ */
