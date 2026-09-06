/* game/common/copspeak.h — reconstructed from game/common/copspeak.cpp (27 fns) */
#ifndef _GAME_COMMON_COPSPEAK_H_
#define _GAME_COMMON_COPSPEAK_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void CopSpeak_RadioStaticInit(void);   /* :198 */
void CopSpeak_RadioStaticActive(int noise);   /* :210 */
void CopSpeak_RadioStaticSquelch(void);   /* :259 */
void CopSpeak_InitRequest(CopSpeak_tRequest *r);   /* :276 */
void CopSpeak_SilenceCop(Car_tObj *car, int playerIndex);   /* :295 */
void CopSpeak_Alloc(CopSpeak_tRequest *r);   /* :312 */
void CopSpeak_Free(CopSpeak_tRequest *r);   /* :344 */
void CopSpeak_ReadyNextRequest(void);   /* :367 */
void CopSpeak_Cancel(void);   /* :539 */
void CopSpeak_Stop(void);   /* :582 */
void CopSpeak_CleanUp(void);   /* :592 */
void CopSpeak_InitVars(void);   /* :628 */
void CopSpeak_DirectRequest(int filehandle, long offset, long size, Car_tObj *car, char *name);   /* :656 */
void CopSpeak_GenericBankRequest(int patch, Car_tObj *car);   /* :682 */
void CopSpeak_StartUp(void);   /* :709 */
int CopSpeak_GetEnginePatch(int type, int timbre);   /* :885 */
int CopSpeak_Play(CopSpeak_tRequest *r, int handle);   /* :920 */
void CopSpeak_Skip(void);   /* :1028 */
int CopSpeak_Request(CopSpeak_tRequest *r);   /* :1051 */
int CopSpeak_BankVolume(CopSpeak_tRequest *r);   /* :1095 */
void CopSpeak_LoadNextRequest(void);   /* :1115 */
void CopSpeak_PlayNextRequest(void);   /* :1191 */
void CopSpeak_Flush(void);   /* :1257 */
void CopSpeak_Server(void);   /* :1271 */
int CopSpeak_SfxQueued(void);   /* :1359 */
void CopSpeak_ShowQueue(void);   /* :1377 */
void CopSpeak_Debug(void);   /* :1509 */

#endif /* _GAME_COMMON_COPSPEAK_H_ */
