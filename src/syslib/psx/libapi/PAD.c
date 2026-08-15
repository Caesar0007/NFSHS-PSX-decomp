#include "common.h"

/* W67-A5: libapi.lib(PAD.OBJ) = the single fn ReadInitPadFlag @0x8010C9B0
 * (next obj: InitCARD2 @0x8010C9C0).  The old stub lived in the WRONG unit
 * (src/syslib/psx/libpad/PAD.c) and was removed 2026-08-10 for the report;
 * that removal left `ReadInitPadFlag' undefined in the src-lane link (the
 * caller is libcard INIT.c's InitCARD).  This TU is the retail-true owner
 * (recon owner: recon/syslib/psx/libapi/PAD.c, gate PASS).  No objdiff unit
 * points here, so the board metric is untouched (no row, no double-count). */
INCLUDE_ASM("asm/nonmatchings/main", ReadInitPadFlag);
