/* game/psx/drawdbg.cpp -- RECONSTRUCTED debug TU (src DRAWDBG.CPP).
 *
 *   DrawDbg.obj is a debug-build translation unit. TUSummary EXT=1 STAT=0 ARG=0 AUTO=0 (data-only: 1 .bss global, no fns)
 *   nfs4f_ranges: owns marker `DrawDebug_func` @0x800C5028 in .text (size 0, bare label).
 *   These debug globals are not referenced by the reconstructed game logic (the debug code
 *   paths that used them were not reconstructed); they are materialized here because the obj
 *   faithfully owns this .bss data in the linked image. @0xVA breadcrumbs.
 */
#include "drawdbg.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80056824).  The retail SYM shows the
 * object saw the track / Group header family, whose unused inline leaves the literal behind in every such object
 * (tools/psyq_pipe/simplemem_bysym.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

u_long gSavePtr;   /* @0x8013d818  EXT ULONG (.bss) -- draw-debug saved primitive ptr */
/* end of drawdbg.cpp */
