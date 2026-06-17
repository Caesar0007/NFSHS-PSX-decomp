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
extern char     *D_8011647C;   /* @0x8011647C path prefix (AccTable, CurveSpeed .csp) */
extern char     *D_80116478;   /* @0x80116478 path prefix (CurveSpeed .qcs) */
extern char     *D_80116490;   /* @0x80116490 path prefix (TrackCurve .qcr) */
extern char     *D_80116494;   /* @0x80116494 path prefix (TrackCurve .crv) */
extern char     *D_80116498;   /* @0x80116498 path prefix (BestLine .qbe) */
extern char     *D_8011649C;   /* @0x8011649C path prefix (BestLine .bes) */
extern int       D_80113228;   /* @0x80113228 track number (sprintf %02d) */
extern Car_tObj *Cars_gHumanRaceCarList[9];   /* cars.obj; [0]+0x240 = car name */

/* sprintf format strings — named rodata symbols (NOT inline literals, which would
 * land in this object's .rodata; the original references them at these addresses) */
extern char      D_800553B8[];  /* "%s%s.acc"     AccTable */
extern char      D_800553C4[];  /* "%sTr%02d.qbe" BestLine (recordMethod==0) */
extern char      D_800553D4[];  /* "%sTr%02d.bes" BestLine (else) */
extern char      D_800553E4[];  /* "%sTr%02d.qcr" TrackCurve (recordMethod==0) */
extern char      D_800553F4[];  /* "%sTr%02d.crv" TrackCurve (else) */
extern char      D_80055404[];  /* "%s%s.qcs"     CurveSpeed (recordMethod==0) */
extern char      D_80055410[];  /* "%s%s.csp"     CurveSpeed (else) */

#endif /* _GAME_COMMON_AIDATARECORD_EXTERNS_H_ */
