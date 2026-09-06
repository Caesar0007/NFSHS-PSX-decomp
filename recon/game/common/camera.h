/* game/common/camera.h — reconstructed from game/common/camera.cpp (38 fns) */
#ifndef _GAME_COMMON_CAMERA_H_
#define _GAME_COMMON_CAMERA_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void EulerToMat(matrixtdef *m, int ax, int ay, int az);   /* :482 */
void Camera_SetCamera(DRender_tView *cview);   /* :613 */
void Camera_LookBack(matrixtdef *src, matrixtdef *tgt);   /* :662 */
void Camera_TunnelLimit(int player, int *armheight);   /* :684 */
void Camera_UpdateCollisionCam(int player);   /* :727 */
void Camera_UpdateSimpleCam(int player);   /* :791 */
void Camera_UpdateBumperCam(int player);   /* :808 */
void Camera_UpdateTailCam(int player, int behavior);   /* :844 */
void Camera_UpdateHeliCam(int player, int behavior);   /* :950 */
void Camera_UpdateCircleCam(int player);   /* :1069 */
void SetCameraZoom(int player, int targetDist);   /* :1116 */
void Camera_UpdateTVCam(int player);   /* :1136 */
void Camera_UpdateAnimCam(int player);   /* :1203 */
void Camera_UpdateFinishCam(int player);   /* :1283 */
void Camera_UpdateBlimpCam(int player);   /* :1350 */
void Camera_SetSplineCam(int player);   /* :1395 */
void Camera_UpdateSplineCam(int player);   /* :1444 */
int Camera_IslandProfile(u_short before);   /* :1553 */
void Camera_UpdatePulloverCam(int player);   /* :1579 */
void Camera_UpdateCopCam1(int player);   /* :1708 */
void Camera_UpdateCopCam2(int player);   /* :1727 */
void Camera_UpdateBTCopCam(int player);   /* :1741 */
void Camera_Update(void);   /* :1777 */
void Camera_Init(void);   /* :1912 */
void Camera_Kill(void);   /* :2001 */
void Camera_PitchAndRoll(int player);   /* :2013 */
int Camera_TooSteep(int player, BWorldSm_Pos *slicePos);   /* :2039 */
void Camera_CheckWallCollisions(int player, coorddef *pos);   /* :2073 */
void Camera_SetAboveGround(int player, coorddef *pos);   /* :2219 */
void Camera_AcquireTarget(int player, coorddef *point, coorddef *pos, matrixtdef *rot, int hirez);   /* :2239 */
void Camera_OpponentLookBehind(int player, coorddef *pos, int reset);   /* :2290 */
void Camera_GetViewInfo(int cviewP, DRender_tCalcView *cview, int viewID);   /* :2356 */
void Camera_GetAudioViewInfo(int cviewP, DRender_tCalcView *cview, coorddef **cvel);   /* :2482 */
int Camera_GetMode(int cviewP);   /* :2547 */
void Camera_SetMode(int cviewP, int mode);   /* :2566 */
void Camera_NextMode(int cviewP);   /* :2622 */
void Camera_ReplayUpdate(int cviewP, Camera_tCamSlot *ptr);   /* :2690 */
void Camera_ResetRelPos(int bitMask);   /* :2713 */

#endif /* _GAME_COMMON_CAMERA_H_ */
