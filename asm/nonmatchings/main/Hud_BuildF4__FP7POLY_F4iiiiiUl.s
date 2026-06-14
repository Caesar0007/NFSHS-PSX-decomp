.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildF4__FP7POLY_F4iiiiiUl, 0xA4

glabel Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C2E34 800D2634 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C2E38 800D2638 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C2E3C 800D263C 4000B38F */  lw         $s3, 0x40($sp)
    /* C2E40 800D2640 1400B1AF */  sw         $s1, 0x14($sp)
    /* C2E44 800D2644 21888000 */  addu       $s1, $a0, $zero
    /* C2E48 800D2648 2000B4AF */  sw         $s4, 0x20($sp)
    /* C2E4C 800D264C 21A0A000 */  addu       $s4, $a1, $zero
    /* C2E50 800D2650 1800B2AF */  sw         $s2, 0x18($sp)
    /* C2E54 800D2654 2190C000 */  addu       $s2, $a2, $zero
    /* C2E58 800D2658 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2E5C 800D265C 2180E000 */  addu       $s0, $a3, $zero
    /* C2E60 800D2660 2400B5AF */  sw         $s5, 0x24($sp)
    /* C2E64 800D2664 4400B58F */  lw         $s5, 0x44($sp)
    /* C2E68 800D2668 4800A28F */  lw         $v0, 0x48($sp)
    /* C2E6C 800D266C 2800BFAF */  sw         $ra, 0x28($sp)
    /* C2E70 800D2670 84CD030C */  jal        SetPolyF4
    /* C2E74 800D2674 040022AE */   sw        $v0, 0x4($s1)
    /* C2E78 800D2678 21202002 */  addu       $a0, $s1, $zero
    /* C2E7C 800D267C 3FCC030C */  jal        SetSemiTrans
    /* C2E80 800D2680 21288002 */   addu      $a1, $s4, $zero
    /* C2E84 800D2684 00141000 */  sll        $v0, $s0, 16
    /* C2E88 800D2688 25185200 */  or         $v1, $v0, $s2
    /* C2E8C 800D268C 21985302 */  addu       $s3, $s2, $s3
    /* C2E90 800D2690 25105300 */  or         $v0, $v0, $s3
    /* C2E94 800D2694 21801502 */  addu       $s0, $s0, $s5
    /* C2E98 800D2698 00841000 */  sll        $s0, $s0, 16
    /* C2E9C 800D269C 25901202 */  or         $s2, $s0, $s2
    /* C2EA0 800D26A0 25801302 */  or         $s0, $s0, $s3
    /* C2EA4 800D26A4 080023AE */  sw         $v1, 0x8($s1)
    /* C2EA8 800D26A8 0C0022AE */  sw         $v0, 0xC($s1)
    /* C2EAC 800D26AC 100032AE */  sw         $s2, 0x10($s1)
    /* C2EB0 800D26B0 140030AE */  sw         $s0, 0x14($s1)
    /* C2EB4 800D26B4 2800BF8F */  lw         $ra, 0x28($sp)
    /* C2EB8 800D26B8 2400B58F */  lw         $s5, 0x24($sp)
    /* C2EBC 800D26BC 2000B48F */  lw         $s4, 0x20($sp)
    /* C2EC0 800D26C0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2EC4 800D26C4 1800B28F */  lw         $s2, 0x18($sp)
    /* C2EC8 800D26C8 1400B18F */  lw         $s1, 0x14($sp)
    /* C2ECC 800D26CC 1000B08F */  lw         $s0, 0x10($sp)
    /* C2ED0 800D26D0 0800E003 */  jr         $ra
    /* C2ED4 800D26D4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_BuildF4__FP7POLY_F4iiiiiUl
