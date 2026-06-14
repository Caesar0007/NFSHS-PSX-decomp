.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Setup__14AIDataRecord_t, 0x50

glabel Setup__14AIDataRecord_t
    /* 5D88C 8006D08C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D890 8006D090 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5D894 8006D094 21808000 */  addu       $s0, $a0, $zero
    /* 5D898 8006D098 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5D89C 8006D09C 4C00028E */  lw         $v0, 0x4C($s0)
    /* 5D8A0 8006D0A0 00000000 */  nop
    /* 5D8A4 8006D0A4 08004014 */  bnez       $v0, .L8006D0C8
    /* 5D8A8 8006D0A8 00000000 */   nop
    /* 5D8AC 8006D0AC 37B4010C */  jal        Load__14AIDataRecord_t
    /* 5D8B0 8006D0B0 21200002 */   addu      $a0, $s0, $zero
    /* 5D8B4 8006D0B4 05004014 */  bnez       $v0, .L8006D0CC
    /* 5D8B8 8006D0B8 08000426 */   addiu     $a0, $s0, 0x8
    /* 5D8BC 8006D0BC 0400058E */  lw         $a1, 0x4($s0)
    /* 5D8C0 8006D0C0 CF94030C */  jal        reservememadr
    /* 5D8C4 8006D0C4 21300000 */   addu      $a2, $zero, $zero
  .L8006D0C8:
    /* 5D8C8 8006D0C8 480002AE */  sw         $v0, 0x48($s0)
  .L8006D0CC:
    /* 5D8CC 8006D0CC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5D8D0 8006D0D0 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D8D4 8006D0D4 0800E003 */  jr         $ra
    /* 5D8D8 8006D0D8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Setup__14AIDataRecord_t
