/* NFS4-R-UK-ES-IT CHANGED @8007ACE4 | base 8007A258 AudioMus_QueueRequestedSong__Fv */
/* callers: AudioMus_Server__Fii, AudioMus_Server__Fii, AudioMus_PlaySong__FPc */
s32 func_800E6D90(s32, ?, u8, s32 *, s32);          /* extern */
s32 func_800EA580(s32, ?, void *, s32);             /* extern */

void func_8007ACE4(void) {
    s32 sp18;
    s32 temp_a0;
    void *temp_a2;
    void *temp_v0;
    void *temp_v0_2;
    void *temp_v1;

    temp_v0 = saved_reg_gp->unk1D8;
    temp_a2 = saved_reg_gp->unk1D8;
    temp_a0 = temp_a2->unk70;
    temp_a2->unk28 = func_800E6D90(temp_v0->unk88, 0, (temp_v0 + temp_v0->unkC)->unkE8, &sp18, 0);
    if (temp_a0 >= 0) {
        saved_reg_gp->unk1D8->unk74 = func_800EA580(temp_a0, 0x3E8, temp_a2 + 0xA8, sp18);
    }
    temp_v0_2 = saved_reg_gp->unk1D8;
    temp_v0_2->unk14 = 2;
    temp_v1 = temp_v0_2 + 0x114;
    temp_v0_2->unk110 = 0;
    temp_v1->unk18 = 0;
    temp_v0_2->unk114 = 0;
    temp_v1->unk4 = 0;
    temp_v1->unk8 = 0;
    temp_v1->unkC = 0;
    temp_v1->unk14 = 0;
}
