#include "common.h"
/* auto_reloc externs */
extern int D_8013C338;
extern int D_80148448;
extern int ticks;

INCLUDE_ASM("asm/nonmatchings/main", func_8005972C);

INCLUDE_ASM("asm/nonmatchings/main", func_8005B438);

void func_8005B460(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_8005B468);

void func_8005B488(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_8005B490);

int func_8005B4C4(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8005B4CC);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C414);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C468);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C5E4);

INCLUDE_ASM("asm/nonmatchings/main", func_8005CB4C);

void func_8005F624(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_8005F62C);

int func_8005F678(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8005F680);

INCLUDE_ASM("asm/nonmatchings/main", func_80061348);

void func_80061370(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80061378);

int func_800613C4(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_800613CC);

INCLUDE_ASM("asm/nonmatchings/main", func_80063248);

void AILife_Debug__FPce(char *fmt, ...) {
}
INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadGridAndSetPersonalityIndexes__Fv);

INCLUDE_ASM("asm/nonmatchings/main", __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc);

int func_8006D50C(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8006D514);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D534);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D554);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D574);

void AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails(void *p, void *arr) {
    *(void **)((char *)p + 0x1C) = arr;
}

void func_80072750(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80072758);

int func_80072830(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_80072838);

int AITrigger_Compare__FPCvT0(const void **p1, const void **p2) {
    return ((int *)*p1)[1] - ((int *)*p2)[1];
}

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetOneWay__Fv);

void AudioClc_SndError__Fi(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_GetAsyncSfx__Fiib);

INCLUDE_ASM("asm/nonmatchings/main", InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem);

void Control_AI__FP8Car_tObj(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80092464);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Alloc__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Free__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_BankVolume__FP17CopSpeak_tRequest);

void FastRandom_CleanUp__Fv(void) {
}

char *LocateNextGroupType__15SerializedGroupi(char *grp, int type) {
    char *p = grp + *(int *)(grp + 4);
    if (*(int *)p != type) return 0;
    return p;
}
INCLUDE_ASM("asm/nonmatchings/main", LocateGroupType__15SerializedGroupii);

INCLUDE_ASM("asm/nonmatchings/main", LocateGroupNum__15SerializedGroupi);

INCLUDE_ASM("asm/nonmatchings/main", LocateCreateGroupType__15SerializedGroupiP9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem);

INCLUDE_ASM("asm/nonmatchings/main", CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", __14tPauseMenuDefs);

INCLUDE_ASM("asm/nonmatchings/main", ___14tPauseMenuDefs);

INCLUDE_ASM("asm/nonmatchings/main", func_800A3F08);

int Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei(void *a, void *b, int c) { return 2; }
INCLUDE_ASM("asm/nonmatchings/main", __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim);

INCLUDE_ASM("asm/nonmatchings/main", Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei);

INCLUDE_ASM("asm/nonmatchings/main", Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei);

INCLUDE_ASM("asm/nonmatchings/main", __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim);

INCLUDE_ASM("asm/nonmatchings/main", Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei);

INCLUDE_ASM("asm/nonmatchings/main", ___14ObjectSignAnim);

INCLUDE_ASM("asm/nonmatchings/main", ___22ObjectFinishedSignAnim);

INCLUDE_ASM("asm/nonmatchings/main", ___15ObjectMultiAnim);

INCLUDE_ASM("asm/nonmatchings/main", ___23ObjectFinishedMultiAnim);

INCLUDE_ASM("asm/nonmatchings/main", func_800A6DE0);

INCLUDE_ASM("asm/nonmatchings/main", func_800B6B9C);

INCLUDE_ASM("asm/nonmatchings/main", Alloc__9SimpleMemii);

INCLUDE_ASM("asm/nonmatchings/main", FeignAlloc__9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", ResizeToFit__9SimpleMem);

INCLUDE_ASM("asm/nonmatchings/main", func_800B75CC);

INCLUDE_ASM("asm/nonmatchings/main", func_800B75F8);

INCLUDE_ASM("asm/nonmatchings/main", Save__11SaveSurfaceP14Trk_NewSimQuad);

INCLUDE_ASM("asm/nonmatchings/main", __11SaveSurfacei);

INCLUDE_ASM("asm/nonmatchings/main", ___11SaveSurface);

INCLUDE_ASM("asm/nonmatchings/main", RestoreAll__11SaveSurface);

void ChangeTPage__FPUsi(unsigned short *p, int i) {
    *p = (*p & 0xFF9F) | (i << 5);
}

INCLUDE_ASM("asm/nonmatchings/main", func_800CB6A0);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_LightningAddFork__FScScSc);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc);

INCLUDE_ASM("asm/nonmatchings/main", func_800D2A44);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BTCStats__Fsb);

int Weather_GetNumParticles__Fi(int player) {
    return *(int *)0x80123408;
}

void fortext4(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_800E80C4);

INCLUDE_ASM("asm/nonmatchings/main", func_800F219C);

INCLUDE_ASM("asm/nonmatchings/main", func_8010694C);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C9FC);

INCLUDE_ASM("asm/nonmatchings/main", func_8010CA40);
