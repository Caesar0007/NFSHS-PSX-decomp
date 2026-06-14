.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_Dist3D__FP8coorddefT0, 0x90

glabel Math_Dist3D__FP8coorddefT0
    /* 8DC38 8009D438 0000838C */  lw         $v1, 0x0($a0)
    /* 8DC3C 8009D43C 0000A28C */  lw         $v0, 0x0($a1)
    /* 8DC40 8009D440 00000000 */  nop
    /* 8DC44 8009D444 23386200 */  subu       $a3, $v1, $v0
    /* 8DC48 8009D448 0200E01C */  bgtz       $a3, .L8009D454
    /* 8DC4C 8009D44C 00000000 */   nop
    /* 8DC50 8009D450 23384300 */  subu       $a3, $v0, $v1
  .L8009D454:
    /* 8DC54 8009D454 0400868C */  lw         $a2, 0x4($a0)
    /* 8DC58 8009D458 0400A28C */  lw         $v0, 0x4($a1)
    /* 8DC5C 8009D45C 00000000 */  nop
    /* 8DC60 8009D460 2318C200 */  subu       $v1, $a2, $v0
    /* 8DC64 8009D464 0200601C */  bgtz       $v1, .L8009D470
    /* 8DC68 8009D468 00000000 */   nop
    /* 8DC6C 8009D46C 23184600 */  subu       $v1, $v0, $a2
  .L8009D470:
    /* 8DC70 8009D470 0800848C */  lw         $a0, 0x8($a0)
    /* 8DC74 8009D474 0800A58C */  lw         $a1, 0x8($a1)
    /* 8DC78 8009D478 00000000 */  nop
    /* 8DC7C 8009D47C 23308500 */  subu       $a2, $a0, $a1
    /* 8DC80 8009D480 0200C01C */  bgtz       $a2, .L8009D48C
    /* 8DC84 8009D484 2A106700 */   slt       $v0, $v1, $a3
    /* 8DC88 8009D488 2330A400 */  subu       $a2, $a1, $a0
  .L8009D48C:
    /* 8DC8C 8009D48C 03004010 */  beqz       $v0, .L8009D49C
    /* 8DC90 8009D490 83100300 */   sra       $v0, $v1, 2
    /* 8DC94 8009D494 29750208 */  j          .L8009D4A4
    /* 8DC98 8009D498 2118E200 */   addu      $v1, $a3, $v0
  .L8009D49C:
    /* 8DC9C 8009D49C 83100700 */  sra        $v0, $a3, 2
    /* 8DCA0 8009D4A0 21186200 */  addu       $v1, $v1, $v0
  .L8009D4A4:
    /* 8DCA4 8009D4A4 2A10C300 */  slt        $v0, $a2, $v1
    /* 8DCA8 8009D4A8 04004010 */  beqz       $v0, .L8009D4BC
    /* 8DCAC 8009D4AC 00000000 */   nop
    /* 8DCB0 8009D4B0 83100600 */  sra        $v0, $a2, 2
    /* 8DCB4 8009D4B4 0800E003 */  jr         $ra
    /* 8DCB8 8009D4B8 21106200 */   addu      $v0, $v1, $v0
  .L8009D4BC:
    /* 8DCBC 8009D4BC 83100300 */  sra        $v0, $v1, 2
    /* 8DCC0 8009D4C0 0800E003 */  jr         $ra
    /* 8DCC4 8009D4C4 2110C200 */   addu      $v0, $a2, $v0
endlabel Math_Dist3D__FP8coorddefT0
