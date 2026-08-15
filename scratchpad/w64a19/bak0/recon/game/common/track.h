/* game/common/track.h — reconstructed from game/common/track.cpp (29 fns) */
#ifndef _GAME_COMMON_TRACK_H_
#define _GAME_COMMON_TRACK_H_
#include "../../nfs4_types.h"

void Track_SetTrackNumber__Fi(int tracknum);   /* :95 */
char * Track_MakeTrackPathName__FPc(char *ext);   /* :103 */
char * Track_MakeTrackDataPathName__FPc(char *ext);   /* :114 */
void AllocArtResource__FP18Track_tArtresourcei(Track_tArtresource *artRes, int numPmx);   /* :142 */
void InitArtResources__Fv(void);   /* :155 */
void DeInitArtResources__Fv(void);   /* :176 */
void LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii(char *shapefile, Draw_tPixMap *pmxList, int loadFlags, int x, int y);   /* :225 */
void LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii(char *shapefile, Draw_tPixMap *pmxList, int x, int y);   /* :375 */
void TexturesLoadInitial__Fv(void);   /* :405 */
void Track_AnimateTextures__Fv(void);   /* :491 */
int Track_GetProperMultiPalShapeIndex__Fii(int shapeindex, int paletteindex);   /* :525 */
void Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1(int uvFlag, Draw_tPixMap *inputPmx, Draw_tPixMap *outputPmx);   /* :538 */
void Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource(Trk_Material *inputMat, Track_tMaterial *outputMat, Track_tArtresource *art);   /* :577 */
void Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial(SerializedGroup *group, int length, Track_tMaterial *matList);   /* :688 */
void ReduceObjectPrecision__FP5GroupT0i(Group *instGroup, Group *defGroup, int bits);   /* :963 */
void InvalidatePersistentCollideBoomObjects__FP5GroupT0(Group *instGroup, Group *defGroup);   /* :1012 */
void CalcObjectBoundingSphere__FP5GroupT0(Group *defGroup, Group *boundingSphereGroup);   /* :1064 */
void CalcObjDefPtrs__Fv(void);   /* :1179 */
void Track_InitPersistentData__FP15SerializedGroup(SerializedGroup *perGroup);   /* :1212 */
void Track_Init__FPc(char *tempName);   /* :1312 */
void Track_DeInit__Fv(void);   /* :1492 */
void Track_AnimateTrackLighting__Fv(void);   /* :1537 */
char * KillFile_OpenRead__Fv(void);   /* :1720 */
void KillFile_ReadEntry__FPciRiT2(char *filePtr, int entryInd, int *chunkInd, int *objectInd);   /* :1732 */
void Track_LoadObjectKillData__Fv(void);   /* :1742 */
void Save__11SaveSurfaceP14Trk_NewSimQuad(SaveSurface *self, Trk_NewSimQuad *simQuad);   /* :1831 */
void * __11SaveSurfacei(SaveSurface *self, int numEntries);   /* :1855 */
extern "C" void ___11SaveSurface(SaveSurface *self, int __in_chrg);   /* :1864 */
void RestoreAll__11SaveSurface(SaveSurface *self);   /* :1871 */

#endif /* _GAME_COMMON_TRACK_H_ */
