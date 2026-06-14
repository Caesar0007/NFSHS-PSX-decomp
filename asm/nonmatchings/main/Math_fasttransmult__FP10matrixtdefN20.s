.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Math_fasttransmult__FP10matrixtdefN20, 0x148

glabel Math_fasttransmult__FP10matrixtdefN20
    /* 8E58C 8009DD8C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 8E590 8009DD90 3000B2AF */  sw         $s2, 0x30($sp)
    /* 8E594 8009DD94 21908000 */  addu       $s2, $a0, $zero
    /* 8E598 8009DD98 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 8E59C 8009DD9C 2188C000 */  addu       $s1, $a2, $zero
    /* 8E5A0 8009DDA0 21700000 */  addu       $t6, $zero, $zero
    /* 8E5A4 8009DDA4 08001924 */  addiu      $t9, $zero, 0x8
    /* 8E5A8 8009DDA8 04001824 */  addiu      $t8, $zero, 0x4
    /* 8E5AC 8009DDAC 21784002 */  addu       $t7, $s2, $zero
    /* 8E5B0 8009DDB0 3400B3AF */  sw         $s3, 0x34($sp)
    /* 8E5B4 8009DDB4 2800B0AF */  sw         $s0, 0x28($sp)
  .L8009DDB8:
    /* 8E5B8 8009DDB8 21480000 */  addu       $t1, $zero, $zero
    /* 8E5BC 8009DDBC 21805802 */  addu       $s0, $s2, $t8
    /* 8E5C0 8009DDC0 21305902 */  addu       $a2, $s2, $t9
    /* 8E5C4 8009DDC4 18000C24 */  addiu      $t4, $zero, 0x18
    /* 8E5C8 8009DDC8 0C000B24 */  addiu      $t3, $zero, 0xC
    /* 8E5CC 8009DDCC 2150A000 */  addu       $t2, $a1, $zero
  .L8009DDD0:
    /* 8E5D0 8009DDD0 0000E48D */  lw         $a0, 0x0($t7)
    /* 8E5D4 8009DDD4 0000428D */  lw         $v0, 0x0($t2)
    /* 8E5D8 8009DDD8 C3180400 */  sra        $v1, $a0, 3
    /* 8E5DC 8009DDDC C3100200 */  sra        $v0, $v0, 3
    /* 8E5E0 8009DDE0 18006200 */  mult       $v1, $v0
    /* 8E5E4 8009DDE4 0000088E */  lw         $t0, 0x0($s0)
    /* 8E5E8 8009DDE8 2110AB00 */  addu       $v0, $a1, $t3
    /* 8E5EC 8009DDEC 0000478C */  lw         $a3, 0x0($v0)
    /* 8E5F0 8009DDF0 12680000 */  mflo       $t5
    /* 8E5F4 8009DDF4 C3180800 */  sra        $v1, $t0, 3
    /* 8E5F8 8009DDF8 C3100700 */  sra        $v0, $a3, 3
    /* 8E5FC 8009DDFC 18006200 */  mult       $v1, $v0
    /* 8E600 8009DE00 2110AC00 */  addu       $v0, $a1, $t4
    /* 8E604 8009DE04 0000C38C */  lw         $v1, 0x0($a2)
    /* 8E608 8009DE08 0000428C */  lw         $v0, 0x0($v0)
    /* 8E60C 8009DE0C 12380000 */  mflo       $a3
    /* 8E610 8009DE10 C3180300 */  sra        $v1, $v1, 3
    /* 8E614 8009DE14 C3100200 */  sra        $v0, $v0, 3
    /* 8E618 8009DE18 18006200 */  mult       $v1, $v0
    /* 8E61C 8009DE1C 04004A25 */  addiu      $t2, $t2, 0x4
    /* 8E620 8009DE20 04006B25 */  addiu      $t3, $t3, 0x4
    /* 8E624 8009DE24 2120C901 */  addu       $a0, $t6, $t1
    /* 8E628 8009DE28 01002925 */  addiu      $t1, $t1, 0x1
    /* 8E62C 8009DE2C 80200400 */  sll        $a0, $a0, 2
    /* 8E630 8009DE30 831A0D00 */  sra        $v1, $t5, 10
    /* 8E634 8009DE34 83120700 */  sra        $v0, $a3, 10
    /* 8E638 8009DE38 21186200 */  addu       $v1, $v1, $v0
    /* 8E63C 8009DE3C 12400000 */  mflo       $t0
    /* 8E640 8009DE40 83120800 */  sra        $v0, $t0, 10
    /* 8E644 8009DE44 21186200 */  addu       $v1, $v1, $v0
    /* 8E648 8009DE48 2110A403 */  addu       $v0, $sp, $a0
    /* 8E64C 8009DE4C 000043AC */  sw         $v1, 0x0($v0)
    /* 8E650 8009DE50 03002229 */  slti       $v0, $t1, 0x3
    /* 8E654 8009DE54 DEFF4014 */  bnez       $v0, .L8009DDD0
    /* 8E658 8009DE58 04008C25 */   addiu     $t4, $t4, 0x4
    /* 8E65C 8009DE5C 0C003927 */  addiu      $t9, $t9, 0xC
    /* 8E660 8009DE60 0C001827 */  addiu      $t8, $t8, 0xC
    /* 8E664 8009DE64 0300CE25 */  addiu      $t6, $t6, 0x3
    /* 8E668 8009DE68 0900C229 */  slti       $v0, $t6, 0x9
    /* 8E66C 8009DE6C D2FF4014 */  bnez       $v0, .L8009DDB8
    /* 8E670 8009DE70 0C00EF25 */   addiu     $t7, $t7, 0xC
    /* 8E674 8009DE74 0000A48F */  lw         $a0, 0x0($sp)
    /* 8E678 8009DE78 0400A28F */  lw         $v0, 0x4($sp)
    /* 8E67C 8009DE7C 0800A88F */  lw         $t0, 0x8($sp)
    /* 8E680 8009DE80 0C00A78F */  lw         $a3, 0xC($sp)
    /* 8E684 8009DE84 1000A38F */  lw         $v1, 0x10($sp)
    /* 8E688 8009DE88 000024AE */  sw         $a0, 0x0($s1)
    /* 8E68C 8009DE8C 040022AE */  sw         $v0, 0x4($s1)
    /* 8E690 8009DE90 080028AE */  sw         $t0, 0x8($s1)
    /* 8E694 8009DE94 0C0027AE */  sw         $a3, 0xC($s1)
    /* 8E698 8009DE98 100023AE */  sw         $v1, 0x10($s1)
    /* 8E69C 8009DE9C 1400A48F */  lw         $a0, 0x14($sp)
    /* 8E6A0 8009DEA0 1800A28F */  lw         $v0, 0x18($sp)
    /* 8E6A4 8009DEA4 1C00A88F */  lw         $t0, 0x1C($sp)
    /* 8E6A8 8009DEA8 2000A78F */  lw         $a3, 0x20($sp)
    /* 8E6AC 8009DEAC 140024AE */  sw         $a0, 0x14($s1)
    /* 8E6B0 8009DEB0 180022AE */  sw         $v0, 0x18($s1)
    /* 8E6B4 8009DEB4 1C0028AE */  sw         $t0, 0x1C($s1)
    /* 8E6B8 8009DEB8 200027AE */  sw         $a3, 0x20($s1)
    /* 8E6BC 8009DEBC 3400B38F */  lw         $s3, 0x34($sp)
    /* 8E6C0 8009DEC0 3000B28F */  lw         $s2, 0x30($sp)
    /* 8E6C4 8009DEC4 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 8E6C8 8009DEC8 2800B08F */  lw         $s0, 0x28($sp)
    /* 8E6CC 8009DECC 0800E003 */  jr         $ra
    /* 8E6D0 8009DED0 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Math_fasttransmult__FP10matrixtdefN20
