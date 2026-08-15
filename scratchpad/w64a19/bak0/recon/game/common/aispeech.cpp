/* game/common/aispeech.cpp -- RECONSTRUCTED (TYPE-DEFINITION-ONLY TU; emits no code or data)
 *
 *   aispeech.obj (SYM FILE-block, nfs4-f-v3.txt lines 57009-58141) is a PURE TYPE-DEFINITION
 *   translation unit: it contributes ZERO .text functions and ZERO .data/.bss symbols to the
 *   linked image. Verified directly from the raw SYM block:
 *     - opens at line 57009 with `94 Def class FILE type NULL size 0 name aispeech.obj`
 *       and closes at line 58141 with the matching `... name aispeech.obj` FILE record;
 *     - every record in between is a type Def / Def2 / TPDEF at VA $00000000 (debug TYPE
 *       metadata only) -- there are NO 8c/8e function-start records and NO .text/.data VAs.
 *
 *   The struct tags + typedefs in the block are the PsyQ / libgte / libgpu / libcd / libpad /
 *   Draw / game standard types this TU's headers pulled in (the PSYLINK SYM format attributes
 *   each type to the first .obj that references it; aispeech.obj absorbed them). The only
 *   AI-speech-SPECIFIC types are:
 *       AISpeechInfo_t        (struct, 24 B; embedded in Car_tObj at +0x534)
 *       speechModeType        (enum)
 *       speechIntensityType   (enum)
 *       speechSourceType      (enum)
 *   all four ALREADY reconstructed in ../../nfs4_types.h (AISpeechInfo_t @ struct line 1584;
 *   the three enums @ lines 591/598/605). There is no source-level code or data to emit here.
 *
 *   (The aispeech .text functions that USE these types -- AISpeech speech selection/dispatch --
 *   are reconstructed in the AI cluster's code TUs, not here; this TU is the header/type home.)
 *
 *   No SYM AUTO/REGPARM locals exist for this TU (0 functions), so the SYM-locals rule is
 *   satisfied vacuously. This stub records the finding for completeness (the VA-descending walk
 *   originally skipped it because it has no .text range).
 */
#include "aispeech.h"
/* (intentionally empty: no functions, no data) */
/* end of aispeech.cpp */
