/* game/common/camera.h — reconstructed from game/common/camera.cpp (38 fns) */
#ifndef _GAME_COMMON_CAMERA_H_
#define _GAME_COMMON_CAMERA_H_
#include "../../nfs4_types.h"

void EulerToMat__FP10matrixtdefiii(matrixtdef *m, int ax, int ay, int az);   /* :482 */
void Camera_SetCamera__FP13DRender_tView(DRender_tView *cview);   /* :613 */
void Camera_LookBack__FP10matrixtdefT0(matrixtdef *src, matrixtdef *tgt);   /* :662 */
void Camera_TunnelLimit__FiPi(int player, int *armheight);   /* :684 */
void Camera_UpdateCollisionCam__Fi(int player);   /* :727 */
void Camera_UpdateSimpleCam__Fi(int player);   /* :791 */
void Camera_UpdateBumperCam__Fi(int player);   /* :808 */
void Camera_UpdateTailCam__Fii(int player, int behavior);   /* :844 */
void Camera_UpdateHeliCam__Fii(int player, int behavior);   /* :950 */
void Camera_UpdateCircleCam__Fi(int player);   /* :1069 */
void SetCameraZoom__Fii(int player, int targetDist);   /* :1116 */
void Camera_UpdateTVCam__Fi(int player);   /* :1136 */
void Camera_UpdateAnimCam__Fi(int player);   /* :1203 */
void Camera_UpdateFinishCam__Fi(int player);   /* :1283 */
void Camera_UpdateBlimpCam__Fi(int player);   /* :1350 */
void Camera_SetSplineCam__Fi(int player);   /* :1395 */
void Camera_UpdateSplineCam__Fi(int player);   /* :1444 */
int Camera_IslandProfile__FUs(u_short before);   /* :1553 */
void Camera_UpdatePulloverCam__Fi(int player);   /* :1579 */
void Camera_UpdateCopCam1__Fi(int player);   /* :1708 */
void Camera_UpdateCopCam2__Fi(int player);   /* :1727 */
void Camera_UpdateBTCopCam__Fi(int player);   /* :1741 */
void Camera_Update__Fv(void);   /* :1777 */
void Camera_Init__Fv(void);   /* :1912 */
void Camera_Kill__Fv(void);   /* :2001 */
void Camera_PitchAndRoll__Fi(int player);   /* :2013 */
int Camera_TooSteep__FiP12BWorldSm_Pos(int player, BWorldSm_Pos *slicePos);   /* :2039 */
void Camera_CheckWallCollisions__FiP8coorddef(int player, coorddef *pos);   /* :2073 */
void Camera_SetAboveGround__FiP8coorddef(int player, coorddef *pos);   /* :2219 */
void Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi(int player, coorddef *point, coorddef *pos, matrixtdef *rot, int hirez);   /* :2239 */
void Camera_OpponentLookBehind__FiP8coorddefi(int player, coorddef *pos, int reset);   /* :2290 */
void Camera_GetViewInfo__FiP17DRender_tCalcViewi(int cviewP, DRender_tCalcView *cview, int viewID);   /* :2356 */
void Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef(int cviewP, DRender_tCalcView *cview, coorddef **cvel);   /* :2482 */
int Camera_GetMode__Fi(int cviewP);   /* :2547 */
void Camera_SetMode__Fii(int cviewP, int mode);   /* :2566 */
void Camera_NextMode__Fi(int cviewP);   /* :2622 */
void Camera_ReplayUpdate__FiP15Camera_tCamSlot(int cviewP, Camera_tCamSlot *ptr);   /* :2690 */
void Camera_ResetRelPos__Fi(int bitMask);   /* :2713 */

#endif /* _GAME_COMMON_CAMERA_H_ */
