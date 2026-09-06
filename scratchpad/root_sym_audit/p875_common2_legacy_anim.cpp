/* P875 follow-up typed API references; compile-only, never a game input. */
#include "p875_common2_original_anim.h"
void (*p875_common2_anim_0)(void) = &Anim_Restart__Fv;
int (*p875_common2_anim_1)(char *trackName) = &Anim_InitSystem__FPc;
void (*p875_common2_anim_2)(void) = &Anim_DeInitSystem__Fv;
int (*p875_common2_anim_3)(int num) = &Anim_Handle__Fi;
int (*p875_common2_anim_4)(int handle) = &Anim_FreeHandle__Fi;
void * (*p875_common2_anim_5)(int handle) = &Anim_GetAnim__Fi;
void (*p875_common2_anim_6)(Trk_AnimateInst *animInst, coorddef *pt, matrixtdef *mat) = &Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef;
int (*p875_common2_anim_7)(int animNum, int flags, coorddef *pt, matrixtdef *mat) = &Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef;
int (*p875_common2_anim_8)(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, matrixtdef *mat) = &Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef;
int (*p875_common2_anim_9)(Trk_AnimateInst *animInst, int flags, int ticks, coorddef *pt, int *animTicks, int *animLength) = &Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4;
