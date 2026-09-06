/* game/psx/skidmark.h — reconstructed from game/psx/skidmark.cpp (11 fns) */
#ifndef _GAME_PSX_SKIDMARK_H_
#define _GAME_PSX_SKIDMARK_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void CalcStartSegment(Skidmark_Segment * r1,Skidmark_Segment * r2,coorddef * cp,coorddef * pt1,coorddef * pt2,int tireWidth);   /* SYM 465f70 @0x800de6f4 */
void CalcOneSegment(Skidmark_Segment * r1,coorddef * cp,coorddef * pt1,coorddef * pt2,int tireWidth);   /* SYM 465fb4 @0x800de8c4 */
Skidmark_Chunk * Skidmark_CheckChunk(coorddef * skidpt,int newsegs,int slice);   /* SYM 465ff4 @0x800de9ec */
void Skidmark_Add(tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type,int slice);   /* SYM 466035 @0x800deb98 */
void Skidmark_AddStretch(Skidmark_Segment ** save,int * savechunk,tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type,int slice);   /* SYM 46606f @0x800def6c */
void Skidmark_Stretch(Skidmark_Segment * save,int savechunk,tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type);   /* SYM 4660c6 @0x800df308 */
void Skidmark_EndStretch(Skidmark_Segment * save,int savechunk,tSkid * prevskid,coorddef * skidpt,CVECTOR * color,int tireWidth,int type);   /* SYM 466117 @0x800df388 */
void Skidmark_OnyxBuildFacets(DRender_tView * Vi);   /* SYM 46616b @0x800df464 */
void Skidmark_InitSkidmark(void);   /* SYM 4661a4 @0x800df504 */
void Skidmark_RestartSkidmark(void);   /* SYM 4661cb @0x800df578 */
void Skidmark_KillSkidmark(void);   /* SYM 4661f5 @0x800df58c */

#endif /* _GAME_PSX_SKIDMARK_H_ */
