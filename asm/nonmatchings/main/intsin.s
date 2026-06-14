.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching intsin, 0x68

glabel intsin
    /* E20E8 800F18E8 13800C3C */  lui        $t4, %hi(sintbl)
    /* E20EC 800F18EC 64748C25 */  addiu      $t4, $t4, %lo(sintbl)
    /* E20F0 800F18F0 00028930 */  andi       $t1, $a0, 0x200
    /* E20F4 800F18F4 00018A30 */  andi       $t2, $a0, 0x100
    /* E20F8 800F18F8 0B002015 */  bnez       $t1, .L800F1928
    /* E20FC 800F18FC FF008830 */   andi      $t0, $a0, 0xFF
    /* E2100 800F1900 05004015 */  bnez       $t2, .L800F1918
    /* E2104 800F1904 80580800 */   sll       $t3, $t0, 2
    /* E2108 800F1908 21688B01 */  addu       $t5, $t4, $t3
    /* E210C 800F190C 0000A28D */  lw         $v0, 0x0($t5)
    /* E2110 800F1910 0800E003 */  jr         $ra
    /* E2114 800F1914 00000000 */   nop
  .L800F1918:
    /* E2118 800F1918 23688B01 */  subu       $t5, $t4, $t3
    /* E211C 800F191C 0004A28D */  lw         $v0, 0x400($t5)
    /* E2120 800F1920 0800E003 */  jr         $ra
    /* E2124 800F1924 00000000 */   nop
  .L800F1928:
    /* E2128 800F1928 05004015 */  bnez       $t2, .L800F1940
    /* E212C 800F192C 80580800 */   sll       $t3, $t0, 2
    /* E2130 800F1930 21688B01 */  addu       $t5, $t4, $t3
    /* E2134 800F1934 0000A28D */  lw         $v0, 0x0($t5)
    /* E2138 800F1938 0800E003 */  jr         $ra
    /* E213C 800F193C 23100200 */   negu      $v0, $v0
  .L800F1940:
    /* E2140 800F1940 23688B01 */  subu       $t5, $t4, $t3
    /* E2144 800F1944 0004A28D */  lw         $v0, 0x400($t5)
    /* E2148 800F1948 0800E003 */  jr         $ra
    /* E214C 800F194C 23100200 */   negu      $v0, $v0
endlabel intsin
