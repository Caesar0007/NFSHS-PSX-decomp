/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_mathnfs.h"
int (*p875_common_mathnfs_0)(coorddef *a, coorddef *b) = &Math_DistXZ__FP8coorddefT0;
int (*p875_common_mathnfs_1)(coorddef *a, coorddef *b) = &Math_Dist3D__FP8coorddefT0;
int (*p875_common_mathnfs_2)(int a, int b) = &Math_BetterDist__Fii;
void (*p875_common_mathnfs_3)(int x, int y, int angle, int *newx, int *newy) = &Math_ResolveRotatedVector__FiiiPiT3;
int (*p875_common_mathnfs_4)(coorddef *v) = &Math_VectorLength__FP8coorddef;
int (*p875_common_mathnfs_5)(coorddef *v) = &Math_VectorLength2__FP8coorddef;
void (*p875_common_mathnfs_6)(coorddef *v) = &Math_NormalizeVector__FP8coorddef;
void (*p875_common_mathnfs_7)(coorddef *v) = &Math_NormalizeShortVector__FP8coorddef;
void (*p875_common_mathnfs_8)(coorddef *v) = &Math_QDNormalizeVector__FP8coorddef;
void (*p875_common_mathnfs_9)(matrixtdef *m1, matrixtdef *m2, matrixtdef *mr) = &Math_fasttransmult__FP10matrixtdefN20;
