.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_BuildPlayList__FiPi, 0x88

glabel AudioMus_BuildPlayList__FiPi
    /* 6B6D8 8007AED8 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B6DC 8007AEDC 00000000 */  nop
    /* 6B6E0 8007AEE0 1D004010 */  beqz       $v0, .L8007AF58
    /* 6B6E4 8007AEE4 00000000 */   nop
    /* 6B6E8 8007AEE8 080040AC */  sw         $zero, 0x8($v0)
    /* 6B6EC 8007AEEC 1A008018 */  blez       $a0, .L8007AF58
    /* 6B6F0 8007AEF0 21380000 */   addu      $a3, $zero, $zero
  .L8007AEF4:
    /* 6B6F4 8007AEF4 0000A38C */  lw         $v1, 0x0($a1)
    /* 6B6F8 8007AEF8 00000000 */  nop
    /* 6B6FC 8007AEFC 12006004 */  bltz       $v1, .L8007AF48
    /* 6B700 8007AF00 00000000 */   nop
    /* 6B704 8007AF04 D401868F */  lw         $a2, %gp_rel(AudioMus_g)($gp)
    /* 6B708 8007AF08 00000000 */  nop
    /* 6B70C 8007AF0C 0400C28C */  lw         $v0, 0x4($a2)
    /* 6B710 8007AF10 00000000 */  nop
    /* 6B714 8007AF14 2A106200 */  slt        $v0, $v1, $v0
    /* 6B718 8007AF18 0B004010 */  beqz       $v0, .L8007AF48
    /* 6B71C 8007AF1C 00000000 */   nop
    /* 6B720 8007AF20 0800C28C */  lw         $v0, 0x8($a2)
    /* 6B724 8007AF24 0000A390 */  lbu        $v1, 0x0($a1)
    /* 6B728 8007AF28 2110C200 */  addu       $v0, $a2, $v0
    /* 6B72C 8007AF2C EC0043A0 */  sb         $v1, 0xEC($v0)
    /* 6B730 8007AF30 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B734 8007AF34 00000000 */  nop
    /* 6B738 8007AF38 0800628C */  lw         $v0, 0x8($v1)
    /* 6B73C 8007AF3C 00000000 */  nop
    /* 6B740 8007AF40 01004224 */  addiu      $v0, $v0, 0x1
    /* 6B744 8007AF44 080062AC */  sw         $v0, 0x8($v1)
  .L8007AF48:
    /* 6B748 8007AF48 0100E724 */  addiu      $a3, $a3, 0x1
    /* 6B74C 8007AF4C 2A10E400 */  slt        $v0, $a3, $a0
    /* 6B750 8007AF50 E8FF4014 */  bnez       $v0, .L8007AEF4
    /* 6B754 8007AF54 0400A524 */   addiu     $a1, $a1, 0x4
  .L8007AF58:
    /* 6B758 8007AF58 0800E003 */  jr         $ra
    /* 6B75C 8007AF5C 00000000 */   nop
endlabel AudioMus_BuildPlayList__FiPi
