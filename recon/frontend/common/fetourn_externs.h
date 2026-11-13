/* frontend/common/fetourn_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FETOURN_EXTERNS_H_
#define _FE_FETOURN_EXTERNS_H_
#include "fetourn_types.h"

/* ===== globals ===== */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_mem.h"
#include "eaclib/psx/eacpsxz/fixdmult.h"
#include "eaclib/psx/eacpsxz/nsync.h"
#include "eaclib/psx/eacpsxz/vars.h"
}
extern tfrontEnd    frontEnd;
extern char        *Paths_Paths[];
extern tTournamentManager tournamentManager;
extern tCarManager  carManager;
extern Car_tStats  Cars_gNewCarStatsList[];
extern tTrackManager trackManager;
/* FETourn.obj statics */

/* ===== vtables ===== */

/* ===== base iterator ctor (rendered free by Ghidra) ===== */
void tListIterator_ctor(tListIterator*, short*, char*);

/* ===== eaclib / syslib / game helpers ===== */
char *TextSys_Word(int);
/* W58-A1: GetGarageCar / GetCarFromID / GetStockCar are tCarManager members -- the free
 * decls mangled to ..__FP11tCarManager.. phantoms that the link can never resolve. */
void  tListIterator_dtor(tListIterator*);
void  FECheat_ActivateBonus(tCheatCode cheat);
bool  FECheat_IsCheatEnabled(tCheatCode cheat);
/* W58-A1 (08A phantom fix): SetCarAvailable / SetTrackAvailable / SetClassAvailable /
 * SetCarViewable / PurchaseCar / PurchaseUpgrade / GetNumOwnedCars are tCarManager /
 * tTrackManager MEMBERS (real symbols ..__11tCarManager.. / ..__13tTrackManager..).
 * The free `(...)` decls mangled every call site as `..__Fe`, which never links.
 * Call sites now use carManager./trackManager. member form; the member decls live in
 * nfs4_types.h.  Byte-neutral: `this` rides $a0 exactly like the old explicit ptr. */

extern "C" {
void qsort(...);
int rand(...);
int sprintf(char *buffer, char *fmt, ...);
}

/* Retail fetourn.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

static inline Car_tStats *Cars_NewCarStatsList(void) { return Cars_gNewCarStatsList; }

static inline long CarManager_NumCars(tCarManager &cm) { return cm.fNumCars; }

static inline tCompetitor *Tournament_Competitors(tTournamentManager &tm) { return tm.fCompetitors; }

static inline int Tournament_BestPlacement(tTournamentManager &tm, int tournamentID) { return (signed char)tm.fBestPlacement[tournamentID]; }

static inline int Tier_TournOffset(tTierInfo &tier) { return tier.fTournOffset; }

/* FRONT6: defined in a header (retail records its inline pairs at the caller's line). */
/* (tTournamentManager::CurrentTourney(): in-class body in shared/tTournamentManager_inl.h, INV-B I6) */

#endif
