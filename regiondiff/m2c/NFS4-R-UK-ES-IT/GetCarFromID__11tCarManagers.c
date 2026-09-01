/* NFS4-R-UK-ES-IT CHANGED @8001640C | base 8001624C GetCarFromID__11tCarManagers */
/* callers: CalcUsedPrice__11tCarManagers, PurchaseCar__11tCarManagersss, PurchaseUpgrade__11tCarManagersss, AddUpgradesToPinkSlipsList__11tCarManagersss, GetGarageCar__11tCarManagersR8tCarInfos */
s32 func_8001640C(void *arg0, s16 arg1) {
    s32 var_a1;
    s8 temp_v0;
    u32 var_a2;
    void *temp_v1;

    var_a2 = 0;
    if (arg0->unk0 != 0) {
        var_a1 = 0;
loop_2:
        temp_v1 = var_a1 + arg0->unk4;
        temp_v0 = temp_v1->unk0;
        var_a2 += 1;
        if (temp_v0 == arg1) {
            temp_v1->unk7 = (u8) (arg0 + temp_v0)->unk208;
            return arg0->unk4 + var_a1;
        }
        var_a1 += 0xCC;
        if (var_a2 >= (u32) arg0->unk0) {
            /* Duplicate return node #5. Try simplifying control flow for better match */
            return 0;
        }
        goto loop_2;
    }
    return 0;
}
