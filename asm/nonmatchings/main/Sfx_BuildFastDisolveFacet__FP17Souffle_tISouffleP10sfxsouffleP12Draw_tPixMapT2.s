.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2, 0x70

glabel Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
    /* CDD28 800DD528 03008290 */  lbu        $v0, 0x3($a0)
    /* CDD2C 800DD52C 08000324 */  addiu      $v1, $zero, 0x8
    /* CDD30 800DD530 23186200 */  subu       $v1, $v1, $v0
    /* CDD34 800DD534 10006228 */  slti       $v0, $v1, 0x10
    /* CDD38 800DD538 02004014 */  bnez       $v0, .L800DD544
    /* CDD3C 800DD53C 00000000 */   nop
    /* CDD40 800DD540 0F000324 */  addiu      $v1, $zero, 0xF
  .L800DD544:
    /* CDD44 800DD544 0300C888 */  lwl        $t0, 0x3($a2)
    /* CDD48 800DD548 0000C898 */  lwr        $t0, 0x0($a2)
    /* CDD4C 800DD54C 0700C988 */  lwl        $t1, 0x7($a2)
    /* CDD50 800DD550 0400C998 */  lwr        $t1, 0x4($a2)
    /* CDD54 800DD554 0B00CA88 */  lwl        $t2, 0xB($a2)
    /* CDD58 800DD558 0800CA98 */  lwr        $t2, 0x8($a2)
    /* CDD5C 800DD55C 0F00CB88 */  lwl        $t3, 0xF($a2)
    /* CDD60 800DD560 0C00CB98 */  lwr        $t3, 0xC($a2)
    /* CDD64 800DD564 0300A8A8 */  swl        $t0, 0x3($a1)
    /* CDD68 800DD568 0000A8B8 */  swr        $t0, 0x0($a1)
    /* CDD6C 800DD56C 0700A9A8 */  swl        $t1, 0x7($a1)
    /* CDD70 800DD570 0400A9B8 */  swr        $t1, 0x4($a1)
    /* CDD74 800DD574 0B00AAA8 */  swl        $t2, 0xB($a1)
    /* CDD78 800DD578 0800AAB8 */  swr        $t2, 0x8($a1)
    /* CDD7C 800DD57C 0F00ABA8 */  swl        $t3, 0xF($a1)
    /* CDD80 800DD580 0C00ABB8 */  swr        $t3, 0xC($a1)
    /* CDD84 800DD584 0200E294 */  lhu        $v0, 0x2($a3)
    /* CDD88 800DD588 00000000 */  nop
    /* CDD8C 800DD58C 21104300 */  addu       $v0, $v0, $v1
    /* CDD90 800DD590 0800E003 */  jr         $ra
    /* CDD94 800DD594 0200A2A4 */   sh        $v0, 0x2($a1)
endlabel Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2
