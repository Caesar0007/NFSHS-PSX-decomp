/* syslib/psx/libgte/REG03.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(REG03.OBJ): GTE (COP2) depth-cueing coefficient setters.  Each loads one
 *   value into a GTE control register via ctc2.  The oracle marks both as ".set noreorder /
 *   Handwritten function / handwritten instruction": the argument is moved straight from $a0
 *   into the control register with NO sign/zero extension and NO C prologue/epilogue, so the
 *   faithful form is the literal handwritten sequence (ctc2 $a0,$N; jr $ra; nop) -- emitted via
 *   the GTE_CTC_THUNK file-scope-__asm__ macro.  Host gets a portable no-op stub. */
#include "../../../lib/gte_thunk.h"

/* @0x80106674 : DQA = GTE control register 27 (depth-cue scale). */
GTE_CTC_THUNK(SetDQA, 27, short);

/* @0x80106680 : DQB = GTE control register 28 (depth-cue offset). */
GTE_CTC_THUNK(SetDQB, 28, long);
