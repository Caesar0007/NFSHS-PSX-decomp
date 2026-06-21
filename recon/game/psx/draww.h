/* game/psx/draww.h — reconstructed from game/psx/draww.cpp (35 fns) */
#ifndef _GAME_PSX_DRAWW_H_
#define _GAME_PSX_DRAWW_H_
#include "../../nfs4_types.h"

void DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache(POLY_GT4 *prim, Draw_SVertex *v0, Draw_SVertex *v1, Draw_SVertex *v2, Draw_SVertex *v3, Draw_tGiveShelbyMoreCache *sd);   /* :235 */
void DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache(POLY_GT3 *prim, Draw_SVertex *v0, Draw_SVertex *v1, Draw_SVertex *v2, Draw_tGiveShelbyMoreCache *sd);   /* :316 */
void DrawW_DivVertice__FP12Draw_SVertexN20(Draw_SVertex *v0, Draw_SVertex *v1, Draw_SVertex *v2);   /* :387 */
int DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31(Draw_tGiveShelbyMoreCache *sd, Draw_SVertex *v0, Draw_SVertex *v1, Draw_SVertex *v2, Draw_SVertex *v3);   /* :402 */
void DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss(Draw_tGiveShelbyMoreCache *sd, int l, Draw_SVertex *v0, Draw_SVertex *v1, Draw_SVertex *v2, Draw_SVertex *v3, int n, int subDivide);   /* :425 */
void DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR(Draw_SVertex *v, VECTOR *dv);   /* :593 */
void DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache(int face, Draw_tGiveShelbyMoreCache *sd);   /* :612 */
void Night_NightCopCalc__FP6VECTORPs(VECTOR *v, short *idx);   /* :711 */
void Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache(VECTOR *v, short *idx, Draw_tGiveShelbyMoreCache *sd);   /* :750 */
void DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32(Draw_tGiveShelbyMoreCache *sd, POLY_GT4 *prim, CCOORD16 *vt0, CCOORD16 *vt1, CCOORD16 *vt2, CCOORD16 *vt3);   /* :802 */
void DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad(Draw_tGiveShelbyMoreCache *sd, Trk_Quad *inQuad);   /* :930 */
void DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache(Draw_tGiveShelbyMoreCache *sd);   /* :1302 */
void DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache(Draw_tGiveShelbyMoreCache *sd);   /* :1331 */
void DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry(DRender_tView *Vi, tBuildEntry *buildList);   /* :1390 */
void DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX(matrixtdef *m, MATRIX *mat);   /* :1663 */
void DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX(coorddef *t, MATRIX *mat);   /* :1674 */
void DrawW_ResetAnimationTimer__Fv(void);   /* :1698 */
int DrawW_GetAnimationTime__FP15Trk_AnimateInst(Trk_AnimateInst *animInst);   /* :1704 */
void DrawW_SetAnimationTime__FP15Trk_AnimateInstPii(Trk_AnimateInst *animInst, int *table, int time);   /* :1721 */
void DrawW_DoObjectAnimations__Fv(void);   /* :1784 */
int DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo(DRender_tView *Vi, ChunkObjectInfo *gObjInfo);   /* :1909 */
int DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi(DRender_tView *Vi, Draw_DCache *sd, Trk_SimObject *simObjs, Group *group, int zClipSq);   /* :2054 */
int DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis(DRender_tView *Vi, Draw_DCache *sd, matrixtdef *matrix, Trk_ObjectDef *objDef, coorddef *pCp, int offset, int light);   /* :2156 */
int DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi(DRender_tView *Vi, Draw_DCache *sd, Trk_ObjectDef *objDef, coorddef *pCp, int offset);   /* :2261 */
int DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo(DRender_tView *Vi, ChunkObjectInfo *gObjInfo);   /* :2346 */
BOOL ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache(DRender_tView *Vi, int ind, coorddef *pCp, Draw_tGiveShelbyMoreCache *sd);   /* :2660 */
void DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry(DRender_tView *Vi, tBuildEntry *buildList);   /* :2717 */
int Draw_CircleClip__FP8coorddefT0i(coorddef *pt1, coorddef *pt2, int r);   /* :2888 */
void Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark(Draw_tCtrlSkidmark *fskid);   /* :2900 */
void DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache(Draw_tGiveShelbyMoreCache *sd);   /* :3049 */
void DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache(CCOORD16 *geomVertices, Trk_Line *lineQuad, int count, Draw_tGiveShelbyMoreCache *sd);   /* :3108 */
void DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16(Chunk *chunkDat, Group *group, Draw_tGiveShelbyMoreCache *sd, COORD16 *trans);   /* :3344 */
void DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache(DRender_tView *Vi, tBuildEntry *buildList, Draw_DCache *sd);   /* :3396 */
void DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache(DRender_tView *Vi, int scale, Draw_DCache *sd);   /* :3692 */
void DepthCue_Init__Fv(void);   /* :3830 */

#endif /* _GAME_PSX_DRAWW_H_ */
