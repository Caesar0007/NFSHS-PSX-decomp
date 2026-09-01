/* NFS4-R-AU REGION-ONLY @800A778C */
/* callers: Track_Init__FPc */
s32 func_800E5F14(?, s32, ?);                       /* extern */

void func_800A778C(s32 arg0) {
    saved_reg_gp->unkD80 = func_800E5F14(0x80056830, arg0 * 0x30, 0);
    saved_reg_gp->unkD84 = 0;
}
