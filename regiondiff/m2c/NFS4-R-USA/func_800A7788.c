/* NFS4-R-USA REGION-ONLY @800A7788 */
/* callers: Track_Init__FPc */
s32 func_800E5F28(?, s32, ?);                       /* extern */

void func_800A7788(s32 arg0) {
    saved_reg_gp->unkD80 = func_800E5F28(0x80056830, arg0 * 0x30, 0);
    saved_reg_gp->unkD84 = 0;
}
