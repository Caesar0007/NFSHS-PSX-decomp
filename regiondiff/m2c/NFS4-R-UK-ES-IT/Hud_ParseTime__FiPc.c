/* NFS4-R-UK-ES-IT CHANGED @800D9964 | base 800D8D64 Hud_ParseTime__FiPc */
/* callers: RaceSummary__Fv, RaceSummary__Fv, RaceStatistics__Fv, RaceStatistics__Fv, Hud_BTCStats__Fsb */
? func_800E5094(?, ?, s16, u8, s32, s32, s32);      /* extern */

void func_800D9964(s32 arg0, ? arg1) {
    s16 temp_t1_2;
    s16 temp_v0;
    s32 temp_t1;
    s32 temp_v0_2;
    s32 var_a3;
    s32 var_t1;
    s32 var_v1;
    void *temp_v1;

    var_t1 = arg0;
    if (var_t1 < 0) {
        var_t1 = 0;
    }
    var_v1 = var_t1 * 0x6400;
    var_a3 = var_t1 != 0;
    if (var_v1 < 0) {
        var_v1 += 0x3FFF;
    }
    temp_t1 = var_v1 >> 0xE;
    temp_v0 = var_v1 / 98304000;
    temp_v0_2 = temp_v0 * 0x1770;
    temp_t1_2 = (temp_t1 - temp_v0_2) % 100;
    if (temp_v0 >= 0x3C) {
        var_a3 = 0;
    }
    if (temp_t1_2 < 0) {
        var_a3 = 0;
    }
    if (temp_v0 < 0) {
        var_a3 = 0;
    }
    if (var_a3 != 0) {
        func_800E5094(arg1, 0x800570A8, temp_v0, *(0x8013EBB0 + (s32) (void *)0x801144D0->unkE0), (s32) (s16) ((temp_t1 - temp_v0_2) / 100), (s32) *(0x8013EBB8 + (s32) (void *)0x801144D0->unkE0), (s32) temp_t1_2);
        return;
    }
    temp_v1 = *(void **)0x801145B0;
    func_800E5094(arg1, 0x800570BC, (s16) *(0x8013EBB0 + (s32) temp_v1), *(0x8013EBB8 + (s32) temp_v1));
}
