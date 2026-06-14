.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetNextTrigger__24AITrigger_TriggerManageri, 0x70

glabel GetNextTrigger__24AITrigger_TriggerManageri
    /* 63244 80072A44 0000828C */  lw         $v0, 0x0($a0)
    /* 63248 80072A48 00000000 */  nop
    /* 6324C 80072A4C 03004014 */  bnez       $v0, .L80072A5C
    /* 63250 80072A50 80100500 */   sll       $v0, $a1, 2
    /* 63254 80072A54 0800E003 */  jr         $ra
    /* 63258 80072A58 21100000 */   addu      $v0, $zero, $zero
  .L80072A5C:
    /* 6325C 80072A5C 21288200 */  addu       $a1, $a0, $v0
    /* 63260 80072A60 2803A28C */  lw         $v0, 0x328($a1)
    /* 63264 80072A64 00000000 */  nop
    /* 63268 80072A68 01004224 */  addiu      $v0, $v0, 0x1
    /* 6326C 80072A6C 2803A2AC */  sw         $v0, 0x328($a1)
    /* 63270 80072A70 0000838C */  lw         $v1, 0x0($a0)
    /* 63274 80072A74 00000000 */  nop
    /* 63278 80072A78 02004314 */  bne        $v0, $v1, .L80072A84
    /* 6327C 80072A7C 00000000 */   nop
    /* 63280 80072A80 2803A0AC */  sw         $zero, 0x328($a1)
  .L80072A84:
    /* 63284 80072A84 2803A38C */  lw         $v1, 0x328($a1)
    /* 63288 80072A88 0000828C */  lw         $v0, 0x0($a0)
    /* 6328C 80072A8C 00000000 */  nop
    /* 63290 80072A90 2A106200 */  slt        $v0, $v1, $v0
    /* 63294 80072A94 05004010 */  beqz       $v0, .L80072AAC
    /* 63298 80072A98 80100300 */   sll       $v0, $v1, 2
    /* 6329C 80072A9C 21108200 */  addu       $v0, $a0, $v0
    /* 632A0 80072AA0 0800428C */  lw         $v0, 0x8($v0)
    /* 632A4 80072AA4 0800E003 */  jr         $ra
    /* 632A8 80072AA8 00000000 */   nop
  .L80072AAC:
    /* 632AC 80072AAC 0800E003 */  jr         $ra
    /* 632B0 80072AB0 21100000 */   addu      $v0, $zero, $zero
endlabel GetNextTrigger__24AITrigger_TriggerManageri
