/* game/psx/skidmark.h — reconstructed from game/psx/skidmark.cpp (11 fns) */
#ifndef _GAME_PSX_SKIDMARK_H_
#define _GAME_PSX_SKIDMARK_H_
#include "../../nfs4_types.h"

void CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i(Skidmark_Segment *r1, Skidmark_Segment *r2, coorddef *cp, coorddef *pt1, coorddef *pt2, int tireWidth);   /* :48 */
void CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i(Skidmark_Segment *r1, coorddef *cp, coorddef *pt1, coorddef *pt2, int tireWidth);   /* :81 */
void * Skidmark_CheckChunk__FP8coorddefii(coorddef *skidpt, int newsegs, int slice);   /* :115 */
void Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii(tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type, int slice);   /* :159 */
void Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii(Skidmark_Segment **save, int *savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type, int slice);   /* :264 */
void Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii(Skidmark_Segment *save, int savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type);   /* :336 */
void Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii(Skidmark_Segment *save, int savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type);   /* :350 */
void Skidmark_OnyxBuildFacets__FP13DRender_tView(DRender_tView *Vi);   /* :365 */
void Skidmark_InitSkidmark__Fv(void);   /* :419 */
void Skidmark_RestartSkidmark__Fv(void);   /* :433 */
void Skidmark_KillSkidmark__Fv(void);   /* :441 */

#endif /* _GAME_PSX_SKIDMARK_H_ */
