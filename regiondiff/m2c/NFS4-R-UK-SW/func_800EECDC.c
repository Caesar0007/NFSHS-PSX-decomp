/* NFS4-R-UK-SW REGION-ONLY @800EECDC */
s32 func_800EF350(s16, s16);                        /* extern */

void func_800EECDC(void *arg0, void *arg1) {
    arg0->unk3 = 2;
    arg0->unk4 = func_800EF350(arg1->unk0, arg1->unk2);
    arg0->unk8 = 0;
}
