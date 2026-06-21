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
extern Car_tStats  *Cars_gNewCarStatsList;
extern tTrackManager trackManager;
extern int          _i;            /* Ghidra phantom local */
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
void  GetGarageCar(tCarManager*, unsigned short, tCarInfo*, int);
void  GetStockCar(tCarManager*, unsigned short, tCarInfo*, int);
void  tListIterator_dtor(tListIterator*);
void *GetCarFromID(tCarManager*, int);
void  FECheat_ActivateBonus(int);
int   FECheat_IsCheatEnabled(tCheatCode);
void  SetCarAvailable(...);
void  SetTrackAvailable(...);
void  SetClassAvailable(...);
void  SetCarViewable(...);
void  PurchaseCar(...);
void  PurchaseUpgrade(...);
int   GetNumOwnedCars(...);

#endif
