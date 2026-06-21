.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _install_drain_cb, 0x28

glabel _install_drain_cb
    /* E060C 800EFE0C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E0610 800EFE10 1000BFAF */  sw         $ra, 0x10($sp)
    /* E0614 800EFE14 0F80053C */  lui        $a1, %hi(_gpu_que_drain)
    /* E0618 800EFE18 0CF6A524 */  addiu      $a1, $a1, %lo(_gpu_que_drain)
    /* E061C 800EFE1C 2BCA030C */  jal        DMACallback
    /* E0620 800EFE20 02000424 */   addiu     $a0, $zero, 0x2
    /* E0624 800EFE24 1000BF8F */  lw         $ra, 0x10($sp)
    /* E0628 800EFE28 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E062C 800EFE2C 0800E003 */  jr         $ra
    /* E0630 800EFE30 00000000 */   nop
endlabel _install_drain_cb
