/* syslib/psx/libgte/REG03.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgte.lib(REG03.OBJ): GTE (COP2) depth-cueing coefficient setters.  Each loads one
 *   value into a GTE control register via ctc2.  The oracle marks both as ".set noreorder /
 *   Handwritten function / handwritten instruction": the argument is moved straight from $a0
 *   into the control register with NO sign/zero extension and NO C prologue/epilogue, so the
 *   faithful form is the literal handwritten sequence (ctc2 $a0,$N; jr $ra; nop) -- emitted via
 *   the GTE_CTC_THUNK file-scope-__asm__ macro.  Host gets a portable no-op stub. */
#include "../../../lib/gte_thunk.h"

/* @0x80106674 : DQA = GTE control register 27 (depth-cue scale). */
/* REG03.obj head (LINK-STRIPPED): thirteen GTE register setters nobody calls -- retail's object text starts at SetDQA.
 * Sony GTE assembly; the instruction lines are the PsyQ 4.3 object's own. */
GTE_ASM_LINK_STRIPPED(SetVertex0, "\tlwc2 $0,0($4)\n" "\tlwc2 $1,4($4)\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetVertex1, "\tlwc2 $2,0($4)\n" "\tlwc2 $3,4($4)\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetVertex2, "\tlwc2 $4,0($4)\n" "\tlwc2 $5,4($4)\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetVertexTri, "\tlwc2 $0,0($4)\n" "\tlwc2 $1,4($4)\n" "\tlwc2 $2,0($5)\n" "\tlwc2 $3,4($5)\n" "\tlwc2 $4,0($6)\n" "\tlwc2 $5,4($6)\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetRGBfifo, "\tlwc2 $20,0($4)\n" "\tlwc2 $21,0($5)\n" "\tlwc2 $22,0($6)\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetIR123, "\tmtc2 $4,$9\n" "\tmtc2 $5,$10\n" "\tmtc2 $6,$11\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetIR0, "\tmtc2 $4,$8\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetSZfifo3, "\tmtc2 $4,$17\n" "\tmtc2 $5,$18\n" "\tmtc2 $6,$19\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetSZfifo4, "\tmtc2 $4,$16\n" "\tmtc2 $5,$17\n" "\tmtc2 $6,$18\n" "\tmtc2 $7,$19\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetSXSYfifo, "\tmtc2 $4,$12\n" "\tmtc2 $5,$13\n" "\tmtc2 $6,$14\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetRii, "\tctc2 $4,$0\n" "\tctc2 $5,$2\n" "\tctc2 $6,$4\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetMAC123, "\tmtc2 $4,$25\n" "\tmtc2 $5,$26\n" "\tmtc2 $6,$27\n" "\tjr $31\n" "\tnop\n");
GTE_ASM_LINK_STRIPPED(SetData32, "\tmtc2 $4,$30\n" "\tjr $31\n" "\tnop\n");
GTE_CTC_THUNK(SetDQA, 27, short);

/* @0x80106680 : DQB = GTE control register 28 (depth-cue offset). */
GTE_CTC_THUNK(SetDQB, 28, long);
