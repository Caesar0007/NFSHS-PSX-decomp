.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii, 0x3D4

glabel Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
    /* CF398 800DEB98 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* CF39C 800DEB9C 2800B4AF */  sw         $s4, 0x28($sp)
    /* CF3A0 800DEBA0 4800B48F */  lw         $s4, 0x48($sp)
    /* CF3A4 800DEBA4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* CF3A8 800DEBA8 21888000 */  addu       $s1, $a0, $zero
    /* CF3AC 800DEBAC 2400B3AF */  sw         $s3, 0x24($sp)
    /* CF3B0 800DEBB0 2198A000 */  addu       $s3, $a1, $zero
    /* CF3B4 800DEBB4 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* CF3B8 800DEBB8 21A8C000 */  addu       $s5, $a2, $zero
    /* CF3BC 800DEBBC 2000B2AF */  sw         $s2, 0x20($sp)
    /* CF3C0 800DEBC0 3000BFAF */  sw         $ra, 0x30($sp)
    /* CF3C4 800DEBC4 1800B0AF */  sw         $s0, 0x18($sp)
    /* CF3C8 800DEBC8 1400228E */  lw         $v0, 0x14($s1)
    /* CF3CC 800DEBCC 4C00A68F */  lw         $a2, 0x4C($sp)
    /* CF3D0 800DEBD0 32004014 */  bnez       $v0, .L800DEC9C
    /* CF3D4 800DEBD4 2190E000 */   addu      $s2, $a3, $zero
    /* CF3D8 800DEBD8 21206002 */  addu       $a0, $s3, $zero
    /* CF3DC 800DEBDC 7B7A030C */  jal        Skidmark_CheckChunk__FP8coorddefii
    /* CF3E0 800DEBE0 02000524 */   addiu     $a1, $zero, 0x2
    /* CF3E4 800DEBE4 21804000 */  addu       $s0, $v0, $zero
    /* CF3E8 800DEBE8 21300002 */  addu       $a2, $s0, $zero
    /* CF3EC 800DEBEC 0C000286 */  lh         $v0, 0xC($s0)
    /* CF3F0 800DEBF0 21382002 */  addu       $a3, $s1, $zero
    /* CF3F4 800DEBF4 1000B3AF */  sw         $s3, 0x10($sp)
    /* CF3F8 800DEBF8 1400B2AF */  sw         $s2, 0x14($sp)
    /* CF3FC 800DEBFC C0280200 */  sll        $a1, $v0, 3
    /* CF400 800DEC00 2328A200 */  subu       $a1, $a1, $v0
    /* CF404 800DEC04 80280500 */  sll        $a1, $a1, 2
    /* CF408 800DEC08 1000A424 */  addiu      $a0, $a1, 0x10
    /* CF40C 800DEC0C 21200402 */  addu       $a0, $s0, $a0
    /* CF410 800DEC10 2C00A524 */  addiu      $a1, $a1, 0x2C
    /* CF414 800DEC14 BD79030C */  jal        CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
    /* CF418 800DEC18 21280502 */   addu      $a1, $s0, $a1
    /* CF41C 800DEC1C 0C000486 */  lh         $a0, 0xC($s0)
    /* CF420 800DEC20 00000000 */  nop
    /* CF424 800DEC24 01008224 */  addiu      $v0, $a0, 0x1
    /* CF428 800DEC28 C0180200 */  sll        $v1, $v0, 3
    /* CF42C 800DEC2C 23186200 */  subu       $v1, $v1, $v0
    /* CF430 800DEC30 80180300 */  sll        $v1, $v1, 2
    /* CF434 800DEC34 21180302 */  addu       $v1, $s0, $v1
    /* CF438 800DEC38 C0100400 */  sll        $v0, $a0, 3
    /* CF43C 800DEC3C 23104400 */  subu       $v0, $v0, $a0
    /* CF440 800DEC40 80100200 */  sll        $v0, $v0, 2
    /* CF444 800DEC44 21100202 */  addu       $v0, $s0, $v0
    /* CF448 800DEC48 0300A88A */  lwl        $t0, 0x3($s5)
    /* CF44C 800DEC4C 0000A89A */  lwr        $t0, 0x0($s5)
    /* CF450 800DEC50 00000000 */  nop
    /* CF454 800DEC54 230068A8 */  swl        $t0, 0x23($v1)
    /* CF458 800DEC58 200068B8 */  swr        $t0, 0x20($v1)
    /* CF45C 800DEC5C 23006888 */  lwl        $t0, 0x23($v1)
    /* CF460 800DEC60 20006898 */  lwr        $t0, 0x20($v1)
    /* CF464 800DEC64 00000000 */  nop
    /* CF468 800DEC68 230048A8 */  swl        $t0, 0x23($v0)
    /* CF46C 800DEC6C 200048B8 */  swr        $t0, 0x20($v0)
    /* CF470 800DEC70 0C000486 */  lh         $a0, 0xC($s0)
    /* CF474 800DEC74 00000000 */  nop
    /* CF478 800DEC78 01008324 */  addiu      $v1, $a0, 0x1
    /* CF47C 800DEC7C C0100300 */  sll        $v0, $v1, 3
    /* CF480 800DEC80 23104300 */  subu       $v0, $v0, $v1
    /* CF484 800DEC84 80100200 */  sll        $v0, $v0, 2
    /* CF488 800DEC88 21100202 */  addu       $v0, $s0, $v0
    /* CF48C 800DEC8C 240054AC */  sw         $s4, 0x24($v0)
    /* CF490 800DEC90 C0100400 */  sll        $v0, $a0, 3
    /* CF494 800DEC94 A57B0308 */  j          .L800DEE94
    /* CF498 800DEC98 23104400 */   subu      $v0, $v0, $a0
  .L800DEC9C:
    /* CF49C 800DEC9C 21206002 */  addu       $a0, $s3, $zero
    /* CF4A0 800DECA0 7B7A030C */  jal        Skidmark_CheckChunk__FP8coorddefii
    /* CF4A4 800DECA4 02000524 */   addiu     $a1, $zero, 0x2
    /* CF4A8 800DECA8 1800248E */  lw         $a0, 0x18($s1)
    /* CF4AC 800DECAC 8415838F */  lw         $v1, %gp_rel(gUseSm)($gp)
    /* CF4B0 800DECB0 00000000 */  nop
    /* CF4B4 800DECB4 46008314 */  bne        $a0, $v1, .L800DEDD0
    /* CF4B8 800DECB8 21804000 */   addu      $s0, $v0, $zero
    /* CF4BC 800DECBC 21280002 */  addu       $a1, $s0, $zero
    /* CF4C0 800DECC0 21302002 */  addu       $a2, $s1, $zero
    /* CF4C4 800DECC4 0C000286 */  lh         $v0, 0xC($s0)
    /* CF4C8 800DECC8 21386002 */  addu       $a3, $s3, $zero
    /* CF4CC 800DECCC 1000B2AF */  sw         $s2, 0x10($sp)
    /* CF4D0 800DECD0 C0200200 */  sll        $a0, $v0, 3
    /* CF4D4 800DECD4 23208200 */  subu       $a0, $a0, $v0
    /* CF4D8 800DECD8 80200400 */  sll        $a0, $a0, 2
    /* CF4DC 800DECDC 10008424 */  addiu      $a0, $a0, 0x10
    /* CF4E0 800DECE0 317A030C */  jal        CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
    /* CF4E4 800DECE4 21200402 */   addu      $a0, $s0, $a0
    /* CF4E8 800DECE8 0C000386 */  lh         $v1, 0xC($s0)
    /* CF4EC 800DECEC 00000000 */  nop
    /* CF4F0 800DECF0 C0100300 */  sll        $v0, $v1, 3
    /* CF4F4 800DECF4 23104300 */  subu       $v0, $v0, $v1
    /* CF4F8 800DECF8 80100200 */  sll        $v0, $v0, 2
    /* CF4FC 800DECFC 21100202 */  addu       $v0, $s0, $v0
    /* CF500 800DED00 0300A88A */  lwl        $t0, 0x3($s5)
    /* CF504 800DED04 0000A89A */  lwr        $t0, 0x0($s5)
    /* CF508 800DED08 00000000 */  nop
    /* CF50C 800DED0C 230048A8 */  swl        $t0, 0x23($v0)
    /* CF510 800DED10 200048B8 */  swr        $t0, 0x20($v0)
    /* CF514 800DED14 0C000386 */  lh         $v1, 0xC($s0)
    /* CF518 800DED18 00000000 */  nop
    /* CF51C 800DED1C C0100300 */  sll        $v0, $v1, 3
    /* CF520 800DED20 23104300 */  subu       $v0, $v0, $v1
    /* CF524 800DED24 80100200 */  sll        $v0, $v0, 2
    /* CF528 800DED28 21100202 */  addu       $v0, $s0, $v0
    /* CF52C 800DED2C 240054AC */  sw         $s4, 0x24($v0)
    /* CF530 800DED30 0C000386 */  lh         $v1, 0xC($s0)
    /* CF534 800DED34 00000000 */  nop
    /* CF538 800DED38 C0100300 */  sll        $v0, $v1, 3
    /* CF53C 800DED3C 23104300 */  subu       $v0, $v0, $v1
    /* CF540 800DED40 80100200 */  sll        $v0, $v0, 2
    /* CF544 800DED44 10004224 */  addiu      $v0, $v0, 0x10
    /* CF548 800DED48 1400238E */  lw         $v1, 0x14($s1)
    /* CF54C 800DED4C 21100202 */  addu       $v0, $s0, $v0
    /* CF550 800DED50 180062AC */  sw         $v0, 0x18($v1)
    /* CF554 800DED54 0C000386 */  lh         $v1, 0xC($s0)
    /* CF558 800DED58 00000000 */  nop
    /* CF55C 800DED5C C0100300 */  sll        $v0, $v1, 3
    /* CF560 800DED60 23104300 */  subu       $v0, $v0, $v1
    /* CF564 800DED64 80100200 */  sll        $v0, $v0, 2
    /* CF568 800DED68 21100202 */  addu       $v0, $s0, $v0
    /* CF56C 800DED6C 280040AC */  sw         $zero, 0x28($v0)
    /* CF570 800DED70 8415828F */  lw         $v0, %gp_rel(gUseSm)($gp)
    /* CF574 800DED74 0300A88A */  lwl        $t0, 0x3($s5)
    /* CF578 800DED78 0000A89A */  lwr        $t0, 0x0($s5)
    /* CF57C 800DED7C 00000000 */  nop
    /* CF580 800DED80 0F0028AA */  swl        $t0, 0xF($s1)
    /* CF584 800DED84 0C0028BA */  swr        $t0, 0xC($s1)
    /* CF588 800DED88 100034AE */  sw         $s4, 0x10($s1)
    /* CF58C 800DED8C 0000688E */  lw         $t0, 0x0($s3)
    /* CF590 800DED90 0400698E */  lw         $t1, 0x4($s3)
    /* CF594 800DED94 08006A8E */  lw         $t2, 0x8($s3)
    /* CF598 800DED98 000028AE */  sw         $t0, 0x0($s1)
    /* CF59C 800DED9C 040029AE */  sw         $t1, 0x4($s1)
    /* CF5A0 800DEDA0 08002AAE */  sw         $t2, 0x8($s1)
    /* CF5A4 800DEDA4 0C000386 */  lh         $v1, 0xC($s0)
    /* CF5A8 800DEDA8 180022AE */  sw         $v0, 0x18($s1)
    /* CF5AC 800DEDAC C0100300 */  sll        $v0, $v1, 3
    /* CF5B0 800DEDB0 23104300 */  subu       $v0, $v0, $v1
    /* CF5B4 800DEDB4 80100200 */  sll        $v0, $v0, 2
    /* CF5B8 800DEDB8 10004224 */  addiu      $v0, $v0, 0x10
    /* CF5BC 800DEDBC 21100202 */  addu       $v0, $s0, $v0
    /* CF5C0 800DEDC0 140022AE */  sw         $v0, 0x14($s1)
    /* CF5C4 800DEDC4 0C000296 */  lhu        $v0, 0xC($s0)
    /* CF5C8 800DEDC8 D17B0308 */  j          .L800DEF44
    /* CF5CC 800DEDCC 01004224 */   addiu     $v0, $v0, 0x1
  .L800DEDD0:
    /* CF5D0 800DEDD0 21300002 */  addu       $a2, $s0, $zero
    /* CF5D4 800DEDD4 0C000286 */  lh         $v0, 0xC($s0)
    /* CF5D8 800DEDD8 21382002 */  addu       $a3, $s1, $zero
    /* CF5DC 800DEDDC 1000B3AF */  sw         $s3, 0x10($sp)
    /* CF5E0 800DEDE0 1400B2AF */  sw         $s2, 0x14($sp)
    /* CF5E4 800DEDE4 C0280200 */  sll        $a1, $v0, 3
    /* CF5E8 800DEDE8 2328A200 */  subu       $a1, $a1, $v0
    /* CF5EC 800DEDEC 80280500 */  sll        $a1, $a1, 2
    /* CF5F0 800DEDF0 1000A424 */  addiu      $a0, $a1, 0x10
    /* CF5F4 800DEDF4 21200402 */  addu       $a0, $s0, $a0
    /* CF5F8 800DEDF8 2C00A524 */  addiu      $a1, $a1, 0x2C
    /* CF5FC 800DEDFC BD79030C */  jal        CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i
    /* CF600 800DEE00 21280502 */   addu      $a1, $s0, $a1
    /* CF604 800DEE04 0C000386 */  lh         $v1, 0xC($s0)
    /* CF608 800DEE08 00000000 */  nop
    /* CF60C 800DEE0C C0100300 */  sll        $v0, $v1, 3
    /* CF610 800DEE10 23104300 */  subu       $v0, $v0, $v1
    /* CF614 800DEE14 80100200 */  sll        $v0, $v0, 2
    /* CF618 800DEE18 21100202 */  addu       $v0, $s0, $v0
    /* CF61C 800DEE1C 0F00288A */  lwl        $t0, 0xF($s1)
    /* CF620 800DEE20 0C00289A */  lwr        $t0, 0xC($s1)
    /* CF624 800DEE24 00000000 */  nop
    /* CF628 800DEE28 230048A8 */  swl        $t0, 0x23($v0)
    /* CF62C 800DEE2C 200048B8 */  swr        $t0, 0x20($v0)
    /* CF630 800DEE30 0C000386 */  lh         $v1, 0xC($s0)
    /* CF634 800DEE34 00000000 */  nop
    /* CF638 800DEE38 C0100300 */  sll        $v0, $v1, 3
    /* CF63C 800DEE3C 23104300 */  subu       $v0, $v0, $v1
    /* CF640 800DEE40 80100200 */  sll        $v0, $v0, 2
    /* CF644 800DEE44 1000238E */  lw         $v1, 0x10($s1)
    /* CF648 800DEE48 21100202 */  addu       $v0, $s0, $v0
    /* CF64C 800DEE4C 240043AC */  sw         $v1, 0x24($v0)
    /* CF650 800DEE50 0C000386 */  lh         $v1, 0xC($s0)
    /* CF654 800DEE54 00000000 */  nop
    /* CF658 800DEE58 01006324 */  addiu      $v1, $v1, 0x1
    /* CF65C 800DEE5C C0100300 */  sll        $v0, $v1, 3
    /* CF660 800DEE60 23104300 */  subu       $v0, $v0, $v1
    /* CF664 800DEE64 80100200 */  sll        $v0, $v0, 2
    /* CF668 800DEE68 21100202 */  addu       $v0, $s0, $v0
    /* CF66C 800DEE6C 0300A88A */  lwl        $t0, 0x3($s5)
    /* CF670 800DEE70 0000A89A */  lwr        $t0, 0x0($s5)
    /* CF674 800DEE74 00000000 */  nop
    /* CF678 800DEE78 230048A8 */  swl        $t0, 0x23($v0)
    /* CF67C 800DEE7C 200048B8 */  swr        $t0, 0x20($v0)
    /* CF680 800DEE80 0C000386 */  lh         $v1, 0xC($s0)
    /* CF684 800DEE84 00000000 */  nop
    /* CF688 800DEE88 01006324 */  addiu      $v1, $v1, 0x1
    /* CF68C 800DEE8C C0100300 */  sll        $v0, $v1, 3
    /* CF690 800DEE90 23104300 */  subu       $v0, $v0, $v1
  .L800DEE94:
    /* CF694 800DEE94 80100200 */  sll        $v0, $v0, 2
    /* CF698 800DEE98 21100202 */  addu       $v0, $s0, $v0
    /* CF69C 800DEE9C 240054AC */  sw         $s4, 0x24($v0)
    /* CF6A0 800DEEA0 0C000386 */  lh         $v1, 0xC($s0)
    /* CF6A4 800DEEA4 00000000 */  nop
    /* CF6A8 800DEEA8 C0100300 */  sll        $v0, $v1, 3
    /* CF6AC 800DEEAC 23104300 */  subu       $v0, $v0, $v1
    /* CF6B0 800DEEB0 80100200 */  sll        $v0, $v0, 2
    /* CF6B4 800DEEB4 21180202 */  addu       $v1, $s0, $v0
    /* CF6B8 800DEEB8 2C004224 */  addiu      $v0, $v0, 0x2C
    /* CF6BC 800DEEBC 21100202 */  addu       $v0, $s0, $v0
    /* CF6C0 800DEEC0 280062AC */  sw         $v0, 0x28($v1)
    /* CF6C4 800DEEC4 0C000386 */  lh         $v1, 0xC($s0)
    /* CF6C8 800DEEC8 00000000 */  nop
    /* CF6CC 800DEECC 01006324 */  addiu      $v1, $v1, 0x1
    /* CF6D0 800DEED0 C0100300 */  sll        $v0, $v1, 3
    /* CF6D4 800DEED4 23104300 */  subu       $v0, $v0, $v1
    /* CF6D8 800DEED8 80100200 */  sll        $v0, $v0, 2
    /* CF6DC 800DEEDC 21100202 */  addu       $v0, $s0, $v0
    /* CF6E0 800DEEE0 280040AC */  sw         $zero, 0x28($v0)
    /* CF6E4 800DEEE4 8415828F */  lw         $v0, %gp_rel(gUseSm)($gp)
    /* CF6E8 800DEEE8 0300A88A */  lwl        $t0, 0x3($s5)
    /* CF6EC 800DEEEC 0000A89A */  lwr        $t0, 0x0($s5)
    /* CF6F0 800DEEF0 00000000 */  nop
    /* CF6F4 800DEEF4 0F0028AA */  swl        $t0, 0xF($s1)
    /* CF6F8 800DEEF8 0C0028BA */  swr        $t0, 0xC($s1)
    /* CF6FC 800DEEFC 100034AE */  sw         $s4, 0x10($s1)
    /* CF700 800DEF00 0000688E */  lw         $t0, 0x0($s3)
    /* CF704 800DEF04 0400698E */  lw         $t1, 0x4($s3)
    /* CF708 800DEF08 08006A8E */  lw         $t2, 0x8($s3)
    /* CF70C 800DEF0C 000028AE */  sw         $t0, 0x0($s1)
    /* CF710 800DEF10 040029AE */  sw         $t1, 0x4($s1)
    /* CF714 800DEF14 08002AAE */  sw         $t2, 0x8($s1)
    /* CF718 800DEF18 0C000386 */  lh         $v1, 0xC($s0)
    /* CF71C 800DEF1C 180022AE */  sw         $v0, 0x18($s1)
    /* CF720 800DEF20 C0100300 */  sll        $v0, $v1, 3
    /* CF724 800DEF24 23104300 */  subu       $v0, $v0, $v1
    /* CF728 800DEF28 80100200 */  sll        $v0, $v0, 2
    /* CF72C 800DEF2C 2C004224 */  addiu      $v0, $v0, 0x2C
    /* CF730 800DEF30 21100202 */  addu       $v0, $s0, $v0
    /* CF734 800DEF34 140022AE */  sw         $v0, 0x14($s1)
    /* CF738 800DEF38 0C000296 */  lhu        $v0, 0xC($s0)
    /* CF73C 800DEF3C 00000000 */  nop
    /* CF740 800DEF40 02004224 */  addiu      $v0, $v0, 0x2
  .L800DEF44:
    /* CF744 800DEF44 0C0002A6 */  sh         $v0, 0xC($s0)
    /* CF748 800DEF48 3000BF8F */  lw         $ra, 0x30($sp)
    /* CF74C 800DEF4C 2C00B58F */  lw         $s5, 0x2C($sp)
    /* CF750 800DEF50 2800B48F */  lw         $s4, 0x28($sp)
    /* CF754 800DEF54 2400B38F */  lw         $s3, 0x24($sp)
    /* CF758 800DEF58 2000B28F */  lw         $s2, 0x20($sp)
    /* CF75C 800DEF5C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* CF760 800DEF60 1800B08F */  lw         $s0, 0x18($sp)
    /* CF764 800DEF64 0800E003 */  jr         $ra
    /* CF768 800DEF68 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii
