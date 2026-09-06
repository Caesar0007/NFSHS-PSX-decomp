/* game/common/anim.h — reconstructed from game/common/anim.cpp (18 fns) */
#ifndef _GAME_COMMON_ANIM_H_
#define _GAME_COMMON_ANIM_H_
#include "../../nfs4_types.h"

/* P875: native EXT free APIs use source spellings. Constructor/member APIs
 * come from the included class declarations; duplicate encoded non-members
 * conflicted with them. Typed references/calls verify the actual exports. */

void Anim_Restart(void);   /* :83 */
int Anim_InitSystem(char *trackName);   /* :107 */
void Anim_DeInitSystem(void);   /* :211 */
int Anim_Handle(int num);   /* :231 */
int Anim_FreeHandle(int handle);   /* :244 */
AnimScript * Anim_GetAnim(int handle);   /* :251 */
void Anim_GetLastRotPos(Trk_AnimateInst *animInst, coorddef *pt, matrixtdef *mat);   /* :261 */
int Anim_GetLastAnimPosRot(int animNum, int flags, coorddef *pt, matrixtdef *mat);   /* :284 */
int Anim_GetRotPos(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, matrixtdef *mat);   /* :304 */
int Anim_GetPos(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, int *animTicks, int *animLength);   /* :368 */

#endif /* _GAME_COMMON_ANIM_H_ */
