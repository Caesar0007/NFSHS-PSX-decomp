.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_ThickenXZ__FP7SVECTORP8coorddefN21, 0x1B8

glabel Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
    /* CDB70 800DD370 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* CDB74 800DD374 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CDB78 800DD378 21988000 */  addu       $s3, $a0, $zero
    /* CDB7C 800DD37C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CDB80 800DD380 2180A000 */  addu       $s0, $a1, $zero
    /* CDB84 800DD384 2000B4AF */  sw         $s4, 0x20($sp)
    /* CDB88 800DD388 21A0C000 */  addu       $s4, $a2, $zero
    /* CDB8C 800DD38C 1800B2AF */  sw         $s2, 0x18($sp)
    /* CDB90 800DD390 2190E000 */  addu       $s2, $a3, $zero
    /* CDB94 800DD394 2400BFAF */  sw         $ra, 0x24($sp)
    /* CDB98 800DD398 1400B1AF */  sw         $s1, 0x14($sp)
    /* CDB9C 800DD39C 0000838E */  lw         $v1, 0x0($s4)
    /* CDBA0 800DD3A0 0000048E */  lw         $a0, 0x0($s0)
    /* CDBA4 800DD3A4 0800828E */  lw         $v0, 0x8($s4)
    /* CDBA8 800DD3A8 0800058E */  lw         $a1, 0x8($s0)
    /* CDBAC 800DD3AC 23206400 */  subu       $a0, $v1, $a0
    /* CDBB0 800DD3B0 CE96030C */  jal        intatan
    /* CDBB4 800DD3B4 23284500 */   subu      $a1, $v0, $a1
    /* CDBB8 800DD3B8 21884000 */  addu       $s1, $v0, $zero
    /* CDBBC 800DD3BC 39C6030C */  jal        intcos
    /* CDBC0 800DD3C0 21202002 */   addu      $a0, $s1, $zero
    /* CDBC4 800DD3C4 66E60434 */  ori        $a0, $zero, 0xE666
    /* CDBC8 800DD3C8 CA90030C */  jal        fixedmult
    /* CDBCC 800DD3CC 23280200 */   negu      $a1, $v0
    /* CDBD0 800DD3D0 21202002 */  addu       $a0, $s1, $zero
    /* CDBD4 800DD3D4 3AC6030C */  jal        intsin
    /* CDBD8 800DD3D8 43880200 */   sra       $s1, $v0, 1
    /* CDBDC 800DD3DC 66E60434 */  ori        $a0, $zero, 0xE666
    /* CDBE0 800DD3E0 CA90030C */  jal        fixedmult
    /* CDBE4 800DD3E4 21284000 */   addu      $a1, $v0, $zero
    /* CDBE8 800DD3E8 0000038E */  lw         $v1, 0x0($s0)
    /* CDBEC 800DD3EC 0000448E */  lw         $a0, 0x0($s2)
    /* CDBF0 800DD3F0 21187100 */  addu       $v1, $v1, $s1
    /* CDBF4 800DD3F4 23186400 */  subu       $v1, $v1, $a0
    /* CDBF8 800DD3F8 831A0300 */  sra        $v1, $v1, 10
    /* CDBFC 800DD3FC 080063A6 */  sh         $v1, 0x8($s3)
    /* CDC00 800DD400 0400038E */  lw         $v1, 0x4($s0)
    /* CDC04 800DD404 0400448E */  lw         $a0, 0x4($s2)
    /* CDC08 800DD408 43100200 */  sra        $v0, $v0, 1
    /* CDC0C 800DD40C 23186400 */  subu       $v1, $v1, $a0
    /* CDC10 800DD410 831A0300 */  sra        $v1, $v1, 10
    /* CDC14 800DD414 0A0063A6 */  sh         $v1, 0xA($s3)
    /* CDC18 800DD418 0800038E */  lw         $v1, 0x8($s0)
    /* CDC1C 800DD41C 0800448E */  lw         $a0, 0x8($s2)
    /* CDC20 800DD420 21186200 */  addu       $v1, $v1, $v0
    /* CDC24 800DD424 23186400 */  subu       $v1, $v1, $a0
    /* CDC28 800DD428 831A0300 */  sra        $v1, $v1, 10
    /* CDC2C 800DD42C 0C0063A6 */  sh         $v1, 0xC($s3)
    /* CDC30 800DD430 0000038E */  lw         $v1, 0x0($s0)
    /* CDC34 800DD434 0000448E */  lw         $a0, 0x0($s2)
    /* CDC38 800DD438 23187100 */  subu       $v1, $v1, $s1
    /* CDC3C 800DD43C 23186400 */  subu       $v1, $v1, $a0
    /* CDC40 800DD440 831A0300 */  sra        $v1, $v1, 10
    /* CDC44 800DD444 100063A6 */  sh         $v1, 0x10($s3)
    /* CDC48 800DD448 0400038E */  lw         $v1, 0x4($s0)
    /* CDC4C 800DD44C 0400448E */  lw         $a0, 0x4($s2)
    /* CDC50 800DD450 00000000 */  nop
    /* CDC54 800DD454 23186400 */  subu       $v1, $v1, $a0
    /* CDC58 800DD458 831A0300 */  sra        $v1, $v1, 10
    /* CDC5C 800DD45C 120063A6 */  sh         $v1, 0x12($s3)
    /* CDC60 800DD460 0800038E */  lw         $v1, 0x8($s0)
    /* CDC64 800DD464 0800448E */  lw         $a0, 0x8($s2)
    /* CDC68 800DD468 23186200 */  subu       $v1, $v1, $v0
    /* CDC6C 800DD46C 23186400 */  subu       $v1, $v1, $a0
    /* CDC70 800DD470 831A0300 */  sra        $v1, $v1, 10
    /* CDC74 800DD474 140063A6 */  sh         $v1, 0x14($s3)
    /* CDC78 800DD478 0000838E */  lw         $v1, 0x0($s4)
    /* CDC7C 800DD47C 0000448E */  lw         $a0, 0x0($s2)
    /* CDC80 800DD480 21187100 */  addu       $v1, $v1, $s1
    /* CDC84 800DD484 23186400 */  subu       $v1, $v1, $a0
    /* CDC88 800DD488 831A0300 */  sra        $v1, $v1, 10
    /* CDC8C 800DD48C 000063A6 */  sh         $v1, 0x0($s3)
    /* CDC90 800DD490 0400838E */  lw         $v1, 0x4($s4)
    /* CDC94 800DD494 0400448E */  lw         $a0, 0x4($s2)
    /* CDC98 800DD498 00000000 */  nop
    /* CDC9C 800DD49C 23186400 */  subu       $v1, $v1, $a0
    /* CDCA0 800DD4A0 831A0300 */  sra        $v1, $v1, 10
    /* CDCA4 800DD4A4 020063A6 */  sh         $v1, 0x2($s3)
    /* CDCA8 800DD4A8 0800838E */  lw         $v1, 0x8($s4)
    /* CDCAC 800DD4AC 0800448E */  lw         $a0, 0x8($s2)
    /* CDCB0 800DD4B0 21186200 */  addu       $v1, $v1, $v0
    /* CDCB4 800DD4B4 23186400 */  subu       $v1, $v1, $a0
    /* CDCB8 800DD4B8 831A0300 */  sra        $v1, $v1, 10
    /* CDCBC 800DD4BC 040063A6 */  sh         $v1, 0x4($s3)
    /* CDCC0 800DD4C0 0000838E */  lw         $v1, 0x0($s4)
    /* CDCC4 800DD4C4 0000448E */  lw         $a0, 0x0($s2)
    /* CDCC8 800DD4C8 23187100 */  subu       $v1, $v1, $s1
    /* CDCCC 800DD4CC 23186400 */  subu       $v1, $v1, $a0
    /* CDCD0 800DD4D0 831A0300 */  sra        $v1, $v1, 10
    /* CDCD4 800DD4D4 180063A6 */  sh         $v1, 0x18($s3)
    /* CDCD8 800DD4D8 0400838E */  lw         $v1, 0x4($s4)
    /* CDCDC 800DD4DC 0400448E */  lw         $a0, 0x4($s2)
    /* CDCE0 800DD4E0 00000000 */  nop
    /* CDCE4 800DD4E4 23186400 */  subu       $v1, $v1, $a0
    /* CDCE8 800DD4E8 831A0300 */  sra        $v1, $v1, 10
    /* CDCEC 800DD4EC 1A0063A6 */  sh         $v1, 0x1A($s3)
    /* CDCF0 800DD4F0 0800838E */  lw         $v1, 0x8($s4)
    /* CDCF4 800DD4F4 0800448E */  lw         $a0, 0x8($s2)
    /* CDCF8 800DD4F8 23186200 */  subu       $v1, $v1, $v0
    /* CDCFC 800DD4FC 23186400 */  subu       $v1, $v1, $a0
    /* CDD00 800DD500 831A0300 */  sra        $v1, $v1, 10
    /* CDD04 800DD504 1C0063A6 */  sh         $v1, 0x1C($s3)
    /* CDD08 800DD508 2400BF8F */  lw         $ra, 0x24($sp)
    /* CDD0C 800DD50C 2000B48F */  lw         $s4, 0x20($sp)
    /* CDD10 800DD510 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CDD14 800DD514 1800B28F */  lw         $s2, 0x18($sp)
    /* CDD18 800DD518 1400B18F */  lw         $s1, 0x14($sp)
    /* CDD1C 800DD51C 1000B08F */  lw         $s0, 0x10($sp)
    /* CDD20 800DD520 0800E003 */  jr         $ra
    /* CDD24 800DD524 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Sfx_ThickenXZ__FP7SVECTORP8coorddefN21
