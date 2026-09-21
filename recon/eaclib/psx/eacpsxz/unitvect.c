/* eaclib/psx/eacpsxz/unitvect.c -- a library member the final link left NO code of (slink /strip removed every function).
 *   It is in the retail link all the same: the SYM has its FILE record, because slink pulls members on demand BEFORE it strips.
 *   What is known about it comes from WHERE retail pulled it in (tools/psyq_pipe/slink_pullsim.py):
 *   retail #220, between libpad PADCMD (asked for by PADENTRY) and trnsmult (matrix.obj's `transmult`): matrix.obj asked for it.
 *   hypot3d.obj (#308) is pulled from the queue slot of THIS member: unitvect -> hypot3d (a unit vector is v / |v|).
 *   Function names and bodies are NOT retained anywhere; the names below are the natural ones for the member and are
 *   INFERRED.  What is evidence is the reference chain -- it is what puts the members in the retail order. */
#include "../../../link_stripped.h"

extern int hypot3d(int x, int y, int z);
LINK_STRIPPED int unitvector(int *v) { return hypot3d(v[0], v[1], v[2]); }
