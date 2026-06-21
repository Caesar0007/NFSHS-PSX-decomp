.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTrackByID__13tTrackManagers, 0x54

glabel GetTrackByID__13tTrackManagers
    /* 12500 80021D00 0000838C */  lw         $v1, 0x0($a0)
    /* 12504 80021D04 00000000 */  nop
    /* 12508 80021D08 0F006010 */  beqz       $v1, .L80021D48
    /* 1250C 80021D0C 21300000 */   addu      $a2, $zero, $zero
    /* 12510 80021D10 00140500 */  sll        $v0, $a1, 16
    /* 12514 80021D14 033C0200 */  sra        $a3, $v0, 16
    /* 12518 80021D18 21286000 */  addu       $a1, $v1, $zero
    /* 1251C 80021D1C 0400838C */  lw         $v1, 0x4($a0)
  .L80021D20:
    /* 12520 80021D20 00000000 */  nop
    /* 12524 80021D24 00006280 */  lb         $v0, 0x0($v1)
    /* 12528 80021D28 00000000 */  nop
    /* 1252C 80021D2C 03004714 */  bne        $v0, $a3, .L80021D3C
    /* 12530 80021D30 0100C624 */   addiu     $a2, $a2, 0x1
    /* 12534 80021D34 0800E003 */  jr         $ra
    /* 12538 80021D38 21106000 */   addu      $v0, $v1, $zero
  .L80021D3C:
    /* 1253C 80021D3C 2B10C500 */  sltu       $v0, $a2, $a1
    /* 12540 80021D40 F7FF4014 */  bnez       $v0, .L80021D20
    /* 12544 80021D44 30006324 */   addiu     $v1, $v1, 0x30
  .L80021D48:
    /* 12548 80021D48 0400828C */  lw         $v0, 0x4($a0)
    /* 1254C 80021D4C 0800E003 */  jr         $ra
    /* 12550 80021D50 00000000 */   nop
endlabel GetTrackByID__13tTrackManagers
