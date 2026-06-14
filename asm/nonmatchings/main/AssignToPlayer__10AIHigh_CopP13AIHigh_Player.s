.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AssignToPlayer__10AIHigh_CopP13AIHigh_Player, 0x8C

glabel AssignToPlayer__10AIHigh_CopP13AIHigh_Player
    /* 56008 80065808 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5600C 8006580C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 56010 80065810 21808000 */  addu       $s0, $a0, $zero
    /* 56014 80065814 1800BFAF */  sw         $ra, 0x18($sp)
    /* 56018 80065818 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5601C 8006581C 5800048E */  lw         $a0, 0x58($s0)
    /* 56020 80065820 00000000 */  nop
    /* 56024 80065824 07008010 */  beqz       $a0, .L80065844
    /* 56028 80065828 2188A000 */   addu      $s1, $a1, $zero
    /* 5602C 8006582C 1C00058E */  lw         $a1, 0x1C($s0)
    /* 56030 80065830 0000028E */  lw         $v0, 0x0($s0)
    /* 56034 80065834 1800078E */  lw         $a3, 0x18($s0)
    /* 56038 80065838 5402468C */  lw         $a2, 0x254($v0)
    /* 5603C 8006583C B36F010C */  jal        RemoveChaser__16AIHigh_BasicPerpii7copType
    /* 56040 80065840 00000000 */   nop
  .L80065844:
    /* 56044 80065844 06002016 */  bnez       $s1, .L80065860
    /* 56048 80065848 01000224 */   addiu     $v0, $zero, 0x1
    /* 5604C 8006584C 2000038E */  lw         $v1, 0x20($s0)
    /* 56050 80065850 00000000 */  nop
    /* 56054 80065854 02006210 */  beq        $v1, $v0, .L80065860
    /* 56058 80065858 00000000 */   nop
    /* 5605C 8006585C 200000AE */  sw         $zero, 0x20($s0)
  .L80065860:
    /* 56060 80065860 07002012 */  beqz       $s1, .L80065880
    /* 56064 80065864 580011AE */   sw        $s1, 0x58($s0)
    /* 56068 80065868 1C00058E */  lw         $a1, 0x1C($s0)
    /* 5606C 8006586C 0000028E */  lw         $v0, 0x0($s0)
    /* 56070 80065870 1800078E */  lw         $a3, 0x18($s0)
    /* 56074 80065874 5402468C */  lw         $a2, 0x254($v0)
    /* 56078 80065878 C26F010C */  jal        AddChaser__16AIHigh_BasicPerpii7copType
    /* 5607C 8006587C 21202002 */   addu      $a0, $s1, $zero
  .L80065880:
    /* 56080 80065880 1800BF8F */  lw         $ra, 0x18($sp)
    /* 56084 80065884 1400B18F */  lw         $s1, 0x14($sp)
    /* 56088 80065888 1000B08F */  lw         $s0, 0x10($sp)
    /* 5608C 8006588C 0800E003 */  jr         $ra
    /* 56090 80065890 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AssignToPlayer__10AIHigh_CopP13AIHigh_Player
