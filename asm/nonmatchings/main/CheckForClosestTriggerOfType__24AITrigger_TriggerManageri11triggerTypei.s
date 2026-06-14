.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei, 0xD0

glabel CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
    /* 63540 80072D40 21480000 */  addu       $t1, $zero, $zero
    /* 63544 80072D44 21502001 */  addu       $t2, $t1, $zero
    /* 63548 80072D48 FFFF0B24 */  addiu      $t3, $zero, -0x1
    /* 6354C 80072D4C 0000828C */  lw         $v0, 0x0($a0)
    /* 63550 80072D50 00000000 */  nop
    /* 63554 80072D54 05004014 */  bnez       $v0, .L80072D6C
    /* 63558 80072D58 21606001 */   addu      $t4, $t3, $zero
  .L80072D5C:
    /* 6355C 80072D5C 0800E003 */  jr         $ra
    /* 63560 80072D60 21106001 */   addu      $v0, $t3, $zero
  .L80072D64:
    /* 63564 80072D64 0800E003 */  jr         $ra
    /* 63568 80072D68 21100001 */   addu      $v0, $t0, $zero
  .L80072D6C:
    /* 6356C 80072D6C 21400000 */  addu       $t0, $zero, $zero
    /* 63570 80072D70 21684000 */  addu       $t5, $v0, $zero
  .L80072D74:
    /* 63574 80072D74 2A100D01 */  slt        $v0, $t0, $t5
    /* 63578 80072D78 1C004010 */  beqz       $v0, .L80072DEC
    /* 6357C 80072D7C 00000000 */   nop
    /* 63580 80072D80 0800838C */  lw         $v1, 0x8($a0)
    /* 63584 80072D84 00000000 */  nop
    /* 63588 80072D88 0000628C */  lw         $v0, 0x0($v1)
    /* 6358C 80072D8C 00000000 */  nop
    /* 63590 80072D90 13004614 */  bne        $v0, $a2, .L80072DE0
    /* 63594 80072D94 00000000 */   nop
    /* 63598 80072D98 03004015 */  bnez       $t2, .L80072DA8
    /* 6359C 80072D9C 00000000 */   nop
    /* 635A0 80072DA0 21506000 */  addu       $t2, $v1, $zero
    /* 635A4 80072DA4 21600001 */  addu       $t4, $t0, $zero
  .L80072DA8:
    /* 635A8 80072DA8 0400628C */  lw         $v0, 0x4($v1)
    /* 635AC 80072DAC 00000000 */  nop
    /* 635B0 80072DB0 ECFF4510 */  beq        $v0, $a1, .L80072D64
    /* 635B4 80072DB4 2A10A200 */   slt       $v0, $a1, $v0
    /* 635B8 80072DB8 07004010 */  beqz       $v0, .L80072DD8
    /* 635BC 80072DBC 00000000 */   nop
    /* 635C0 80072DC0 E8FFE01C */  bgtz       $a3, .L80072D64
    /* 635C4 80072DC4 00000000 */   nop
    /* 635C8 80072DC8 0300E104 */  bgez       $a3, .L80072DD8
    /* 635CC 80072DCC 00000000 */   nop
    /* 635D0 80072DD0 E2FF2015 */  bnez       $t1, .L80072D5C
    /* 635D4 80072DD4 00000000 */   nop
  .L80072DD8:
    /* 635D8 80072DD8 21486000 */  addu       $t1, $v1, $zero
    /* 635DC 80072DDC 21580001 */  addu       $t3, $t0, $zero
  .L80072DE0:
    /* 635E0 80072DE0 04008424 */  addiu      $a0, $a0, 0x4
    /* 635E4 80072DE4 5DCB0108 */  j          .L80072D74
    /* 635E8 80072DE8 01000825 */   addiu     $t0, $t0, 0x1
  .L80072DEC:
    /* 635EC 80072DEC 03002011 */  beqz       $t1, .L80072DFC
    /* 635F0 80072DF0 00000000 */   nop
    /* 635F4 80072DF4 0400E004 */  bltz       $a3, .L80072E08
    /* 635F8 80072DF8 21106001 */   addu      $v0, $t3, $zero
  .L80072DFC:
    /* 635FC 80072DFC 0200E01C */  bgtz       $a3, .L80072E08
    /* 63600 80072E00 21108001 */   addu      $v0, $t4, $zero
    /* 63604 80072E04 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80072E08:
    /* 63608 80072E08 0800E003 */  jr         $ra
    /* 6360C 80072E0C 00000000 */   nop
endlabel CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei
