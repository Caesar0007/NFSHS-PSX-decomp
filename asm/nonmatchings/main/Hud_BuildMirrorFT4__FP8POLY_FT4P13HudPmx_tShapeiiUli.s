.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli, 0x104

glabel Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C2C24 800D2424 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C2C28 800D2428 3800A28F */  lw         $v0, 0x38($sp)
    /* C2C2C 800D242C 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2C30 800D2430 21808000 */  addu       $s0, $a0, $zero
    /* C2C34 800D2434 1800B2AF */  sw         $s2, 0x18($sp)
    /* C2C38 800D2438 2190A000 */  addu       $s2, $a1, $zero
    /* C2C3C 800D243C 2000B4AF */  sw         $s4, 0x20($sp)
    /* C2C40 800D2440 21A0C000 */  addu       $s4, $a2, $zero
    /* C2C44 800D2444 1400B1AF */  sw         $s1, 0x14($sp)
    /* C2C48 800D2448 2188E000 */  addu       $s1, $a3, $zero
    /* C2C4C 800D244C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C2C50 800D2450 3C00B38F */  lw         $s3, 0x3C($sp)
    /* C2C54 800D2454 2400BFAF */  sw         $ra, 0x24($sp)
    /* C2C58 800D2458 94CD030C */  jal        SetPolyFT4
    /* C2C5C 800D245C 040002AE */   sw        $v0, 0x4($s0)
    /* C2C60 800D2460 21200002 */  addu       $a0, $s0, $zero
    /* C2C64 800D2464 3FCC030C */  jal        SetSemiTrans
    /* C2C68 800D2468 21286002 */   addu      $a1, $s3, $zero
    /* C2C6C 800D246C 10004286 */  lh         $v0, 0x10($s2)
    /* C2C70 800D2470 001C1100 */  sll        $v1, $s1, 16
    /* C2C74 800D2474 21108202 */  addu       $v0, $s4, $v0
    /* C2C78 800D2478 25106200 */  or         $v0, $v1, $v0
    /* C2C7C 800D247C 080002AE */  sw         $v0, 0x8($s0)
    /* C2C80 800D2480 0000428E */  lw         $v0, 0x0($s2)
    /* C2C84 800D2484 25187400 */  or         $v1, $v1, $s4
    /* C2C88 800D2488 100003AE */  sw         $v1, 0x10($s0)
    /* C2C8C 800D248C 0C0002AE */  sw         $v0, 0xC($s0)
    /* C2C90 800D2490 0400428E */  lw         $v0, 0x4($s2)
    /* C2C94 800D2494 00000000 */  nop
    /* C2C98 800D2498 140002AE */  sw         $v0, 0x14($s0)
    /* C2C9C 800D249C 14000292 */  lbu        $v0, 0x14($s0)
    /* C2CA0 800D24A0 00000000 */  nop
    /* C2CA4 800D24A4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* C2CA8 800D24A8 140002A2 */  sb         $v0, 0x14($s0)
    /* C2CAC 800D24AC 12004286 */  lh         $v0, 0x12($s2)
    /* C2CB0 800D24B0 10004386 */  lh         $v1, 0x10($s2)
    /* C2CB4 800D24B4 21102202 */  addu       $v0, $s1, $v0
    /* C2CB8 800D24B8 00140200 */  sll        $v0, $v0, 16
    /* C2CBC 800D24BC 21188302 */  addu       $v1, $s4, $v1
    /* C2CC0 800D24C0 25104300 */  or         $v0, $v0, $v1
    /* C2CC4 800D24C4 180002AE */  sw         $v0, 0x18($s0)
    /* C2CC8 800D24C8 0800428E */  lw         $v0, 0x8($s2)
    /* C2CCC 800D24CC 00000000 */  nop
    /* C2CD0 800D24D0 1C0002AE */  sw         $v0, 0x1C($s0)
    /* C2CD4 800D24D4 12004286 */  lh         $v0, 0x12($s2)
    /* C2CD8 800D24D8 00000000 */  nop
    /* C2CDC 800D24DC 21882202 */  addu       $s1, $s1, $v0
    /* C2CE0 800D24E0 008C1100 */  sll        $s1, $s1, 16
    /* C2CE4 800D24E4 25883402 */  or         $s1, $s1, $s4
    /* C2CE8 800D24E8 200011AE */  sw         $s1, 0x20($s0)
    /* C2CEC 800D24EC 0C00428E */  lw         $v0, 0xC($s2)
    /* C2CF0 800D24F0 00000000 */  nop
    /* C2CF4 800D24F4 240002AE */  sw         $v0, 0x24($s0)
    /* C2CF8 800D24F8 24000292 */  lbu        $v0, 0x24($s0)
    /* C2CFC 800D24FC 00000000 */  nop
    /* C2D00 800D2500 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* C2D04 800D2504 240002A2 */  sb         $v0, 0x24($s0)
    /* C2D08 800D2508 2400BF8F */  lw         $ra, 0x24($sp)
    /* C2D0C 800D250C 2000B48F */  lw         $s4, 0x20($sp)
    /* C2D10 800D2510 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2D14 800D2514 1800B28F */  lw         $s2, 0x18($sp)
    /* C2D18 800D2518 1400B18F */  lw         $s1, 0x14($sp)
    /* C2D1C 800D251C 1000B08F */  lw         $s0, 0x10($sp)
    /* C2D20 800D2520 0800E003 */  jr         $ra
    /* C2D24 800D2524 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
