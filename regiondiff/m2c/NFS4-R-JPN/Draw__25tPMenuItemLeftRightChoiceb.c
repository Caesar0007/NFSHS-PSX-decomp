/* NFS4-R-JPN CHANGED @800A82E4 | base 800A7650 Draw__25tPMenuItemLeftRightChoiceb */
? func_800A7BA8(s16, s16, s32, s16);                /* extern */
s16 func_800B9D0C(s32);                             /* extern */

void func_800A82E4(void *arg0, s16 arg1) {
    s16 temp_v0_2;
    void *temp_v0;
    void *temp_v1;

    func_800A7BA8((s16) arg0->unk4, arg1, arg0->unk0 & 1, func_800B9D0C(arg0->unk4));
    temp_v1 = arg0->unkC;
    temp_v0 = temp_v1->unk8;
    temp_v0_2 = temp_v0->unk1C(temp_v1 + temp_v0->unk18, -1);
    func_800A7BA8(temp_v0_2, arg1, arg0->unk0 & 1, func_800B9D0C((s32) temp_v0_2));
}
