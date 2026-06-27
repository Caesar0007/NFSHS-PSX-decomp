/* frontend/common/fememcard_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEMEMCARD_EXTERNS_H_
#define _FE_FEMEMCARD_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ===== globals ===== */
extern int          ticks;
extern tfrontEnd    frontEnd;
extern tFEApplication *FEApp[];
extern char        *Paths_Paths[];
extern tTrackManager  trackManager;
extern tCarManager    carManager;
extern tTournamentManager tournamentManager;
extern tPadModuleState gPadinfo;
extern fMemCardInfo_def gMemCardInfo;
extern tScreenMemcard *screenMemcard;
extern int         *Stats_gTrackRecords;
extern int          gMasterSFXLevel;
/* FEMemCard.obj data globals */
extern int          CURRENTPLAYER[];          /* @0x80051A68 -- unsized-array form: int-value loads
                                                 into an arg reg use the oracle's separate v0 scratch */
extern char         productCode[11];          /* @0x80051A6C */
extern int          nomessage;                /* @0x80051A78 */
extern char         CURRENTLYUSINGMEMCARD;    /* @0x80051A7C */
extern char         MEMCARD_INITIALIZED;      /* @0x80051A80 */
extern int          textSysMemCardFail_Index[7]; /* @0x80051A84 */
extern char         MEMCARDFRONTENDISINITTED;
static char         TITLE[40];                /* STAT @0x80052B68 */

/* ===== vtables (manual) ===== */
extern __vtbl_ptr_type tDialogYesNoMem_vtable[];
extern __vtbl_ptr_type tDialogNoInputMessage_vtable[];

/* ===== dialog ctors/dtors + member fns (rendered free by Ghidra) ===== */
void tScreen_ctor(tScreen*);
void tScreen_dtor(tScreen*, int);
void tDialogYesNo_ctor(tDialogYesNo*);
void Display(tDialogBase*);
void Hide(tDialogBase*);
short Run(tDialogInteractive*);
void Redraw(tFEApplication*);
void UpdateMusic(tFEApplication*);

/* ===== memcard (PSX::memcard) ===== */
int   MCRD_handlecardevents(int);
void  MCRD_savefile(int, MCRDFILE_def*);
void  MCRD_loadfile(int, MCRDFILE_def*, int);
CARDINFO_def *MCRD_getcard(int);
void  MCRD_init(int);
void  MCRD_restore();
void  MCRD_getopts(MCRDOPTS_def*);
void  MCRD_setopts(MCRDOPTS_def*);

/* ===== eaclib / syslib / game ===== */
void  Clock_MasterInterruptHandler();
void  timedwait5(int);
void  AudioMus_StopSong(int);
char *TextSys_Word(int);
void *PlayerNameExist(int);
char *PlayerName(int);
void  FECheat_SaveBonus(unsigned long*);
void  FECheat_LoadBonus(unsigned long*);

/* ===== game-manager methods (rendered free by Ghidra; first arg is the manager ptr) ===== */
void  SaveTournament(tTournamentManager*, tSaveTournament*);
void  RestoreTournament(tTournamentManager*, tSaveTournament*);
void  LoadTournament(tTournamentManager*, tSaveTournament*);
void  SaveTracks(tTrackManager*, tSaveTrackInfo*);
void  LoadTracks(tTrackManager*, tSaveTrackInfo*);
void  SaveCars(tCarManager*, tSaveCarInfo*);
void  LoadCars(tCarManager*, tSaveCarInfo*, short);
void  SavePinkSlipsCars(tCarManager*, tSaveCarInfo*, short);   /* overload of FE SavePinkSlipsCars(short,short) */
void  LoadPinkSlipsCars(tCarManager*, tSaveCarInfo*, short);
void  SetPads();
void  Front_ResetPSXController(int, unsigned int);

#endif

