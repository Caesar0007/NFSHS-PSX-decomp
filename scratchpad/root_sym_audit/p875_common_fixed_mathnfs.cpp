/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/mathnfs.h"
int (*p875_common_mathnfs_0)(coorddef *a,coorddef *b) = &Math_DistXZ;
int (*p875_common_mathnfs_1)(coorddef *a,coorddef *b) = &Math_Dist3D;
int (*p875_common_mathnfs_2)(int a,int b) = &Math_BetterDist;
void (*p875_common_mathnfs_3)(int x,int y,int angle,int *newx,int *newy) = &Math_ResolveRotatedVector;
int (*p875_common_mathnfs_4)(coorddef *v) = &Math_VectorLength;
int (*p875_common_mathnfs_5)(coorddef *v) = &Math_VectorLength2;
void (*p875_common_mathnfs_6)(coorddef *v) = &Math_NormalizeVector;
void (*p875_common_mathnfs_7)(coorddef *v) = &Math_NormalizeShortVector;
void (*p875_common_mathnfs_8)(coorddef *v) = &Math_QDNormalizeVector;
void (*p875_common_mathnfs_9)(matrixtdef *m1,matrixtdef *m2,matrixtdef *mr) = &Math_fasttransmult;
