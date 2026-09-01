/* NFS4-R-FR-DE CHANGED @8002B824 | base 8002B6D8 Front_GetInGameVars__Fv */
/* callers: main */
? func_8007BC44(s32);                               /* extern */

void func_8002B824(void) {
    s32 var_t2;
    u8 temp_v0;
    void *temp_v1;
    void *var_t1;

    temp_v0 = *(u8 *)0x8013D970;
    (void *)0x801158E4->unk341 = temp_v0;
    func_8007BC44((s32) ((temp_v0 & 0xFF) * 0x23) >> 6);
    var_t2 = 0;
    var_t1 = (void *)0x801144D0;
    (void *)0x801158E4->unk342 = (u8) *(u8 *)0x8013D974;
    (void *)0x801158E4->unk344 = (u8) *(u8 *)0x8013D978;
    (void *)0x801158E4->unk343 = (u8) *(u8 *)0x8013D97C;
    (void *)0x801158E4->unk345 = (u8) *(u8 *)0x8013D980;
    (void *)0x801158E4->unk5A = (u16) (void *)0x801144D0->unkB8;
    (void *)0x801158E4->unk346 = (u8) (void *)0x801144D0->unkEC;
    do {
        temp_v1 = var_t2 + 0x801158E4;
        temp_v1->unk362 = (u8) var_t1->unk60;
        temp_v1->unk34B = (u8) var_t1->unk68;
        temp_v1->unk349 = (u8) var_t1->unk70;
        temp_v1->unk34F = (u8) var_t1->unk78;
        temp_v1->unk34D = (u8) var_t1->unk80;
        var_t2 += 1;
        temp_v1->unk359 = (u8) var_t1->unkA8;
        temp_v1->unk35B = (u8) var_t1->unkB0;
        var_t1 += 4;
    } while (var_t2 < 2);
}
