/* game/common/mpause.h — reconstructed from game/common/mpause.cpp (10 fns) */
#ifndef _GAME_COMMON_MPAUSE_H_
#define _GAME_COMMON_MPAUSE_H_
#include "../../nfs4_types.h"

void * __14tPauseMenuDefs(tPauseMenuDefs *self);   /* :172 */
extern "C" void ___14tPauseMenuDefs(tPauseMenuDefs *self, int __in_chrg);   /* :268 */
void MPause_MusicLogic__Fc(char active);   /* :290 */
void MPause_ControllerLogic__Fv(void);   /* :376 */
int MPause_Logic__Fv(void);   /* :390 */
void MPause_Render__Fv(void);   /* :490 */
void MPause_InitMPause__Fv(void);   /* :540 */
void MPause_StartPauseMenu__Fv(void);   /* :548 */
void MPause_EndPauseMenu__Fv(void);   /* :598 */
void MPause_KillMPause__Fv(void);   /* :605 */

#endif /* _GAME_COMMON_MPAUSE_H_ */
