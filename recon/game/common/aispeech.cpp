/* game/common/aispeech.cpp -- TYPE-ONLY SOURCE/TYPING SURFACE NOT FULLY RESTORED.
 *
 *   aispeech.obj (SYM FILE-block, nfs4-f-v3.txt lines 57009-58141) is a PURE TYPE-DEFINITION
 *   translation unit: it contributes ZERO .text functions and ZERO .data/.bss symbols to the
 *   linked image as named symbols. It also owns the anonymous SimpleMem
 *   read-only tag below. Verified directly from the raw SYM block:
 *     - opens at line 57009 with `94 Def class FILE type NULL size 0 name aispeech.obj`
 *       and closes at line 58141 with the matching `... name aispeech.obj` FILE record;
 *     - every record in between is a type Def / Def2 / TPDEF at VA $00000000 (debug TYPE
 *       metadata only) -- there are NO 8c/8e function-start records and NO .text/.data VAs.
 *
 *   The struct tags + typedefs in the block are the PsyQ / libgte / libgpu / libcd / libpad /
 *   Draw / game standard types this TU's own headers pulled in. These are
 *   per-object compiler records,not types transferred here from other objects.
 *   The only
 *   AI-speech-SPECIFIC types are:
 *       AISpeechInfo_t        (struct, 24 B; embedded in Car_tObj at +0x534)
 *       speechModeType        (enum)
 *       speechIntensityType   (enum)
 *       speechSourceType      (enum)
 *   Their known definitions currently reside in color_types.h. That does NOT
 *   expose them in this TU:aispeech.h is still an empty reconstruction header.
 *   The wider retail type graph,including two Car_tObj typedef copies,has not
 *   been restored here or covered by the119 current native-debug input set.
 *   Restore genuine declaration/include contexts,not dummy typedef padding.
 *
 *   (The aispeech .text functions that USE these types -- AISpeech speech selection/dispatch --
 *   are reconstructed in the AI cluster's code TUs, not here; this TU is the header/type home.)
 *
 *   No SYM AUTO/REGPARM locals exist(0 functions);a vacuous local audit is NOT
 *   a source/type-restoration certificate. Original header spelling/context
 *   is not uniquely supplied by these type records and needs reference work.
 *   Audit:build/nc12/physics_type_order_20261028/consumer-audit.json.
 */
#include "aispeech.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80055660): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
/* (intentionally empty: no functions, no data) */
/* end of aispeech.cpp */
