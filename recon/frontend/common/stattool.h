#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_CORE_GS_EARLY   /* retail: GameSetup before tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_LIST_NO_RANGE_INDEXED   /* retail stattool object: tListIterator, Indexed, Range */
/* frontend/common/stattool.h - reconstructed declarations for STATTOOL.CPP (C++ TU) */
#ifndef _FE_COMMON_STATTOOL_H_
#define _FE_COMMON_STATTOOL_H_
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_PADS "gamesetup_leaf_types.h"   /* retail Stattool.obj: GameSetup right after the pads */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "../../game/common/color_types.h"
#include "shared/TCB.h"   /* retail: TCB/EXEC/DIRENTRY/CARD_FILE_HEADER right after the color graph */
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/CARD_FILE_HEADER.h"
#include "stattool_types.h"
#include "stattool_externs.h"

/* STATTOOL.CPP is C++ (cfront-mangled) -> normal C++ linkage. */
void Stattool_nCreateIndex(int nNumber,int *nInput,short *nIndex);
void Stattool_ParseTime(int nTime,char *sLapTime);
void UserNameUpperCaseOneLetter(char *c);
void Stattool_SamNelsonsUpperLowerStringConverterForRecords(char *string);
void StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(char *string);
void Stattool_GetAllDefaultRecords(tRecordBuffer *TrackRecords,bool cheatones);
void Stattool_ReadDefaultRecords(tRecordBuffer *Records,bool cheatones);
void Stattool_GetRecords(short nShowTrack,tRecordBuffer *TrackRecords);
int Stattool_ReturnRecordLapTime(short nTrack);
short Stattool_CheckForHumanCar(Car_tStats *dummyCars);
char * Stattool_GetAINameFromPersonality(tPersonalities personality);

extern char minChar[6];   /* per-language minute separators ("::::::") */
extern char secChar[6];   /* per-language centisecond separators (".:....") */

#endif
