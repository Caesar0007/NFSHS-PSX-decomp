.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching locateshape, 0x60

glabel locateshape
    /* DB910 800EB110 0800838C */  lw         $v1, 0x8($a0)
    /* DB914 800EB114 0000A58C */  lw         $a1, 0x0($a1)
    /* DB918 800EB118 13006010 */  beqz       $v1, .L800EB168
    /* DB91C 800EB11C C0100300 */   sll       $v0, $v1, 3
    /* DB920 800EB120 21304400 */  addu       $a2, $v0, $a0
    /* DB924 800EB124 FFFF6324 */  addiu      $v1, $v1, -0x1
  .L800EB128:
    /* DB928 800EB128 06006010 */  beqz       $v1, .L800EB144
    /* DB92C 800EB12C F8FFC624 */   addiu     $a2, $a2, -0x8
    /* DB930 800EB130 1000C28C */  lw         $v0, 0x10($a2)
    /* DB934 800EB134 00000000 */  nop
    /* DB938 800EB138 FBFF4514 */  bne        $v0, $a1, .L800EB128
    /* DB93C 800EB13C FFFF6324 */   addiu     $v1, $v1, -0x1
    /* DB940 800EB140 01006324 */  addiu      $v1, $v1, 0x1
  .L800EB144:
    /* DB944 800EB144 C0100300 */  sll        $v0, $v1, 3
    /* DB948 800EB148 21184400 */  addu       $v1, $v0, $a0
    /* DB94C 800EB14C 1000628C */  lw         $v0, 0x10($v1)
    /* DB950 800EB150 00000000 */  nop
    /* DB954 800EB154 04004514 */  bne        $v0, $a1, .L800EB168
    /* DB958 800EB158 00000000 */   nop
    /* DB95C 800EB15C 1400628C */  lw         $v0, 0x14($v1)
    /* DB960 800EB160 0800E003 */  jr         $ra
    /* DB964 800EB164 21108200 */   addu      $v0, $a0, $v0
  .L800EB168:
    /* DB968 800EB168 0800E003 */  jr         $ra
    /* DB96C 800EB16C 21100000 */   addu      $v0, $zero, $zero
endlabel locateshape
