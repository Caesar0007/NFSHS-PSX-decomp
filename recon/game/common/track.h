/* game/common/track.h — reconstructed from game/common/track.cpp (29 fns) */
#ifndef _GAME_COMMON_TRACK_H_
#define _GAME_COMMON_TRACK_H_
#include "track_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Track_SetTrackNumber(int tracknum);   /* :95 */
char * Track_MakeTrackPathName(char *ext);   /* :103 */
char * Track_MakeTrackDataPathName(char *ext);   /* :114 */
void AllocArtResource(Track_tArtresource *artRes,int numPmx);   /* :142 */
void InitArtResources(void);   /* :155 */
void DeInitArtResources(void);   /* :176 */
void LoadShapesAndMakePmx(char *shapefile,Draw_tPixMap *pmxList,int loadFlags,int x,int y);   /* :225 */
void LoadShapesAndMakePmx_EnvMap(char *shapefile,Draw_tPixMap *pmxList,int x,int y);   /* :375 */
void TexturesLoadInitial(void);   /* :405 */
void Track_AnimateTextures(void);   /* :491 */
int Track_GetProperMultiPalShapeIndex(int shapeindex,int paletteindex);   /* :525 */
void Track_ProcessFlipAndUVFlags(int uvFlag,Draw_tPixMap *inputPmx,Draw_tPixMap *outputPmx);   /* :538 */
void Track_AssociateSingleMaterial(Trk_Material *inputMat,Track_tMaterial *outputMat,Track_tArtresource *art);   /* :577 */
void Track_LinkMaterials(SerializedGroup *group,int length,Track_tMaterial *matList);   /* :688 */
void ReduceObjectPrecision(Group *instGroup,Group *defGroup,int bits);   /* :963 */
void InvalidatePersistentCollideBoomObjects(Group *instGroup,Group *defGroup);   /* :1012 */
void CalcObjectBoundingSphere(Group *defGroup,Group *boundingSphereGroup);   /* :1064 */
void CalcObjDefPtrs(void);   /* :1179 */
void Track_InitPersistentData(SerializedGroup *perGroup);   /* :1212 */
void Track_Init(char *tempName);   /* :1312 */
void Track_DeInit(void);   /* :1492 */
void Track_AnimateTrackLighting(void);   /* :1537 */
char * KillFile_OpenRead(void);   /* :1720 */
void KillFile_ReadEntry(char *filePtr,int entryInd,int &chunkInd,int &objectInd);   /* :1732 */
void Track_LoadObjectKillData(void);   /* :1742 */
extern "C" void ___11SaveSurface(SaveSurface *self, int __in_chrg);   /* :1864 */

#endif /* _GAME_COMMON_TRACK_H_ */
