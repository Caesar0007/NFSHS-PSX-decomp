.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ReduceObjectPrecision__FP5GroupT0i, 0xA0

glabel ReduceObjectPrecision__FP5GroupT0i
    /* AAA5C 800BA25C 25008010 */  beqz       $a0, .L800BA2F4
    /* AAA60 800BA260 04008A24 */   addiu     $t2, $a0, 0x4
    /* AAA64 800BA264 FFFF0C24 */  addiu      $t4, $zero, -0x1
    /* AAA68 800BA268 00008B8C */  lw         $t3, 0x0($a0)
    /* AAA6C 800BA26C 880F8D8F */  lw         $t5, %gp_rel(Track_gObjDefs)($gp)
  .L800BA270:
    /* AAA70 800BA270 FFFF6B25 */  addiu      $t3, $t3, -0x1
    /* AAA74 800BA274 1F006C11 */  beq        $t3, $t4, .L800BA2F4
    /* AAA78 800BA278 00000000 */   nop
    /* AAA7C 800BA27C 1A00A010 */  beqz       $a1, .L800BA2E8
    /* AAA80 800BA280 00000000 */   nop
    /* AAA84 800BA284 06004285 */  lh         $v0, 0x6($t2)
    /* AAA88 800BA288 00000000 */  nop
    /* AAA8C 800BA28C 80100200 */  sll        $v0, $v0, 2
    /* AAA90 800BA290 21104D00 */  addu       $v0, $v0, $t5
    /* AAA94 800BA294 0000428C */  lw         $v0, 0x0($v0)
    /* AAA98 800BA298 00000000 */  nop
    /* AAA9C 800BA29C 04004824 */  addiu      $t0, $v0, 0x4
    /* AAAA0 800BA2A0 08004724 */  addiu      $a3, $v0, 0x8
    /* AAAA4 800BA2A4 02004990 */  lbu        $t1, 0x2($v0)
  .L800BA2A8:
    /* AAAA8 800BA2A8 00000000 */  nop
    /* AAAAC 800BA2AC FFFF2925 */  addiu      $t1, $t1, -0x1
    /* AAAB0 800BA2B0 0D002C11 */  beq        $t1, $t4, .L800BA2E8
    /* AAAB4 800BA2B4 00000000 */   nop
    /* AAAB8 800BA2B8 00000285 */  lh         $v0, 0x0($t0)
    /* AAABC 800BA2BC FEFFE384 */  lh         $v1, -0x2($a3)
    /* AAAC0 800BA2C0 0000E484 */  lh         $a0, 0x0($a3)
    /* AAAC4 800BA2C4 0710C200 */  srav       $v0, $v0, $a2
    /* AAAC8 800BA2C8 0718C300 */  srav       $v1, $v1, $a2
    /* AAACC 800BA2CC 0720C400 */  srav       $a0, $a0, $a2
    /* AAAD0 800BA2D0 000002A5 */  sh         $v0, 0x0($t0)
    /* AAAD4 800BA2D4 FEFFE3A4 */  sh         $v1, -0x2($a3)
    /* AAAD8 800BA2D8 0000E4A4 */  sh         $a0, 0x0($a3)
    /* AAADC 800BA2DC 0800E724 */  addiu      $a3, $a3, 0x8
    /* AAAE0 800BA2E0 AAE80208 */  j          .L800BA2A8
    /* AAAE4 800BA2E4 08000825 */   addiu     $t0, $t0, 0x8
  .L800BA2E8:
    /* AAAE8 800BA2E8 00004285 */  lh         $v0, 0x0($t2)
    /* AAAEC 800BA2EC 9CE80208 */  j          .L800BA270
    /* AAAF0 800BA2F0 21504201 */   addu      $t2, $t2, $v0
  .L800BA2F4:
    /* AAAF4 800BA2F4 0800E003 */  jr         $ra
    /* AAAF8 800BA2F8 00000000 */   nop
endlabel ReduceObjectPrecision__FP5GroupT0i
