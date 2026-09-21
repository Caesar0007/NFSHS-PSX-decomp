/* game/common/chunkvis.cpp -- reconstructed metadata-only translation unit
 *
 * The raw SYM has an exact chunkvis.obj FILE pair (records 0x206049 and
 * 0x2086d7).  Its 401 interior records describe only the included type
 * environment: tags, aggregate members/bit-fields, terminators, and typedefs.
 * It has no function, SLD, EXT/STAT storage, or emitted code/data record.
 *
 * The nop at 0x8008b934 is Chunk_DeInit's return delay slot: Chunk_DeInit
 * spans 0x8008b930..0x8008b938 and remains a 2-instruction PASS.  There is no
 * retail symbol named Chunkvis at that address.  This empty source owner is
 * retained because the metadata-only object is real; the exact original
 * include spelling/order is not recoverable from the object records alone.
 */
#include "chunkvis.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x800559DC).  The retail SYM shows the
 * object saw the track / Group header family, whose unused inline leaves the literal behind in every such object
 * (tools/psyq_pipe/simplemem_bysym.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
/* Intentionally no functions or storage: that is the retail object shape. */
/* end of chunkvis.cpp */
