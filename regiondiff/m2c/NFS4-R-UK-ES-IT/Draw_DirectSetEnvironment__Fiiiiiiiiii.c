/* NFS4-R-UK-ES-IT CHANGED @800BF200 | base 800BE478 Draw_DirectSetEnvironment__Fiiiiiiiiii */
/* callers: Quick_DD__Fiii, NFS4_LoadingIcon__Fv, Draw_CheckFirstFrameRender__Fv, Draw_CheckFirstFrameRender__Fv, Draw_SetEnvironment__Fiiiiiiii */
? func_800E8E5C(s32);                               /* extern */
? func_800EE12C(?);                                 /* extern */
? func_800EE66C(? *);                               /* extern */
? func_800EE72C(? *);                               /* extern */
? func_800F2BB4(? *, s32, ?, ?, s32);               /* extern */
? func_800F2C68(? *, s32, ?, ?, s32);               /* extern */

void func_800BF200(s32 arg0, ? arg1, ? arg2, s32 arg3, s32 arg4, s32 arg5, s32 arg6, s32 arg7, s32 arg8, s32 arg9) {
    ? sp18;
    s16 sp22;
    s16 sp26;
    s8 sp30;
    s8 sp31;
    s8 sp32;
    s8 sp33;

    if (arg4 != 0) {
        func_800F2BB4(&sp18, arg0, arg1, arg2, arg3);
        if (arg6 != 0) {
            sp31 = (s8) arg7;
            sp32 = (s8) arg8;
            sp33 = (s8) arg9;
            sp30 = 1;
        } else {
            sp30 = 0;
        }
        func_800EE66C(&sp18);
    }
    if (arg5 != 0) {
        func_800F2C68(&sp18, arg0, arg1, arg2, arg3);
        sp22 = 0x15;
        sp26 = 0x100;
        func_800EE12C(0);
        func_800EE72C(&sp18);
        func_800E8E5C((s32) *(s32 *)0x8013EFD0 >> 1);
        func_800EE12C(1);
    }
}
