.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PointDirection__FP8coorddefN20, 0x78

glabel PointDirection__FP8coorddefN20
    /* 704B0 8007FCB0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 704B4 8007FCB4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 704B8 8007FCB8 21908000 */  addu       $s2, $a0, $zero
    /* 704BC 8007FCBC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 704C0 8007FCC0 2180A000 */  addu       $s0, $a1, $zero
    /* 704C4 8007FCC4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 704C8 8007FCC8 2188C000 */  addu       $s1, $a2, $zero
    /* 704CC 8007FCCC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 704D0 8007FCD0 0000438E */  lw         $v1, 0x0($s2)
    /* 704D4 8007FCD4 0000048E */  lw         $a0, 0x0($s0)
    /* 704D8 8007FCD8 0800228E */  lw         $v0, 0x8($s1)
    /* 704DC 8007FCDC 0800058E */  lw         $a1, 0x8($s0)
    /* 704E0 8007FCE0 23206400 */  subu       $a0, $v1, $a0
    /* 704E4 8007FCE4 CA90030C */  jal        fixedmult
    /* 704E8 8007FCE8 23284500 */   subu      $a1, $v0, $a1
    /* 704EC 8007FCEC 0000048E */  lw         $a0, 0x0($s0)
    /* 704F0 8007FCF0 0800058E */  lw         $a1, 0x8($s0)
    /* 704F4 8007FCF4 21804000 */  addu       $s0, $v0, $zero
    /* 704F8 8007FCF8 0000268E */  lw         $a2, 0x0($s1)
    /* 704FC 8007FCFC 0800438E */  lw         $v1, 0x8($s2)
    /* 70500 8007FD00 2320C400 */  subu       $a0, $a2, $a0
    /* 70504 8007FD04 CA90030C */  jal        fixedmult
    /* 70508 8007FD08 23286500 */   subu      $a1, $v1, $a1
    /* 7050C 8007FD0C 23100202 */  subu       $v0, $s0, $v0
    /* 70510 8007FD10 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 70514 8007FD14 1800B28F */  lw         $s2, 0x18($sp)
    /* 70518 8007FD18 1400B18F */  lw         $s1, 0x14($sp)
    /* 7051C 8007FD1C 1000B08F */  lw         $s0, 0x10($sp)
    /* 70520 8007FD20 0800E003 */  jr         $ra
    /* 70524 8007FD24 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PointDirection__FP8coorddefN20
