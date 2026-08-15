/* game/common/sim.h — reconstructed from game/common/sim.cpp (8 fns) */
#ifndef _GAME_COMMON_SIM_H_
#define _GAME_COMMON_SIM_H_
#include "../../nfs4_types.h"

void Sim_StartUp__Fv(void);   /* :186 */
void Sim_Restart__Fv(void);   /* :231 */
void Sim_CleanUp__Fv(void);   /* :264 */
void Sim_FadeInSFX__Fv(void);   /* :290 */
void Sim_ProcessSimSchedules__Fv(void);   /* :312 */
void Sim_ProcessPause__Fv(void);   /* :467 */
void Sim_CheckForPause__Fi(int checkInput);   /* :536 */
void Sim_MainGameLoop__Fv(void);   /* :554 */

#endif /* _GAME_COMMON_SIM_H_ */
