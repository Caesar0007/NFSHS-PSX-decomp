.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching transform, 0x110

glabel transform
    /* DB6D8 800EAED8 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* DB6DC 800EAEDC 2800B2AF */  sw         $s2, 0x28($sp)
    /* DB6E0 800EAEE0 21908000 */  addu       $s2, $a0, $zero
    /* DB6E4 800EAEE4 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* DB6E8 800EAEE8 2198A000 */  addu       $s3, $a1, $zero
    /* DB6EC 800EAEEC 3400BFAF */  sw         $ra, 0x34($sp)
    /* DB6F0 800EAEF0 3000B4AF */  sw         $s4, 0x30($sp)
    /* DB6F4 800EAEF4 2400B1AF */  sw         $s1, 0x24($sp)
    /* DB6F8 800EAEF8 2000B0AF */  sw         $s0, 0x20($sp)
    /* DB6FC 800EAEFC 0000448E */  lw         $a0, 0x0($s2)
    /* DB700 800EAF00 0000658E */  lw         $a1, 0x0($s3)
    /* DB704 800EAF04 CA90030C */  jal        fixedmult
    /* DB708 800EAF08 21A0C000 */   addu      $s4, $a2, $zero
    /* DB70C 800EAF0C 0400448E */  lw         $a0, 0x4($s2)
    /* DB710 800EAF10 0C00658E */  lw         $a1, 0xC($s3)
    /* DB714 800EAF14 CA90030C */  jal        fixedmult
    /* DB718 800EAF18 21804000 */   addu      $s0, $v0, $zero
    /* DB71C 800EAF1C 0800448E */  lw         $a0, 0x8($s2)
    /* DB720 800EAF20 1800658E */  lw         $a1, 0x18($s3)
    /* DB724 800EAF24 CA90030C */  jal        fixedmult
    /* DB728 800EAF28 21884000 */   addu      $s1, $v0, $zero
    /* DB72C 800EAF2C 21801102 */  addu       $s0, $s0, $s1
    /* DB730 800EAF30 21800202 */  addu       $s0, $s0, $v0
    /* DB734 800EAF34 1000B0AF */  sw         $s0, 0x10($sp)
    /* DB738 800EAF38 0000448E */  lw         $a0, 0x0($s2)
    /* DB73C 800EAF3C 0400658E */  lw         $a1, 0x4($s3)
    /* DB740 800EAF40 CA90030C */  jal        fixedmult
    /* DB744 800EAF44 00000000 */   nop
    /* DB748 800EAF48 0400448E */  lw         $a0, 0x4($s2)
    /* DB74C 800EAF4C 1000658E */  lw         $a1, 0x10($s3)
    /* DB750 800EAF50 CA90030C */  jal        fixedmult
    /* DB754 800EAF54 21804000 */   addu      $s0, $v0, $zero
    /* DB758 800EAF58 0800448E */  lw         $a0, 0x8($s2)
    /* DB75C 800EAF5C 1C00658E */  lw         $a1, 0x1C($s3)
    /* DB760 800EAF60 CA90030C */  jal        fixedmult
    /* DB764 800EAF64 21884000 */   addu      $s1, $v0, $zero
    /* DB768 800EAF68 21801102 */  addu       $s0, $s0, $s1
    /* DB76C 800EAF6C 21800202 */  addu       $s0, $s0, $v0
    /* DB770 800EAF70 1400B0AF */  sw         $s0, 0x14($sp)
    /* DB774 800EAF74 0000448E */  lw         $a0, 0x0($s2)
    /* DB778 800EAF78 0800658E */  lw         $a1, 0x8($s3)
    /* DB77C 800EAF7C CA90030C */  jal        fixedmult
    /* DB780 800EAF80 00000000 */   nop
    /* DB784 800EAF84 0400448E */  lw         $a0, 0x4($s2)
    /* DB788 800EAF88 1400658E */  lw         $a1, 0x14($s3)
    /* DB78C 800EAF8C CA90030C */  jal        fixedmult
    /* DB790 800EAF90 21804000 */   addu      $s0, $v0, $zero
    /* DB794 800EAF94 0800448E */  lw         $a0, 0x8($s2)
    /* DB798 800EAF98 2000658E */  lw         $a1, 0x20($s3)
    /* DB79C 800EAF9C CA90030C */  jal        fixedmult
    /* DB7A0 800EAFA0 21884000 */   addu      $s1, $v0, $zero
    /* DB7A4 800EAFA4 21801102 */  addu       $s0, $s0, $s1
    /* DB7A8 800EAFA8 21800202 */  addu       $s0, $s0, $v0
    /* DB7AC 800EAFAC 1800B0AF */  sw         $s0, 0x18($sp)
    /* DB7B0 800EAFB0 1000A38F */  lw         $v1, 0x10($sp)
    /* DB7B4 800EAFB4 1400A78F */  lw         $a3, 0x14($sp)
    /* DB7B8 800EAFB8 1800A88F */  lw         $t0, 0x18($sp)
    /* DB7BC 800EAFBC 000083AE */  sw         $v1, 0x0($s4)
    /* DB7C0 800EAFC0 040087AE */  sw         $a3, 0x4($s4)
    /* DB7C4 800EAFC4 080088AE */  sw         $t0, 0x8($s4)
    /* DB7C8 800EAFC8 3400BF8F */  lw         $ra, 0x34($sp)
    /* DB7CC 800EAFCC 3000B48F */  lw         $s4, 0x30($sp)
    /* DB7D0 800EAFD0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* DB7D4 800EAFD4 2800B28F */  lw         $s2, 0x28($sp)
    /* DB7D8 800EAFD8 2400B18F */  lw         $s1, 0x24($sp)
    /* DB7DC 800EAFDC 2000B08F */  lw         $s0, 0x20($sp)
    /* DB7E0 800EAFE0 0800E003 */  jr         $ra
    /* DB7E4 800EAFE4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel transform
