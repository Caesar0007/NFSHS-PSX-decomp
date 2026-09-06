/* Frozen original recon/game/psx/skidmark.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
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
void (*p875_probe_0)(Skidmark_Segment *r1, Skidmark_Segment *r2, coorddef *cp, coorddef *pt1, coorddef *pt2, int tireWidth) = &CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i;
void (*p875_probe_1)(Skidmark_Segment *r1, coorddef *cp, coorddef *pt1, coorddef *pt2, int tireWidth) = &CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i;
void * (*p875_probe_2)(coorddef *skidpt, int newsegs, int slice) = &Skidmark_CheckChunk__FP8coorddefii;
void (*p875_probe_3)(tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type, int slice) = &Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii;
void (*p875_probe_4)(Skidmark_Segment **save, int *savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type, int slice) = &Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii;
void (*p875_probe_5)(Skidmark_Segment *save, int savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type) = &Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii;
void (*p875_probe_6)(Skidmark_Segment *save, int savechunk, tSkid *prevskid, coorddef *skidpt, CVECTOR *color, int tireWidth, int type) = &Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii;
void (*p875_probe_7)(DRender_tView *Vi) = &Skidmark_OnyxBuildFacets__FP13DRender_tView;
void (*p875_probe_8)(void) = &Skidmark_InitSkidmark__Fv;
void (*p875_probe_9)(void) = &Skidmark_RestartSkidmark__Fv;
void (*p875_probe_10)(void) = &Skidmark_KillSkidmark__Fv;
