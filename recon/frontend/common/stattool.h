
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_CORE_GS_EARLY   /* retail: GameSetup before tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_LIST_NO_RANGE_INDEXED   /* retail stattool object: tListIterator, Indexed, Range */
/* frontend/common/stattool.h - reconstructed declarations for STATTOOL.CPP (C++ TU) */
#ifndef _FE_COMMON_STATTOOL_H_
#define _FE_COMMON_STATTOOL_H_
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../../game/common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../../game/common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../../game/common/gamesetup_leaf_types.h"   /* own types at this point */
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
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
