/* Frozen original recon/game/psx/fe3dmenu.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Fe3D_InitShowroom__Fv(void);   /* :76 */
void CameraLookAt__FP10matrixtdefP8coorddef(matrixtdef *mat, coorddef *camPoint);   /* :120 */
void Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii(Car_tObj *carObj, DRender_tView *Vi, int posX, int posY, int player, u_long rotation, int camRot, float camY, float camZ, int light, int reflection);   /* :150 */
void (*p875_probe_0)(void) = &Fe3D_InitShowroom__Fv;
void (*p875_probe_1)(matrixtdef *mat, coorddef *camPoint) = &CameraLookAt__FP10matrixtdefP8coorddef;
void (*p875_probe_2)(Car_tObj *carObj, DRender_tView *Vi, int posX, int posY, int player, u_long rotation, int camRot, float camY, float camZ, int light, int reflection) = &Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii;
