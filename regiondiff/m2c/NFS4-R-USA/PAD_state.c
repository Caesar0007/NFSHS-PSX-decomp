/* NFS4-R-USA CHANGED @800E4DA4 | base 800E41AC PAD_state */
/* callers: FEInput_GetNoDebounceKey__Fii, FEInput_GetNoDebounceKey__Fii, DrawCongratsMessage__23tScreenBeTheCopCongrats, Movie_Play__Fc, Movie_Play__Fc */
s32 func_800E4DF4(void *, void *);                  /* extern */

s32 func_800E4DA4(u32 arg0) {
    void *temp_a1;

    temp_a1 = (s32 *)0x80140000 - 0x45C;
    if (*(s32 *)0x8013FBA4 != 0) {
        if (arg0 < 8U) {
            return func_800E4DF4((arg0 * 8) + (temp_a1 + 4), temp_a1) & 0xFFFF;
        }
        /* Duplicate return node #4. Try simplifying control flow for better match */
        return 0;
    }
    return 0;
}
