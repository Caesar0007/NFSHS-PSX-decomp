/* NFS4-R-AU CHANGED @8003F934 | base 8003F590 ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
? func_80018A6C(s32, ?, void *);                    /* extern */
? func_8003C260(void *, ?, s32 *, ?);               /* extern */

void func_8003F934(void *arg0, ? arg1, s32 *arg2, ? arg3) {
    s32 temp_v1;
    s32 temp_v1_2;
    s32 temp_v1_3;
    void *temp_a2;

    temp_v1 = *arg2;
    if (temp_v1 != 0x10) {
        if (temp_v1 != 4) {
            temp_v1_2 = (void *)0x80052584->unk0;
            if ((temp_v1_2 != 6) || ((void *)0x80052584->unk4 != temp_v1_2)) {
                *arg2 = 1;
            }
        }
        if (*arg2 == 0x10) {
            goto block_7;
        }
    } else {
block_7:
        temp_v1_3 = (void *)0x80052584->unk0;
        temp_a2 = (void *)0x80050000 + 0x2584;
        if ((temp_v1_3 != 6) || (temp_a2->unk4 != temp_v1_3)) {
            arg0->unk448 = 1;
            (void *)0x80052584->unk0 = 7;
            temp_a2->unk4 = 7;
            func_80018A6C(arg0 + 0x3A0, 0x80050000, temp_a2);
        }
    }
    func_8003C260(arg0, arg1, arg2, arg3);
}
