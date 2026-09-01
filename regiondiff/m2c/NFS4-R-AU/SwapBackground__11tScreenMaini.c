/* NFS4-R-AU CHANGED @80037120 | base 80036F20 SwapBackground__11tScreenMaini */
/* callers: MenuExtended_SetOnePlayer__FR12tMenuCommand, MenuExtended_SetTwoPlayer__FR12tMenuCommand, MenuExtended_SetSingleRace__FR12tMenuCommand, MenuExtended_SetTournament__FR12tMenuCommand, MenuExtended_SetSpecialEvent__FR12tMenuCommand */
? func_80026294(void *, ? *, void *);               /* extern */
? func_80037354(void *, ?);                         /* extern */
? func_800514F4(s32);                               /* extern */
? func_800E5094(? *, ?, s32);                       /* extern */
s32 func_800EB41C(? *, void *);                     /* extern */

void func_80037120(void *arg0, s32 arg1) {
    ? sp10;
    ? var_a1_2;
    s32 temp_a0;
    s32 temp_hi;
    s32 temp_v0;
    s32 temp_v0_2;
    s32 temp_v1_3;
    s32 var_a0;
    s32 var_a1;
    void *temp_v1;
    void *temp_v1_2;
    ? *phi_a0;

    func_800514F4(arg0->unk64);
    var_a0 = arg0->unk5A8;
    arg0->unk550 = 1;
    var_a1 = var_a0 * 4;
    temp_v1 = arg0 + (var_a0 * 0x28);
    if ((temp_v1->unk564 == 0) && (temp_v1->unk55C == 0)) {
        temp_v1_2 = arg0 + ((1 - var_a0) * 0x28);
        if ((temp_v1_2->unk564 == 0) && (temp_v1_2->unk55C == 0)) {
            if (arg1 == -1) {
                do {
                    temp_v0_2 = func_800EB41C((? *) var_a0, (void *) var_a1);
                    temp_hi = MULT_HI(temp_v0_2, 0x84210843);
                    temp_v1_3 = temp_v0_2 >> 0x1F;
                    var_a1 = (s32) (arg0 + (arg0->unk5A8 * 4));
                    var_a1->unk5AC = (s32) (temp_v0_2 - ((((s32) (temp_hi + temp_v0_2) >> 4) - temp_v1_3) * 0x1F));
                    temp_v0 = arg0->unk5A8;
                    var_a0 = (s32) &sp10;
                    phi_a0 = (? *) var_a0;
                } while ((arg0 + (temp_v0 * 4))->unk5AC == (arg0 + ((1 - temp_v0) * 4))->unk5AC);
            } else {
                (arg0 + var_a1)->unk5AC = arg1;
                phi_a0 = &sp10;
            }
            func_800E5094(phi_a0, 0x80011830, (arg0 + (arg0->unk5A8 * 4))->unk5AC);
            func_80026294(arg0, &sp10, arg0 + ((arg0->unk5A8 * 0x28) + 0x558));
            temp_a0 = arg0->unk78;
            arg0->unk78 = 0;
            arg0->unk5A8 = (s32) (1 - arg0->unk5A8);
            if (temp_a0 != 3) {
                var_a1_2 = 1;
            } else {
                var_a1_2 = 3;
            }
            func_80037354(arg0, var_a1_2);
            arg0->unk5B4 = 0x10;
        }
    }
}
