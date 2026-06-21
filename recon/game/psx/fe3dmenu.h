/* game/psx/fe3dmenu.h — reconstructed from game/psx/fe3dmenu.cpp (3 fns) */
#ifndef _GAME_PSX_FE3DMENU_H_
#define _GAME_PSX_FE3DMENU_H_
#include "../../nfs4_types.h"

void Fe3D_InitShowroom__Fv(void);   /* :76 */
void CameraLookAt__FP10matrixtdefP8coorddef(matrixtdef *mat, coorddef *camPoint);   /* :120 */
void Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii(Car_tObj *carObj, DRender_tView *Vi, int posX, int posY, int player, u_long rotation, int camRot, float camY, float camZ, int light, int reflection);   /* :150 */

#endif /* _GAME_PSX_FE3DMENU_H_ */
