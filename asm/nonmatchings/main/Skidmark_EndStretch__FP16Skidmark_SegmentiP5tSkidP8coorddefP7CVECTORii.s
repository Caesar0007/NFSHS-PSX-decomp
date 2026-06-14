.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii, 0xDC

glabel Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
    /* CFB88 800DF388 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* CFB8C 800DF38C 2000B2AF */  sw         $s2, 0x20($sp)
    /* CFB90 800DF390 21908000 */  addu       $s2, $a0, $zero
    /* CFB94 800DF394 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* CFB98 800DF398 2188A000 */  addu       $s1, $a1, $zero
    /* CFB9C 800DF39C 1800B0AF */  sw         $s0, 0x18($sp)
    /* CFBA0 800DF3A0 2180C000 */  addu       $s0, $a2, $zero
    /* CFBA4 800DF3A4 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* CFBA8 800DF3A8 21A8E000 */  addu       $s5, $a3, $zero
    /* CFBAC 800DF3AC 40281100 */  sll        $a1, $s1, 1
    /* CFBB0 800DF3B0 2128B100 */  addu       $a1, $a1, $s1
    /* CFBB4 800DF3B4 80280500 */  sll        $a1, $a1, 2
    /* CFBB8 800DF3B8 2328B100 */  subu       $a1, $a1, $s1
    /* CFBBC 800DF3BC 80280500 */  sll        $a1, $a1, 2
    /* CFBC0 800DF3C0 2328B100 */  subu       $a1, $a1, $s1
    /* CFBC4 800DF3C4 4C00A28F */  lw         $v0, 0x4C($sp)
    /* CFBC8 800DF3C8 00290500 */  sll        $a1, $a1, 4
    /* CFBCC 800DF3CC 2400B3AF */  sw         $s3, 0x24($sp)
    /* CFBD0 800DF3D0 4800B38F */  lw         $s3, 0x48($sp)
    /* CFBD4 800DF3D4 2800B4AF */  sw         $s4, 0x28($sp)
    /* CFBD8 800DF3D8 5000B48F */  lw         $s4, 0x50($sp)
    /* CFBDC 800DF3DC 1000A2AF */  sw         $v0, 0x10($sp)
    /* CFBE0 800DF3E0 7C15828F */  lw         $v0, %gp_rel(gSm)($gp)
    /* CFBE4 800DF3E4 3000BFAF */  sw         $ra, 0x30($sp)
    /* CFBE8 800DF3E8 317A030C */  jal        CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i
    /* CFBEC 800DF3EC 21284500 */   addu      $a1, $v0, $a1
    /* CFBF0 800DF3F0 0300638A */  lwl        $v1, 0x3($s3)
    /* CFBF4 800DF3F4 0000639A */  lwr        $v1, 0x0($s3)
    /* CFBF8 800DF3F8 00000000 */  nop
    /* CFBFC 800DF3FC 130043AA */  swl        $v1, 0x13($s2)
    /* CFC00 800DF400 100043BA */  swr        $v1, 0x10($s2)
    /* CFC04 800DF404 140054AE */  sw         $s4, 0x14($s2)
    /* CFC08 800DF408 0300638A */  lwl        $v1, 0x3($s3)
    /* CFC0C 800DF40C 0000639A */  lwr        $v1, 0x0($s3)
    /* CFC10 800DF410 00000000 */  nop
    /* CFC14 800DF414 0F0003AA */  swl        $v1, 0xF($s0)
    /* CFC18 800DF418 0C0003BA */  swr        $v1, 0xC($s0)
    /* CFC1C 800DF41C 100014AE */  sw         $s4, 0x10($s0)
    /* CFC20 800DF420 0000A38E */  lw         $v1, 0x0($s5)
    /* CFC24 800DF424 0400A88E */  lw         $t0, 0x4($s5)
    /* CFC28 800DF428 0800A98E */  lw         $t1, 0x8($s5)
    /* CFC2C 800DF42C 000003AE */  sw         $v1, 0x0($s0)
    /* CFC30 800DF430 040008AE */  sw         $t0, 0x4($s0)
    /* CFC34 800DF434 080009AE */  sw         $t1, 0x8($s0)
    /* CFC38 800DF438 140012AE */  sw         $s2, 0x14($s0)
    /* CFC3C 800DF43C 180011AE */  sw         $s1, 0x18($s0)
    /* CFC40 800DF440 3000BF8F */  lw         $ra, 0x30($sp)
    /* CFC44 800DF444 2C00B58F */  lw         $s5, 0x2C($sp)
    /* CFC48 800DF448 2800B48F */  lw         $s4, 0x28($sp)
    /* CFC4C 800DF44C 2400B38F */  lw         $s3, 0x24($sp)
    /* CFC50 800DF450 2000B28F */  lw         $s2, 0x20($sp)
    /* CFC54 800DF454 1C00B18F */  lw         $s1, 0x1C($sp)
    /* CFC58 800DF458 1800B08F */  lw         $s0, 0x18($sp)
    /* CFC5C 800DF45C 0800E003 */  jr         $ra
    /* CFC60 800DF460 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii
