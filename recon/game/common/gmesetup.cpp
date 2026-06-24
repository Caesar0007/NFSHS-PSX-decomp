/* game/common/gmesetup.cpp -- RECONSTRUCTED (NFS4 PSX game-setup startup/cleanup; C++ TU)
 *   2 free fns: GameSetup_StartUp(int*) + GameSetup_CleanUp(void).  SYM locals applied
 *   (FrontEndDataStream/$s2, s/$s0, i/$a1, h/$s4, p/$a0, l/$v1).  GTE-free.
 *   100% byte-match on the repo's gcc-2.8.0 (225 insns, pin-free).  Three levers:
 *     1. entry-guard `if (*FrontEndDataStream) do{...}while(*s)` -> param earns $s2
 *        (the guard derefs the PARAM, the back-edge derefs `s`);
 *     2. index-form copy loop `for(i..) p[i]=s[i+2]` -> flips the i/p $a0<->$a1
 *        coalescing the oracle wants (i=$a1 opcode, p=$a0 ptr+call-arg web);
 *     3. in-place store `p += s[1]*0x2D; *p = s[2]` -> the dead-`p` mutate
 *        (`addu a0,a0,v1`) instead of a preserved-base temp.
 *   (Mc-muffin's decomp.me dMkUR seeded the structure; these 3 reconcile it on
 *    the authoritative 2.8.0 allocator, which differs from decomp.me's 2.8.1.)
 */
#include "../../nfs4_types.h"
#include "gmesetup_externs.h"

/* ---- gmesetup.obj OWNED global (EXT) ---- */
GameSetup_tData GameSetup_gData;

/* ---- intra-TU forward declarations (signature-exact) ---- */
void GameSetup_StartUp(int *FrontEndDataStream);
void GameSetup_CleanUp(void);


/* ---- GameSetup_StartUp__FPi  @0x8009BD9C  [GMESETUP.CPP:155-354] ---- */
void GameSetup_StartUp(int *FrontEndDataStream)
{
    int i;          /* $a1 -- opcode (reused as the array-store counter) */
    int *s;         /* $s0 -- data-stream walk pointer */
    int *p;         /* $a0 -- resolved FEI target pointer */
    FEI_tList *l;   /* $v1 -- FEI_gList iterator */
    int *h;         /* $s4 -- Input_gHandler base */

    Input_StartUp();

    h = (int *)&Input_gHandler;
    s = FrontEndDataStream;
    if (*FrontEndDataStream != 0)
    do {
        i = *s;
        if (i >= 0x103) {
            for (l = FEI_gList, p = 0; l->v != 0; l++) {
                if (l->v == i) {
                    p = l->p;
                }
            }
            if (p != 0) {
                p += s[1] * 0x2D;
                *p = s[2];
            }
            s += 3;
        }
        else if (i >= 0x4D) {
            h[i - 0x4D] = s[1];
            if (Device_gDeviceList[s[1] & 0xFF].startupfunc != 0) {
                (*(int (*)(int))Device_gDeviceList[s[1] & 0xFF].startupfunc)(s[1] >> 8);
            }
            s += 2;
        }
        else {
            for (l = FEI_gList, p = 0; l->v != 0; l++) {
                if (l->v == i) {
                    p = l->p;
                }
            }
            if (p != 0) {
                if (*s >= 0x4B) {
                    for (i = 0; i < s[1]; i++) {
                        p[i] = s[i + 2];
                    }
                }
                else {
                    *p = s[1];
                }
            }
            if (*s >= 0x4B) {
                s += s[1];
            }
            s += 2;
        }
    } while (*s != 0);

    purgememadr(FrontEndDataStream);
    timedwait(100);
    PAD_update();
    if ((PAD_state(0) & 0xFFFF) == 0x909)  GameSetup_gData.sgge = 0x8;
    if ((PAD_state(0) & 0xFFFF) == 0xA080) GameSetup_gData.sgge = 0x2;
    if ((PAD_state(0) & 0xFFFF) == 0xC001) GameSetup_gData.sgge = 0x4;
    if ((PAD_state(0) & 0xFFFF) == 0x640)  GameSetup_gData.sgge = 0x10;
    if ((PAD_state(0) & 0xFFFF) == 0x610)  GameSetup_gData.sgge = 0x20;
    if ((PAD_state(0) & 0xFFFF) == 0x910)  GameSetup_gData.sgge = 0x40;
    if ((PAD_state(0) & 0xFFFF) == 0x5010) GameSetup_gData.sgge = 0x80;
    if ((PAD_state(0) & 0xFFFF) == 0x620)  GameSetup_gData.sgge = 0x100;
    gMasterMusicLevel       = GameSetup_gData.userSetting.musicLevel;
    gMasterSFXLevel         = GameSetup_gData.userSetting.sfxLevel;
    gMasterFENarrationLevel = GameSetup_gData.userSetting.speechLevel;
    gMasterEngineLevel      = GameSetup_gData.userSetting.engineLevel;
    gMasterAmbientLevel     = GameSetup_gData.userSetting.ambientLevel;
    Device_SetHardCodedKeys();
}

/* ---- GameSetup_CleanUp__Fv  @0x8009C120 ---- */
void GameSetup_CleanUp(void)
{
    return;
}

/* end of gmesetup.cpp */
