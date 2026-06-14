.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_DistXZ__FP8coorddefT0, 0x54

glabel Math_DistXZ__FP8coorddefT0
    /* 8DBE4 8009D3E4 0000838C */  lw         $v1, 0x0($a0)
    /* 8DBE8 8009D3E8 0000A28C */  lw         $v0, 0x0($a1)
    /* 8DBEC 8009D3EC 0800878C */  lw         $a3, 0x8($a0)
    /* 8DBF0 8009D3F0 0800A48C */  lw         $a0, 0x8($a1)
    /* 8DBF4 8009D3F4 23306200 */  subu       $a2, $v1, $v0
    /* 8DBF8 8009D3F8 0200C01C */  bgtz       $a2, .L8009D404
    /* 8DBFC 8009D3FC 00000000 */   nop
    /* 8DC00 8009D400 23304300 */  subu       $a2, $v0, $v1
  .L8009D404:
    /* 8DC04 8009D404 2318E400 */  subu       $v1, $a3, $a0
    /* 8DC08 8009D408 0300601C */  bgtz       $v1, .L8009D418
    /* 8DC0C 8009D40C 2A106600 */   slt       $v0, $v1, $a2
    /* 8DC10 8009D410 23188700 */  subu       $v1, $a0, $a3
    /* 8DC14 8009D414 2A106600 */  slt        $v0, $v1, $a2
  .L8009D418:
    /* 8DC18 8009D418 04004010 */  beqz       $v0, .L8009D42C
    /* 8DC1C 8009D41C 00000000 */   nop
    /* 8DC20 8009D420 83100300 */  sra        $v0, $v1, 2
    /* 8DC24 8009D424 0800E003 */  jr         $ra
    /* 8DC28 8009D428 2110C200 */   addu      $v0, $a2, $v0
  .L8009D42C:
    /* 8DC2C 8009D42C 83100600 */  sra        $v0, $a2, 2
    /* 8DC30 8009D430 0800E003 */  jr         $ra
    /* 8DC34 8009D434 21106200 */   addu      $v0, $v1, $v0
endlabel Math_DistXZ__FP8coorddefT0
