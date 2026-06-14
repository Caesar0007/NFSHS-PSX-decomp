.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InvalidatePersistentCollideBoomObjects__FP5GroupT0, 0x6C

glabel InvalidatePersistentCollideBoomObjects__FP5GroupT0
    /* AAAFC 800BA2FC 18008010 */  beqz       $a0, .L800BA360
    /* AAB00 800BA300 00000000 */   nop
    /* AAB04 800BA304 1600A010 */  beqz       $a1, .L800BA360
    /* AAB08 800BA308 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* AAB0C 800BA30C 0000858C */  lw         $a1, 0x0($a0)
    /* AAB10 800BA310 00000000 */  nop
    /* AAB14 800BA314 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* AAB18 800BA318 1100A210 */  beq        $a1, $v0, .L800BA360
    /* AAB1C 800BA31C 04008424 */   addiu     $a0, $a0, 0x4
    /* AAB20 800BA320 21304000 */  addu       $a2, $v0, $zero
  .L800BA324:
    /* AAB24 800BA324 06008284 */  lh         $v0, 0x6($a0)
    /* AAB28 800BA328 880F838F */  lw         $v1, %gp_rel(Track_gObjDefs)($gp)
    /* AAB2C 800BA32C 80100200 */  sll        $v0, $v0, 2
    /* AAB30 800BA330 21104300 */  addu       $v0, $v0, $v1
    /* AAB34 800BA334 0000428C */  lw         $v0, 0x0($v0)
    /* AAB38 800BA338 00000000 */  nop
    /* AAB3C 800BA33C 00004284 */  lh         $v0, 0x0($v0)
    /* AAB40 800BA340 00000000 */  nop
    /* AAB44 800BA344 02004610 */  beq        $v0, $a2, .L800BA350
    /* AAB48 800BA348 00000000 */   nop
    /* AAB4C 800BA34C 020080A0 */  sb         $zero, 0x2($a0)
  .L800BA350:
    /* AAB50 800BA350 00008284 */  lh         $v0, 0x0($a0)
    /* AAB54 800BA354 FFFFA524 */  addiu      $a1, $a1, -0x1
    /* AAB58 800BA358 F2FFA614 */  bne        $a1, $a2, .L800BA324
    /* AAB5C 800BA35C 21208200 */   addu      $a0, $a0, $v0
  .L800BA360:
    /* AAB60 800BA360 0800E003 */  jr         $ra
    /* AAB64 800BA364 00000000 */   nop
endlabel InvalidatePersistentCollideBoomObjects__FP5GroupT0
