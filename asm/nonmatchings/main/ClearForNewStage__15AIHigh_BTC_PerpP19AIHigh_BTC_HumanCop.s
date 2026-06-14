.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop, 0x64

glabel ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
    /* 50710 8005FF10 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 50714 8005FF14 1000B0AF */  sw         $s0, 0x10($sp)
    /* 50718 8005FF18 21808000 */  addu       $s0, $a0, $zero
    /* 5071C 8005FF1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 50720 8005FF20 1800BFAF */  sw         $ra, 0x18($sp)
    /* 50724 8005FF24 2E70010C */  jal        Clear__16AIHigh_BasicPerp
    /* 50728 8005FF28 2188A000 */   addu      $s1, $a1, $zero
    /* 5072C 8005FF2C 0000038E */  lw         $v1, 0x0($s0)
    /* 50730 8005FF30 01000224 */  addiu      $v0, $zero, 0x1
    /* 50734 8005FF34 700000AE */  sw         $zero, 0x70($s0)
    /* 50738 8005FF38 740000AE */  sw         $zero, 0x74($s0)
    /* 5073C 8005FF3C 780002AE */  sw         $v0, 0x78($s0)
    /* 50740 8005FF40 7C0000AE */  sw         $zero, 0x7C($s0)
    /* 50744 8005FF44 680260AC */  sw         $zero, 0x268($v1)
    /* 50748 8005FF48 0000228E */  lw         $v0, 0x0($s1)
    /* 5074C 8005FF4C 0000038E */  lw         $v1, 0x0($s0)
    /* 50750 8005FF50 6402428C */  lw         $v0, 0x264($v0)
    /* 50754 8005FF54 00000000 */  nop
    /* 50758 8005FF58 640262AC */  sw         $v0, 0x264($v1)
    /* 5075C 8005FF5C 7C0020AE */  sw         $zero, 0x7C($s1)
    /* 50760 8005FF60 1800BF8F */  lw         $ra, 0x18($sp)
    /* 50764 8005FF64 1400B18F */  lw         $s1, 0x14($sp)
    /* 50768 8005FF68 1000B08F */  lw         $s0, 0x10($sp)
    /* 5076C 8005FF6C 0800E003 */  jr         $ra
    /* 50770 8005FF70 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop
