/* NFS4-R-UK-ES-IT CHANGED @800A5DD0 | base 800A5258 Object_KillStatus__Fv */
/* callers: BWorld_Restart__Fv, BWorld_DeInit__Fv */
void func_800A5DD0(void) {
    s32 var_s1;
    void ***var_s0;
    void **temp_v1;
    void *temp_v0;

    var_s1 = 0;
    var_s0 = (void ***)0x80117044;
    do {
        temp_v1 = *var_s0;
        if (temp_v1 != NULL) {
            temp_v0 = *temp_v1;
            temp_v0->unkC(temp_v1 + temp_v0->unk8, 3);
            *var_s0 = NULL;
        }
        var_s1 += 1;
        var_s0 += 4;
    } while (var_s1 < 0x1C2);
}
