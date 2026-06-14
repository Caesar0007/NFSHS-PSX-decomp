.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2, 0x108

glabel Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2
    /* 9DE78 800AD678 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 9DE7C 800AD67C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9DE80 800AD680 21808000 */  addu       $s0, $a0, $zero
    /* 9DE84 800AD684 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9DE88 800AD688 2190A000 */  addu       $s2, $a1, $zero
    /* 9DE8C 800AD68C 2400B5AF */  sw         $s5, 0x24($sp)
    /* 9DE90 800AD690 21A8C000 */  addu       $s5, $a2, $zero
    /* 9DE94 800AD694 2800B6AF */  sw         $s6, 0x28($sp)
    /* 9DE98 800AD698 21B0E000 */  addu       $s6, $a3, $zero
    /* 9DE9C 800AD69C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 9DEA0 800AD6A0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 9DEA4 800AD6A4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 9DEA8 800AD6A8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9DEAC 800AD6AC 00004286 */  lh         $v0, 0x0($s2)
    /* 9DEB0 800AD6B0 00000486 */  lh         $a0, 0x0($s0)
    /* 9DEB4 800AD6B4 4000B18F */  lw         $s1, 0x40($sp)
    /* 9DEB8 800AD6B8 4400B38F */  lw         $s3, 0x44($sp)
    /* 9DEBC 800AD6BC 4800B48F */  lw         $s4, 0x48($sp)
    /* 9DEC0 800AD6C0 23204400 */  subu       $a0, $v0, $a0
    /* 9DEC4 800AD6C4 CA90030C */  jal        fixedmult
    /* 9DEC8 800AD6C8 21282002 */   addu      $a1, $s1, $zero
    /* 9DECC 800AD6CC 00000396 */  lhu        $v1, 0x0($s0)
    /* 9DED0 800AD6D0 00000000 */  nop
    /* 9DED4 800AD6D4 21186200 */  addu       $v1, $v1, $v0
    /* 9DED8 800AD6D8 000063A6 */  sh         $v1, 0x0($s3)
    /* 9DEDC 800AD6DC 02004286 */  lh         $v0, 0x2($s2)
    /* 9DEE0 800AD6E0 02000486 */  lh         $a0, 0x2($s0)
    /* 9DEE4 800AD6E4 21282002 */  addu       $a1, $s1, $zero
    /* 9DEE8 800AD6E8 CA90030C */  jal        fixedmult
    /* 9DEEC 800AD6EC 23204400 */   subu      $a0, $v0, $a0
    /* 9DEF0 800AD6F0 02000396 */  lhu        $v1, 0x2($s0)
    /* 9DEF4 800AD6F4 00000000 */  nop
    /* 9DEF8 800AD6F8 21186200 */  addu       $v1, $v1, $v0
    /* 9DEFC 800AD6FC 020063A6 */  sh         $v1, 0x2($s3)
    /* 9DF00 800AD700 04004286 */  lh         $v0, 0x4($s2)
    /* 9DF04 800AD704 04000486 */  lh         $a0, 0x4($s0)
    /* 9DF08 800AD708 21282002 */  addu       $a1, $s1, $zero
    /* 9DF0C 800AD70C CA90030C */  jal        fixedmult
    /* 9DF10 800AD710 23204400 */   subu      $a0, $v0, $a0
    /* 9DF14 800AD714 04000396 */  lhu        $v1, 0x4($s0)
    /* 9DF18 800AD718 00000000 */  nop
    /* 9DF1C 800AD71C 21186200 */  addu       $v1, $v1, $v0
    /* 9DF20 800AD720 040063A6 */  sh         $v1, 0x4($s3)
    /* 9DF24 800AD724 06004286 */  lh         $v0, 0x6($s2)
    /* 9DF28 800AD728 06000486 */  lh         $a0, 0x6($s0)
    /* 9DF2C 800AD72C 21282002 */  addu       $a1, $s1, $zero
    /* 9DF30 800AD730 CA90030C */  jal        fixedmult
    /* 9DF34 800AD734 23204400 */   subu      $a0, $v0, $a0
    /* 9DF38 800AD738 2120A002 */  addu       $a0, $s5, $zero
    /* 9DF3C 800AD73C 2128C002 */  addu       $a1, $s6, $zero
    /* 9DF40 800AD740 21302002 */  addu       $a2, $s1, $zero
    /* 9DF44 800AD744 06000396 */  lhu        $v1, 0x6($s0)
    /* 9DF48 800AD748 21388002 */  addu       $a3, $s4, $zero
    /* 9DF4C 800AD74C 21186200 */  addu       $v1, $v1, $v0
    /* 9DF50 800AD750 72B5020C */  jal        Quatern_VecInterpolate__FP8coorddefT0iT0
    /* 9DF54 800AD754 060063A6 */   sh        $v1, 0x6($s3)
    /* 9DF58 800AD758 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 9DF5C 800AD75C 2800B68F */  lw         $s6, 0x28($sp)
    /* 9DF60 800AD760 2400B58F */  lw         $s5, 0x24($sp)
    /* 9DF64 800AD764 2000B48F */  lw         $s4, 0x20($sp)
    /* 9DF68 800AD768 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 9DF6C 800AD76C 1800B28F */  lw         $s2, 0x18($sp)
    /* 9DF70 800AD770 1400B18F */  lw         $s1, 0x14($sp)
    /* 9DF74 800AD774 1000B08F */  lw         $s0, 0x10($sp)
    /* 9DF78 800AD778 0800E003 */  jr         $ra
    /* 9DF7C 800AD77C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2
