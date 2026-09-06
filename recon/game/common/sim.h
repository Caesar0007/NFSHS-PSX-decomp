/* game/common/sim.h — reconstructed from game/common/sim.cpp (8 fns) */
#ifndef _GAME_COMMON_SIM_H_
#define _GAME_COMMON_SIM_H_
#include "sim_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Sim_StartUp(void);   /* :186 */
void Sim_Restart(void);   /* :231 */
void Sim_CleanUp(void);   /* :264 */
void Sim_FadeInSFX(void);   /* :290 */
void Sim_ProcessSimSchedules(void);   /* :312 */
void Sim_CheckForPause(int checkInput);   /* :536 */
void Sim_MainGameLoop(void);   /* :554 */

#endif /* _GAME_COMMON_SIM_H_ */
