/* NFS4-R-FR-DE CHANGED @8003F9A4 | base 8003F590 ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
? func_80018AC4(s32, ?, void *);                    /* extern */
? func_8003C2D0(void *, ?, s32 *, ?);               /* extern */

void func_8003F9A4(void *arg0, ? arg1, s32 *arg2, ? arg3) {
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    void *temp_a2;

    temp_v1 = *arg2;
    if (temp_v1 != 0x10) {
        if (temp_v1 != 4) {
            temp_v1_2 = (void *)0x8005288C->unk0;
            if ((temp_v1_2 != 6) || ((void *)0x8005288C->unk4 != temp_v1_2)) {
                *arg2 = 1;
            }
        }
        if (*arg2 == 0x10) {
            goto block_7;
        }
    } else {
block_7:
        temp_v1_3 = (void *)0x8005288C->unk0;
        temp_a2 = (void *)0x80050000 + 0x288C;
        if ((temp_v1_3 != 6) || (temp_a2->unk4 != temp_v1_3)) {
            arg0->unk448 = 1;
            (void *)0x8005288C->unk0 = 7;
            temp_a2->unk4 = 7;
            func_80018AC4(arg0 + 0x3A0, 0x80050000, temp_a2);
        }
    }
    func_8003C2D0(arg0, arg1, arg2, arg3);
}
