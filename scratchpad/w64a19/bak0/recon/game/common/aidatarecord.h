/* game/common/aidatarecord.h — reconstructed from game/common/aidatarecord.cpp, game/common/aidatarecord.h (26 fns) */
#ifndef _GAME_COMMON_AIDATARECORD_H_
#define _GAME_COMMON_AIDATARECORD_H_
#include "../../nfs4_types.h"

void * __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc(AIDataRecord_t *self, int whichIsThis, char *preBuffer);   /* :32 */
void ___14AIDataRecord_t(AIDataRecord_t *self, int __in_chrg);   /* :63 */
int AddRecordToCollection__14AIDataRecord_t(AIDataRecord_t *self);   /* :77 */
int RemoveRecordFromCollection__14AIDataRecord_t(AIDataRecord_t *self);   /* :91 */
void StartUp1__14AIDataRecord_t(void);   /* :104 */
void StartUp2__14AIDataRecord_t(void);   /* :139 */
void CleanUp1__14AIDataRecord_t(void);   /* :152 */
void CleanUp2__14AIDataRecord_t(void);   /* :166 */
void Setup__14AIDataRecord_t(AIDataRecord_t *self);   /* :170 */
int Load__14AIDataRecord_t(AIDataRecord_t *self);   /* :225 */
int SaveAndPurge__14AIDataRecord_t(AIDataRecord_t *self);   /* :243 */
void * __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t(AIDataRecord_AccTable_t *self, char *preBuffer, int scale, int whichIsThis);   /* :394 */
int Get__23AIDataRecord_AccTable_ti(AIDataRecord_AccTable_t *self, int speed);   /* :403 */
void Setup__23AIDataRecord_AccTable_t(AIDataRecord_AccTable_t *self);   /* :408 */
void * __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t(AIDataRecord_BestLine_t *self, int whichIsThis);   /* :457 */
void * __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t(AIDataRecord_TrackCurve_t *self, int whichIsThis);   /* :535 */
int Get__25AIDataRecord_TrackCurve_ti(AIDataRecord_TrackCurve_t *self, int slice);   /* :546 */
void * __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t(AIDataRecord_CurveSpeedTable_t *self, char *carName, int whichIsThis);   /* :617 */
int Get__30AIDataRecord_CurveSpeedTable_ti(AIDataRecord_CurveSpeedTable_t *self, int curve);   /* :629 */
void Upgrade__30AIDataRecord_CurveSpeedTable_ti(AIDataRecord_CurveSpeedTable_t *self, int handlingUpgrade);   /* :680 */

/* ---- header-defined (inline / class) functions ---- */
void ___23AIDataRecord_AccTable_t(AIDataRecord_AccTable_t *self, int __in_chrg);   /* :109 */
void ___23AIDataRecord_BestLine_t(AIDataRecord_BestLine_t *self, int __in_chrg);   /* :150 */
void ___25AIDataRecord_TrackCurve_t(AIDataRecord_TrackCurve_t *self, int __in_chrg);   /* :163 */
void ___30AIDataRecord_CurveSpeedTable_t(AIDataRecord_CurveSpeedTable_t *self, int __in_chrg);   /* :182 */
int Get__26AIDataRecord_CarTracking_ti(AIDataRecord_CarTracking_t *self, int slice);   /* :191 */
void ___26AIDataRecord_CarTracking_t(AIDataRecord_CarTracking_t *self, int __in_chrg);   /* :199 */

#endif /* _GAME_COMMON_AIDATARECORD_H_ */
