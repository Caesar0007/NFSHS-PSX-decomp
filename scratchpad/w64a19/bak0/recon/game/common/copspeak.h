/* game/common/copspeak.h — reconstructed from game/common/copspeak.cpp (27 fns) */
#ifndef _GAME_COMMON_COPSPEAK_H_
#define _GAME_COMMON_COPSPEAK_H_
#include "../../nfs4_types.h"

void CopSpeak_RadioStaticInit__Fv(void);   /* :198 */
void CopSpeak_RadioStaticActive__Fi(int noise);   /* :210 */
void CopSpeak_RadioStaticSquelch__Fv(void);   /* :259 */
void CopSpeak_InitRequest__FP17CopSpeak_tRequest(CopSpeak_tRequest *r);   /* :276 */
void CopSpeak_SilenceCop__FP8Car_tObji(Car_tObj *car, int playerIndex);   /* :295 */
void CopSpeak_Alloc__FP17CopSpeak_tRequest(CopSpeak_tRequest *r);   /* :312 */
void CopSpeak_Free__FP17CopSpeak_tRequest(CopSpeak_tRequest *r);   /* :344 */
void CopSpeak_ReadyNextRequest__Fv(void);   /* :367 */
void CopSpeak_Cancel__Fv(void);   /* :539 */
void CopSpeak_Stop__Fv(void);   /* :582 */
void CopSpeak_CleanUp__Fv(void);   /* :592 */
void CopSpeak_InitVars__Fv(void);   /* :628 */
void CopSpeak_DirectRequest__FillP8Car_tObjPc(int filehandle, long offset, long size, Car_tObj *car, char *name);   /* :656 */
void CopSpeak_GenericBankRequest__FiP8Car_tObj(int patch, Car_tObj *car);   /* :682 */
void CopSpeak_StartUp__Fv(void);   /* :709 */
int CopSpeak_GetEnginePatch__Fii(int type, int timbre);   /* :885 */
int CopSpeak_Play__FP17CopSpeak_tRequesti(CopSpeak_tRequest *r, int handle);   /* :920 */
void CopSpeak_Skip__Fv(void);   /* :1028 */
int CopSpeak_Request__FP17CopSpeak_tRequest(CopSpeak_tRequest *r);   /* :1051 */
int CopSpeak_BankVolume__FP17CopSpeak_tRequest(CopSpeak_tRequest *r);   /* :1095 */
void CopSpeak_LoadNextRequest__Fv(void);   /* :1115 */
void CopSpeak_PlayNextRequest__Fv(void);   /* :1191 */
void CopSpeak_Flush__Fv(void);   /* :1257 */
void CopSpeak_Server__Fv(void);   /* :1271 */
int CopSpeak_SfxQueued__Fv(void);   /* :1359 */
void CopSpeak_ShowQueue__Fv(void);   /* :1377 */
void CopSpeak_Debug__Fv(void);   /* :1509 */

#endif /* _GAME_COMMON_COPSPEAK_H_ */
