.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_ResolveRotatedVector__FiiiPiT3, 0xC4

glabel Math_ResolveRotatedVector__FiiiPiT3
    /* 8DE28 8009D628 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8DE2C 8009D62C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8DE30 8009D630 21988000 */  addu       $s3, $a0, $zero
    /* 8DE34 8009D634 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8DE38 8009D638 21A0A000 */  addu       $s4, $a1, $zero
    /* 8DE3C 8009D63C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 8DE40 8009D640 21A8E000 */  addu       $s5, $a3, $zero
    /* 8DE44 8009D644 2800BFAF */  sw         $ra, 0x28($sp)
    /* 8DE48 8009D648 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8DE4C 8009D64C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8DE50 8009D650 0200C104 */  bgez       $a2, .L8009D65C
    /* 8DE54 8009D654 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8DE58 8009D658 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L8009D65C:
    /* 8DE5C 8009D65C 03820600 */  sra        $s0, $a2, 8
    /* 8DE60 8009D660 09B5030C */  jal        fixedsin
    /* 8DE64 8009D664 21200002 */   addu      $a0, $s0, $zero
    /* 8DE68 8009D668 21200002 */  addu       $a0, $s0, $zero
    /* 8DE6C 8009D66C 29B5030C */  jal        fixedcos
    /* 8DE70 8009D670 21884000 */   addu      $s1, $v0, $zero
    /* 8DE74 8009D674 21904000 */  addu       $s2, $v0, $zero
    /* 8DE78 8009D678 21204002 */  addu       $a0, $s2, $zero
    /* 8DE7C 8009D67C CA90030C */  jal        fixedmult
    /* 8DE80 8009D680 21286002 */   addu      $a1, $s3, $zero
    /* 8DE84 8009D684 21202002 */  addu       $a0, $s1, $zero
    /* 8DE88 8009D688 21288002 */  addu       $a1, $s4, $zero
    /* 8DE8C 8009D68C CA90030C */  jal        fixedmult
    /* 8DE90 8009D690 21804000 */   addu      $s0, $v0, $zero
    /* 8DE94 8009D694 21202002 */  addu       $a0, $s1, $zero
    /* 8DE98 8009D698 21286002 */  addu       $a1, $s3, $zero
    /* 8DE9C 8009D69C 23800202 */  subu       $s0, $s0, $v0
    /* 8DEA0 8009D6A0 CA90030C */  jal        fixedmult
    /* 8DEA4 8009D6A4 0000B0AE */   sw        $s0, 0x0($s5)
    /* 8DEA8 8009D6A8 21204002 */  addu       $a0, $s2, $zero
    /* 8DEAC 8009D6AC 21288002 */  addu       $a1, $s4, $zero
    /* 8DEB0 8009D6B0 CA90030C */  jal        fixedmult
    /* 8DEB4 8009D6B4 21804000 */   addu      $s0, $v0, $zero
    /* 8DEB8 8009D6B8 21800202 */  addu       $s0, $s0, $v0
    /* 8DEBC 8009D6BC 4000A28F */  lw         $v0, 0x40($sp)
    /* 8DEC0 8009D6C0 00000000 */  nop
    /* 8DEC4 8009D6C4 000050AC */  sw         $s0, 0x0($v0)
    /* 8DEC8 8009D6C8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 8DECC 8009D6CC 2400B58F */  lw         $s5, 0x24($sp)
    /* 8DED0 8009D6D0 2000B48F */  lw         $s4, 0x20($sp)
    /* 8DED4 8009D6D4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8DED8 8009D6D8 1800B28F */  lw         $s2, 0x18($sp)
    /* 8DEDC 8009D6DC 1400B18F */  lw         $s1, 0x14($sp)
    /* 8DEE0 8009D6E0 1000B08F */  lw         $s0, 0x10($sp)
    /* 8DEE4 8009D6E4 0800E003 */  jr         $ra
    /* 8DEE8 8009D6E8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Math_ResolveRotatedVector__FiiiPiT3
