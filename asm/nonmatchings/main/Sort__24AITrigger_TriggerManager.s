.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sort__24AITrigger_TriggerManager, 0x38

glabel Sort__24AITrigger_TriggerManager
    /* 63630 80072E30 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 63634 80072E34 1000BFAF */  sw         $ra, 0x10($sp)
    /* 63638 80072E38 0000858C */  lw         $a1, 0x0($a0)
    /* 6363C 80072E3C 00000000 */  nop
    /* 63640 80072E40 0500A010 */  beqz       $a1, .L80072E58
    /* 63644 80072E44 08008424 */   addiu     $a0, $a0, 0x8
    /* 63648 80072E48 0780073C */  lui        $a3, %hi(AITrigger_Compare__FPCvT0)
    /* 6364C 80072E4C 04000624 */  addiu      $a2, $zero, 0x4
    /* 63650 80072E50 6397030C */  jal        qsort
    /* 63654 80072E54 182EE724 */   addiu     $a3, $a3, %lo(AITrigger_Compare__FPCvT0)
  .L80072E58:
    /* 63658 80072E58 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6365C 80072E5C 00000000 */  nop
    /* 63660 80072E60 0800E003 */  jr         $ra
    /* 63664 80072E64 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sort__24AITrigger_TriggerManager
