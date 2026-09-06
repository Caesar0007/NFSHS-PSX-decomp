/* game/common/dashhud.h — reconstructed from game/common/dashhud.cpp (6 fns) */
#ifndef _GAME_COMMON_DASHHUD_H_
#define _GAME_COMMON_DASHHUD_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

void DashHUD_InitHUD(void);   /* :38 */
void DashHUD_KillHUD(void);   /* :101 */
void DashHUD_ResetHUD(void);   /* :106 */
void DashHUD_ToggleHud(int player);   /* :125 */
void DashHUD_CheckWrongWay(int player);   /* :151 */
void DashHUD_HUDCalc(int player);   /* :171 */

#endif /* _GAME_COMMON_DASHHUD_H_ */
