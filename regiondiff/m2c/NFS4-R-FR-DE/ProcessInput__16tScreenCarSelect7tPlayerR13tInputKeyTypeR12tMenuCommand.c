/* NFS4-R-FR-DE CHANGED @8003C2D0 | base 8003BF90 ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
/* callers: ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
? func_8003B8DC(void *, ?);                         /* extern */

void func_8003C2D0(void *arg0, s32 *arg2) {
    s8 sp10;
    ? var_a1;
    s16 temp_v1_2;
    s32 temp_a1;
    void *temp_v0;
    void *temp_v1;
    void *var_a0;

    if (*arg2 == 8) {
        temp_v0 = arg0->unk60;
        temp_a1 = temp_v0->unk6C(arg0 + temp_v0->unk68, &sp10);
        if ((*(void **)0x80051D70)->unk22C == 0) {
            var_a0 = *(void **)0x800522A8 + 0x2018;
        } else {
            var_a0 = *(void *)0x800522A8 + 0x2078;
        }
        var_a0->unk4 = 0x10C;
        var_a0->unk0 = (s32) (var_a0->unk0 & ~1);
        if (temp_a1 != 0) {
            if ((sp10 == 8) || (sp10 == 0x18)) {
                var_a0->unk4 = 0x10D;
            }
            if (sp10 == 1) {
                var_a0->unk4 = 0x10E;
            }
            if (sp13 == 0) {
                var_a0->unk0 = (s32) (var_a0->unk0 | 1);
            }
        }
        if (((void *)0x801158E4->unk31E == 1) || ((void *)0x801158E4->unk3 == 1)) {
            temp_v1 = *(void *)0x800522A8;
            temp_v1->unk20B8 = (s32) (temp_v1->unk20B8 | 1);
        }
    }
    if (*arg2 == 0x10) {
        temp_v1_2 = arg0->unk11C;
        switch (temp_v1_2) {                        /* irregular */
        case 5:
            var_a1 = 0;
block_28:
            func_8003B8DC(arg0, var_a1);
            break;
        case 6:
            var_a1 = 2;
            goto block_28;
        default:
            if (*(u8 *)0x801158E7 != 1) {
                var_a1 = 1;
                goto block_28;
            }
            break;
        }
    }
}
