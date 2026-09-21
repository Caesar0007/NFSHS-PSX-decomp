/* eaclib/psx/eacpsxz/window.c -- RECONSTRUCTED.  eacpsxz.lib(window.obj): retail SYM FILE record, link index 404.
 *   No function of it is in the image; its contribution is this .sdata block 0x8013DD64..0x8013DD70 (zero, INITIALISED),
 *   which sits exactly in its link-order slot.  No debug records: the cells are int-sized, types unknown. */
int videopages = 0;   /* @0x8013DD64 */
int videopage = 0;    /* @0x8013DD68 */
int windowpage = 0;   /* @0x8013DD6C */

/* .bss 0x801485AC..0x80148780, in window.obj's link-order slot (sizes from the label spacing; element types unknown) */
int windowbuf[78];       /* @0x801485AC 312 B */
int currentwindow[39];   /* @0x801486E4 156 B : GPU window block */

/* ---- a function the final link REMOVED, known only by the library member it pulled in (name / body not retained) ----
 * pageflip.obj (#309) is pulled right after hypot3d.obj, from the slots of unitvect / trnsmult / window: this member, the
 * window layer, is the one with a reason to touch the page-flip state.  tools/psyq_pipe/slink_pullsim.py */
#include "../../../link_stripped.h"
extern int vsdeferred;
LINK_STRIPPED int window_StrippedFlip(void) { return vsdeferred; }
