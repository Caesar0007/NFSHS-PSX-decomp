.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetCautionSurface__FP8coorddefP12BWorldSm_Pos, 0x74

glabel SetCautionSurface__FP8coorddefP12BWorldSm_Pos
    /* 95F3C 800A573C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 95F40 800A5740 1000B0AF */  sw         $s0, 0x10($sp)
    /* 95F44 800A5744 2180A000 */  addu       $s0, $a1, $zero
    /* 95F48 800A5748 1400BFAF */  sw         $ra, 0x14($sp)
    /* 95F4C 800A574C B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 95F50 800A5750 01000624 */   addiu     $a2, $zero, 0x1
    /* 95F54 800A5754 7800058E */  lw         $a1, 0x78($s0)
    /* 95F58 800A5758 00000000 */  nop
    /* 95F5C 800A575C 1000A010 */  beqz       $a1, .L800A57A0
    /* 95F60 800A5760 00000000 */   nop
    /* 95F64 800A5764 0000A290 */  lbu        $v0, 0x0($a1)
    /* 95F68 800A5768 00000000 */  nop
    /* 95F6C 800A576C 40004230 */  andi       $v0, $v0, 0x40
    /* 95F70 800A5770 0B004014 */  bnez       $v0, .L800A57A0
    /* 95F74 800A5774 00000000 */   nop
    /* 95F78 800A5778 1480043C */  lui        $a0, %hi(Track_gSaveSurface)
    /* 95F7C 800A577C CCD4848C */  lw         $a0, %lo(Track_gSaveSurface)($a0)
    /* 95F80 800A5780 C3EB020C */  jal        Save__11SaveSurfaceP14Trk_NewSimQuad
    /* 95F84 800A5784 00000000 */   nop
    /* 95F88 800A5788 7800038E */  lw         $v1, 0x78($s0)
    /* 95F8C 800A578C 00000000 */  nop
    /* 95F90 800A5790 00006290 */  lbu        $v0, 0x0($v1)
    /* 95F94 800A5794 00000000 */  nop
    /* 95F98 800A5798 40004234 */  ori        $v0, $v0, 0x40
    /* 95F9C 800A579C 000062A0 */  sb         $v0, 0x0($v1)
  .L800A57A0:
    /* 95FA0 800A57A0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 95FA4 800A57A4 1000B08F */  lw         $s0, 0x10($sp)
    /* 95FA8 800A57A8 0800E003 */  jr         $ra
    /* 95FAC 800A57AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetCautionSurface__FP8coorddefP12BWorldSm_Pos
