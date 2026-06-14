.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp, 0x70

glabel AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
    /* 4D3AC 8005CBAC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4D3B0 8005CBB0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4D3B4 8005CBB4 21808000 */  addu       $s0, $a0, $zero
    /* 4D3B8 8005CBB8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4D3BC 8005CBBC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4D3C0 8005CBC0 5800048E */  lw         $a0, 0x58($s0)
    /* 4D3C4 8005CBC4 00000000 */  nop
    /* 4D3C8 8005CBC8 07008010 */  beqz       $a0, .L8005CBE8
    /* 4D3CC 8005CBCC 2188A000 */   addu      $s1, $a1, $zero
    /* 4D3D0 8005CBD0 1C00058E */  lw         $a1, 0x1C($s0)
    /* 4D3D4 8005CBD4 0000028E */  lw         $v0, 0x0($s0)
    /* 4D3D8 8005CBD8 1800078E */  lw         $a3, 0x18($s0)
    /* 4D3DC 8005CBDC 5402468C */  lw         $a2, 0x254($v0)
    /* 4D3E0 8005CBE0 B36F010C */  jal        RemoveChaser__16AIHigh_BasicPerpii7copType
    /* 4D3E4 8005CBE4 00000000 */   nop
  .L8005CBE8:
    /* 4D3E8 8005CBE8 07002012 */  beqz       $s1, .L8005CC08
    /* 4D3EC 8005CBEC 580011AE */   sw        $s1, 0x58($s0)
    /* 4D3F0 8005CBF0 1C00058E */  lw         $a1, 0x1C($s0)
    /* 4D3F4 8005CBF4 0000028E */  lw         $v0, 0x0($s0)
    /* 4D3F8 8005CBF8 1800078E */  lw         $a3, 0x18($s0)
    /* 4D3FC 8005CBFC 5402468C */  lw         $a2, 0x254($v0)
    /* 4D400 8005CC00 C26F010C */  jal        AddChaser__16AIHigh_BasicPerpii7copType
    /* 4D404 8005CC04 21202002 */   addu      $a0, $s1, $zero
  .L8005CC08:
    /* 4D408 8005CC08 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4D40C 8005CC0C 1400B18F */  lw         $s1, 0x14($sp)
    /* 4D410 8005CC10 1000B08F */  lw         $s0, 0x10($sp)
    /* 4D414 8005CC14 0800E003 */  jr         $ra
    /* 4D418 8005CC18 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp
