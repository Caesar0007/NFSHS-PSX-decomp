.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__6tPMenu, 0xF0

glabel Draw__6tPMenu
    /* 98D10 800A8510 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98D14 800A8514 1400B1AF */  sw         $s1, 0x14($sp)
    /* 98D18 800A8518 21888000 */  addu       $s1, $a0, $zero
    /* 98D1C 800A851C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 98D20 800A8520 65A0020C */  jal        CheckForDisabled__6tPMenu
    /* 98D24 800A8524 1000B0AF */   sw        $s0, 0x10($sp)
    /* 98D28 800A8528 21280000 */  addu       $a1, $zero, $zero
    /* 98D2C 800A852C 0800268E */  lw         $a2, 0x8($s1)
    /* 98D30 800A8530 01001024 */  addiu      $s0, $zero, 0x1
    /* 98D34 800A8534 0800C38C */  lw         $v1, 0x8($a2)
    /* 98D38 800A8538 62000224 */  addiu      $v0, $zero, 0x62
    /* 98D3C 800A853C 781882AF */  sw         $v0, %gp_rel(D_8013DDC4)($gp)
    /* 98D40 800A8540 30006484 */  lh         $a0, 0x30($v1)
    /* 98D44 800A8544 3400628C */  lw         $v0, 0x34($v1)
    /* 98D48 800A8548 00000000 */  nop
    /* 98D4C 800A854C 09F84000 */  jalr       $v0
    /* 98D50 800A8550 2120C400 */   addu      $a0, $a2, $a0
    /* 98D54 800A8554 75000224 */  addiu      $v0, $zero, 0x75
    /* 98D58 800A8558 781882AF */  sw         $v0, %gp_rel(D_8013DDC4)($gp)
  .L800A855C:
    /* 98D5C 800A855C 00141000 */  sll        $v0, $s0, 16
    /* 98D60 800A8560 03240200 */  sra        $a0, $v0, 16
    /* 98D64 800A8564 80100400 */  sll        $v0, $a0, 2
    /* 98D68 800A8568 21102202 */  addu       $v0, $s1, $v0
    /* 98D6C 800A856C 0800438C */  lw         $v1, 0x8($v0)
    /* 98D70 800A8570 00000000 */  nop
    /* 98D74 800A8574 1D006010 */  beqz       $v1, .L800A85EC
    /* 98D78 800A8578 00000000 */   nop
    /* 98D7C 800A857C 0000628C */  lw         $v0, 0x0($v1)
    /* 98D80 800A8580 00000000 */  nop
    /* 98D84 800A8584 01004238 */  xori       $v0, $v0, 0x1
    /* 98D88 800A8588 01004230 */  andi       $v0, $v0, 0x1
    /* 98D8C 800A858C 15004010 */  beqz       $v0, .L800A85E4
    /* 98D90 800A8590 00000000 */   nop
    /* 98D94 800A8594 0400228E */  lw         $v0, 0x4($s1)
    /* 98D98 800A8598 00000000 */  nop
    /* 98D9C 800A859C 06004010 */  beqz       $v0, .L800A85B8
    /* 98DA0 800A85A0 00000000 */   nop
    /* 98DA4 800A85A4 0000258E */  lw         $a1, 0x0($s1)
    /* 98DA8 800A85A8 0800628C */  lw         $v0, 0x8($v1)
    /* 98DAC 800A85AC 26288500 */  xor        $a1, $a0, $a1
    /* 98DB0 800A85B0 70A10208 */  j          .L800A85C0
    /* 98DB4 800A85B4 0100A52C */   sltiu     $a1, $a1, 0x1
  .L800A85B8:
    /* 98DB8 800A85B8 0800628C */  lw         $v0, 0x8($v1)
    /* 98DBC 800A85BC 21280000 */  addu       $a1, $zero, $zero
  .L800A85C0:
    /* 98DC0 800A85C0 30004484 */  lh         $a0, 0x30($v0)
    /* 98DC4 800A85C4 3400428C */  lw         $v0, 0x34($v0)
    /* 98DC8 800A85C8 00000000 */  nop
    /* 98DCC 800A85CC 09F84000 */  jalr       $v0
    /* 98DD0 800A85D0 21206400 */   addu      $a0, $v1, $a0
    /* 98DD4 800A85D4 7818828F */  lw         $v0, %gp_rel(D_8013DDC4)($gp)
    /* 98DD8 800A85D8 00000000 */  nop
    /* 98DDC 800A85DC 0D004224 */  addiu      $v0, $v0, 0xD
    /* 98DE0 800A85E0 781882AF */  sw         $v0, %gp_rel(D_8013DDC4)($gp)
  .L800A85E4:
    /* 98DE4 800A85E4 57A10208 */  j          .L800A855C
    /* 98DE8 800A85E8 01001026 */   addiu     $s0, $s0, 0x1
  .L800A85EC:
    /* 98DEC 800A85EC 1800BF8F */  lw         $ra, 0x18($sp)
    /* 98DF0 800A85F0 1400B18F */  lw         $s1, 0x14($sp)
    /* 98DF4 800A85F4 1000B08F */  lw         $s0, 0x10($sp)
    /* 98DF8 800A85F8 0800E003 */  jr         $ra
    /* 98DFC 800A85FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Draw__6tPMenu
