/* game/common/quatern.h — reconstructed from game/common/quatern.cpp (4 fns) */
#ifndef _GAME_COMMON_QUATERN_H_
#define _GAME_COMMON_QUATERN_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Quatern_VecInterpolate(coorddef *cp0,coorddef *cp1,int weight,coorddef *cp);   /* :59 */
void Quatern_Interpolate(tQuat *q0,tQuat *q1,coorddef *cp0,coorddef *cp1,int weight,tQuat *q,coorddef *cp);   /* :67 */
void Quatern_QuatToMat(tQuat *q,matrixtdef *matrix);   /* :158 */
void Quatern_MatToQuat(matrixtdef *matrix,tQuat *q);   /* :206 */

#endif /* _GAME_COMMON_QUATERN_H_ */
