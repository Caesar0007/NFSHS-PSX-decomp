/* NFS4-R-JPN CHANGED @80023688 | base 800238F8 FEInput_GetNoDebounceKey__Fii */
/* callers: FEInput_GetDebounceKey__Fii, FEInput_GetKeyFromPlayer__F7tPlayerl, SetupCurrCredit__14tCreditManager, SetupCurrCredit__14tCreditManager */
? func_80023618(s32);                               /* extern */
s32 func_800E4B90(s32, void *);                     /* extern */
? func_800E4BF4();                                  /* extern */

s32 func_80023688(s32 arg0, s32 arg1) {
    s32 temp_s0;
    s32 var_v0;
    s32 var_v0_2;
    s32 var_v0_3;
    u8 temp_v1;
    void *temp_a0;
    void *temp_a1;
    void *temp_s2;

    func_800E4BF4();
    temp_s0 = arg1 << 5;
    temp_s2 = temp_s0 + 0x8013F990;
    var_v0 = 0;
    if (temp_s2->unk4 == 0) {
        func_80023618(arg1);
        temp_a1 = temp_s0 + 0x8013F996;
        temp_v1 = temp_s2->unk5;
        temp_a0 = temp_a1 + 2;
        switch (temp_v1) {                          /* switch 1; irregular */
        case 0x73:                                  /* switch 1 */
        case 0x53:                                  /* switch 1 */
            switch (arg0) {                         /* switch 2; irregular */
            case 0x800000:                          /* switch 2 */
                var_v0_2 = (u8) temp_a1->unk2 < 0x40U;
block_25:
                var_v0 = 1;
                if (var_v0_2 == 0) {
                case 0x23:                          /* switch 1 */
                    return 0;
                }
                /* Duplicate return node #35. Try simplifying control flow for better match */
                return var_v0;
            case 0x200000:                          /* switch 2 */
                var_v0_3 = (u8) temp_a1->unk2 < 0xC1U;
block_28:
                if (var_v0_3 != 0) {
                    return 0;
                }
block_34:
                var_v0 = 1;
                /* Duplicate return node #35. Try simplifying control flow for better match */
                return var_v0;
            case 0x100000:                          /* switch 2 */
                var_v0_2 = (u8) temp_a0->unk1 < 0x40U;
                goto block_25;
            case 0x400000:                          /* switch 2 */
                var_v0_3 = (u8) temp_a0->unk1 < 0xC1U;
                goto block_28;
            case 0x80000000:                        /* switch 2 */
                var_v0_2 = (u8) temp_a0->unk2 < 0x40U;
                goto block_25;
            case 0x20000000:                        /* switch 2 */
                var_v0_3 = (u8) temp_a0->unk2 < 0xC1U;
                goto block_28;
            case 0x10000000:                        /* switch 2 */
                var_v0_2 = (u8) temp_a0->unk3 < 0x40U;
                goto block_25;
            case 0x40000000:                        /* switch 2 */
                var_v0_3 = (u8) temp_a0->unk3 < 0xC1U;
                goto block_28;
            default:                                /* switch 2 */
                var_v0 = 1;
                if (!(~((arg1 << 5) + 0x8013F990)->unk6 & arg0)) {
                    return 0;
                }
                /* Duplicate return node #35. Try simplifying control flow for better match */
                return var_v0;
            }
            break;
        default:                                    /* switch 1 */
            var_v0 = 0;
            if (func_800E4B90(arg1 * 4, temp_a1) & 0xFFFF & arg0) {
                goto block_34;
            }
            /* Duplicate return node #35. Try simplifying control flow for better match */
            return var_v0;
        }
    } else {
        return var_v0;
    }
}
