/* game/common/quatern.h — reconstructed from game/common/quatern.cpp (4 fns) */
#ifndef _GAME_COMMON_QUATERN_H_
#define _GAME_COMMON_QUATERN_H_
#include "../../nfs4_types.h"

void Quatern_VecInterpolate__FP8coorddefT0iT0(coorddef *cp0, coorddef *cp1, int weight, coorddef *cp);   /* :59 */
void Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2(tQuat *q0, tQuat *q1, coorddef *cp0, coorddef *cp1, int weight, tQuat *q, coorddef *cp);   /* :67 */
void Quatern_QuatToMat__FP5tQuatP10matrixtdef(tQuat *q, matrixtdef *matrix);   /* :158 */
void Quatern_MatToQuat__FP10matrixtdefP5tQuat(matrixtdef *matrix, tQuat *q);   /* :206 */

#endif /* _GAME_COMMON_QUATERN_H_ */
