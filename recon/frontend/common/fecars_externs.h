/* fecars_externs.h -- externs referenced by fecars.cpp (canonical decls reused from sibling modules + SYM Globals) */
#ifndef FECARS_EXTERNS_H
#define FECARS_EXTERNS_H

#include "fecars_types.h"

/* global manager/state instances */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tTrackManager      trackManager;
extern tCarManager        carManager;          /* the global car-manager singleton (gCarManager alias) */

/* global data (SYM Globals.jsonl)
   🔴 DO NOT RE-SORT the next two (17B EXTERN-ORDER LAW): both are TU-owned
   TENTATIVE definitions in fecars.cpp, emitted in FIRST-DECLARATION order.
   Retail run (SYM FECars.obj block): 0x80051540 cars_disableBonuses (CHAR) ->
   0x80051544 gCarSelected[2][50]. */
extern char  cars_disableBonuses;              /* 0x80051540  CHAR */
extern char  gCarSelected[2][50];              /* 0x80051544  ARY ARY CHAR dims 2x50 (per-player car-seen bitmap) */
extern char  bigBuf[];                         /* 0x80010000  shared big load/scratch buffer */

/* FECars calls the external cheat API, but its owner graph does not contain
 * the foreign tCheatCode tag.  Preserve the retail linkage at that boundary. */
#define cheat_AllCops 12
bool FECheat_IsCheatEnabled(int)
    __asm__("FECheat_IsCheatEnabled__F10tCheatCode");
extern char *Paths_Paths[];

extern "C" {
void blockmove(...);
void *loadfileadr(...);
int purgememadr(...);
void *reservememadr(...);
int sprintf(...);
}

/* class vtables (FECars.obj-defined iterator subclasses) */
extern __vtbl_ptr_type tListIteratorCar_vtable[], tListIteratorCarColor_vtable[];

#endif
