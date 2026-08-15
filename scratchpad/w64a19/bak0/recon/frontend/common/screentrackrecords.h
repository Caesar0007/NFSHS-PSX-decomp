/* frontend/common/screentrackrecords.h — reconstructed from frontend/common/screentrackrecords.cpp, frontend/common/screentrackrecords.h (7 fns) */
#ifndef _FRONTEND_COMMON_SCREENTRACKRECORDS_H_
#define _FRONTEND_COMMON_SCREENTRACKRECORDS_H_
#include "../../nfs4_types.h"

void GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3(tScreenTrackRecords *self, short *numPermShapes, short *numSwapShapes, char **permFileName, char **swapFileName);   /* :67 */
void Initialize__19tScreenTrackRecords(tScreenTrackRecords *self);   /* :78 */
void Cleanup__19tScreenTrackRecords(tScreenTrackRecords *self);   /* :97 */
void DrawOneRecord__19tScreenTrackRecordsibi(tScreenTrackRecords *self, int index, BOOL newrecord, int y);   /* :113 */
void DrawRecords__19tScreenTrackRecordss(tScreenTrackRecords *self, short maxitem);   /* :161 */
void DrawBackground__19tScreenTrackRecords(tScreenTrackRecords *self);   /* :210 */

/* ---- header-defined (inline / class) functions ---- */
void ___19tScreenTrackRecords(tScreenTrackRecords *self, int __in_chrg);   /* :55 */

#endif /* _FRONTEND_COMMON_SCREENTRACKRECORDS_H_ */
