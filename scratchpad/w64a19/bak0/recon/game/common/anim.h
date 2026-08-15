/* game/common/anim.h — reconstructed from game/common/anim.cpp (18 fns) */
#ifndef _GAME_COMMON_ANIM_H_
#define _GAME_COMMON_ANIM_H_
#include "../../nfs4_types.h"

void Anim_Restart__Fv(void);   /* :83 */
int Anim_InitSystem__FPc(char *trackName);   /* :107 */
void Anim_DeInitSystem__Fv(void);   /* :211 */
int Anim_Handle__Fi(int num);   /* :231 */
int Anim_FreeHandle__Fi(int handle);   /* :244 */
void * Anim_GetAnim__Fi(int handle);   /* :251 */
void Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef(Trk_AnimateInst *animInst, coorddef *pt, matrixtdef *mat);   /* :261 */
int Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef(int animNum, int flags, coorddef *pt, matrixtdef *mat);   /* :284 */
int Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, matrixtdef *mat);   /* :304 */
int Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, int *animTicks, int *animLength);   /* :368 */
void * __10AnimScripti(AnimScript *self, int num);   /* :460 */
void * __10AnimScriptii(AnimScript *self, int num, int numParts);   /* :472 */
void * __10AnimScriptP5Groupiii(AnimScript *self, Group *instanceGroup, int type, int boomIndex, int numParts);   /* :485 */
void SetAnimAttrib__10AnimScripti(AnimScript *self, int flags);   /* :513 */
void GetAnimFrameInfo__10AnimScriptPiT1(AnimScript *self, int *frame, int *numFrames);   /* :523 */
int GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef(AnimScript *self, coorddef *pt, matrixtdef *mat);   /* :553 */
int GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef(AnimScript *self, int index, coorddef *pt, matrixtdef *mat);   /* :564 */
int GetStatus__10AnimScript(AnimScript *self);   /* :599 */

#endif /* _GAME_COMMON_ANIM_H_ */
