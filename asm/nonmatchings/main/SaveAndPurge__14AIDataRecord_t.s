.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SaveAndPurge__14AIDataRecord_t, 0x50

glabel SaveAndPurge__14AIDataRecord_t
    /* 5D920 8006D120 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D924 8006D124 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D928 8006D128 21808000 */  addu       $s0, $a0, $zero
    /* 5D92C 8006D12C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5D930 8006D130 4800048E */  lw         $a0, 0x48($s0)
    /* 5D934 8006D134 00000000 */  nop
    /* 5D938 8006D138 09008010 */  beqz       $a0, .L8006D160
    /* 5D93C 8006D13C 21100000 */   addu      $v0, $zero, $zero
    /* 5D940 8006D140 4C00028E */  lw         $v0, 0x4C($s0)
    /* 5D944 8006D144 00000000 */  nop
    /* 5D948 8006D148 03004014 */  bnez       $v0, .L8006D158
    /* 5D94C 8006D14C 00000000 */   nop
    /* 5D950 8006D150 5095030C */  jal        purgememadr
    /* 5D954 8006D154 00000000 */   nop
  .L8006D158:
    /* 5D958 8006D158 480000AE */  sw         $zero, 0x48($s0)
    /* 5D95C 8006D15C 01000224 */  addiu      $v0, $zero, 0x1
  .L8006D160:
    /* 5D960 8006D160 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5D964 8006D164 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D968 8006D168 0800E003 */  jr         $ra
    /* 5D96C 8006D16C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SaveAndPurge__14AIDataRecord_t
