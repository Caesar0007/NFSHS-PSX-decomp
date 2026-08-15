/* frontend/common/fecheats_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FECHEATS_EXTERNS_H_
#define _FE_SCREENS_FECHEATS_EXTERNS_H_
#include "../../nfs4_types.h"

/* ===== globals ===== */
extern unsigned int       gFECheats;
extern unsigned int       gFEBonus;
extern tFEApplication    *FEApp;
extern tCarManager        carManager;
extern tTrackManager      trackManager;
extern tTournamentManager tournamentManager;
/* TRUE TYPE = the array object (was `tRecordBuffer *`; W62-A17): every oracle ref is an
   ADDRESS materialization (`addiu`), never a pointer load.  Owner def in
   game/common/nfs3.cpp.  (fecheats.cpp still carries its own unsized-array asm-label
   view for the %hi-as-RTL-pseudo codegen lever; this decl is the link-correct one.) */
extern tRecordBuffer     Stats_gTrackRecords[187];

/* ===== helpers ===== */
void  AudioCmn_PlayFESFX(int sfx);
char *TextSys_Word(int id);
void  Stattool_GetAllDefaultRecords(tRecordBuffer *buf, bool def);

/* same-TU forward decls */
void  FECheat_HandleActivation(tCheatCode cheat);
void  FECheat_EncodeString(char *input, char *output);
void  FECheat_EncodeString2(char *input, char *output);
void  FECheat_ActivateBonus(tCheatCode cheat);

#endif
