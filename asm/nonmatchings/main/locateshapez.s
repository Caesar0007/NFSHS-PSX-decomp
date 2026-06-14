.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching locateshapez, 0x60

glabel locateshapez
    /* DB970 800EB170 0800838C */  lw         $v1, 0x8($a0)
    /* DB974 800EB174 0000A58C */  lw         $a1, 0x0($a1)
    /* DB978 800EB178 13006010 */  beqz       $v1, .L800EB1C8
    /* DB97C 800EB17C C0100300 */   sll       $v0, $v1, 3
    /* DB980 800EB180 21304400 */  addu       $a2, $v0, $a0
    /* DB984 800EB184 FFFF6324 */  addiu      $v1, $v1, -0x1
  .L800EB188:
    /* DB988 800EB188 06006010 */  beqz       $v1, .L800EB1A4
    /* DB98C 800EB18C F8FFC624 */   addiu     $a2, $a2, -0x8
    /* DB990 800EB190 1000C28C */  lw         $v0, 0x10($a2)
    /* DB994 800EB194 00000000 */  nop
    /* DB998 800EB198 FBFF4514 */  bne        $v0, $a1, .L800EB188
    /* DB99C 800EB19C FFFF6324 */   addiu     $v1, $v1, -0x1
    /* DB9A0 800EB1A0 01006324 */  addiu      $v1, $v1, 0x1
  .L800EB1A4:
    /* DB9A4 800EB1A4 C0100300 */  sll        $v0, $v1, 3
    /* DB9A8 800EB1A8 21184400 */  addu       $v1, $v0, $a0
    /* DB9AC 800EB1AC 1000628C */  lw         $v0, 0x10($v1)
    /* DB9B0 800EB1B0 00000000 */  nop
    /* DB9B4 800EB1B4 04004514 */  bne        $v0, $a1, .L800EB1C8
    /* DB9B8 800EB1B8 00000000 */   nop
    /* DB9BC 800EB1BC 1400628C */  lw         $v0, 0x14($v1)
    /* DB9C0 800EB1C0 0800E003 */  jr         $ra
    /* DB9C4 800EB1C4 21108200 */   addu      $v0, $a0, $v0
  .L800EB1C8:
    /* DB9C8 800EB1C8 0800E003 */  jr         $ra
    /* DB9CC 800EB1CC 21100000 */   addu      $v0, $zero, $zero
endlabel locateshapez
