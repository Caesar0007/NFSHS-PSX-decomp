/* game/common/anim_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_ANIM_EXTERNS_H_
#define _GAME_COMMON_ANIM_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

char *Platform_GetDCTBuffer(...); void Platform_ResetDCTBuffer();
extern Group              *gPersistObjInst;          /* track.obj */
extern Sim_tSimGlobalVar  simGlobal;          /* Sim.obj   (.gameTicks) */
extern void  Quatern_QuatToMat(tQuat *q, matrixtdef *m);     /* quatern.obj */
extern void *__builtin_vec_new(unsigned int size);
extern void DrawW_ResetAnimationTimer(void);
extern void Quatern_Interpolate(tQuat *q0,tQuat *q1,coorddef *cp0,coorddef *cp1,int weight,tQuat *q,coorddef *cp);
extern void Quatern_VecInterpolate(coorddef *cp0,coorddef *cp1,int weight,coorddef *cp);
extern void __builtin_vec_delete(void *deleteMe);
int __builtin_delete(...);
void  trap(int code);

#endif /* _GAME_COMMON_ANIM_EXTERNS_H_ */
