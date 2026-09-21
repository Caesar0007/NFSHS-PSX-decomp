/* eaclib/psx/eacpsxz/vsync.c -- a library member the final link left NO code of (slink /strip removed every function).
 *   It is in the retail link all the same: the SYM has its FILE record, because slink pulls members on demand BEFORE it strips.
 *   What is known about it comes from WHERE retail pulled it in (tools/psyq_pipe/slink_pullsim.py):
 *   retail #323, right after hypot.obj: pulled from pageflip.obj's slot (pageflip.obj is #309, hypot3d.obj #308).
 *   NB this is EA's `vsync`, not Sony's libetc VSYNC.obj (`VSync`), which is linked as well.
 *   Function names and bodies are NOT retained anywhere; the names below are the natural ones for the member and are
 *   INFERRED.  What is evidence is the reference chain -- it is what puts the members in the retail order. */
#include "../../../link_stripped.h"

LINK_STRIPPED int vsync(int mode) { return mode; }
