/* fe3dmenu_externs.h -- externs for fe3dmenu.cpp (3D showroom/car render; PsyQ math + soft-float) */
#ifndef FE3DMENU_EXTERNS_H
#define FE3DMENU_EXTERNS_H

#include "fe3dmenu_types.h"

/* globals (SYM Globals.jsonl) */
extern COORD16  Fe3D_lightsVertex[64];   /* 0x80051334  ARY STRUCT COORD16 x64 */
extern COORD16  Fe3D_spotVertex[33];     /* 0x8005126c  ARY STRUCT COORD16 x33 */
extern char     bigBuf[];
extern int      gMenuRotate[2];
/* Scratchpad stack terminator; it has no linked storage or SYM type record. */
#define gScratchLastWord (*(int *)0x1F8003FC)
/* w38-a9: Render_gMenuRenderFlag dropped -- it is the SCRATCHPAD field
   sd->head.mirror @0x1F80000C, not a linked symbol (see Draw_MenuRenderingView).
   The remaining scalars use the UNSIZED-ARRAY ASM-LABEL VIEW: as plain `extern int`
   scalars cc1plus emits the one-insn assembler macro `sw $r,sym` / self-temp
   `lui $r,sym; lw $r,0($r)`, which maspsx/GNU-as expand with $at and which nothing
   can CSE or schedule; the oracle instead materializes ONE %hi base per symbol in a
   register (often callee-saved) and reuses it across calls.  The unsized-array form
   makes the %hi an ordinary RTL pseudo (catalog "$at-macro store => wrong declared
   shape" / IDT Ch9 unsized-extern rule).  Same storage, same symbol. */
extern int      R3DCar_Clock_v[]              asm("R3DCar_Clock");
extern int      R3DCar_ClockLast_v[]          asm("R3DCar_ClockLast");
extern int      R3DCar_InMenu_v[]             asm("R3DCar_InMenu");
/* generic128HzClock is the IRQ/VBlank-incremented 128Hz tick counter -> genuinely
   VOLATILE: the oracle RE-LOADS it inside the `if` body instead of reusing the value
   it just compared (catalog F "volatile IRQ-written status word"; a plain int lets
   cse.c forward the compare's load and drops that second `lw`). */
extern volatile int generic128HzClock_v[]     asm("generic128HzClock");
extern int      stackSpeedUpEnbabledFlag_v[]  asm("stackSpeedUpEnbabledFlag");
extern int      showRoomFlag_v[]              asm("showRoomFlag");
extern u_long   gWSavePtr_v[]                 asm("gWSavePtr");
#define R3DCar_Clock              (R3DCar_Clock_v[0])
#define R3DCar_ClockLast          (R3DCar_ClockLast_v[0])
#define R3DCar_InMenu             (R3DCar_InMenu_v[0])
#define generic128HzClock         (generic128HzClock_v[0])
#define stackSpeedUpEnbabledFlag  (stackSpeedUpEnbabledFlag_v[0])
#define showRoomFlag              (showRoomFlag_v[0])
#define gWSavePtr                 (gWSavePtr_v[0])

/* PsyQ / EA fixed-point + matrix math */
void Math_NormalizeVector(coorddef *);
void Math_fasttransmult(matrixtdef *, matrixtdef *, matrixtdef *);

extern "C" {
int   csin(int angle);
int   ccos(int angle);
int   fastintsin(int angle);
int   fastintcos(int angle);
void  crossproduct(coorddef *a, coorddef *b, coorddef *result);
int   fixedxformy(matrixtdef *matrix, int angle);
void  transpose(matrixtdef *source, matrixtdef *destination);
void  transform(int *source, int *matrix, int *destination);
void *SetSp(void *stack_pointer);
}

/* 3D car / texture / projection render */
void Texture_LoadMenuTexture(void);
void TrsProj_ResetTransPrecision(void);
void TrsProj_SetMenuProjection(int, int, int, int);
/* w38-a9 BUG FIX: was `(Car_tObj *, int)` -> mangled __FP8Car_tObji, but the
   definition in recon/game/common/r3dcar.cpp (and the retail symbol the oracle
   `jal`s here) is __FP8Car_tObjP13DRender_tView.  The wrong 2nd param type made
   every call site in this TU reference a NON-EXISTENT symbol (latent link bug;
   verify_asm is reloc-name lenient so it never surfaced in the gate). */
void R3DCar_InsertCarFacetMenu(Car_tObj *, DRender_tView *);
void R3DCar_InsertCarFacetMenuII(Car_tObj *, int);
void R3DCar_Showroom(DRender_tView *);

/* GCC soft-float intrinsics (PSX has no FPU) */
long long CONCAT44(unsigned int, unsigned int);

#endif
