/* game/common/async.cpp -- RECONSTRUCTED (empty runtime/library TU).
 *   GAME\COMMON\async.obj -- empty marker (Async_func @0x800BBB84 sz=0, .text). Async CD/IO helper stub; no code/data in this build.
 *   Verified empty: no TUSummary row (or EXT=0/STAT=0) + ranges-map shows only a 0-4 byte
 *   PSYLINK boundary marker; no functions, no data attributed. Out of game-source scope
 *   (library/runtime), included for tree-inventory completeness. */
#include "async.h"
/* (intentionally empty) */
/* ---- a function the final link REMOVED (slink /strip), known only by the library member it pulled in ----
 * slink pulls library members on demand BEFORE it strips dead functions, in the order the unresolved names are met.
 * eacpsxz.lib(exit.obj) sits between loadshp.obj (asked for by Track.obj) and ssysinit.obj (asked for by audio.obj): one of
 * TrgSfx / udff / async / aidebug / audio referenced addexit or gExitFuncs.  async.obj has NO surviving function, and
 * registering an exit handler is what the start-up of an async file module does -- owner by plausibility among 9
 * equally exact placements, not proven.
 * Name and body are not retained; the reference is.  tools/psyq_pipe/slink_pullsolve.py */
#include "../../link_stripped.h"
extern "C" int addexit(...);
LINK_STRIPPED int Async_StrippedAddExit(void) { return addexit(); }

/* end of async.cpp */
