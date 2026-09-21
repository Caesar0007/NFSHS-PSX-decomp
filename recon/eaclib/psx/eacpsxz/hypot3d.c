/* eaclib/psx/eacpsxz/hypot3d.c -- a library member the final link left NO code of (slink /strip removed every function).
 *   It is in the retail link all the same: the SYM has its FILE record, because slink pulls members on demand BEFORE it strips.
 *   What is known about it comes from WHERE retail pulled it in (tools/psyq_pipe/slink_pullsim.py):
 *   retail #308, right after the libpad members PADMAIN asked for: pulled from unitvect.obj's slot.
 *   hypot.obj (#322) is pulled from the queue slot of THIS member: hypot3d -> hypot.
 *   Function names and bodies are NOT retained anywhere; the names below are the natural ones for the member and are
 *   INFERRED.  What is evidence is the reference chain -- it is what puts the members in the retail order. */
#include "../../../link_stripped.h"

extern int hypot(int x, int y);
LINK_STRIPPED int hypot3d(int x, int y, int z) { return hypot(hypot(x, y), z); }
