/* game/common/aidatarecord_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_AIDATARECORD_EXTERNS_H_
#define _GAME_COMMON_AIDATARECORD_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- aidatarecord.obj manual vtable symbols (cross-TU data) ---- */
extern __vtbl_ptr_type AIDataRecord_t_vtable[], AIDataRecord_AccTable_t_vtable[],
  AIDataRecord_BestLine_t_vtable[], AIDataRecord_TrackCurve_t_vtable[],
  AIDataRecord_CurveSpeedTable_t_vtable[];

extern int gNumSlices;

/* path-prefix globals (Paths table @0x80116468) + car list, for the ctor sprintf()s */
extern char     *D_8011647C;   /* @0x8011647C path prefix (= D_80116470[3]) */
extern Car_tObj *Cars_gHumanRaceCarList[9];   /* cars.obj; [0]+0x240 = car name */

#endif /* _GAME_COMMON_AIDATARECORD_EXTERNS_H_ */
