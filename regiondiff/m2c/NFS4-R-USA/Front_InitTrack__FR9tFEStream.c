/* NFS4-R-USA CHANGED @80029284 | base 8002921C Front_InitTrack__FR9tFEStream */
/* callers: Front_BuildStream__FPi */
? func_80021C04(?, u8, void *);                     /* extern */
s32 func_80021E60(?, s8);                           /* extern */
? func_800327DC(?, s32);                            /* extern */
? func_800E6EC8(s32, void *, ?);                    /* extern */
s32 func_800EB430();                                /* extern */

void func_80029284(void *arg0) {
    u8 temp_v1;
    void *temp_a0;

    if ((void *)0x801158B8->unk4 == 2) {
        func_800327DC(0x80115D90, arg0 + 0x2C0);
        func_800E6EC8(func_80021E60(0x80115D08, arg0->unk2C0), arg0 + 0x290, 0x30);
    } else {
        func_80021C04(0x80115D08, ((void *)0x801158B8->unk46 + 0x801158B8)->unk23, arg0 + 0x290);
        arg0->unk2C0 = (s8) arg0->unk290;
        temp_a0 = arg0 + 0x2C0;
        if (((void *)0x801158B8->unk12A == 1) || (temp_v1 = (void *)0x801158B8->unk4, (temp_v1 == 1)) || (temp_v1 == 6)) {
            temp_a0->unk1 = (u8) ((void *)0x801158B8->unk46 + 0x801158B8)->unk32;
            temp_a0->unk2 = (u8) ((void *)0x801158B8->unk46 + 0x801158B8)->unk37;
            temp_a0->unk3 = (u8) ((void *)0x801158B8->unk46 + 0x801158B8)->unk16;
            temp_a0->unk4 = (u8) ((void *)0x801158B8->unk46 + 0x801158B8)->unk1B;
        } else {
            temp_a0->unk4 = 0U;
            temp_a0->unk3 = 0U;
            temp_a0->unk2 = 0U;
            temp_a0->unk1 = 0U;
        }
        arg0->unk2E0 = 0x10000;
    }
    if ((u8) arg0->unk2C1 >= 2U) {
        arg0->unk2C1 = (u8) (func_800EB430() & 1);
    }
    if ((u8) arg0->unk2C2 >= 2U) {
        arg0->unk2C2 = (u8) (func_800EB430() & 1);
    }
    if ((u8) arg0->unk2C3 >= 2U) {
        arg0->unk2C3 = (u8) (func_800EB430() & 1);
    }
    if ((u8) arg0->unk2C4 >= 2U) {
        arg0->unk2C4 = (u8) (func_800EB430() & 1);
    }
}
