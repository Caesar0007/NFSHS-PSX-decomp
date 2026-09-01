/* NFS4-R-JPN CHANGED @80028ECC | base 8002921C Front_InitTrack__FR9tFEStream */
/* callers: Front_BuildStream__FPi */
? func_80021964(?, u8, void *);                     /* extern */
s32 func_80021BC0(?, s8);                           /* extern */
? func_800323FC(?, s32);                            /* extern */
? func_800E6CB4(s32, void *, ?);                    /* extern */
s32 func_800EB21C();                                /* extern */

void func_80028ECC(void *arg0) {
    u8 temp_v1;
    void *temp_a0;

    if ((void *)0x801156A4->unk4 == 2) {
        func_800323FC(0x80115B7C, arg0 + 0x2C0);
        func_800E6CB4(func_80021BC0(0x80115AF4, arg0->unk2C0), arg0 + 0x290, 0x30);
    } else {
        func_80021964(0x80115AF4, ((void *)0x801156A4->unk46 + 0x801156A4)->unk23, arg0 + 0x290);
        arg0->unk2C0 = (s8) arg0->unk290;
        temp_a0 = arg0 + 0x2C0;
        if (((void *)0x801156A4->unk12A == 1) || (temp_v1 = (void *)0x801156A4->unk4, (temp_v1 == 1)) || (temp_v1 == 6)) {
            temp_a0->unk1 = (u8) ((void *)0x801156A4->unk46 + 0x801156A4)->unk32;
            temp_a0->unk2 = (u8) ((void *)0x801156A4->unk46 + 0x801156A4)->unk37;
            temp_a0->unk3 = (u8) ((void *)0x801156A4->unk46 + 0x801156A4)->unk16;
            temp_a0->unk4 = (u8) ((void *)0x801156A4->unk46 + 0x801156A4)->unk1B;
        } else {
            temp_a0->unk4 = 0U;
            temp_a0->unk3 = 0U;
            temp_a0->unk2 = 0U;
            temp_a0->unk1 = 0U;
        }
        arg0->unk2E0 = 0x10000;
    }
    if ((u8) arg0->unk2C1 >= 2U) {
        arg0->unk2C1 = (u8) (func_800EB21C() & 1);
    }
    if ((u8) arg0->unk2C2 >= 2U) {
        arg0->unk2C2 = (u8) (func_800EB21C() & 1);
    }
    if ((u8) arg0->unk2C3 >= 2U) {
        arg0->unk2C3 = (u8) (func_800EB21C() & 1);
    }
    if ((u8) arg0->unk2C4 >= 2U) {
        arg0->unk2C4 = (u8) (func_800EB21C() & 1);
    }
}
