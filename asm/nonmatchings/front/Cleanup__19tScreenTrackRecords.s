.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__19tScreenTrackRecords, 0x3C

glabel Cleanup__19tScreenTrackRecords
    /* 32EC4 800426C4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 32EC8 800426C8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 32ECC 800426CC 21808000 */  addu       $s0, $a0, $zero
    /* 32ED0 800426D0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 32ED4 800426D4 6400048E */  lw         $a0, 0x64($s0)
    /* 32ED8 800426D8 5095030C */  jal        purgememadr
    /* 32EDC 800426DC 00000000 */   nop
    /* 32EE0 800426E0 0E2A010C */  jal        StatChk_ClearNewRecords__Fv
    /* 32EE4 800426E4 640000AE */   sw        $zero, 0x64($s0)
    /* 32EE8 800426E8 6898000C */  jal        Cleanup__7tScreen
    /* 32EEC 800426EC 21200002 */   addu      $a0, $s0, $zero
    /* 32EF0 800426F0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 32EF4 800426F4 1000B08F */  lw         $s0, 0x10($sp)
    /* 32EF8 800426F8 0800E003 */  jr         $ra
    /* 32EFC 800426FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Cleanup__19tScreenTrackRecords
