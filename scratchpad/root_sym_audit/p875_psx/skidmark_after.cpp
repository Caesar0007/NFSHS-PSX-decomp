#include "C:/Temp/nfs4-decomp/recon/game/psx/skidmark.h"
void (*p875_probe_0)(Skidmark_Segment * r1,Skidmark_Segment * r2,coorddef * cp,coorddef * pt1,coorddef * pt2,int tireWidth) = &CalcStartSegment;
void (*p875_probe_1)(Skidmark_Segment * r1,coorddef * cp,coorddef * pt1,coorddef * pt2,int tireWidth) = &CalcOneSegment;
Skidmark_Chunk * (*p875_probe_2)(coorddef * skidpt,int newsegs,int slice) = &Skidmark_CheckChunk;
void (*p875_probe_3)(tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type,int slice) = &Skidmark_Add;
void (*p875_probe_4)(Skidmark_Segment ** save,int * savechunk,tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type,int slice) = &Skidmark_AddStretch;
void (*p875_probe_5)(Skidmark_Segment * save,int savechunk,tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type) = &Skidmark_Stretch;
void (*p875_probe_6)(Skidmark_Segment * save,int savechunk,tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type) = &Skidmark_EndStretch;
void (*p875_probe_7)(DRender_tView * Vi) = &Skidmark_OnyxBuildFacets;
void (*p875_probe_8)(void) = &Skidmark_InitSkidmark;
void (*p875_probe_9)(void) = &Skidmark_RestartSkidmark;
void (*p875_probe_10)(void) = &Skidmark_KillSkidmark;
