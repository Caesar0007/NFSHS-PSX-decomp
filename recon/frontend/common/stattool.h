/* frontend/common/stattool.h - reconstructed declarations for STATTOOL.CPP (C++ TU) */
#ifndef _FE_COMMON_STATTOOL_H_
#define _FE_COMMON_STATTOOL_H_
#include "../../nfs4_types.h"
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