/* game/psx/trsproj.h — reconstructed from game/psx/trsproj.cpp (11 fns) */
#ifndef _GAME_PSX_TRSPROJ_H_
#define _GAME_PSX_TRSPROJ_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void TrsProj_SetTransPrecision(int val);   /* SYM 47f303 @0x800e192c */
void TrsProj_ResetTransPrecision(void);   /* SYM 47f32e @0x800e1938 */
void TrsProj_SetProjection(int cx,int cy,int w,int h);   /* SYM 47f35b @0x800e1948 */
void TrsProj_SetMenuProjection(int cx,int cy,int w,int h);   /* SYM 47f385 @0x800e19c8 */
void TrsProj_SetViewTrsProjEnviro(DRender_tView * Vi);   /* SYM 47f3b3 @0x800e1a08 */
void TrsProj_SetPsxMatrix(matrixtdef * m,coorddef * t);   /* SYM 47f3f0 @0x800e1a5c */
void TrsProj_SetPsxTrans(coorddef * t);   /* SYM 47f42c @0x800e1b4c */
void TrsProj_SetPsxTransZero(void);   /* SYM 47f45a @0x800e1b9c */
void TrsProj_TransPt(coorddef * s,coorddef * d);   /* SYM 47f483 @0x800e1bcc */
void TrsProj_TransPtN16(RelCoord16 * s,coorddef * d,int n);   /* SYM 47f4af @0x800e1c58 */
void TrsProj_TransformProjectVertex(matrixtdef * m,coorddef * t,int n,coorddef * s,Draw_tVertex * v);   /* SYM 47f4ea @0x800e1ce0 */

#endif /* _GAME_PSX_TRSPROJ_H_ */
