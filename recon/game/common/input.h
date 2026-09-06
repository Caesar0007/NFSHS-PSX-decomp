/* game/common/input.h — reconstructed from game/common/input.cpp (8 fns) */
#ifndef _GAME_COMMON_INPUT_H_
#define _GAME_COMMON_INPUT_H_
#include "input_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

int * Input_StartUp(void);   /* :55 */
int Input_WingCommandMode(int player);   /* :84 */
void Input_Update(void);   /* :104 */
void Input_Store(void);   /* :436 */
void Input_Fetch(int humanIndex);   /* :456 */
char Input_Gear(char currentGear,int numGears);   /* :466 */
int Input_Interface(u_long key,int debounce);   /* :488 */
int Input_MainExitKey(void);   /* :543 */

#endif /* _GAME_COMMON_INPUT_H_ */
