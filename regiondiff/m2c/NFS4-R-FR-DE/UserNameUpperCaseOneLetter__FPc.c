/* NFS4-R-FR-DE CHANGED @8004B004 | base 8004AAB4 UserNameUpperCaseOneLetter__FPc */
/* callers: Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc, Stattool_SamNelsonsUpperLowerStringConverterForRecords__FPc, StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc */
void func_8004B004(u8 *arg0) {
    u8 temp_v0;
    u8 temp_v1;

    temp_v1 = *arg0;
    if ((u32) (temp_v1 - 0x61) < 0x1AU) {
        *arg0 = temp_v1 + 0xE0;
        return;
    }
    temp_v0 = *arg0;
    switch (temp_v0) {
    case 0xE4:
        *arg0 = 0xC4;
        return;
    case 0xF6:
        *arg0 = 0xD6;
        return;
    case 0xFC:
        *arg0 = 0xDC;
        return;
    case 0xE9:
        *arg0 = 0x45;
        return;
    case 0xE1:
        *arg0 = 0x41;
        return;
    case 0xED:
        *arg0 = 0x49;
        return;
    case 0xF3:
        *arg0 = 0x4F;
        return;
    case 0xFA:
        *arg0 = 0x55;
        return;
    case 0xF1:
        *arg0 = 0xD1;
        return;
    case 0xE5:
        *arg0 = 0xC5;
        return;
    case 0xE0:
        *arg0 = 0xC0;
        return;
    case 0xE8:
        if (*(u8 *)0x80115C24 == 4) {
            *arg0 = 0xC8;
            return;
        }
        /* Duplicate return node #8. Try simplifying control flow for better match */
        *arg0 = 0x45;
        return;
    case 0xEC:
        *arg0 = 0xCC;
        return;
    case 0xF2:
        *arg0 = 0xD2;
        return;
    case 0xF9:
        *arg0 = 0xD9;
        /* fallthrough */
    default:
        return;
    }
}
