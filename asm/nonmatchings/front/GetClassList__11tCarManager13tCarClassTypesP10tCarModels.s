.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetClassList__11tCarManager13tCarClassTypesP10tCarModels, 0x114

glabel GetClassList__11tCarManager13tCarClassTypesP10tCarModels
    /* 7C64 80017464 21480000 */  addu       $t1, $zero, $zero
    /* 7C68 80017468 21402001 */  addu       $t0, $t1, $zero
    /* 7C6C 8001746C 0000828C */  lw         $v0, 0x0($a0)
    /* 7C70 80017470 00000000 */  nop
    /* 7C74 80017474 1D004010 */  beqz       $v0, .L800174EC
    /* 7C78 80017478 2158C000 */   addu      $t3, $a2, $zero
    /* 7C7C 8001747C 00140600 */  sll        $v0, $a2, 16
    /* 7C80 80017480 03540200 */  sra        $t2, $v0, 16
    /* 7C84 80017484 FFFF0331 */  andi       $v1, $t0, 0xFFFF
  .L80017488:
    /* 7C88 80017488 40100300 */  sll        $v0, $v1, 1
    /* 7C8C 8001748C 21104300 */  addu       $v0, $v0, $v1
    /* 7C90 80017490 00190200 */  sll        $v1, $v0, 4
    /* 7C94 80017494 21104300 */  addu       $v0, $v0, $v1
    /* 7C98 80017498 0400838C */  lw         $v1, 0x4($a0)
    /* 7C9C 8001749C 80100200 */  sll        $v0, $v0, 2
    /* 7CA0 800174A0 21304300 */  addu       $a2, $v0, $v1
    /* 7CA4 800174A4 0200C290 */  lbu        $v0, 0x2($a2)
    /* 7CA8 800174A8 00000000 */  nop
    /* 7CAC 800174AC 09004514 */  bne        $v0, $a1, .L800174D4
    /* 7CB0 800174B0 00140900 */   sll       $v0, $t1, 16
    /* 7CB4 800174B4 031C0200 */  sra        $v1, $v0, 16
    /* 7CB8 800174B8 2A106A00 */  slt        $v0, $v1, $t2
    /* 7CBC 800174BC 04004010 */  beqz       $v0, .L800174D0
    /* 7CC0 800174C0 80100300 */   sll       $v0, $v1, 2
    /* 7CC4 800174C4 0000C380 */  lb         $v1, 0x0($a2)
    /* 7CC8 800174C8 21104700 */  addu       $v0, $v0, $a3
    /* 7CCC 800174CC 000043AC */  sw         $v1, 0x0($v0)
  .L800174D0:
    /* 7CD0 800174D0 01002925 */  addiu      $t1, $t1, 0x1
  .L800174D4:
    /* 7CD4 800174D4 01000825 */  addiu      $t0, $t0, 0x1
    /* 7CD8 800174D8 0000838C */  lw         $v1, 0x0($a0)
    /* 7CDC 800174DC FFFF0231 */  andi       $v0, $t0, 0xFFFF
    /* 7CE0 800174E0 2B104300 */  sltu       $v0, $v0, $v1
    /* 7CE4 800174E4 E8FF4014 */  bnez       $v0, .L80017488
    /* 7CE8 800174E8 FFFF0331 */   andi      $v1, $t0, 0xFFFF
  .L800174EC:
    /* 7CEC 800174EC FFFF2231 */  andi       $v0, $t1, 0xFFFF
    /* 7CF0 800174F0 001C0B00 */  sll        $v1, $t3, 16
    /* 7CF4 800174F4 031C0300 */  sra        $v1, $v1, 16
    /* 7CF8 800174F8 2A104300 */  slt        $v0, $v0, $v1
    /* 7CFC 800174FC 1B004010 */  beqz       $v0, .L8001756C
    /* 7D00 80017500 21402001 */   addu      $t0, $t1, $zero
    /* 7D04 80017504 00140900 */  sll        $v0, $t1, 16
    /* 7D08 80017508 032C0200 */  sra        $a1, $v0, 16
    /* 7D0C 8001750C 21306000 */  addu       $a2, $v1, $zero
  .L80017510:
    /* 7D10 80017510 FFFF0231 */  andi       $v0, $t0, 0xFFFF
    /* 7D14 80017514 1A004500 */  div        $zero, $v0, $a1
    /* 7D18 80017518 0200A014 */  bnez       $a1, .L80017524
    /* 7D1C 8001751C 00000000 */   nop
    /* 7D20 80017520 0D000700 */  break      7
  .L80017524:
    /* 7D24 80017524 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 7D28 80017528 0400A114 */  bne        $a1, $at, .L8001753C
    /* 7D2C 8001752C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 7D30 80017530 02004114 */  bne        $v0, $at, .L8001753C
    /* 7D34 80017534 00000000 */   nop
    /* 7D38 80017538 0D000600 */  break      6
  .L8001753C:
    /* 7D3C 8001753C 10180000 */  mfhi       $v1
    /* 7D40 80017540 01000825 */  addiu      $t0, $t0, 0x1
    /* 7D44 80017544 80100200 */  sll        $v0, $v0, 2
    /* 7D48 80017548 80180300 */  sll        $v1, $v1, 2
    /* 7D4C 8001754C 21186700 */  addu       $v1, $v1, $a3
    /* 7D50 80017550 0000638C */  lw         $v1, 0x0($v1)
    /* 7D54 80017554 21104700 */  addu       $v0, $v0, $a3
    /* 7D58 80017558 000043AC */  sw         $v1, 0x0($v0)
    /* 7D5C 8001755C FFFF0231 */  andi       $v0, $t0, 0xFFFF
    /* 7D60 80017560 2A104600 */  slt        $v0, $v0, $a2
    /* 7D64 80017564 EAFF4014 */  bnez       $v0, .L80017510
    /* 7D68 80017568 00000000 */   nop
  .L8001756C:
    /* 7D6C 8001756C 00140900 */  sll        $v0, $t1, 16
    /* 7D70 80017570 0800E003 */  jr         $ra
    /* 7D74 80017574 03140200 */   sra       $v0, $v0, 16
endlabel GetClassList__11tCarManager13tCarClassTypesP10tCarModels
