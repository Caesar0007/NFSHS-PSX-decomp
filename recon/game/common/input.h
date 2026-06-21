/* game/common/input.h — reconstructed from game/common/input.cpp (8 fns) */
#ifndef _GAME_COMMON_INPUT_H_
#define _GAME_COMMON_INPUT_H_
#include "../../nfs4_types.h"

int * Input_StartUp__Fv(void);   /* :55 */
int Input_WingCommandMode__Fi(int player);   /* :84 */
void Input_Update__Fv(void);   /* :104 */
void Input_Store__Fv(void);   /* :436 */
void Input_Fetch__Fi(int humanIndex);   /* :456 */
char Input_Gear__Fci(char currentGear, int numGears);   /* :466 */
int Input_Interface__FUli(u_long key, int debounce);   /* :488 */
int Input_MainExitKey__Fv(void);   /* :543 */

#endif /* _GAME_COMMON_INPUT_H_ */
