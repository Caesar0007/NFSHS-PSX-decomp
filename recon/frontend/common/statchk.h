#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_CORE_GS_EARLY   /* retail: GameSetup before tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_LIST_NO_INDEXED   /* retail statchk object: tListIterator + Range only */
/* frontend/common/statchk.h - reconstructed declarations for STATCHK.CPP (C++ TU) */
#ifndef _FE_COMMON_STATCHK_H_
#define _FE_COMMON_STATCHK_H_
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_PADS "gamesetup_leaf_types.h"   /* retail StatChk.obj: GameSetup right after the pads */
#include "statchk_types.h"
#include "statchk_externs.h"

/* STATCHK.CPP is C++ (cfront-mangled) -> normal C++ linkage. */
bool StatChk_IsRecordLapTime(Car_tStats *dummyCars,short nNumCars,short *nBestCarIndex);
void StatChk_SaveRecordLapTime(Car_tStats *dummyCars,short nNumCars,short nBestCarIndex);
short StatChk_IsTopTime(Car_tStats *dummyCars,short nNumCars);
void StatChk_SaveTopTime(Car_tStats *dummyCars,short nNumCars);
void StatChk_ClearNewRecords(void);

extern bool NewRecords[8];  /* per-slot new-record flags */
extern bool NewBestLap;     /* new best-lap flag */

#endif
