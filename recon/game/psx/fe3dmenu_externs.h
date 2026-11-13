/* fe3dmenu_externs.h -- externs for fe3dmenu.cpp (3D showroom/car render; PsyQ math + soft-float) */
#ifndef FE3DMENU_EXTERNS_H
#define FE3DMENU_EXTERNS_H
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#include "fe3dmenu_types.h"

/* globals (SYM Globals.jsonl) */
extern char     bigBuf[];
/* Scratchpad stack terminator; it has no linked storage or SYM type record. */
#define gScratchLastWord (*(int *)0x1F8003FC)
/* w38-a9: Render_gMenuRenderFlag dropped -- it is the SCRATCHPAD field
   sd->head.mirror @0x1F80000C, not a linked symbol (see Draw_MenuRenderingView).
   The remaining scalars are plain externs (2026-11-06 cleanup).  The former
   unsized-array asm-label views (`R3DCar_Clock_v[] asm("R3DCar_Clock")` + #define)
   were measured unnecessary under ASPSX 2.77: fe3dmenu.cpp verify_asm 3/3 PASS,
   sldprobe 0 tag diffs / 0 ALIGN warnings and identical data with or without
   them.  generic128HzClock is volatile everywhere: the timer ISR
   Clock_MasterInterruptHandler (clock.cpp) writes it (user ruling 2026-11-06)
   and readers re-load it. */
extern int R3DCar_Clock;
extern int R3DCar_ClockLast;
extern int R3DCar_InMenu;
/* generic128HzClock is the IRQ/VBlank-incremented 128Hz tick counter -> genuinely
   VOLATILE: the oracle RE-LOADS it inside the `if` body instead of reusing the value
   it just compared (catalog F "volatile IRQ-written status word"; a plain int lets
   cse.c forward the compare's load and drops that second `lw`). */
extern volatile int generic128HzClock;
extern int stackSpeedUpEnbabledFlag;
extern u_long gWSavePtr;





/* showRoomFlag, gMenuRotate, Fe3D_spotVertex, Fe3D_lightsVertex: DEFINED in fe3dmenu.cpp (their first
   declaration fixes the emission order of the object's data) */
extern bool showRoomFlag;


/* PsyQ / EA fixed-point + matrix math */
void Math_NormalizeVector(coorddef *);
void Math_fasttransmult(matrixtdef *, matrixtdef *, matrixtdef *);

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_matrix.h"
#include "eaclib/psx/eacpsxz/sinfunc.h"
}
extern "C" {
int   csin(int angle);
int   ccos(int angle);
unsigned long SetSp(unsigned long);
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
