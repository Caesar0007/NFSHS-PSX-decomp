#include "C:/Temp/nfs4-decomp/recon/game/psx/fe3dmenu.h"
void (*p875_probe_0)(void) = &Fe3D_InitShowroom;
void (*p875_probe_1)(matrixtdef * mat,coorddef * camPoint) = &CameraLookAt;
void (*p875_probe_2)(Car_tObj * carObj,DRender_tView * Vi,int posX,int posY,int player,u_long rotation,int camRot,float camY,float camZ,int light,int reflection) = &Draw_MenuRenderingView;
