/* game/common/aidebug.cpp -- RECONSTRUCTED debug TU (src AIDEBUG.CPP).
 *
 *   aidebug.obj is a debug-build translation unit. TUSummary EXT=1 STAT=2 ARG=0 AUTO=0 (data-only: 3 .bss globals, no fns)
 *   nfs4f_ranges: owns marker `Aidebug_func` @0x800BBB84 in .text (size 0, bare label).
 *   These debug globals are not referenced by the reconstructed game logic (the debug code
 *   paths that used them were not reconstructed); they are materialized here because the obj
 *   faithfully owns this .bss data in the linked image. @0xVA breadcrumbs.
 */
#include "aidebug.h"

int  grabValue;   /* @0x8013d4f8  EXT BOOL (.bss, 4-byte boolean) -- AI-debug grab toggle */
static int gAIDebug_PosX;   /* @0x8013dddc  STAT INT (.bss) -- AI-debug overlay X */
static int gAIDebug_PosY;   /* @0x8013dde0  STAT INT (.bss) -- AI-debug overlay Y */
/* end of aidebug.cpp */
