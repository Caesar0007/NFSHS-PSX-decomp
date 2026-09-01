/* NFS4-R-JPN CHANGED @80023618 | base 80023898 FEInput_VerifyControllerValues__Fi */
/* callers: FEInput_GetNoDebounceKey__Fii */
? func_80026D4C(?);                                 /* extern */

void func_80023618(s32 arg0) {
    void *temp_a1;

    temp_a1 = (arg0 << 5) + 0x8013F990;
    if ((temp_a1->unk4 == 0) && (temp_a1->unk5 != 0x23) && (((arg0 * 2) + 0x801156A4)->unk35E != temp_a1->unk5)) {
        func_80026D4C(0);
    }
}
