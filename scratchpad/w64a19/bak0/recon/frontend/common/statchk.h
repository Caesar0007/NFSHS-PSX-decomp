/* frontend/common/statchk.h - reconstructed declarations for STATCHK.CPP (C++ TU) */
#ifndef _FE_COMMON_STATCHK_H_
#define _FE_COMMON_STATCHK_H_
#include "../../nfs4_types.h"
#include "statchk_externs.h"

/* STATCHK.CPP is C++ (cfront-mangled) -> normal C++ linkage. */
void * StatChk_IsRecordLapTime(Car_tStats *dummyCars,short nNumCars,short *nBestCarIndex);
void StatChk_SaveRecordLapTime(Car_tStats *dummyCars,short nNumCars,short nBestCarIndex);
short StatChk_IsTopTime(Car_tStats *dummyCars,short nNumCars);
void StatChk_SaveTopTime(Car_tStats *dummyCars,short nNumCars);
void StatChk_ClearNewRecords(void);

extern int NewRecords[8];   /* per-slot new-record flags */
extern int NewBestLap;      /* new best-lap flag */

#endif