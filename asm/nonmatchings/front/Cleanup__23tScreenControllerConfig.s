.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__23tScreenControllerConfig, 0x3C

glabel Cleanup__23tScreenControllerConfig
    /* 36020 80045820 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 36024 80045824 1000B0AF */  sw         $s0, 0x10($sp)
    /* 36028 80045828 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3602C 8004582C 460C010C */  jal        ClearActuators__23tScreenControllerConfig
    /* 36030 80045830 21808000 */   addu      $s0, $a0, $zero
    /* 36034 80045834 6B0C010C */  jal        TurnOffShakers__23tScreenControllerConfig
    /* 36038 80045838 21200002 */   addu      $a0, $s0, $zero
    /* 3603C 8004583C 98BF030C */  jal        PadStartCom
    /* 36040 80045840 00000000 */   nop
    /* 36044 80045844 6898000C */  jal        Cleanup__7tScreen
    /* 36048 80045848 21200002 */   addu      $a0, $s0, $zero
    /* 3604C 8004584C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 36050 80045850 1000B08F */  lw         $s0, 0x10($sp)
    /* 36054 80045854 0800E003 */  jr         $ra
    /* 36058 80045858 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__23tScreenControllerConfig
