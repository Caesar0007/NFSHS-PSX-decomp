/* eaclib/psx/eacpsxz/pageflip.c -- RECONSTRUCTED.  eacpsxz.lib(pageflip.obj): retail SYM FILE record, link index 491.
 *   No function of it is in the image; its contribution is this .sdata block 0x8013DD70..0x8013DD7C (zero, INITIALISED),
 *   the last cells of .sdata.  No debug records: the cells are int-sized, types unknown. */
int gpusetdispenv = 0;   /* @0x8013DD70 */
int vblsetdispenv = 0;   /* @0x8013DD74 */
int vsdeferred = 0;      /* @0x8013DD78 */

/* ---- a function the final link REMOVED, known only by the library member it pulled in (name / body not retained) ----
 * vsync.obj (#323) is pulled right after hypot.obj, i.e. from this member's slot right after hypot3d.obj's.  tools/psyq_pipe/slink_pullsim.py */
#include "../../../link_stripped.h"
extern int vsync(int mode);
LINK_STRIPPED int pageflip_StrippedWait(void) { return vsync(0); }
