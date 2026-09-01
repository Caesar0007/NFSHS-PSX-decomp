/* NFS4-R-UK-ES-IT CHANGED @8003ACE4 | base 8003A9D4 DrawCar__FR8tCarInfossffcbUl7tPlayer */
/* callers: DrawForeground__16tScreenCarSelect, DrawForeground__16tScreenCarSelect, DrawBackground__20tScreenCarSelectDuel, DrawBackground__20tScreenCarSelectDuel, DrawBackground__25tScreenCarSelectTwoPlayer */
? func_80012C30(void *, ?, s16, s16, s32, s32, s32, s32, s32, s32, s32); /* extern */
? func_80012FDC(?, s16, s16, s32, s32, s32, s32, s32); /* extern */
? func_800BF8D4(u8, void *, s32);                   /* extern */

void func_8003ACE4(void *arg0, s16 arg1, s32 arg2, s32 arg3, s32 arg4, u8 arg5, s32 arg6, s32 arg7, s32 arg8) {
    s16 temp_s3;
    s32 temp_a1;
    s32 temp_v1;
    s32 var_v0;

    temp_v1 = *(s32 *)0x8013EFB8;
    var_v0 = temp_v1;
    if (temp_v1 < 0) {
        var_v0 = temp_v1 + 0x7FF;
    }
    *(s32 *)0x8013EB1C = 0;
    temp_s3 = arg2 - 8;
    if ((u32) (temp_v1 - ((var_v0 >> 0xB) << 0xB)) < 0x400U) {
        *(s32 *)0x8013EB20 = 0;
    } else {
        *(void *)0x8013EB20 = 1;
    }
    if (arg0->unk0 >= 0) {
        temp_a1 = arg8 * 4;
        *(*(0x80053300 + temp_a1))->unk288 = (s32) arg0->unk1;
        (*(0x80053300 + temp_a1))->unk288->unkA0 = (s32) arg0->unkC7;
        *(0x80051B54 + temp_a1) = (s32) (*(0x80051B54 + temp_a1) + 3);
        (*(0x80053300 + temp_a1))->unk288->unk3C = (s32) (((u8) arg0->unkC4 >> 2) & 1);
        (*(0x80053300 + temp_a1))->unk288->unk40 = (s32) (((u8) arg0->unkC4 >> 1) & 1);
        (*(0x80053300 + temp_a1))->unk288->unk44 = (s32) (arg0->unkC4 & 1);
        func_800BF8D4(arg0->unkC5, *(0x80053300 + temp_a1), arg8);
        func_80012C30(*(0x80053300 + temp_a1), 0x80118260, arg1, temp_s3, arg8, 0, arg7, arg3, arg4, arg5 & 0xFF, arg6);
        return;
    }
    func_80012FDC(0x80118260, arg1, temp_s3, arg8, 0, arg7, arg3, arg4);
}
