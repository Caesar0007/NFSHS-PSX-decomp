/* frontend/common/fefades.h - reconstructed declarations for FEFADES.CPP (C++ TU) */
#ifndef _FRONTEND_COMMON_FEFADES_H_
#define _FRONTEND_COMMON_FEFADES_H_
#include "../../nfs4_types.h"
#include "fefades_externs.h"

/* FEFADES.CPP is C++ (cfront-mangled). CalcFadeVal is OVERLOADED (2/3/4-arg). */
int CalcFadeVal(int col1,int col2,int amount);
int CalcFadeVal(int col1,int amount);
int CalcFadeVal(int col1,int col2,int amount,int fFade);
int CalcTextFadeUnselToSel(tMenuTextType type,short fSelFade,short fFade);
int CalcTextFadeSelToHi(tMenuTextType type,short fSelFade,short fFade);
void CalcOnOffFade(tMenuTextType type,short fOnOffFade,short fSelFade,short fFade,int &OnColor, int &OffColor);

#endif