/* game/psx/profile.cpp -- RECONSTRUCTED (TYPE-DEFINITION-ONLY TU; emits no code or data)
 *
 *   profile.obj (SYM FILE-block, nfs4-f-v2.txt lines 214011-214300) is a PURE TYPE-DEFINITION
 *   translation unit: it contributes ZERO .text functions and ZERO .data/.bss symbols to the
 *   linked image. Verified three ways:
 *     (1) SourceLineMap.jsonl  -> 0 rows for PROFILE.CPP (no SLD line records = no code).
 *     (2) TUSummary.jsonl tu_obj="profile.obj" -> ARG=0 AUTO=0 REG=0 REGPARM=0 EXT=0 STAT=0
 *         (zero functions, zero external fcn/data defs, zero statics). Only debug TYPE metadata:
 *         25 STRTAG + 160 MOS + 4 MOU + 1 UNTAG + 59 TPDEF + 13 FIELD + 26 EOS (total 288 records).
 *     (3) raw SYM block (v2.txt 214011..) opens with `94 Def class FILE ... name profile.obj` and
 *         holds ONLY type Def/Def2 records ($00000000 VA) -- no 8c/8e function-start records, no
 *         .text VAs.
 *
 *   The 25 struct tags + 59 typedefs are the PsyQ / libgte / libgpu / libcd / libpad standard types
 *   this TU's headers pulled in (the SYM format attributes each type to the first .obj that
 *   references it; profile.obj, early in link order, absorbed them):
 *     TCB, EXEC, DIRENTRY, PAD_PSX, PAD_NEGCON, PAD_ANALOG, PAD_MOUSE, PAD_COMMON, VECTOR, SVECTOR,
 *     CVECTOR, DVECTOR, RVECTOR, CRVECTOR3, CRVECTOR4, RECT, DR_ENV, DRAWENV, DISPENV, shapetbl,
 *     coorddef, cdstreamstruct, linedef, SHAPETABLEENTRY (+ union ._5); typedef aliases SHAPE,
 *     LIBCOORD, CDSTREAM, LINE, size_t, u_char, ...
 *
 *   All 24 struct types are ALREADY reconstructed in ../../nfs4_types.h (verified present). There is
 *   no source-level code or data to emit here -- the original profile.cpp compiled to type info only
 *   (declaration/inline-only content). This stub records the finding for completeness.
 *
 *   No SYM AUTO/REGPARM locals exist for this TU (0 functions), so the SYM-locals rule is satisfied
 *   vacuously.
 */
#include "profile.h"
/* (intentionally empty: no functions, no data) */
/* end of profile.cpp */
