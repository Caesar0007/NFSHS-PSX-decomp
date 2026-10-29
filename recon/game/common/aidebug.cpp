/* game/common/aidebug.cpp -- RECONSTRUCTED debug TU (src AIDEBUG.CPP).
 *
 *   aidebug.obj is a debug-named,data-only retail translation unit. TUSummary EXT=1 STAT=2 ARG=0 AUTO=0 (3 .bss globals,no fns)
 *   nfs4f_ranges: owns marker `Aidebug_func` @0x800BBB84 in .text (size 0, bare label).
 *   These debug globals are not referenced by the reconstructed game logic (the debug code
 *   paths are absent from this retail code image); they are materialized here because the obj
 *   faithfully owns this .bss data in the linked image. @0xVA breadcrumbs.
 *   TYPE/HEADER SURFACE NOT RESTORED:aidebug.h currently supplies no game
 *   types,whereas this retail object carries the full Car_tObj body and ten
 *   typedef copies. It is outside the119 current native-debug input set.
 *   The raw bodies are available;the context causing repeated copies needs
 *   genuine reference/source recovery,not dummy declarations. A no-function
 *   local audit cannot certify this object's source/type completeness.
 */
#include "aidebug.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x8005673C): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

bool grabValue;   /* @0x8013d4f8  SYM BOOL; CC1PLPSX stores C++ bool in 4 bytes */
static int gAIDebug_PosX;   /* @0x8013dddc  STAT INT (.bss) -- AI-debug overlay X */
static int gAIDebug_PosY;   /* @0x8013dde0  STAT INT (.bss) -- AI-debug overlay Y */
/* end of aidebug.cpp */
