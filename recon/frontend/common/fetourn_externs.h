/* frontend/common/fetourn_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FETOURN_EXTERNS_H_
#define _FE_FETOURN_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ===== globals ===== */
extern int          ticks;
extern tfrontEnd    frontEnd;
extern char        *Paths_Paths[];
extern tTournamentManager tournamentManager;
extern tCarManager  carManager;
extern Car_tStats  Cars_gNewCarStatsList[];
extern tTrackManager trackManager;
extern int          gFEData_8001165c;       /* trophy-letter pack (unresolved data global) */
extern char         gFEData_80011658, gFEData_80011659, gFEData_8001165a;
extern long         gTrackFinishBill, gTrackFinishBonus;
extern long         gTrackFinishPrizes[64];
/* FETourn.obj statics */
static long         retbill;       /* STAT */
static long         retbonus;      /* STAT */

/* ===== vtables ===== */
extern __vtbl_ptr_type tListIteratorTournament_vtable[];

/* ===== base iterator ctor (rendered free by Ghidra) ===== */
void tListIterator_ctor(tListIterator*, short*, char*);

/* ===== eaclib / syslib / game helpers ===== */
char *TextSys_Word(int);
/* W58-A1: GetGarageCar / GetCarFromID / GetStockCar are tCarManager members -- the free
 * decls mangled to ..__FP11tCarManager.. phantoms that the link can never resolve. */
void  tListIterator_dtor(tListIterator*);
void  FECheat_ActivateBonus(int) asm("FECheat_ActivateBonus__F10tCheatCode");
int   FECheat_IsCheatEnabled(tCheatCode);
/* W58-A1 (08A phantom fix): SetCarAvailable / SetTrackAvailable / SetClassAvailable /
 * SetCarViewable / PurchaseCar / PurchaseUpgrade / GetNumOwnedCars are tCarManager /
 * tTrackManager MEMBERS (real symbols ..__11tCarManager.. / ..__13tTrackManager..).
 * The free `(...)` decls mangled every call site as `..__Fe`, which never links.
 * Call sites now use carManager./trackManager. member form; the member decls live in
 * nfs4_types.h.  Byte-neutral: `this` rides $a0 exactly like the old explicit ptr. */

#endif
