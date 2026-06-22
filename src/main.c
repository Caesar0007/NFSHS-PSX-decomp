#include "common.h"
/* auto_reloc externs */
extern int D_8013C338;
extern int D_80148448;
extern int ticks;

void AI_StartUp__Fv(void) {
}

void AI_CleanUp__Fv(void) {
}

void AI_Main_OverallSetup__Fv(void) {
}

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

INCLUDE_ASM("asm/nonmatchings/main", ___16AIHigh_BasicPerp);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C414);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C468);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C5E4);

INCLUDE_ASM("asm/nonmatchings/main", func_8005CB4C);

int FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp(void *cop, void *perp) {
    if (*(void **)((char *)cop + 0x58) == perp)
        *(int *)((char *)cop + 0x60) = 2;
    return 2;
}
void FreezeAndEndChase__14AIHigh_BTC_Cop(void) {
}

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

INCLUDE_ASM("asm/nonmatchings/main", ___15AIHigh_Opponent);

INCLUDE_ASM("asm/nonmatchings/main", ___10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIHigh_Traffic);

void AILife_Debug__FPce(char *fmt, ...) {
}
INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadGridAndSetPersonalityIndexes__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_SetPersonality__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_SetPersonalityPointers__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadPersonalityData__FP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadScriptData__FP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadGlue__FP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_Startup__Fv);

void AIPerson_Cleanup__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AIPhysics_UseCoolPhysics__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", AddRecordToCollection__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", RemoveRecordFromCollection__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", StartUp1__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", StartUp2__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", CleanUp1__14AIDataRecord_t);

void CleanUp2__14AIDataRecord_t(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Setup__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", Load__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", SaveAndPurge__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t);

int Get__23AIDataRecord_AccTable_ti(void *this, int i) {
    short *table = *(short **)((char *)this + 0x48);
    return table[i] << 8;
}
INCLUDE_ASM("asm/nonmatchings/main", Setup__23AIDataRecord_AccTable_t);

INCLUDE_ASM("asm/nonmatchings/main", __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t);

unsigned char Get__25AIDataRecord_TrackCurve_ti(void *this, int i) {
    unsigned char *table = *(unsigned char **)((char *)this + 0x48);
    return table[i];
}
INCLUDE_ASM("asm/nonmatchings/main", __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", Get__30AIDataRecord_CurveSpeedTable_ti);

INCLUDE_ASM("asm/nonmatchings/main", Upgrade__30AIDataRecord_CurveSpeedTable_ti);

int func_8006D50C(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8006D514);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D534);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D554);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D574);

INCLUDE_ASM("asm/nonmatchings/main", ___23AIDataRecord_AccTable_t);

int AISpeeds_GetNextAICar__FP8Car_tObj(void *a0) {
    return *(int *)((char *)a0 + 0x768);
}

void AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails(void *p, void *arr) {
    *(void **)((char *)p + 0x1C) = arr;
}
INCLUDE_ASM("asm/nonmatchings/main", AIScript_ClearLastReactionIndex__FP10AIScript_t);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_Startup__FP10AIScript_t);

void AIScript_Cleanup__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_ProcessActionsAndReactions__FP10AIScript_ti);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_GetReactionTicksLeft__FP10AIScript_t);

void AIState_CleanUp__Fv(void) {
}

void DoSlowNitrous__13AIState_Chase(void *this) {
    *(int *)((char *)*(void **)this + 0x73C) = 0x8000;
    *(int *)((char *)*(void **)this + 0x740) = 0xC000;
}

INCLUDE_ASM("asm/nonmatchings/main", CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi);

int TestForRelease__21AIState_RovingTraffic(void *this) {
    int f10 = *(int *)((char *)this + 0x10);
    int fC  = *(int *)((char *)this + 0xC);
    return !(f10 < fC);
}

void func_80072750(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80072758);

int func_80072830(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_80072838);

void DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t(void) {
}

int AITrigger_Compare__FPCvT0(const void **p1, const void **p2) {
    return ((int *)*p1)[1] - ((int *)*p2)[1];
}

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetOneWay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetDriveSide__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetRoughLapTimes__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AITune_StartUp1__Fv);

void AITune_StartUp2__Fv(void) {
}

void AITune_CleanUp1__Fv(void) {
}

void AITune_CleanUp2__Fv(void) {
}

int AIWorld_GameOdometer__FP8Car_tObj(void *car) {
    unsigned short v = ((unsigned short *)car)[3];
    return (v * 3) << 17;
}

int AIWorld_IsDriveableLane_UsingMask__Fii(int lane, int mask) {
    char *p = (char *)(lane << 5);
    p += (int)*(char **)0x8013C7C0;
    return *(short *)(p + 0x16) & mask;
}

void SetAnimAttrib__10AnimScripti(void *this, int v) {
    *(int *)((char *)this + 8) = v;
}

void AudioClc_SndError__Fi(void) {
}

int AudioCmn_GetTrackRecordLapTime__Fv(void) {
    return *(int *)0x801132D4;
}

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_GetAsyncSfx__Fiib);

void AudioEng_Resume__Fv(void) {
}

void BWorld_StartLoop__Fv(void) {
}

void BWorldSm_DeInit__Fv(void) {
}

void Cars_GetDashData__FP8Car_tObjPiN21(char *car, int *speed, int *gear, int *rpm) {
    *speed = *(int *)(car + 0x468);
    *gear  = *(unsigned char *)(car + 0x442);
    *rpm   = *(int *)(car + 0x420);
}

void Cars_InitDashData__FP8Car_tObjPiT1(char *car, int *a, int *b) {
    char *sec;
    sec = *(char **)(car + 0x464);
    *a  = *(int *)(sec + 0xF0);
    sec = *(char **)(car + 0x464);
    *b  = *(int *)(sec + 0xF4);
}

void Cars_Initialize__FPci(char *buf, int n) {
    int i = 0;
    if (n <= 0) return;
    do {
        *buf++ = 0;
        i++;
    } while (i < n);
}

INCLUDE_ASM("asm/nonmatchings/main", InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem);

void Chunk_UpdateSys__FP13DRender_tView(void) {
}

void Chunk_Init__Fv(void) {
}

void Chunk_DeInit__Fv(void) {
}

void Control_AI__FP8Car_tObj(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80092464);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Alloc__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Free__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_BankVolume__FP17CopSpeak_tRequest);

void FastRandom_CleanUp__Fv(void) {
}

void GameSetup_CleanUp__Fv(void) {
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

int Value__21tPListIteratorIndexed7tPlayer(char *this) {
    unsigned char *idxp = *(unsigned char **)(this + 0xC);
    int *array = *(int **)(this + 4);
    return array[*idxp];
}

int NextMenu__10tPMenuItem(void *this) { return 0; }
int Debounce__10tPMenuItem(void *this) { return 1; }
void ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand(void) {
}

int Debounce__25tPMenuItemLeftRightSlider(void *this) { return 0; }

int NextMenu__24tPMenuItemGoToMenuButton(void *a0) {
    return *(int *)((char *)a0 + 0xC);
}

int IsNavigable__21tPMenuItemInteractive(void *this) { return 1; }
int IsNavigable__28tPMenuItemNonInteractiveText(void *this) { return 0; }

void Physics_CheckGamedata__Fv(void) {
}

void R3DCar_MATRIX3DT_Copy__FPiT0(int *src, int *dst) {
    int i = 8;
    do {
        *dst++ = *src++;
        i--;
    } while (i != -1);
}

void Render_RenderDebugView__Fv(void) {
}

void Replay_LoadReplay__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_800B6B9C);

INCLUDE_ASM("asm/nonmatchings/main", Alloc__9SimpleMemii);

INCLUDE_ASM("asm/nonmatchings/main", FeignAlloc__9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", ResizeToFit__9SimpleMem);

INCLUDE_ASM("asm/nonmatchings/main", func_800B75CC);

INCLUDE_ASM("asm/nonmatchings/main", func_800B75F8);

void Track_AnimateTrackLighting__Fv(void) {
}

void KillFile_ReadEntry__FPciRiT2(char *file, int i, int *hash, int *size) {
    int *p = (int *)(file + i * 8);
    *hash = p[1];
    *size = p[2];
}

INCLUDE_ASM("asm/nonmatchings/main", Save__11SaveSurfaceP14Trk_NewSimQuad);

INCLUDE_ASM("asm/nonmatchings/main", __11SaveSurfacei);

INCLUDE_ASM("asm/nonmatchings/main", ___11SaveSurface);

INCLUDE_ASM("asm/nonmatchings/main", RestoreAll__11SaveSurface);

void TrgSfx_KillTrgSfx__Fv(void) {
}

int Udff_GetInt__FP10Udff_tInfo(void *this) {
    int **pp = (int **)((char *)this + 8);
    int *p = *pp;
    int v = *p;
    *pp = p + 1;
    return v;
}

int Device_Null__FUl(unsigned long x) { return 0; }

void Draw_RestartRenderEngine__Fv(void) {
}

void ChangeTPage__FPUsi(unsigned short *p, int i) {
    *p = (*p & 0xFF9F) | (i << 5);
}
void DrawC_SetEnviroment__Fv(void) {
}

void Force_UnPause__Fv(void) {
}

void Force_HitSign__FP8Car_tObj(void) {
}

void Force_HitWall__Fi(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_800CB6A0);

void Flare_IdentMatrix__FP6MATRIX(int *m) {
    m[0] = 0x1000;
    m[1] = 0;
    m[2] = 0x1000;
    m[3] = 0;
    m[4] = 0x1000;
}

INCLUDE_ASM("asm/nonmatchings/main", Hrz_LightningAddFork__FScScSc);

void Hud_DebugCrap__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc);

INCLUDE_ASM("asm/nonmatchings/main", func_800D2A44);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BTCStats__Fsb);

void Platform_DebuggerPollHost__Fv(void) {
}

int InGame_GetDevice__Fi(int x) { return x & 0xFF; }

void Texture_KillTrackTexture__Fv(void) {
}

int Weather_GetNumParticles__Fi(int player) {
    return *(int *)0x80123408;
}

void fortext4(void) {
}

void __main(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", __SN_ENTRY_POINT);

INCLUDE_ASM("asm/nonmatchings/main", stup1);

INCLUDE_ASM("asm/nonmatchings/main", stup0);

INCLUDE_ASM("asm/nonmatchings/main", func_800E41FC);

INCLUDE_ASM("asm/nonmatchings/main", rdiv);

void FREE_remove(int unused, char *node) {
    char *next;
    char *prev;
    unsigned short flags;
    next  = *(char **)(node + 0x14);
    prev  = *(char **)(node + 0x10);
    *(char **)(next + 0x10) = prev;
    *(char **)(prev + 0x14) = next;
    flags = *(unsigned short *)(node + 2);
    *(unsigned short *)(node + 0) = 0;
    *(unsigned short *)(node + 2) = flags & 0xBFFF;
}

INCLUDE_ASM("asm/nonmatchings/main", func_800E5EDC);

INCLUDE_ASM("asm/nonmatchings/main", func_800E6E88);

INCLUDE_ASM("asm/nonmatchings/main", func_800E6EA8);

INCLUDE_ASM("asm/nonmatchings/main", func_800E80C4);

int gettick(void) {
    return ticks;
}

void func_800ED0D4(void) {
}

int shapecount(void *a0) {
    return *(int *)((char *)a0 + 0x8);
}

INCLUDE_ASM("asm/nonmatchings/main", func_800F0BF4);

INCLUDE_ASM("asm/nonmatchings/main", SetVideoMode);

int GetVideoMode(void) {
    return *(int *)0x80134838;
}

INCLUDE_ASM("asm/nonmatchings/main", intcos);

INCLUDE_ASM("asm/nonmatchings/main", intsin);

INCLUDE_ASM("asm/nonmatchings/main", func_800F1B3C);

INCLUDE_ASM("asm/nonmatchings/main", func_800F219C);

INCLUDE_ASM("asm/nonmatchings/main", VSync);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2494);

INCLUDE_ASM("asm/nonmatchings/main", ResetCallback);

INCLUDE_ASM("asm/nonmatchings/main", InterruptCallback);

INCLUDE_ASM("asm/nonmatchings/main", DMACallback);

INCLUDE_ASM("asm/nonmatchings/main", VSyncCallback);

INCLUDE_ASM("asm/nonmatchings/main", VSyncCallbacks);

INCLUDE_ASM("asm/nonmatchings/main", CheckCallback);

INCLUDE_ASM("asm/nonmatchings/main", SetIntrMask);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2968);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2A40);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2C10);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2D58);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2DF8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2E70);

void putm(unsigned char *p, unsigned int val, int count) {
    count--;
    if (count < 0) return;
    p = p + count;
    do {
        *p = (unsigned char)val;
        val >>= 8;
        count--;
        p--;
    } while (count >= 0);
}
void puti(unsigned char *p, unsigned int val, int count) {
    count--;
    if (count < 0) return;
    do {
        *p = (unsigned char)val;
        val >>= 8;
        count--;
        p++;
    } while (count >= 0);
}

void SetPolyGT4(unsigned char *p) {
    p[3] = 12;
    p[7] = 0x3C;
}

void SetPolyF3(unsigned char *p) {
    p[3] = 4;
    p[7] = 0x20;
}
void SetPolyF4(unsigned char *p) {
    p[3] = 5;
    p[7] = 0x28;
}
void SetPolyG4(unsigned char *p) {
    p[3] = 8;
    p[7] = 0x38;
}
void SetPolyFT4(unsigned char *p) {
    p[3] = 9;
    p[7] = 0x2C;
}

int MEM_defaultevent(void *arg) { return 0; }

unsigned short GetClut(int x, int y) {
    return (y << 6) | ((x >> 4) & 0x3F);
}

int setclipwindow(void *p) { return 0; }

void checkrect(unsigned short *rect) {
    if (rect[2] & 1) {
        rect[3] |= 1;
    }
}

INCLUDE_ASM("asm/nonmatchings/main", DecDCTvlcSize);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTvlc);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTReset);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTin);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTout);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTinSync);

INCLUDE_ASM("asm/nonmatchings/main", DecDCToutCallback);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8AF8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8BE8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8C78);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8D04);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8D98);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8E2C);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8E44);

int CD_Close(int i) {
    int *table = *(int **)0x80146CF8;
    table[i - 1] = 0;
    return 0;
}

INCLUDE_ASM("asm/nonmatchings/main", MemCardInit);

INCLUDE_ASM("asm/nonmatchings/main", MemCardEnd);

INCLUDE_ASM("asm/nonmatchings/main", MemCardStart);

INCLUDE_ASM("asm/nonmatchings/main", MemCardStop);

INCLUDE_ASM("asm/nonmatchings/main", MemCardExist);

INCLUDE_ASM("asm/nonmatchings/main", func_800FABF0);

INCLUDE_ASM("asm/nonmatchings/main", MemCardAccept);

INCLUDE_ASM("asm/nonmatchings/main", func_800FAE2C);

INCLUDE_ASM("asm/nonmatchings/main", MemCardReadData);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB118);

INCLUDE_ASM("asm/nonmatchings/main", MemCardWriteData);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB30C);

INCLUDE_ASM("asm/nonmatchings/main", MemCardReadFile);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB560);

INCLUDE_ASM("asm/nonmatchings/main", MemCardWriteFile);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB780);

INCLUDE_ASM("asm/nonmatchings/main", MemCardGetDirentry);

INCLUDE_ASM("asm/nonmatchings/main", MemCardCallback);

INCLUDE_ASM("asm/nonmatchings/main", MemCardSync);

INCLUDE_ASM("asm/nonmatchings/main", MemCardCreateFile);

INCLUDE_ASM("asm/nonmatchings/main", MemCardDeleteFile);

INCLUDE_ASM("asm/nonmatchings/main", MemCardFormat);

INCLUDE_ASM("asm/nonmatchings/main", MemCardUnformat);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC11C);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC170);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC1F4);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC4E4);

void yieldthread(void) {
}

void freemutex(int *p) {
    *p = 0;
}

void SNDI_mutexalloc(void) {
}

void SNDI_mutexfree(void) {
}

void SNDI_mutexlock(void) {
}

void SNDI_mutexunlock(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80100730);

INCLUDE_ASM("asm/nonmatchings/main", func_8010073C);

INCLUDE_ASM("asm/nonmatchings/main", func_80100748);

INCLUDE_ASM("asm/nonmatchings/main", func_80100760);

unsigned char *iSPCH_GetBankBits(unsigned char *hdr) {
    int stride = (hdr[2] & 0xF) + 2;
    int count  = hdr[3];
    hdr += 8;
    return hdr + count * stride;
}

int iSPCH_OneChosen(void) {
    return D_80148448;
}

void iSNDresetpatch(void *p) {
    *(int *)((char *)p + 0x90) = 0;
}

void _padCmdParaMode(unsigned char *p, int mode) {
    p[0x36] = 0x43;
    *(unsigned char **)(p + 0x2C) = p + 0x24;
    p[0x24] = (unsigned char)mode;
    p[0x35] = 1;
}

INCLUDE_ASM("asm/nonmatchings/main", func_80106500);

INCLUDE_ASM("asm/nonmatchings/main", startIntrVSync);

INCLUDE_ASM("asm/nonmatchings/main", func_8010658C);

INCLUDE_ASM("asm/nonmatchings/main", func_801065F8);

INCLUDE_ASM("asm/nonmatchings/main", func_80106624);

INCLUDE_ASM("asm/nonmatchings/main", startIntrDMA);

INCLUDE_ASM("asm/nonmatchings/main", func_801066F8);

INCLUDE_ASM("asm/nonmatchings/main", func_80106878);

INCLUDE_ASM("asm/nonmatchings/main", func_80106924);

INCLUDE_ASM("asm/nonmatchings/main", func_8010694C);

int decodeansi(unsigned char **pp) {
    unsigned char *p = *pp;
    int v = *p;
    *pp = p + 1;
    return v;
}

int psxdevelopmentsystem(void) {
    unsigned short val = *(unsigned short *)0x86;
    if (val == 0x375A) return 1;
    if (val == 0x275A) return 0;
    return -1;
}

void TermPrim(unsigned long *p) {
    *p |= 0x00FFFFFFUL;
}

INCLUDE_ASM("asm/nonmatchings/main", func_80107080);

INCLUDE_ASM("asm/nonmatchings/main", CD_init_80108140);

INCLUDE_ASM("asm/nonmatchings/main", DsReadyCallback);

INCLUDE_ASM("asm/nonmatchings/main", DsDataCallback);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpIOE);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpError);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpTimeout);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpNewcard);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpIOEx);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpErrorx);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpTimeoutx);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpNewcardx);

INCLUDE_ASM("asm/nonmatchings/main", _card_open);

INCLUDE_ASM("asm/nonmatchings/main", _card_start);

INCLUDE_ASM("asm/nonmatchings/main", _card_close);

INCLUDE_ASM("asm/nonmatchings/main", _card_stop);

INCLUDE_ASM("asm/nonmatchings/main", _clr_card_event);

INCLUDE_ASM("asm/nonmatchings/main", _get_card_event);

INCLUDE_ASM("asm/nonmatchings/main", _get_card_event_x);

INCLUDE_ASM("asm/nonmatchings/main", _chk_card_event);

INCLUDE_ASM("asm/nonmatchings/main", _chk_card_event_x);

INCLUDE_ASM("asm/nonmatchings/main", UserFuncInit);

INCLUDE_ASM("asm/nonmatchings/main", UserFuncOpen);

INCLUDE_ASM("asm/nonmatchings/main", UserFuncExecute);

int UserFuncComplete(void) {
    return ((unsigned int)*(int *)0x8013C2E0) >> 31;
}

int iSNDabs(int x) {
    return x < 0 ? -x : x;
}

INCLUDE_ASM("asm/nonmatchings/main", func_8010B100);

INCLUDE_ASM("asm/nonmatchings/main", func_8010B10C);

INCLUDE_ASM("asm/nonmatchings/main", func_8010B124);

int iSPCH_CheckSentenceRules(int a, int b, unsigned char *rules) {
    int mask = rules[1] & ~b;
    int diff = rules[2] ^ a;
    return (diff & mask) == 0;
}
void iSPCH_InitSample(unsigned char *p) {
    *(int *)(p + 4) = -1;
    *(int *)(p + 0) = 0;
    *(int *)(p + 8) = 0;
    p[0xC] = 0xFF;
    p[0xD] = 0xFF;
    p[0xE] = 0xFF;
    p[0xF] = 0xFF;
}

int ReadInitPadFlag(void) {
    return D_8013C338;
}

INCLUDE_ASM("asm/nonmatchings/main", func_8010C9FC);

INCLUDE_ASM("asm/nonmatchings/main", func_8010CA40);

