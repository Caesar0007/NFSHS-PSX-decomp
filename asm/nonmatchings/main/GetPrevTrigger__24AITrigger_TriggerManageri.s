.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetPrevTrigger__24AITrigger_TriggerManageri, 0x70

glabel GetPrevTrigger__24AITrigger_TriggerManageri
    /* 632B4 80072AB4 0000828C */  lw         $v0, 0x0($a0)
    /* 632B8 80072AB8 00000000 */  nop
    /* 632BC 80072ABC 03004014 */  bnez       $v0, .L80072ACC
    /* 632C0 80072AC0 80100500 */   sll       $v0, $a1, 2
    /* 632C4 80072AC4 0800E003 */  jr         $ra
    /* 632C8 80072AC8 21100000 */   addu      $v0, $zero, $zero
  .L80072ACC:
    /* 632CC 80072ACC 21288200 */  addu       $a1, $a0, $v0
    /* 632D0 80072AD0 2803A28C */  lw         $v0, 0x328($a1)
    /* 632D4 80072AD4 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 632D8 80072AD8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 632DC 80072ADC 05004314 */  bne        $v0, $v1, .L80072AF4
    /* 632E0 80072AE0 2803A2AC */   sw        $v0, 0x328($a1)
    /* 632E4 80072AE4 0000828C */  lw         $v0, 0x0($a0)
    /* 632E8 80072AE8 00000000 */  nop
    /* 632EC 80072AEC 21104300 */  addu       $v0, $v0, $v1
    /* 632F0 80072AF0 2803A2AC */  sw         $v0, 0x328($a1)
  .L80072AF4:
    /* 632F4 80072AF4 2803A38C */  lw         $v1, 0x328($a1)
    /* 632F8 80072AF8 0000828C */  lw         $v0, 0x0($a0)
    /* 632FC 80072AFC 00000000 */  nop
    /* 63300 80072B00 2A106200 */  slt        $v0, $v1, $v0
    /* 63304 80072B04 05004010 */  beqz       $v0, .L80072B1C
    /* 63308 80072B08 80100300 */   sll       $v0, $v1, 2
    /* 6330C 80072B0C 21108200 */  addu       $v0, $a0, $v0
    /* 63310 80072B10 0800428C */  lw         $v0, 0x8($v0)
    /* 63314 80072B14 0800E003 */  jr         $ra
    /* 63318 80072B18 00000000 */   nop
  .L80072B1C:
    /* 6331C 80072B1C 0800E003 */  jr         $ra
    /* 63320 80072B20 21100000 */   addu      $v0, $zero, $zero
endlabel GetPrevTrigger__24AITrigger_TriggerManageri
