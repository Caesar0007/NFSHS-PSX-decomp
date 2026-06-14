.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos, 0x58

glabel BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
    /* 707D4 8007FFD4 00008284 */  lh         $v0, 0x0($a0)
    /* 707D8 8007FFD8 7402838F */  lw         $v1, %gp_rel(BWorldSm_slices)($gp)
    /* 707DC 8007FFDC 40110200 */  sll        $v0, $v0, 5
    /* 707E0 8007FFE0 21104300 */  addu       $v0, $v0, $v1
    /* 707E4 8007FFE4 15004290 */  lbu        $v0, 0x15($v0)
    /* 707E8 8007FFE8 00000000 */  nop
    /* 707EC 8007FFEC 44004230 */  andi       $v0, $v0, 0x44
    /* 707F0 8007FFF0 0C004014 */  bnez       $v0, .L80080024
    /* 707F4 8007FFF4 01000224 */   addiu     $v0, $zero, 0x1
    /* 707F8 8007FFF8 7800848C */  lw         $a0, 0x78($a0)
    /* 707FC 8007FFFC 00000000 */  nop
    /* 70800 80080000 04008010 */  beqz       $a0, .L80080014
    /* 70804 80080004 00000000 */   nop
    /* 70808 80080008 00008290 */  lbu        $v0, 0x0($a0)
    /* 7080C 8008000C 06000208 */  j          .L80080018
    /* 70810 80080010 0F004230 */   andi      $v0, $v0, 0xF
  .L80080014:
    /* 70814 80080014 0E000224 */  addiu      $v0, $zero, 0xE
  .L80080018:
    /* 70818 80080018 08004238 */  xori       $v0, $v0, 0x8
    /* 7081C 8008001C 0800E003 */  jr         $ra
    /* 70820 80080020 0100422C */   sltiu     $v0, $v0, 0x1
  .L80080024:
    /* 70824 80080024 0800E003 */  jr         $ra
    /* 70828 80080028 00000000 */   nop
endlabel BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos
