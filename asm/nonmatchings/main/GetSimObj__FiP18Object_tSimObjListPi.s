.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetSimObj__FiP18Object_tSimObjListPi, 0xD4

glabel GetSimObj__FiP18Object_tSimObjListPi
    /* 95714 800A4F14 0000A38C */  lw         $v1, 0x0($a1)
    /* 95718 800A4F18 0800A88C */  lw         $t0, 0x8($a1)
    /* 9571C 800A4F1C 00000000 */  nop
    /* 95720 800A4F20 21106800 */  addu       $v0, $v1, $t0
    /* 95724 800A4F24 2A108200 */  slt        $v0, $a0, $v0
    /* 95728 800A4F28 0C004014 */  bnez       $v0, .L800A4F5C
    /* 9572C 800A4F2C 21380000 */   addu      $a3, $zero, $zero
    /* 95730 800A4F30 23108300 */  subu       $v0, $a0, $v1
    /* 95734 800A4F34 23204800 */  subu       $a0, $v0, $t0
    /* 95738 800A4F38 800D838F */  lw         $v1, %gp_rel(Object_customSimObjs)($gp)
    /* 9573C 800A4F3C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 95740 800A4F40 0000C2AC */  sw         $v0, 0x0($a2)
    /* 95744 800A4F44 80100400 */  sll        $v0, $a0, 2
    /* 95748 800A4F48 21104400 */  addu       $v0, $v0, $a0
    /* 9574C 800A4F4C 80100200 */  sll        $v0, $v0, 2
    /* 95750 800A4F50 04006724 */  addiu      $a3, $v1, 0x4
    /* 95754 800A4F54 0800E003 */  jr         $ra
    /* 95758 800A4F58 2110E200 */   addu      $v0, $a3, $v0
  .L800A4F5C:
    /* 9575C 800A4F5C 0400A28C */  lw         $v0, 0x4($a1)
    /* 95760 800A4F60 00000000 */  nop
    /* 95764 800A4F64 0000C2AC */  sw         $v0, 0x0($a2)
    /* 95768 800A4F68 0000A38C */  lw         $v1, 0x0($a1)
    /* 9576C 800A4F6C 00000000 */  nop
    /* 95770 800A4F70 2A108300 */  slt        $v0, $a0, $v1
    /* 95774 800A4F74 04004014 */  bnez       $v0, .L800A4F88
    /* 95778 800A4F78 00000000 */   nop
    /* 9577C 800A4F7C 0C00A28C */  lw         $v0, 0xC($a1)
    /* 95780 800A4F80 23208300 */  subu       $a0, $a0, $v1
    /* 95784 800A4F84 0000C2AC */  sw         $v0, 0x0($a2)
  .L800A4F88:
    /* 95788 800A4F88 0000C28C */  lw         $v0, 0x0($a2)
    /* 9578C 800A4F8C 00000000 */  nop
    /* 95790 800A4F90 C0180200 */  sll        $v1, $v0, 3
    /* 95794 800A4F94 23186200 */  subu       $v1, $v1, $v0
    /* 95798 800A4F98 1480023C */  lui        $v0, %hi(Track_chunkList)
    /* 9579C 800A4F9C B8D4428C */  lw         $v0, %lo(Track_chunkList)($v0)
    /* 957A0 800A4FA0 00190300 */  sll        $v1, $v1, 4
    /* 957A4 800A4FA4 21186200 */  addu       $v1, $v1, $v0
    /* 957A8 800A4FA8 5000628C */  lw         $v0, 0x50($v1)
    /* 957AC 800A4FAC 00000000 */  nop
    /* 957B0 800A4FB0 0B004010 */  beqz       $v0, .L800A4FE0
    /* 957B4 800A4FB4 00000000 */   nop
    /* 957B8 800A4FB8 04004724 */  addiu      $a3, $v0, 0x4
    /* 957BC 800A4FBC 80100400 */  sll        $v0, $a0, 2
    /* 957C0 800A4FC0 21104400 */  addu       $v0, $v0, $a0
    /* 957C4 800A4FC4 80100200 */  sll        $v0, $v0, 2
    /* 957C8 800A4FC8 2138E200 */  addu       $a3, $a3, $v0
    /* 957CC 800A4FCC 1300E390 */  lbu        $v1, 0x13($a3)
    /* 957D0 800A4FD0 10000224 */  addiu      $v0, $zero, 0x10
    /* 957D4 800A4FD4 02006214 */  bne        $v1, $v0, .L800A4FE0
    /* 957D8 800A4FD8 00000000 */   nop
    /* 957DC 800A4FDC 21380000 */  addu       $a3, $zero, $zero
  .L800A4FE0:
    /* 957E0 800A4FE0 0800E003 */  jr         $ra
    /* 957E4 800A4FE4 2110E000 */   addu      $v0, $a3, $zero
endlabel GetSimObj__FiP18Object_tSimObjListPi
