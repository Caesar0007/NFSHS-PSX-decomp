.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VectorNormal, 0x30

glabel VectorNormal
    /* E22DC 800F1ADC 0000888C */  lw         $t0, 0x0($a0)
    /* E22E0 800F1AE0 0400898C */  lw         $t1, 0x4($a0)
    /* E22E4 800F1AE4 08008A8C */  lw         $t2, 0x8($a0)
    /* E22E8 800F1AE8 2138E003 */  addu       $a3, $ra, $zero
    /* E22EC 800F1AEC CFC6030C */  jal        _vec_norm_kernel
    /* E22F0 800F1AF0 00000000 */   nop
    /* E22F4 800F1AF4 0000A8AC */  sw         $t0, 0x0($a1)
    /* E22F8 800F1AF8 0400A9AC */  sw         $t1, 0x4($a1)
    /* E22FC 800F1AFC 0800AAAC */  sw         $t2, 0x8($a1)
    /* E2300 800F1B00 21F8E000 */  addu       $ra, $a3, $zero
    /* E2304 800F1B04 0800E003 */  jr         $ra
    /* E2308 800F1B08 00000000 */   nop
endlabel VectorNormal
