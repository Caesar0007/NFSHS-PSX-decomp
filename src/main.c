#include "common.h"

/* The resident program's "main" catch-all TU is now EMPTY.  Every function splat
 * originally dumped here has been re-attributed to its owning obj/module:
 *   - 333 game/lib functions   -> their owning modules         (main sweep, 2026-06-24)
 *   - 3 inert SN-LNK obj blobs  -> asm/data/sn_lnk_blobs.text.s (data, 0 refs)
 *   - func_8010C9FC (libcard card-IRQ handler blob) -> syslib/psx/libcard/A74.c
 *   - func_8010CA40 (libcard card patch templates)  -> syslib/psx/libcard/PATCH.c
 * Kept as a (near-)empty TU so linkers/nfs4.ld's main.c.o reference still resolves.
 */
