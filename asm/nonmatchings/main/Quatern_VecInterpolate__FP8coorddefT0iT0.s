.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Quatern_VecInterpolate__FP8coorddefT0iT0, 0xB0

glabel Quatern_VecInterpolate__FP8coorddefT0iT0
    /* 9DDC8 800AD5C8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 9DDCC 800AD5CC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9DDD0 800AD5D0 21808000 */  addu       $s0, $a0, $zero
    /* 9DDD4 800AD5D4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9DDD8 800AD5D8 2188A000 */  addu       $s1, $a1, $zero
    /* 9DDDC 800AD5DC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9DDE0 800AD5E0 2190C000 */  addu       $s2, $a2, $zero
    /* 9DDE4 800AD5E4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 9DDE8 800AD5E8 2198E000 */  addu       $s3, $a3, $zero
    /* 9DDEC 800AD5EC 2000BFAF */  sw         $ra, 0x20($sp)
    /* 9DDF0 800AD5F0 0000228E */  lw         $v0, 0x0($s1)
    /* 9DDF4 800AD5F4 0000048E */  lw         $a0, 0x0($s0)
    /* 9DDF8 800AD5F8 21284002 */  addu       $a1, $s2, $zero
    /* 9DDFC 800AD5FC CA90030C */  jal        fixedmult
    /* 9DE00 800AD600 23204400 */   subu      $a0, $v0, $a0
    /* 9DE04 800AD604 0000038E */  lw         $v1, 0x0($s0)
    /* 9DE08 800AD608 00000000 */  nop
    /* 9DE0C 800AD60C 21186200 */  addu       $v1, $v1, $v0
    /* 9DE10 800AD610 000063AE */  sw         $v1, 0x0($s3)
    /* 9DE14 800AD614 0400228E */  lw         $v0, 0x4($s1)
    /* 9DE18 800AD618 0400048E */  lw         $a0, 0x4($s0)
    /* 9DE1C 800AD61C 21284002 */  addu       $a1, $s2, $zero
    /* 9DE20 800AD620 CA90030C */  jal        fixedmult
    /* 9DE24 800AD624 23204400 */   subu      $a0, $v0, $a0
    /* 9DE28 800AD628 0400038E */  lw         $v1, 0x4($s0)
    /* 9DE2C 800AD62C 00000000 */  nop
    /* 9DE30 800AD630 21186200 */  addu       $v1, $v1, $v0
    /* 9DE34 800AD634 040063AE */  sw         $v1, 0x4($s3)
    /* 9DE38 800AD638 0800228E */  lw         $v0, 0x8($s1)
    /* 9DE3C 800AD63C 0800048E */  lw         $a0, 0x8($s0)
    /* 9DE40 800AD640 21284002 */  addu       $a1, $s2, $zero
    /* 9DE44 800AD644 CA90030C */  jal        fixedmult
    /* 9DE48 800AD648 23204400 */   subu      $a0, $v0, $a0
    /* 9DE4C 800AD64C 0800038E */  lw         $v1, 0x8($s0)
    /* 9DE50 800AD650 00000000 */  nop
    /* 9DE54 800AD654 21186200 */  addu       $v1, $v1, $v0
    /* 9DE58 800AD658 080063AE */  sw         $v1, 0x8($s3)
    /* 9DE5C 800AD65C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 9DE60 800AD660 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 9DE64 800AD664 1800B28F */  lw         $s2, 0x18($sp)
    /* 9DE68 800AD668 1400B18F */  lw         $s1, 0x14($sp)
    /* 9DE6C 800AD66C 1000B08F */  lw         $s0, 0x10($sp)
    /* 9DE70 800AD670 0800E003 */  jr         $ra
    /* 9DE74 800AD674 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Quatern_VecInterpolate__FP8coorddefT0iT0
