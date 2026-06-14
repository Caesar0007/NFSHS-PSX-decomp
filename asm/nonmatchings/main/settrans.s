.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching settrans, 0x2C

glabel settrans
    /* E0F0C 800F070C 07008004 */  bltz       $a0, .L800F072C
    /* E0F10 800F0710 00000000 */   nop
    /* E0F14 800F0714 03008010 */  beqz       $a0, .L800F0724
    /* E0F18 800F0718 00000000 */   nop
    /* E0F1C 800F071C CAC10308 */  j          .L800F0728
    /* E0F20 800F0720 03000224 */   addiu     $v0, $zero, 0x3
  .L800F0724:
    /* E0F24 800F0724 01000224 */  addiu      $v0, $zero, 0x1
  .L800F0728:
    /* E0F28 800F0728 C81782AF */  sw         $v0, %gp_rel(semitrans)($gp)
  .L800F072C:
    /* E0F2C 800F072C C817828F */  lw         $v0, %gp_rel(semitrans)($gp)
    /* E0F30 800F0730 0800E003 */  jr         $ra
    /* E0F34 800F0734 43100200 */   sra       $v0, $v0, 1
endlabel settrans
