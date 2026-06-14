.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Load__14AIDataRecord_t, 0x44

glabel Load__14AIDataRecord_t
    /* 5D8DC 8006D0DC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D8E0 8006D0E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D8E4 8006D0E4 21808000 */  addu       $s0, $a0, $zero
    /* 5D8E8 8006D0E8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5D8EC 8006D0EC 5000028E */  lw         $v0, 0x50($s0)
    /* 5D8F0 8006D0F0 00000000 */  nop
    /* 5D8F4 8006D0F4 04004014 */  bnez       $v0, .L8006D108
    /* 5D8F8 8006D0F8 08000426 */   addiu     $a0, $s0, 0x8
    /* 5D8FC 8006D0FC 1997030C */  jal        loadpackadrz
    /* 5D900 8006D100 21280000 */   addu      $a1, $zero, $zero
    /* 5D904 8006D104 480002AE */  sw         $v0, 0x48($s0)
  .L8006D108:
    /* 5D908 8006D108 4800028E */  lw         $v0, 0x48($s0)
    /* 5D90C 8006D10C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5D910 8006D110 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D914 8006D114 2B100200 */  sltu       $v0, $zero, $v0
    /* 5D918 8006D118 0800E003 */  jr         $ra
    /* 5D91C 8006D11C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Load__14AIDataRecord_t
