/* game/common/replay.h — reconstructed from game/common/replay.cpp (16 fns) */
#ifndef _GAME_COMMON_REPLAY_H_
#define _GAME_COMMON_REPLAY_H_
#include "../../nfs4_types.h"

char * Replay_Compress__FPc(char *uncompressed_data);   /* :72 */
char * Replay_Decompress__FPc(char *compressed_data);   /* :127 */
void Replay_InitReplay__Fv(void);   /* :169 */
void Replay_ResetReplay__Fv(void);   /* :202 */
void Replay_StoringReplay__Fv(void);   /* :270 */
void Replay_StoringControllerData__FG15tControllerData(tControllerData controllerdata);   /* :283 */
void Replay_RetreivingControllerData__Fv(void);   /* :314 */
void Replay_SaveInput__Fi(int car);   /* :342 */
void Replay_GetInput__Fi(int car);   /* :371 */
void Replay_SaveReplay__Fv(void);   /* :447 */
void Replay_LoadReplay__Fv(void);   /* :469 */
void Replay_DoReplay__FP8Car_tObj(Car_tObj *carObj);   /* :498 */
void Replay_GetInterfaceKey__Fv(void);   /* :516 */
void Replay_LoadCameraFile__Fv(void);   /* :665 */
void Replay_ReplayChooseCamera__Fii(int player, int slice);   /* :797 */
void Replay_ReplayFindClosestCamera__Fii(int player, int slice);   /* :841 */

#endif /* _GAME_COMMON_REPLAY_H_ */
