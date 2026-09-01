/* NFS4-R-USA CHANGED @8007AC48 | base 8007A1DC AudioMus_Fail__Fi */
/* callers: AudioMus_Server__Fii, AudioMus_Server__Fii, AudioMus_Server__Fii */
s32 func_8007AA48();                                /* extern */
? func_800EA744(s32, s32, ?);                       /* extern */

void func_8007AC48(s32 arg0) {
    void *temp_v0;
    void *temp_v0_2;

    temp_v0 = saved_reg_gp->unk1D8;
    temp_v0->unk1C = arg0;
    if (temp_v0->unk8C != 0) {
        func_800EA744(saved_reg_gp->unk1D8->unk70, func_8007AA48(), 0);
        saved_reg_gp->unk1D8->unk20 = func_8007AA48();
    }
    if (arg0 == -5) {
        saved_reg_gp->unk1D8->unk14 = 2;
        return;
    }
    temp_v0_2 = saved_reg_gp->unk1D8;
    temp_v0_2->unk18 = 1;
    temp_v0_2->unk10 = 0;
    temp_v0_2->unk28 = 0;
    temp_v0_2->unk14 = -1;
    temp_v0_2->unkC = -1;
}
