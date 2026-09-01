/* NFS4-R-JPN CHANGED @8003A81C | base 8003A9D4 DrawCar__FR8tCarInfossffcbUl7tPlayer */
/* callers: DrawForeground__16tScreenCarSelect, DrawForeground__16tScreenCarSelect, DrawBackground__20tScreenCarSelectDuel, DrawBackground__20tScreenCarSelectDuel, DrawBackground__25tScreenCarSelectTwoPlayer */
? func_80012B98(void *, ?, s16, s16, s32, s32, s32, s32, s32, s32, s32); /* extern */
? func_80012F40(?, s16, s16, s32, s32, s32, s32, s32); /* extern */
? func_800BF694(u8, void *, s32);                   /* extern */

void func_8003A81C(void *arg0, s16 arg1, s16 arg2, s32 arg3, s32 arg4, u8 arg5, s32 arg6, s32 arg7, s32 arg8) {
    s32 temp_a1;
    s32 temp_v1;
    s32 var_v0;

    temp_v1 = *(s32 *)0x8013ED78;
    var_v0 = temp_v1;
    if (temp_v1 < 0) {
        var_v0 = temp_v1 + 0x7FF;
    }
    *(s32 *)0x8013E8DC = 0;
    if ((u32) (temp_v1 - ((var_v0 >> 0xB) << 0xB)) < 0x400U) {
        *(s32 *)0x8013E8E0 = 0;
    } else {
        *(void *)0x8013E8E0 = 1;
    }
    if (arg0->unk0 >= 0) {
        temp_a1 = arg8 * 4;
        *(*(0x800529C0 + temp_a1))->unk288 = (s32) arg0->unk1;
        (*(0x800529C0 + temp_a1))->unk288->unkA0 = (s32) arg0->unkC7;
        *(0x80051214 + temp_a1) = (s32) (*(0x80051214 + temp_a1) + 3);
        (*(0x800529C0 + temp_a1))->unk288->unk3C = (s32) (((u8) arg0->unkC4 >> 2) & 1);
        (*(0x800529C0 + temp_a1))->unk288->unk40 = (s32) (((u8) arg0->unkC4 >> 1) & 1);
        (*(0x800529C0 + temp_a1))->unk288->unk44 = (s32) (arg0->unkC4 & 1);
        func_800BF694(arg0->unkC5, *(0x800529C0 + temp_a1), arg8);
        func_80012B98(*(0x800529C0 + temp_a1), 0x80118020, arg1, arg2, arg8, 0, arg7, arg3, arg4, arg5 & 0xFF, arg6);
        return;
    }
    func_80012F40(0x80118020, arg1, arg2, arg8, 0, arg7, arg3, arg4);
}
