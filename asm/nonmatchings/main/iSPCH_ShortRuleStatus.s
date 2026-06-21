.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ShortRuleStatus, 0x68

glabel iSPCH_ShortRuleStatus
    /* F1724 80100F24 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F1728 80100F28 1400B1AF */  sw         $s1, 0x14($sp)
    /* F172C 80100F2C 2188A000 */  addu       $s1, $a1, $zero
    /* F1730 80100F30 1000B0AF */  sw         $s0, 0x10($sp)
    /* F1734 80100F34 1800BFAF */  sw         $ra, 0x18($sp)
    /* F1738 80100F38 C901040C */  jal        VoxSentence_GetShortRule
    /* F173C 80100F3C 21800000 */   addu      $s0, $zero, $zero
    /* F1740 80100F40 21184000 */  addu       $v1, $v0, $zero
    /* F1744 80100F44 01000224 */  addiu      $v0, $zero, 0x1
    /* F1748 80100F48 03006214 */  bne        $v1, $v0, .L80100F58
    /* F174C 80100F4C 02000224 */   addiu     $v0, $zero, 0x2
    /* F1750 80100F50 07002212 */  beq        $s1, $v0, .L80100F70
    /* F1754 80100F54 00000000 */   nop
  .L80100F58:
    /* F1758 80100F58 03006214 */  bne        $v1, $v0, .L80100F68
    /* F175C 80100F5C 00000000 */   nop
    /* F1760 80100F60 03002316 */  bne        $s1, $v1, .L80100F70
    /* F1764 80100F64 00000000 */   nop
  .L80100F68:
    /* F1768 80100F68 03006014 */  bnez       $v1, .L80100F78
    /* F176C 80100F6C 21100002 */   addu      $v0, $s0, $zero
  .L80100F70:
    /* F1770 80100F70 01001024 */  addiu      $s0, $zero, 0x1
    /* F1774 80100F74 21100002 */  addu       $v0, $s0, $zero
  .L80100F78:
    /* F1778 80100F78 1800BF8F */  lw         $ra, 0x18($sp)
    /* F177C 80100F7C 1400B18F */  lw         $s1, 0x14($sp)
    /* F1780 80100F80 1000B08F */  lw         $s0, 0x10($sp)
    /* F1784 80100F84 0800E003 */  jr         $ra
    /* F1788 80100F88 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_ShortRuleStatus
