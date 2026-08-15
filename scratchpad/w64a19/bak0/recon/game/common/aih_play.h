/* game/common/aih_play.h — reconstructed from game/common/aih_play.cpp (9 fns) */
#ifndef _GAME_COMMON_AIH_PLAY_H_
#define _GAME_COMMON_AIH_PLAY_H_
#include "../../nfs4_types.h"

int CheckIfABlockadeCanBeSetup__13AIHigh_Player(AIHigh_Player *self);   /* :55 */
void SetupBlockade__13AIHigh_Player(AIHigh_Player *self);   /* :184 */
void CheckForNewLevel__13AIHigh_Playeri(AIHigh_Player *self, int force);   /* :434 */
void HandleSpeech__13AIHigh_Player(AIHigh_Player *self);   /* :517 */
void MaintainAvailableCops__13AIHigh_Player(AIHigh_Player *self);   /* :669 */
void * __13AIHigh_PlayerP8Car_tObj(AIHigh_Player *self, Car_tObj *carObj);   /* :750 */
void HandleCops__13AIHigh_Player(AIHigh_Player *self);   /* :808 */
void CleanupBlockaders__13AIHigh_Playeri(AIHigh_Player *self, int forceClearAll);   /* :871 */
void HandlePullOver__13AIHigh_Player(AIHigh_Player *self);   /* :906 */

#endif /* _GAME_COMMON_AIH_PLAY_H_ */
