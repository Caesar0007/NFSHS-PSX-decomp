.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VectorNormalSS, 0x30

glabel VectorNormalSS
    /* E230C 800F1B0C 00008884 */  lh         $t0, 0x0($a0)
    /* E2310 800F1B10 02008984 */  lh         $t1, 0x2($a0)
    /* E2314 800F1B14 04008A84 */  lh         $t2, 0x4($a0)
  .L800F1B18:
    /* E2318 800F1B18 2138E003 */  addu       $a3, $ra, $zero
    /* E231C 800F1B1C CFC6030C */  jal        func_800F1B3C
    /* E2320 800F1B20 00000000 */   nop
    /* E2324 800F1B24 0000A8A4 */  sh         $t0, 0x0($a1)
    /* E2328 800F1B28 0200A9A4 */  sh         $t1, 0x2($a1)
    /* E232C 800F1B2C 0400AAA4 */  sh         $t2, 0x4($a1)
    /* E2330 800F1B30 21F8E000 */  addu       $ra, $a3, $zero
    /* E2334 800F1B34 0800E003 */  jr         $ra
    /* E2338 800F1B38 00000000 */   nop
endlabel VectorNormalSS
