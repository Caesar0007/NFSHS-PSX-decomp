/* frontend/common/fecheats_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FECHEATS_EXTERNS_H_
#define _FE_SCREENS_FECHEATS_EXTERNS_H_
#include "fecheats_types.h"

/* ===== globals ===== */
/* P881: native SYM 2c74a1/2c74b8 are ULONG scalars, matching the u_long
   owning definitions in game/common/nfs3.cpp (not U_INT array views). */
extern unsigned long      gFECheats;
extern unsigned long      gFEBonus;
extern tFEApplication    *FEApp;
extern tCarManager        carManager;
extern tTrackManager      trackManager;
extern tTournamentManager tournamentManager;
/* TRUE TYPE = the array object (was `tRecordBuffer *`; W62-A17): every oracle ref is an
   ADDRESS materialization (`addiu`), never a pointer load.  Owner def in
   game/common/nfs3.cpp. P881 uses this actual array directly; no replacement
   scalar or CPP-local asm-label view is needed. */
extern tRecordBuffer     Stats_gTrackRecords[187];

/* ===== helpers ===== */
void  AudioCmn_PlayFESFX(int sfx);
char *TextSys_Word(int id);
void  Stattool_GetAllDefaultRecords(tRecordBuffer *buf, bool def);

/* same-TU forward decls */
void  FECheat_EncodeString(char *input, char *output);
void  FECheat_EncodeString2(char *input, char *output);
void  FECheat_ActivateBonus(tCheatCode cheat);

#endif
