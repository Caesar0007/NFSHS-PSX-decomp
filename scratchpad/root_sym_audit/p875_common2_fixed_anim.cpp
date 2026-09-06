/* P875 follow-up typed API references; compile-only, never a game input. */
#include "C:/Temp/nfs4-decomp/recon/game/common/anim.h"
void (*p875_common2_anim_0)(void) = &Anim_Restart;
int (*p875_common2_anim_1)(char *trackName) = &Anim_InitSystem;
void (*p875_common2_anim_2)(void) = &Anim_DeInitSystem;
int (*p875_common2_anim_3)(int num) = &Anim_Handle;
int (*p875_common2_anim_4)(int handle) = &Anim_FreeHandle;
AnimScript * (*p875_common2_anim_5)(int handle) = &Anim_GetAnim;
void (*p875_common2_anim_6)(Trk_AnimateInst *animInst,coorddef *pt,matrixtdef *mat) = &Anim_GetLastRotPos;
int (*p875_common2_anim_7)(int animNum,int flags,coorddef *pt,matrixtdef *mat) = &Anim_GetLastAnimPosRot;
int (*p875_common2_anim_8)(Trk_AnimateInst *animInst,int flags,int ticks,coorddef *pt,matrixtdef *mat) = &Anim_GetRotPos;
int (*p875_common2_anim_9)(Trk_AnimateInst *animInst,int flags,int ticks,coorddef *pt,int *animTicks, int *animLength) = &Anim_GetPos;
