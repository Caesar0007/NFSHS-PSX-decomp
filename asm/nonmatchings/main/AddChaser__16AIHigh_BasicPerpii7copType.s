.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddChaser__16AIHigh_BasicPerpii7copType, 0x54

glabel AddChaser__16AIHigh_BasicPerpii7copType
    /* 4C708 8005BF08 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4C70C 8005BF0C 70008324 */  addiu      $v1, $a0, 0x70
    /* 4C710 8005BF10 80380700 */  sll        $a3, $a3, 2
    /* 4C714 8005BF14 21186700 */  addu       $v1, $v1, $a3
    /* 4C718 8005BF18 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4C71C 8005BF1C 0000628C */  lw         $v0, 0x0($v1)
    /* 4C720 8005BF20 00000000 */  nop
    /* 4C724 8005BF24 01004224 */  addiu      $v0, $v0, 0x1
    /* 4C728 8005BF28 000062AC */  sw         $v0, 0x0($v1)
    /* 4C72C 8005BF2C 28008224 */  addiu      $v0, $a0, 0x28
    /* 4C730 8005BF30 05000324 */  addiu      $v1, $zero, 0x5
    /* 4C734 8005BF34 1C0045AC */  sw         $a1, 0x1C($v0)
    /* 4C738 8005BF38 200046AC */  sw         $a2, 0x20($v0)
    /* 4C73C 8005BF3C 80100500 */  sll        $v0, $a1, 2
    /* 4C740 8005BF40 21108200 */  addu       $v0, $a0, $v0
    /* 4C744 8005BF44 D76F010C */  jal        CheckChaserPosition__16AIHigh_BasicPerpii
    /* 4C748 8005BF48 4C0043AC */   sw        $v1, 0x4C($v0)
    /* 4C74C 8005BF4C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4C750 8005BF50 00000000 */  nop
    /* 4C754 8005BF54 0800E003 */  jr         $ra
    /* 4C758 8005BF58 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AddChaser__16AIHigh_BasicPerpii7copType
