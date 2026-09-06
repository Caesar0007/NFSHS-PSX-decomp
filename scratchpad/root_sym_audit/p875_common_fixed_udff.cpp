/* P875 typed address references; compile-only, never linked into the game. */
#include "C:/Temp/nfs4-decomp/recon/game/common/udff.h"
Udff_tInfo * (*p875_common_udff_0)(char *name,char *mem,int abortFlag) = &Udff_Opena;
void (*p875_common_udff_1)(Udff_tInfo *handle) = &Udff_Close;
int (*p875_common_udff_2)(Udff_tInfo *handle) = &Udff_GetInt;
void (*p875_common_udff_3)(Udff_tInfo *handle,char *mem,int size) = &Udff_GetBuffer;
