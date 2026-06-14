.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching EulerToMat__FP10matrixtdefiii, 0xF8

glabel EulerToMat__FP10matrixtdefiii
    /* 70E0C 8008060C 38FFBD27 */  addiu      $sp, $sp, -0xC8
    /* 70E10 80080610 B400B1AF */  sw         $s1, 0xB4($sp)
    /* 70E14 80080614 21888000 */  addu       $s1, $a0, $zero
    /* 70E18 80080618 1000A427 */  addiu      $a0, $sp, 0x10
    /* 70E1C 8008061C B000B0AF */  sw         $s0, 0xB0($sp)
    /* 70E20 80080620 2180C000 */  addu       $s0, $a2, $zero
    /* 70E24 80080624 BC00B3AF */  sw         $s3, 0xBC($sp)
    /* 70E28 80080628 2198E000 */  addu       $s3, $a3, $zero
    /* 70E2C 8008062C C000BFAF */  sw         $ra, 0xC0($sp)
    /* 70E30 80080630 EBAA030C */  jal        fixedxformx
    /* 70E34 80080634 B800B2AF */   sw        $s2, 0xB8($sp)
    /* 70E38 80080638 3800B227 */  addiu      $s2, $sp, 0x38
    /* 70E3C 8008063C 21204002 */  addu       $a0, $s2, $zero
    /* 70E40 80080640 04AB030C */  jal        fixedxformy
    /* 70E44 80080644 21280002 */   addu      $a1, $s0, $zero
    /* 70E48 80080648 6000B027 */  addiu      $s0, $sp, 0x60
    /* 70E4C 8008064C 21200002 */  addu       $a0, $s0, $zero
    /* 70E50 80080650 1DAB030C */  jal        fixedxformz
    /* 70E54 80080654 21286002 */   addu      $a1, $s3, $zero
    /* 70E58 80080658 21200002 */  addu       $a0, $s0, $zero
    /* 70E5C 8008065C 21284002 */  addu       $a1, $s2, $zero
    /* 70E60 80080660 8800B027 */  addiu      $s0, $sp, 0x88
    /* 70E64 80080664 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 70E68 80080668 21300002 */   addu      $a2, $s0, $zero
    /* 70E6C 8008066C 21200002 */  addu       $a0, $s0, $zero
    /* 70E70 80080670 1000A527 */  addiu      $a1, $sp, 0x10
    /* 70E74 80080674 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 70E78 80080678 21302002 */   addu      $a2, $s1, $zero
    /* 70E7C 8008067C 0C00228E */  lw         $v0, 0xC($s1)
    /* 70E80 80080680 00000000 */  nop
    /* 70E84 80080684 8800A2AF */  sw         $v0, 0x88($sp)
    /* 70E88 80080688 1000228E */  lw         $v0, 0x10($s1)
    /* 70E8C 8008068C 00000000 */  nop
    /* 70E90 80080690 8C00A2AF */  sw         $v0, 0x8C($sp)
    /* 70E94 80080694 1400228E */  lw         $v0, 0x14($s1)
    /* 70E98 80080698 00000000 */  nop
    /* 70E9C 8008069C 9000A2AF */  sw         $v0, 0x90($sp)
    /* 70EA0 800806A0 1800228E */  lw         $v0, 0x18($s1)
    /* 70EA4 800806A4 2000238E */  lw         $v1, 0x20($s1)
    /* 70EA8 800806A8 23100200 */  negu       $v0, $v0
    /* 70EAC 800806AC 0C0022AE */  sw         $v0, 0xC($s1)
    /* 70EB0 800806B0 1C00228E */  lw         $v0, 0x1C($s1)
    /* 70EB4 800806B4 23180300 */  negu       $v1, $v1
    /* 70EB8 800806B8 140023AE */  sw         $v1, 0x14($s1)
    /* 70EBC 800806BC 23100200 */  negu       $v0, $v0
    /* 70EC0 800806C0 100022AE */  sw         $v0, 0x10($s1)
    /* 70EC4 800806C4 8800A28F */  lw         $v0, 0x88($sp)
    /* 70EC8 800806C8 00000000 */  nop
    /* 70ECC 800806CC 180022AE */  sw         $v0, 0x18($s1)
    /* 70ED0 800806D0 8C00A28F */  lw         $v0, 0x8C($sp)
    /* 70ED4 800806D4 00000000 */  nop
    /* 70ED8 800806D8 1C0022AE */  sw         $v0, 0x1C($s1)
    /* 70EDC 800806DC 9000A28F */  lw         $v0, 0x90($sp)
    /* 70EE0 800806E0 00000000 */  nop
    /* 70EE4 800806E4 200022AE */  sw         $v0, 0x20($s1)
    /* 70EE8 800806E8 C000BF8F */  lw         $ra, 0xC0($sp)
    /* 70EEC 800806EC BC00B38F */  lw         $s3, 0xBC($sp)
    /* 70EF0 800806F0 B800B28F */  lw         $s2, 0xB8($sp)
    /* 70EF4 800806F4 B400B18F */  lw         $s1, 0xB4($sp)
    /* 70EF8 800806F8 B000B08F */  lw         $s0, 0xB0($sp)
    /* 70EFC 800806FC 0800E003 */  jr         $ra
    /* 70F00 80080700 C800BD27 */   addiu     $sp, $sp, 0xC8
endlabel EulerToMat__FP10matrixtdefiii
