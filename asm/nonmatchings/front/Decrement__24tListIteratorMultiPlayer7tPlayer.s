.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Decrement__24tListIteratorMultiPlayer7tPlayer, 0xA0

glabel Decrement__24tListIteratorMultiPlayer7tPlayer
    /* 14C94 80024494 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 14C98 80024498 0200A214 */  bne        $a1, $v0, .L800244A4
    /* 14C9C 8002449C 00000000 */   nop
    /* 14CA0 800244A0 21280000 */  addu       $a1, $zero, $zero
  .L800244A4:
    /* 14CA4 800244A4 0400868C */  lw         $a2, 0x4($a0)
    /* 14CA8 800244A8 00000000 */  nop
    /* 14CAC 800244AC 2118C500 */  addu       $v1, $a2, $a1
    /* 14CB0 800244B0 00006290 */  lbu        $v0, 0x0($v1)
    /* 14CB4 800244B4 00000000 */  nop
    /* 14CB8 800244B8 1A004014 */  bnez       $v0, .L80024524
    /* 14CBC 800244BC 00000000 */   nop
    /* 14CC0 800244C0 FF004230 */  andi       $v0, $v0, 0xFF
    /* 14CC4 800244C4 0000838C */  lw         $v1, 0x0($a0)
    /* 14CC8 800244C8 40100200 */  sll        $v0, $v0, 1
    /* 14CCC 800244CC 21104300 */  addu       $v0, $v0, $v1
    /* 14CD0 800244D0 02004284 */  lh         $v0, 0x2($v0)
    /* 14CD4 800244D4 00000000 */  nop
    /* 14CD8 800244D8 10004018 */  blez       $v0, .L8002451C
    /* 14CDC 800244DC 2118C500 */   addu      $v1, $a2, $a1
  .L800244E0:
    /* 14CE0 800244E0 00006290 */  lbu        $v0, 0x0($v1)
    /* 14CE4 800244E4 00000000 */  nop
    /* 14CE8 800244E8 01004224 */  addiu      $v0, $v0, 0x1
    /* 14CEC 800244EC 000062A0 */  sb         $v0, 0x0($v1)
    /* 14CF0 800244F0 0400868C */  lw         $a2, 0x4($a0)
    /* 14CF4 800244F4 00000000 */  nop
    /* 14CF8 800244F8 2110C500 */  addu       $v0, $a2, $a1
    /* 14CFC 800244FC 00004290 */  lbu        $v0, 0x0($v0)
    /* 14D00 80024500 0000838C */  lw         $v1, 0x0($a0)
    /* 14D04 80024504 40100200 */  sll        $v0, $v0, 1
    /* 14D08 80024508 21104300 */  addu       $v0, $v0, $v1
    /* 14D0C 8002450C 02004284 */  lh         $v0, 0x2($v0)
    /* 14D10 80024510 00000000 */  nop
    /* 14D14 80024514 F2FF401C */  bgtz       $v0, .L800244E0
    /* 14D18 80024518 2118C500 */   addu      $v1, $a2, $a1
  .L8002451C:
    /* 14D1C 8002451C 0800E003 */  jr         $ra
    /* 14D20 80024520 00000000 */   nop
  .L80024524:
    /* 14D24 80024524 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 14D28 80024528 000062A0 */  sb         $v0, 0x0($v1)
    /* 14D2C 8002452C 0800E003 */  jr         $ra
    /* 14D30 80024530 00000000 */   nop
endlabel Decrement__24tListIteratorMultiPlayer7tPlayer
