.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioTrk_StartUp__Fv, 0x5C

glabel AudioTrk_StartUp__Fv
    /* 6CEF4 8007C6F4 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CEF8 8007C6F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6CEFC 8007C6FC 0E004014 */  bnez       $v0, .L8007C738
    /* 6CF00 8007C700 1000BFAF */   sw        $ra, 0x10($sp)
    /* 6CF04 8007C704 0580043C */  lui        $a0, %hi(D_80055864)
    /* 6CF08 8007C708 64588424 */  addiu      $a0, $a0, %lo(D_80055864)
    /* 6CF0C 8007C70C 00010524 */  addiu      $a1, $zero, 0x100
    /* 6CF10 8007C710 CF94030C */  jal        reservememadr
    /* 6CF14 8007C714 21300000 */   addu      $a2, $zero, $zero
    /* 6CF18 8007C718 080282AF */  sw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CF1C 8007C71C FFFF0424 */  addiu      $a0, $zero, -0x1
    /* 6CF20 8007C720 0F000324 */  addiu      $v1, $zero, 0xF
    /* 6CF24 8007C724 F0004224 */  addiu      $v0, $v0, 0xF0
  .L8007C728:
    /* 6CF28 8007C728 040044AC */  sw         $a0, 0x4($v0)
    /* 6CF2C 8007C72C FFFF6324 */  addiu      $v1, $v1, -0x1
    /* 6CF30 8007C730 FDFF6104 */  bgez       $v1, .L8007C728
    /* 6CF34 8007C734 F0FF4224 */   addiu     $v0, $v0, -0x10
  .L8007C738:
    /* 6CF38 8007C738 85F1010C */  jal        AudioTrk_Reset__Fv
    /* 6CF3C 8007C73C 00000000 */   nop
    /* 6CF40 8007C740 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6CF44 8007C744 00000000 */  nop
    /* 6CF48 8007C748 0800E003 */  jr         $ra
    /* 6CF4C 8007C74C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioTrk_StartUp__Fv
