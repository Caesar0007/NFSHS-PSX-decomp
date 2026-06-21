.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc, 0x4C

glabel StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
    /* 3B44C 8004AC4C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3B450 8004AC50 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3B454 8004AC54 21808000 */  addu       $s0, $a0, $zero
    /* 3B458 8004AC58 1400BFAF */  sw         $ra, 0x14($sp)
    /* 3B45C 8004AC5C 00000292 */  lbu        $v0, 0x0($s0)
    /* 3B460 8004AC60 00000000 */  nop
    /* 3B464 8004AC64 08004010 */  beqz       $v0, .L8004AC88
    /* 3B468 8004AC68 00000000 */   nop
  .L8004AC6C:
    /* 3B46C 8004AC6C AD2A010C */  jal        UserNameUpperCaseOneLetter__FPc
    /* 3B470 8004AC70 21200002 */   addu      $a0, $s0, $zero
    /* 3B474 8004AC74 01001026 */  addiu      $s0, $s0, 0x1
    /* 3B478 8004AC78 00000292 */  lbu        $v0, 0x0($s0)
    /* 3B47C 8004AC7C 00000000 */  nop
    /* 3B480 8004AC80 FAFF4014 */  bnez       $v0, .L8004AC6C
    /* 3B484 8004AC84 00000000 */   nop
  .L8004AC88:
    /* 3B488 8004AC88 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3B48C 8004AC8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 3B490 8004AC90 0800E003 */  jr         $ra
    /* 3B494 8004AC94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
