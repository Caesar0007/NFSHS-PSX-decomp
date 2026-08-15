/* game/common/render.h — reconstructed from game/common/render.cpp (23 fns) */
#ifndef _GAME_COMMON_RENDER_H_
#define _GAME_COMMON_RENDER_H_
#include "../../nfs4_types.h"

void Render_CreatePlayerViews__Fv(void);   /* :92 */
void Render_CreatePauseMenuViews__Fv(void);   /* :140 */
void Render_CreateViews__Fv(void);   /* :151 */
void Render_StartRenderingWorldView__Fi(int viewid);   /* :169 */
void Render_StopRenderingWorldView__Fi(int viewid);   /* :215 */
void Render_RenderWorld__FP13DRender_tView(DRender_tView *Vi);   /* :223 */
void Render_RenderPlayerView__Fii(int ViewID, int Player);   /* :270 */
void Render_RenderDebugView__Fv(void);   /* :332 */
void Render_StartFrameRender__Fv(void);   /* :359 */
void Render_StopFrameRender__Fv(void);   /* :375 */
void Render_InitPauseMenu__Fv(void);   /* :387 */
void Render_RenderPauseMenuView__Fv(void);   /* :393 */
void Render_KillPauseMenu__Fv(void);   /* :411 */
void Render_Render__Fi(int pause);   /* :417 */
void FlareThing__Fv(void);   /* :535 */
void Render_InitTrackRender__Fv(void);   /* :563 */
void Render_RestartTrackRender__Fv(void);   /* :600 */
void Render_InitTrackRenderPostSim__Fv(void);   /* :612 */
void Render_KillTrackRender__Fv(void);   /* :624 */
void Render_InitLibRender__Fv(void);   /* :640 */
void StampImage__Fii(int xo, int depth);   /* :711 */
void Render_InitBlurMode__Fv(void);   /* :773 */
void Render_InsertDepthOfField__Fv(void);   /* :790 */

#endif /* _GAME_COMMON_RENDER_H_ */
