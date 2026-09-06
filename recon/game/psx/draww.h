/* game/psx/draww.h — reconstructed from game/psx/draww.cpp (35 fns) */
#ifndef _GAME_PSX_DRAWW_H_
#define _GAME_PSX_DRAWW_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void DrawW_AddSubdividPrimGT4(POLY_GT4 * prim,Draw_SVertex * v0,Draw_SVertex * v1,Draw_SVertex * v2,Draw_SVertex * v3,Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e0aa2 @0x800c5028 */
void DrawW_AddSubdividPrimGT3(POLY_GT3 * prim,Draw_SVertex * v0,Draw_SVertex * v1,Draw_SVertex * v2,Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e0b03 @0x800c50b4 */
void DrawW_DivVertice(Draw_SVertex * v0,Draw_SVertex * v1,Draw_SVertex * v2);   /* SYM 3e0b64 @0x800c5124 */
int DrawW_CalcSubdivision(Draw_tGiveShelbyMoreCache * sd,Draw_SVertex * v0,Draw_SVertex * v1,Draw_SVertex * v2,Draw_SVertex * v3);   /* SYM 3e0b97 @0x800c51fc */
void DrawW_SubdividFacet(Draw_tGiveShelbyMoreCache * sd,int l,Draw_SVertex * v0,Draw_SVertex * v1,Draw_SVertex * v2,Draw_SVertex * v3,short n,short subDivide);   /* SYM 3e0beb @0x800c5284 */
void DrawW_LoadPrecVECTOR(Draw_SVertex * v,VECTOR * dv);   /* SYM 3e0c40 @0x800c5bb4 */
void DrawW_SetUpSubdividFacet(int face,Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e0c7c @0x800c5be0 */
void Night_NightCopCalc(VECTOR * v,short * idx);   /* SYM 3e0cc2 @0x800c5f18 */
void Night_NightCalc(VECTOR * v,short * idx,Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e0cef @0x800c5fb8 */
void DrawW_NightColorCalc(Draw_tGiveShelbyMoreCache * sd,POLY_GT4 * prim,CCOORD16 * vt0,CCOORD16 * vt1,CCOORD16 * vt2,CCOORD16 * vt3);   /* SYM 3e0d35 @0x800c609c */
void DrawW_DrawQuad(Draw_tGiveShelbyMoreCache * sd,Trk_Quad * inQuad);   /* SYM 3e0d8d @0x800c64f8 */
void DrawW_kCtrlWorld_High(Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e0dd2 @0x800c6e38 */
void DrawW_StripDraw_High(Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e0e14 @0x800c6eb8 */
void DrawW_DoTrough(DRender_tView * Vi,tBuildEntry * buildList);   /* SYM 3e0e55 @0x800c6fa0 */
void DrawW_WorldSetUpMatrix(matrixtdef * m,MATRIX * mat);   /* SYM 3e0e92 @0x800c753c */
void DrawW_WorldSetUpTranslation(coorddef * t,MATRIX * mat);   /* SYM 3e0ece @0x800c75d8 */
void DrawW_ResetAnimationTimer(void);   /* SYM 3e0f0c @0x800c761c */
int DrawW_GetAnimationTime(Trk_AnimateInst * animInst);   /* SYM 3e0f37 @0x800c7644 */
void DrawW_SetAnimationTime(Trk_AnimateInst * animInst,int * table,int time);   /* SYM 3e0f70 @0x800c76c8 */
void DrawW_DoObjectAnimations(void);   /* SYM 3e0fac @0x800c7808 */
int DrawW_BuildObjectFacets(DRender_tView * Vi,ChunkObjectInfo * gObjInfo);   /* SYM 3e0fd6 @0x800c78a8 */
int DrawW_BuildCustomObjectFacets(DRender_tView * Vi,Draw_DCache * sd,Trk_SimObject * simObjs,Group * group,int zClipSq);   /* SYM 3e1020 @0x800c7b9c */
int DrawObjectTransform(DRender_tView * Vi,Draw_DCache * sd,matrixtdef * matrix,Trk_ObjectDef * objDef,coorddef * pCp,int offset,short light);   /* SYM 3e1084 @0x800c7ebc */
int DrawObjectSimple(DRender_tView * Vi,Draw_DCache * sd,Trk_ObjectDef * objDef,coorddef * pCp,int offset);   /* SYM 3e10ef @0x800c8214 */
int DrawW_BuildChunkObjectFacets(DRender_tView * Vi,ChunkObjectInfo * gObjInfo);   /* SYM 3e1149 @0x800c8508 */
bool ObjectClipped(DRender_tView * Vi,int ind,coorddef * pCp,Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e1198 @0x800c8bd0 */
void DrawW_DoObjects(DRender_tView * Vi,tBuildEntry * buildList);   /* SYM 3e11ed @0x800c8cc4 */
int Draw_CircleClip(coorddef * pt1,coorddef * pt2,int r);   /* SYM 3e122b @0x800c903c */
void Draw_kCtrlSkidmark(Draw_tCtrlSkidmark * fskid);   /* SYM 3e1258 @0x800c909c */
void DrawW_SetUpSubdividFacet_Line(Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e1290 @0x800c9620 */
void DrawW_OnyxLinePrim(CCOORD16 * geomVertices,Trk_Line * lineQuad,int count,Draw_tGiveShelbyMoreCache * sd);   /* SYM 3e12da @0x800c98b8 */
void DrawW_BuildChunkCenterLineFacets(Chunk * chunkDat,Group * group,Draw_tGiveShelbyMoreCache * sd,COORD16 * trans);   /* SYM 3e132e @0x800ca0a4 */
void DrawW_DoLines(DRender_tView * Vi,tBuildEntry * buildList,Draw_DCache * sd);   /* SYM 3e1392 @0x800ca204 */
void DrawW_BuildSpikeBelt(DRender_tView * Vi,int scale,Draw_DCache * sd);   /* SYM 3e13dc @0x800ca520 */
void DepthCue_Init(void);   /* SYM 3e1420 @0x800ca950 */

#endif /* _GAME_PSX_DRAWW_H_ */
