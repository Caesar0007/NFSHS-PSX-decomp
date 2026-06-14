.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __15AIHigh_OpponentP8Car_tObj, 0x44

glabel __15AIHigh_OpponentP8Car_tObj
    /* 542E8 80063AE8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 542EC 80063AEC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 542F0 80063AF0 1400BFAF */  sw         $ra, 0x14($sp)
    /* 542F4 80063AF4 308A010C */  jal        __13AIHigh_PlayerP8Car_tObj
    /* 542F8 80063AF8 21808000 */   addu      $s0, $a0, $zero
    /* 542FC 80063AFC 21100002 */  addu       $v0, $s0, $zero
    /* 54300 80063B00 0580033C */  lui        $v1, %hi(_vt_15AIHigh_Opponent)
    /* 54304 80063B04 F8506324 */  addiu      $v1, $v1, %lo(_vt_15AIHigh_Opponent)
    /* 54308 80063B08 140043AC */  sw         $v1, 0x14($v0)
    /* 5430C 80063B0C B00040AC */  sw         $zero, 0xB0($v0)
    /* 54310 80063B10 B40040AC */  sw         $zero, 0xB4($v0)
    /* 54314 80063B14 B80040AC */  sw         $zero, 0xB8($v0)
    /* 54318 80063B18 BC0040AC */  sw         $zero, 0xBC($v0)
    /* 5431C 80063B1C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 54320 80063B20 1000B08F */  lw         $s0, 0x10($sp)
    /* 54324 80063B24 0800E003 */  jr         $ra
    /* 54328 80063B28 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __15AIHigh_OpponentP8Car_tObj
