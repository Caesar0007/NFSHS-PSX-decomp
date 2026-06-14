.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDgetlimits, 0x50

glabel SNDgetlimits
    /* DA784 800E9F84 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA788 800E9F88 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA78C 800E9F8C 00000000 */  nop
    /* DA790 800E9F90 0E004010 */  beqz       $v0, .L800E9FCC
    /* DA794 800E9F94 1280023C */   lui       $v0, %hi(sndpsxlimits)
    /* DA798 800E9F98 D4344724 */  addiu      $a3, $v0, %lo(sndpsxlimits)
    /* DA79C 800E9F9C 0000E38C */  lw         $v1, 0x0($a3)
    /* DA7A0 800E9FA0 0400E58C */  lw         $a1, 0x4($a3)
    /* DA7A4 800E9FA4 0800E68C */  lw         $a2, 0x8($a3)
    /* DA7A8 800E9FA8 000083AC */  sw         $v1, 0x0($a0)
    /* DA7AC 800E9FAC 040085AC */  sw         $a1, 0x4($a0)
    /* DA7B0 800E9FB0 080086AC */  sw         $a2, 0x8($a0)
    /* DA7B4 800E9FB4 0C00E38C */  lw         $v1, 0xC($a3)
    /* DA7B8 800E9FB8 1000E58C */  lw         $a1, 0x10($a3)
    /* DA7BC 800E9FBC 0C0083AC */  sw         $v1, 0xC($a0)
    /* DA7C0 800E9FC0 100085AC */  sw         $a1, 0x10($a0)
    /* DA7C4 800E9FC4 0800E003 */  jr         $ra
    /* DA7C8 800E9FC8 21100000 */   addu      $v0, $zero, $zero
  .L800E9FCC:
    /* DA7CC 800E9FCC 0800E003 */  jr         $ra
    /* DA7D0 800E9FD0 F2FF0224 */   addiu     $v0, $zero, -0xE
endlabel SNDgetlimits
