.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli, 0x10C

glabel Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C2D28 800D2528 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C2D2C 800D252C 3800A28F */  lw         $v0, 0x38($sp)
    /* C2D30 800D2530 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2D34 800D2534 21808000 */  addu       $s0, $a0, $zero
    /* C2D38 800D2538 1800B2AF */  sw         $s2, 0x18($sp)
    /* C2D3C 800D253C 2190A000 */  addu       $s2, $a1, $zero
    /* C2D40 800D2540 2000B4AF */  sw         $s4, 0x20($sp)
    /* C2D44 800D2544 21A0C000 */  addu       $s4, $a2, $zero
    /* C2D48 800D2548 1400B1AF */  sw         $s1, 0x14($sp)
    /* C2D4C 800D254C 2188E000 */  addu       $s1, $a3, $zero
    /* C2D50 800D2550 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C2D54 800D2554 3C00B38F */  lw         $s3, 0x3C($sp)
    /* C2D58 800D2558 2400BFAF */  sw         $ra, 0x24($sp)
    /* C2D5C 800D255C 94CD030C */  jal        SetPolyFT4
    /* C2D60 800D2560 040002AE */   sw        $v0, 0x4($s0)
    /* C2D64 800D2564 21200002 */  addu       $a0, $s0, $zero
    /* C2D68 800D2568 3FCC030C */  jal        SetSemiTrans
    /* C2D6C 800D256C 21286002 */   addu      $a1, $s3, $zero
    /* C2D70 800D2570 10004286 */  lh         $v0, 0x10($s2)
    /* C2D74 800D2574 001C1100 */  sll        $v1, $s1, 16
    /* C2D78 800D2578 21108202 */  addu       $v0, $s4, $v0
    /* C2D7C 800D257C 25106200 */  or         $v0, $v1, $v0
    /* C2D80 800D2580 080002AE */  sw         $v0, 0x8($s0)
    /* C2D84 800D2584 0000428E */  lw         $v0, 0x0($s2)
    /* C2D88 800D2588 25187400 */  or         $v1, $v1, $s4
    /* C2D8C 800D258C 100003AE */  sw         $v1, 0x10($s0)
    /* C2D90 800D2590 10000396 */  lhu        $v1, 0x10($s0)
    /* C2D94 800D2594 0C0002AE */  sw         $v0, 0xC($s0)
    /* C2D98 800D2598 0400448E */  lw         $a0, 0x4($s2)
    /* C2D9C 800D259C 08000296 */  lhu        $v0, 0x8($s0)
    /* C2DA0 800D25A0 FDFF6324 */  addiu      $v1, $v1, -0x3
    /* C2DA4 800D25A4 100003A6 */  sh         $v1, 0x10($s0)
    /* C2DA8 800D25A8 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* C2DAC 800D25AC 080002A6 */  sh         $v0, 0x8($s0)
    /* C2DB0 800D25B0 140004AE */  sw         $a0, 0x14($s0)
    /* C2DB4 800D25B4 12004286 */  lh         $v0, 0x12($s2)
    /* C2DB8 800D25B8 10004386 */  lh         $v1, 0x10($s2)
    /* C2DBC 800D25BC 21102202 */  addu       $v0, $s1, $v0
    /* C2DC0 800D25C0 00140200 */  sll        $v0, $v0, 16
    /* C2DC4 800D25C4 21188302 */  addu       $v1, $s4, $v1
    /* C2DC8 800D25C8 25104300 */  or         $v0, $v0, $v1
    /* C2DCC 800D25CC 180002AE */  sw         $v0, 0x18($s0)
    /* C2DD0 800D25D0 0800428E */  lw         $v0, 0x8($s2)
    /* C2DD4 800D25D4 00000000 */  nop
    /* C2DD8 800D25D8 1C0002AE */  sw         $v0, 0x1C($s0)
    /* C2DDC 800D25DC 12004286 */  lh         $v0, 0x12($s2)
    /* C2DE0 800D25E0 00000000 */  nop
    /* C2DE4 800D25E4 21882202 */  addu       $s1, $s1, $v0
    /* C2DE8 800D25E8 008C1100 */  sll        $s1, $s1, 16
    /* C2DEC 800D25EC 25883402 */  or         $s1, $s1, $s4
    /* C2DF0 800D25F0 200011AE */  sw         $s1, 0x20($s0)
    /* C2DF4 800D25F4 0C00448E */  lw         $a0, 0xC($s2)
    /* C2DF8 800D25F8 18000296 */  lhu        $v0, 0x18($s0)
    /* C2DFC 800D25FC 20000396 */  lhu        $v1, 0x20($s0)
    /* C2E00 800D2600 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* C2E04 800D2604 FDFF6324 */  addiu      $v1, $v1, -0x3
    /* C2E08 800D2608 180002A6 */  sh         $v0, 0x18($s0)
    /* C2E0C 800D260C 240004AE */  sw         $a0, 0x24($s0)
    /* C2E10 800D2610 200003A6 */  sh         $v1, 0x20($s0)
    /* C2E14 800D2614 2400BF8F */  lw         $ra, 0x24($sp)
    /* C2E18 800D2618 2000B48F */  lw         $s4, 0x20($sp)
    /* C2E1C 800D261C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2E20 800D2620 1800B28F */  lw         $s2, 0x18($sp)
    /* C2E24 800D2624 1400B18F */  lw         $s1, 0x14($sp)
    /* C2E28 800D2628 1000B08F */  lw         $s0, 0x10($sp)
    /* C2E2C 800D262C 0800E003 */  jr         $ra
    /* C2E30 800D2630 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
