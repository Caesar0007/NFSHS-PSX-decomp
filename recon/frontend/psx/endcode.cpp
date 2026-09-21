/* frontend/psx/endcode.cpp -- RECONSTRUCTED (empty runtime/library TU).
 *   FRONTEND\PSX\endcode.obj -- empty marker (endcode @0x8005125C sz=0 front.text). PSYLINK end-of-front.text boundary marker.
 *   Verified empty: no TUSummary row (or EXT=0/STAT=0) + ranges-map shows only a 0-4 byte
 *   PSYLINK boundary marker; no functions, no data attributed. Out of game-source scope
 *   (library/runtime), included for tree-inventory completeness. */
#include "endcode.h"
/* endcode.obj is the LAST game object and has no function: what it contributes is the global `endofcode`, the one label of
 * section `.last`, which EA's link script put in a group of its own behind .bss (the retail MAP has _last_obj / __last_obj =
 * endofcode = 0x80148B04).  platform.obj takes endofcode + 8 as the start of free memory.  An assembler file in the original
 * (no C object can define a zero-size label in a named section), hence the file-scope block. */
__asm__("\t.section .last\n\t.globl endofcode\nendofcode:\n\t.text\n");
/* end of endcode.cpp */
