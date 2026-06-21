.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCarFromSimID__11tCarManagers, 0x50

glabel GetCarFromSimID__11tCarManagers
    /* 6A9C 8001629C 0000868C */  lw         $a2, 0x0($a0)
    /* 6AA0 800162A0 00000000 */  nop
    /* 6AA4 800162A4 0F00C010 */  beqz       $a2, .L800162E4
    /* 6AA8 800162A8 21180000 */   addu      $v1, $zero, $zero
    /* 6AAC 800162AC 00140500 */  sll        $v0, $a1, 16
    /* 6AB0 800162B0 033C0200 */  sra        $a3, $v0, 16
    /* 6AB4 800162B4 2128C000 */  addu       $a1, $a2, $zero
    /* 6AB8 800162B8 0400848C */  lw         $a0, 0x4($a0)
  .L800162BC:
    /* 6ABC 800162BC 00000000 */  nop
    /* 6AC0 800162C0 01008290 */  lbu        $v0, 0x1($a0)
    /* 6AC4 800162C4 00000000 */  nop
    /* 6AC8 800162C8 03004714 */  bne        $v0, $a3, .L800162D8
    /* 6ACC 800162CC 01006324 */   addiu     $v1, $v1, 0x1
    /* 6AD0 800162D0 0800E003 */  jr         $ra
    /* 6AD4 800162D4 21108000 */   addu      $v0, $a0, $zero
  .L800162D8:
    /* 6AD8 800162D8 2B106500 */  sltu       $v0, $v1, $a1
    /* 6ADC 800162DC F7FF4014 */  bnez       $v0, .L800162BC
    /* 6AE0 800162E0 CC008424 */   addiu     $a0, $a0, 0xCC
  .L800162E4:
    /* 6AE4 800162E4 0800E003 */  jr         $ra
    /* 6AE8 800162E8 21100000 */   addu      $v0, $zero, $zero
endlabel GetCarFromSimID__11tCarManagers
