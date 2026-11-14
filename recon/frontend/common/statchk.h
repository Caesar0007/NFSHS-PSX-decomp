
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#define NFS4_FE_CORE_GS_EARLY   /* retail: GameSetup before tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_LIST_NO_INDEXED   /* retail statchk object: tListIterator + Range only */
/* frontend/common/statchk.h - reconstructed declarations for STATCHK.CPP (C++ TU) */
#ifndef _FE_COMMON_STATCHK_H_
#define _FE_COMMON_STATCHK_H_
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../../game/common/draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "../../game/common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../../game/common/gamesetup_leaf_types.h"   /* own types at this point */
#include "../../game/common/draw_leaf_b_pixmap.h"
#include "../../game/common/draw_leaf_c_cache.h"
#include "../../game/common/draw_leaf_d_carvertex.h"
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
