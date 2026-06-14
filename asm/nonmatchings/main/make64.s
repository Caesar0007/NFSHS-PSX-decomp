.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching make64, 0x58

glabel make64
    /* EEC88 800FE488 2000C828 */  slti       $t0, $a2, 0x20
    /* EEC8C 800FE48C 06000015 */  bnez       $t0, .L800FE4A8
    /* EEC90 800FE490 E0FFC920 */   addi      $t1, $a2, -0x20 /* handwritten instruction */
    /* EEC94 800FE494 04702501 */  sllv       $t6, $a1, $t1
    /* EEC98 800FE498 000080AC */  sw         $zero, 0x0($a0)
    /* EEC9C 800FE49C 04008EAC */  sw         $t6, 0x4($a0)
    /* EECA0 800FE4A0 0800E003 */  jr         $ra
    /* EECA4 800FE4A4 00000000 */   nop
  .L800FE4A8:
    /* EECA8 800FE4A8 0800C018 */  blez       $a2, .L800FE4CC
    /* EECAC 800FE4AC 20000B24 */   addiu     $t3, $zero, 0x20
    /* EECB0 800FE4B0 22506601 */  sub        $t2, $t3, $a2 /* handwritten instruction */
    /* EECB4 800FE4B4 0468C500 */  sllv       $t5, $a1, $a2
    /* EECB8 800FE4B8 07704501 */  srav       $t6, $a1, $t2
    /* EECBC 800FE4BC 00008DAC */  sw         $t5, 0x0($a0)
    /* EECC0 800FE4C0 04008EAC */  sw         $t6, 0x4($a0)
    /* EECC4 800FE4C4 0800E003 */  jr         $ra
    /* EECC8 800FE4C8 00000000 */   nop
  .L800FE4CC:
    /* EECCC 800FE4CC 000085AC */  sw         $a1, 0x0($a0)
    /* EECD0 800FE4D0 C3770500 */  sra        $t6, $a1, 31
    /* EECD4 800FE4D4 04008EAC */  sw         $t6, 0x4($a0)
    /* EECD8 800FE4D8 0800E003 */  jr         $ra
    /* EECDC 800FE4DC 00000000 */   nop
endlabel make64
