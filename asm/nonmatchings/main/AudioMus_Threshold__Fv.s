.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_Threshold__Fv, 0x84

glabel AudioMus_Threshold__Fv
    /* 6A758 80079F58 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6A75C 80079F5C 00000000 */  nop
    /* 6A760 80079F60 05008010 */  beqz       $a0, .L80079F78
    /* 6A764 80079F64 00000000 */   nop
    /* 6A768 80079F68 8C00828C */  lw         $v0, 0x8C($a0)
    /* 6A76C 80079F6C 00000000 */  nop
    /* 6A770 80079F70 03004014 */  bnez       $v0, .L80079F80
    /* 6A774 80079F74 00000000 */   nop
  .L80079F78:
    /* 6A778 80079F78 0800E003 */  jr         $ra
    /* 6A77C 80079F7C 21100000 */   addu      $v0, $zero, $zero
  .L80079F80:
    /* 6A780 80079F80 2000828C */  lw         $v0, 0x20($a0)
    /* 6A784 80079F84 00000000 */  nop
    /* 6A788 80079F88 FBFF4014 */  bnez       $v0, .L80079F78
    /* 6A78C 80079F8C 02000224 */   addiu     $v0, $zero, 0x2
    /* 6A790 80079F90 1400838C */  lw         $v1, 0x14($a0)
    /* 6A794 80079F94 00000000 */  nop
    /* 6A798 80079F98 04006214 */  bne        $v1, $v0, .L80079FAC
    /* 6A79C 80079F9C 00000000 */   nop
  .L80079FA0:
    /* 6A7A0 80079FA0 8800828C */  lw         $v0, 0x88($a0)
    /* 6A7A4 80079FA4 0800E003 */  jr         $ra
    /* 6A7A8 80079FA8 00000000 */   nop
  .L80079FAC:
    /* 6A7AC 80079FAC 9000828C */  lw         $v0, 0x90($a0)
    /* 6A7B0 80079FB0 00000000 */  nop
    /* 6A7B4 80079FB4 F0FF4010 */  beqz       $v0, .L80079F78
    /* 6A7B8 80079FB8 00000000 */   nop
    /* 6A7BC 80079FBC A400838C */  lw         $v1, 0xA4($a0)
    /* 6A7C0 80079FC0 A800828C */  lw         $v0, 0xA8($a0)
    /* 6A7C4 80079FC4 00000000 */  nop
    /* 6A7C8 80079FC8 2A104300 */  slt        $v0, $v0, $v1
    /* 6A7CC 80079FCC F4FF4014 */  bnez       $v0, .L80079FA0
    /* 6A7D0 80079FD0 21100000 */   addu      $v0, $zero, $zero
    /* 6A7D4 80079FD4 0800E003 */  jr         $ra
    /* 6A7D8 80079FD8 00000000 */   nop
endlabel AudioMus_Threshold__Fv
