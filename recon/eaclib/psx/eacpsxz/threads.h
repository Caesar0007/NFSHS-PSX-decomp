#ifndef _THREADS_H_
#define _THREADS_H_

#include "eac_types.h"

/* g_currentthread: the oracle reaches it via %gp_rel (iscurrentthread wants
 * `lw $v0,%gp_rel(g_currentthread)($gp)`), so threads.obj OWNS it in .sdata.
 * lever-#6: a cc1plus C++ tentative definition (no init) lands the symbol
 * directly in .sdata, so maspsx -G4 expands `lw $2,g_currentthread` to the
 * oracle's `lw $2,%gp_rel(...)($gp)` (verified in an isolated cc1plus+maspsx
 * run).  This is the OWNING module's real definition; the zero word in
 * asm/data/sdata_8013C54C.sdata.s is the splat placeholder for the same symbol
 * (dedup at final-link when the TU is sealed -- the standard "owned globals
 * defined in the cpp" resolution). */
extern int g_currentthread;   /* fwd decl (owned + defined below, gp-rel) */

extern unsigned int iscurrentthread(int id);   /* @0x800FE408 */
extern void         yieldthread(void);         /* @0x800FE41C */

#endif
