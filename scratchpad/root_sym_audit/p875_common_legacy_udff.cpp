/* P875 typed address references; compile-only, never linked into the game. */
#include "p875_common_original_udff.h"
void * (*p875_common_udff_0)(char *name, char *mem, int abortFlag) = &Udff_Opena__FPcT0i;
void (*p875_common_udff_1)(Udff_tInfo *handle) = &Udff_Close__FP10Udff_tInfo;
int (*p875_common_udff_2)(Udff_tInfo *handle) = &Udff_GetInt__FP10Udff_tInfo;
void (*p875_common_udff_3)(Udff_tInfo *handle, char *mem, int size) = &Udff_GetBuffer__FP10Udff_tInfoPci;
