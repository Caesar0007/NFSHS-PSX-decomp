/* game/common/render.h — reconstructed from game/common/render.cpp (23 fns) */
#ifndef _GAME_COMMON_RENDER_H_
#define _GAME_COMMON_RENDER_H_
#include "render_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void Render_CreatePlayerViews(void);   /* :92 */
void Render_CreatePauseMenuViews(void);   /* :140 */
void Render_CreateViews(void);   /* :151 */
void Render_StartRenderingWorldView(int viewid);   /* :169 */
void Render_StopRenderingWorldView(int viewid);   /* :215 */
void Render_RenderWorld(DRender_tView *Vi);   /* :223 */
void Render_RenderPlayerView(int ViewID, int Player);   /* :270 */
void Render_RenderDebugView(void);   /* :332 */
void Render_StartFrameRender(void);   /* :359 */
void Render_StopFrameRender(void);   /* :375 */
void Render_InitPauseMenu(void);   /* :387 */
void Render_RenderPauseMenuView(void);   /* :393 */
void Render_KillPauseMenu(void);   /* :411 */
void Render_Render(int pause);   /* :417 */
void FlareThing(void);   /* :535 */
void Render_InitTrackRender(void);   /* :563 */
void Render_RestartTrackRender(void);   /* :600 */
void Render_InitTrackRenderPostSim(void);   /* :612 */
void Render_KillTrackRender(void);   /* :624 */
void Render_InitLibRender(void);   /* :640 */
void StampImage(int xo, int depth);   /* :711 */
void Render_InitBlurMode(void);   /* :773 */
void Render_InsertDepthOfField(void);   /* :790 */

#endif /* _GAME_COMMON_RENDER_H_ */
