.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__15tScreenCongrats, 0x2C

glabel Cleanup__15tScreenCongrats
    /* 38660 80047E60 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 38664 80047E64 1000B0AF */  sw         $s0, 0x10($sp)
    /* 38668 80047E68 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3866C 80047E6C B136010C */  jal        CleanupSpinningCarsMenu__Fv
    /* 38670 80047E70 21808000 */   addu      $s0, $a0, $zero
    /* 38674 80047E74 6898000C */  jal        Cleanup__7tScreen
    /* 38678 80047E78 21200002 */   addu      $a0, $s0, $zero
    /* 3867C 80047E7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 38680 80047E80 1000B08F */  lw         $s0, 0x10($sp)
    /* 38684 80047E84 0800E003 */  jr         $ra
    /* 38688 80047E88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__15tScreenCongrats
