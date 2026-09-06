/* game/psx/psxcontroller.h — reconstructed from game/psx/psxcontroller.cpp (4 fns) */
#ifndef _GAME_PSX_PSXCONTROLLER_H_
#define _GAME_PSX_PSXCONTROLLER_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void InGame_ResetPSXController(int player,int config);   /* SYM 4547ea @0x800dc4cc */
int InGame_GetPSXPadValue(int value,int player);   /* SYM 454816 @0x800dc990 */
int InGame_GetDevice(int control);   /* SYM 45483e @0x800dcd34 */
void InGame_SetRamp(void);   /* SYM 454860 @0x800dcd3c */

#endif /* _GAME_PSX_PSXCONTROLLER_H_ */
