/* game/psx/fe3dmenu.h — reconstructed from game/psx/fe3dmenu.cpp (3 fns) */
#ifndef _GAME_PSX_FE3DMENU_H_
#define _GAME_PSX_FE3DMENU_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Fe3D_InitShowroom(void);   /* SYM 49e715 @0x80012938 */
void CameraLookAt(matrixtdef * mat,coorddef * camPoint);   /* SYM 49e738 @0x80012ae4 */
void Draw_MenuRenderingView(Car_tObj * carObj,DRender_tView * Vi,int posX,int posY,int player,u_long rotation,int camRot,float camY,float camZ,int light,int reflection);   /* SYM 49e76c @0x80012bf8 */

#endif /* _GAME_PSX_FE3DMENU_H_ */
