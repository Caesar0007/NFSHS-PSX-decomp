/* game/common/replay.h — reconstructed from game/common/replay.cpp (16 fns) */
#ifndef _GAME_COMMON_REPLAY_H_
#define _GAME_COMMON_REPLAY_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

char * Replay_Compress(char *uncompressed_data);   /* :72 */
char * Replay_Decompress(char *compressed_data);   /* :127 */
void Replay_InitReplay(void);   /* :169 */
void Replay_ResetReplay(void);   /* :202 */
void Replay_StoringReplay(void);   /* :270 */
void Replay_StoringControllerData(tControllerData controllerdata);   /* :283 */
tControllerData Replay_RetreivingControllerData(void);   /* :314 */
void Replay_SaveInput(int car);   /* :342 */
void Replay_GetInput(int car);   /* :371 */
void Replay_SaveReplay(void);   /* :447 */
void Replay_LoadReplay(void);   /* :469 */
void Replay_DoReplay(Car_tObj *carObj);   /* :498 */
void Replay_GetInterfaceKey(void);   /* :516 */
void Replay_LoadCameraFile(void);   /* :665 */
void Replay_ReplayChooseCamera(int player,int slice);   /* :797 */
void Replay_ReplayFindClosestCamera(int player,int slice);   /* :841 */

#endif /* _GAME_COMMON_REPLAY_H_ */
