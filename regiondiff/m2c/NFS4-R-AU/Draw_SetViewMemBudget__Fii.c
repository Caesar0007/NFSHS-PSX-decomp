/* NFS4-R-AU CHANGED @800BEBC4 | base 800BDDD8 Draw_SetViewMemBudget__Fii */
/* callers: PSXFront_AllocateDrawMemory__Fv */
void func_800BEBC4(s32 arg0, s32 arg1) {
    ((arg0 * 0xC8) + 0x8011FF70)->unk4 = (s32) (arg1 - 0x1A0);
}
