/* game/common/mpause.h — reconstructed from game/common/mpause.cpp (10 fns) */
#ifndef _GAME_COMMON_MPAUSE_H_
#define _GAME_COMMON_MPAUSE_H_
#include "../../nfs4_types.h"

/* P875: native EXT free APIs use source spellings. Constructor/member APIs
 * come from the included class declarations; duplicate encoded non-members
 * conflicted with them. Typed references/calls verify the actual exports. */

extern "C" void ___14tPauseMenuDefs(tPauseMenuDefs *self, int __in_chrg);   /* :268 */
void MPause_MusicLogic(char active);   /* :290 */
void MPause_ControllerLogic(void);   /* :376 */
int MPause_Logic(void);   /* :390 */
void MPause_Render(void);   /* :490 */
void MPause_InitMPause(void);   /* :540 */
void MPause_StartPauseMenu(void);   /* :548 */
void MPause_EndPauseMenu(void);   /* :598 */
void MPause_KillMPause(void);   /* :605 */

#endif /* _GAME_COMMON_MPAUSE_H_ */
