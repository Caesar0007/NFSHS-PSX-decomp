/* NFS4-R-USA REGION-ONLY @800A77E4 */
s32 func_800A77E4(void) {
    s32 temp_v1;

    temp_v1 = saved_reg_gp->unkD84;
    saved_reg_gp->unkD84 = (s32) (temp_v1 + 1);
    return saved_reg_gp->unkD80 + (temp_v1 * 0x30);
}
