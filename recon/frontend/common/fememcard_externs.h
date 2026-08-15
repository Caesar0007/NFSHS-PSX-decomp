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
/* TRUE TYPE = the array object (was `int *`; W62-A17).  Every oracle reference in
   asm/nonmatchings/ materializes its ADDRESS (7x `addiu`, i.e. `la`), never loads a
   pointer VALUE -- so it is storage, not a pointer cell.  Owner def:
   game/common/nfs3.cpp `tRecordBuffer Stats_gTrackRecords[187];` @0x80114d94, and the
   0x154-byte per-track blockmoves in statchk/stattool (0x11 records x 20 bytes) confirm
   the element type + extent. */
extern tRecordBuffer Stats_gTrackRecords[187];
extern int          gMasterSFXLevel;
/* FEMemCard.obj data globals */
extern int          CURRENTPLAYER[];          /* @0x80051A68 -- unsized-array form: int-value loads
                                                 into an arg reg use the oracle's separate v0 scratch */
extern char         productCode[11];          /* @0x80051A6C */
extern int          nomessage;                /* @0x80051A78 */
/* TRUE TYPE = 4-byte BOOL (was `char`; W62-A17 decl-divergence fix).  Evidence:
   SYM `94 Def class EXT type BOOL` @0x80051A7C (v3 BOOL = 4 bytes), the next symbol
   MEMCARD_INITIALIZED sits at +4 (0x80051A80), and an oracle census over
   asm/nonmatchings/ shows 7 `lw` + 8 `sw` and ZERO byte ops on this symbol. */
extern int          CURRENTLYUSINGMEMCARD;    /* @0x80051A7C */
/* TRUE TYPE = 4-byte BOOL (was `char`; W62-A17).  SYM `94 Def class EXT type BOOL`
   @0x80051A80; oracle census = 4 `lw` + 2 `sw`, zero byte ops. */
extern int          MEMCARD_INITIALIZED;      /* @0x80051A80 */
extern int          textSysMemCardFail_Index[7]; /* @0x80051A84 */
/* TRUE TYPE = 4-byte BOOL (was `char`; W62-A17).  SYM `94 Def class EXT type BOOL`
   @0x8013D284; oracle census = 2 `lw` + 3 `sw`, zero byte ops. */
extern int          MEMCARDFRONTENDISINITTED;
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
/* W62-A17: the whole MCRD_* family is defined in frontend/psx/memcard.c -- a C-lane TU,
   so the link symbols are the PLAIN names.  Six of these decls were missing `extern "C"`,
   so this C++ TU emitted MCRD_init__Fi / MCRD_restore__Fv / MCRD_savefile__FiP12MCRDFILE_def
   / MCRD_loadfile__FiP12MCRDFILE_defi / MCRD_getopts__FP12MCRDOPTS_def /
   MCRD_setopts__FP12MCRDOPTS_def -- manglings that exist nowhere (nm ALIAS class).
   (MCRD_savefile really returns int in memcard.c; return type is not mangled, so the
   `void` spelling is link-safe -- left alone, the caller ignores $v0.) */
extern "C" {
int   MCRD_handlecardevents(int);
void  MCRD_savefile(int, MCRDFILE_def*);
void  MCRD_loadfile(int, MCRDFILE_def*, int);
CARDINFO_def *MCRD_getcard(int);
void  MCRD_init(int);
void  MCRD_restore();
void  MCRD_getopts(MCRDOPTS_def*);
void  MCRD_setopts(MCRDOPTS_def*);
}

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

