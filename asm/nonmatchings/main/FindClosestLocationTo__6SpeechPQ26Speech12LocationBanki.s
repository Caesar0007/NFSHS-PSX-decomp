.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki, 0xD8

glabel FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki
    /* 85100 80094900 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 85104 80094904 2000B4AF */  sw         $s4, 0x20($sp)
    /* 85108 80094908 21A08000 */  addu       $s4, $a0, $zero
    /* 8510C 8009490C 2800B6AF */  sw         $s6, 0x28($sp)
    /* 85110 80094910 21B0A000 */  addu       $s6, $a1, $zero
    /* 85114 80094914 3000BFAF */  sw         $ra, 0x30($sp)
    /* 85118 80094918 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 8511C 8009491C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 85120 80094920 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 85124 80094924 1800B2AF */  sw         $s2, 0x18($sp)
    /* 85128 80094928 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8512C 8009492C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 85130 80094930 6003828E */  lw         $v0, 0x360($s4)
    /* 85134 80094934 00000000 */  nop
    /* 85138 80094938 1B004010 */  beqz       $v0, .L800949A8
    /* 8513C 8009493C 21B8C000 */   addu      $s7, $a2, $zero
    /* 85140 80094940 21980000 */  addu       $s3, $zero, $zero
    /* 85144 80094944 10271224 */  addiu      $s2, $zero, 0x2710
    /* 85148 80094948 21886002 */  addu       $s1, $s3, $zero
    /* 8514C 8009494C FFFF1524 */  addiu      $s5, $zero, -0x1
  .L80094950:
    /* 85150 80094950 6003828E */  lw         $v0, 0x360($s4)
    /* 85154 80094954 00000000 */  nop
    /* 85158 80094958 2A102202 */  slt        $v0, $s1, $v0
    /* 8515C 8009495C 10004010 */  beqz       $v0, .L800949A0
    /* 85160 80094960 00111100 */   sll       $v0, $s1, 4
    /* 85164 80094964 2180C202 */  addu       $s0, $s6, $v0
    /* 85168 80094968 0800028E */  lw         $v0, 0x8($s0)
    /* 8516C 8009496C 00000000 */  nop
    /* 85170 80094970 09005510 */  beq        $v0, $s5, .L80094998
    /* 85174 80094974 21200002 */   addu      $a0, $s0, $zero
    /* 85178 80094978 1B52020C */  jal        Distance__Q26Speech12LocationBanki
    /* 8517C 8009497C 2128E002 */   addu      $a1, $s7, $zero
    /* 85180 80094980 21184000 */  addu       $v1, $v0, $zero
    /* 85184 80094984 2A107200 */  slt        $v0, $v1, $s2
    /* 85188 80094988 03004010 */  beqz       $v0, .L80094998
    /* 8518C 8009498C 00000000 */   nop
    /* 85190 80094990 21906000 */  addu       $s2, $v1, $zero
    /* 85194 80094994 21980002 */  addu       $s3, $s0, $zero
  .L80094998:
    /* 85198 80094998 54520208 */  j          .L80094950
    /* 8519C 8009499C 01003126 */   addiu     $s1, $s1, 0x1
  .L800949A0:
    /* 851A0 800949A0 6B520208 */  j          .L800949AC
    /* 851A4 800949A4 21106002 */   addu      $v0, $s3, $zero
  .L800949A8:
    /* 851A8 800949A8 21100000 */  addu       $v0, $zero, $zero
  .L800949AC:
    /* 851AC 800949AC 3000BF8F */  lw         $ra, 0x30($sp)
    /* 851B0 800949B0 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 851B4 800949B4 2800B68F */  lw         $s6, 0x28($sp)
    /* 851B8 800949B8 2400B58F */  lw         $s5, 0x24($sp)
    /* 851BC 800949BC 2000B48F */  lw         $s4, 0x20($sp)
    /* 851C0 800949C0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 851C4 800949C4 1800B28F */  lw         $s2, 0x18($sp)
    /* 851C8 800949C8 1400B18F */  lw         $s1, 0x14($sp)
    /* 851CC 800949CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 851D0 800949D0 0800E003 */  jr         $ra
    /* 851D4 800949D4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki
