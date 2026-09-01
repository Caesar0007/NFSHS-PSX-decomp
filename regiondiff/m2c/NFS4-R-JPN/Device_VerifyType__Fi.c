/* NFS4-R-JPN CHANGED @800BDF80 | base 800BD3C0 Device_VerifyType__Fi */
/* callers: Device_Fail__Fi, Device_PSXPad__FUl, Device_ReadPad__FiUl, Device_Analog__FUl */
? func_800DCEC4(s32, s32);                          /* extern */

s32 func_800BDF80(s32 arg0) {
    s32 temp_a0;
    s32 temp_a1;
    s32 var_v0;
    void *temp_s0;
    void *temp_s1;

    if (*(s32 *)0x8013E338 != 0) {
        temp_s0 = (arg0 * 8) + 0x8013F990;
        var_v0 = 0;
        if (temp_s0->unk4 == 0) {
            if (temp_s0->unk5 == 0x23) {
                return 0;
            }
            temp_a0 = arg0 != 0;
            temp_a1 = -temp_a0;
            temp_s1 = (temp_a1 & 2) + 0x801156A4;
            if (temp_s0->unk5 != temp_s1->unk35E) {
                func_800DCEC4(temp_a0, ((temp_a1 & 4) + 0x80114290)->unk60);
                temp_s1->unk35E = (s16) temp_s0->unk5;
                return 1;
            }
            goto block_6;
        }
        /* Duplicate return node #7. Try simplifying control flow for better match */
        return var_v0;
    }
block_6:
    var_v0 = 1;
    return var_v0;
}
