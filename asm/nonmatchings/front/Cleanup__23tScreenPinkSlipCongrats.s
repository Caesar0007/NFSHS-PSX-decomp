.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__23tScreenPinkSlipCongrats, 0x2C

glabel Cleanup__23tScreenPinkSlipCongrats
    /* 39644 80048E44 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39648 80048E48 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3964C 80048E4C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 39650 80048E50 B136010C */  jal        CleanupSpinningCarsMenu__Fv
    /* 39654 80048E54 21808000 */   addu      $s0, $a0, $zero
    /* 39658 80048E58 6898000C */  jal        Cleanup__7tScreen
    /* 3965C 80048E5C 21200002 */   addu      $a0, $s0, $zero
    /* 39660 80048E60 1400BF8F */  lw         $ra, 0x14($sp)
    /* 39664 80048E64 1000B08F */  lw         $s0, 0x10($sp)
    /* 39668 80048E68 0800E003 */  jr         $ra
    /* 3966C 80048E6C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__23tScreenPinkSlipCongrats
