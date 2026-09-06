/* game/psx/force.h — reconstructed from game/psx/force.cpp (9 fns) */
#ifndef _GAME_PSX_FORCE_H_
#define _GAME_PSX_FORCE_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Force_Vbl(void);   /* SYM 3f1520 @0x800ca998 */
void Force_Update(Car_tObj * car);   /* SYM 3f153b @0x800cabc0 */
void Force_StartUp(void);   /* SYM 3f1562 @0x800cb018 */
void Force_Disable(void);   /* SYM 3f1581 @0x800cb0e4 */
int Force_IsForceOn(Car_tObj * car);   /* SYM 3f15a0 @0x800cb158 */
void Force_Pause(void);   /* SYM 3f15ca @0x800cb1b4 */
void Force_UnPause(void);   /* SYM 3f15e7 @0x800cb1f4 */
void Force_HitSign(Car_tObj * car);   /* SYM 3f1606 @0x800cb1fc */
void Force_HitWall(int impulse);   /* SYM 3f162e @0x800cb204 */

#endif /* _GAME_PSX_FORCE_H_ */
