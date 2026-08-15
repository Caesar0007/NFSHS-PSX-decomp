#include "../../lib/libfns.h"
/* fecars_externs.h -- externs referenced by fecars.cpp (canonical decls reused from sibling modules + SYM Globals) */
#ifndef FECARS_EXTERNS_H
#define FECARS_EXTERNS_H

/* global manager/state instances */
extern tfrontEnd          frontEnd;
extern tTournamentManager tournamentManager;
extern tTrackManager      trackManager;
extern tCarManager        carManager;          /* the global car-manager singleton (gCarManager alias) */

/* global data (SYM Globals.jsonl) */
extern char  gCarSelected[2][50];              /* 0x80051544  ARY ARY CHAR dims 2x50 (per-player car-seen bitmap) */
extern char  bigBuf[];                         /* 0x80010000  shared big load/scratch buffer */

/* free functions (canonical sibling decls) */
int       FECheat_IsCheatEnabled(tCheatCode);
extern char *Paths_Paths[];

/* class vtables (FECars.obj-defined iterator subclasses) */
extern __vtbl_ptr_type tListIteratorCar_vtable[], tListIteratorCarColor_vtable[];

#endif
