.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Stats_ClearPosition__Fv, 0x40

glabel Stats_ClearPosition__Fv
    /* A8914 800B8114 21200000 */  addu       $a0, $zero, $zero
    /* A8918 800B8118 FFFF0624 */  addiu      $a2, $zero, -0x1
    /* A891C 800B811C FEFF053C */  lui        $a1, (0xFFFE7961 >> 16)
    /* A8920 800B8120 6179A534 */  ori        $a1, $a1, (0xFFFE7961 & 0xFFFF)
    /* A8924 800B8124 1280023C */  lui        $v0, %hi(Stats_racePosition)
    /* A8928 800B8128 E0E04324 */  addiu      $v1, $v0, %lo(Stats_racePosition)
  .L800B812C:
    /* A892C 800B812C 000066AC */  sw         $a2, 0x0($v1)
    /* A8930 800B8130 040065AC */  sw         $a1, 0x4($v1)
    /* A8934 800B8134 080060AC */  sw         $zero, 0x8($v1)
    /* A8938 800B8138 0C0060AC */  sw         $zero, 0xC($v1)
    /* A893C 800B813C 01008424 */  addiu      $a0, $a0, 0x1
    /* A8940 800B8140 06008228 */  slti       $v0, $a0, 0x6
    /* A8944 800B8144 F9FF4014 */  bnez       $v0, .L800B812C
    /* A8948 800B8148 10006324 */   addiu     $v1, $v1, 0x10
    /* A894C 800B814C 0800E003 */  jr         $ra
    /* A8950 800B8150 00000000 */   nop
endlabel Stats_ClearPosition__Fv
