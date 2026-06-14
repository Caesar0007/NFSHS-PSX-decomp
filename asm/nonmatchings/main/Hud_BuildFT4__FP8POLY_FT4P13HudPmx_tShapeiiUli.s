.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli, 0xF0

glabel Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C2B34 800D2334 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* C2B38 800D2338 3800A28F */  lw         $v0, 0x38($sp)
    /* C2B3C 800D233C 1000B0AF */  sw         $s0, 0x10($sp)
    /* C2B40 800D2340 21808000 */  addu       $s0, $a0, $zero
    /* C2B44 800D2344 1800B2AF */  sw         $s2, 0x18($sp)
    /* C2B48 800D2348 2190A000 */  addu       $s2, $a1, $zero
    /* C2B4C 800D234C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C2B50 800D2350 2198C000 */  addu       $s3, $a2, $zero
    /* C2B54 800D2354 1400B1AF */  sw         $s1, 0x14($sp)
    /* C2B58 800D2358 2188E000 */  addu       $s1, $a3, $zero
    /* C2B5C 800D235C 2000B4AF */  sw         $s4, 0x20($sp)
    /* C2B60 800D2360 3C00B48F */  lw         $s4, 0x3C($sp)
    /* C2B64 800D2364 2400BFAF */  sw         $ra, 0x24($sp)
    /* C2B68 800D2368 94CD030C */  jal        SetPolyFT4
    /* C2B6C 800D236C 040002AE */   sw        $v0, 0x4($s0)
    /* C2B70 800D2370 21200002 */  addu       $a0, $s0, $zero
    /* C2B74 800D2374 3FCC030C */  jal        SetSemiTrans
    /* C2B78 800D2378 21288002 */   addu      $a1, $s4, $zero
    /* C2B7C 800D237C 001C1100 */  sll        $v1, $s1, 16
    /* C2B80 800D2380 25107300 */  or         $v0, $v1, $s3
    /* C2B84 800D2384 080002AE */  sw         $v0, 0x8($s0)
    /* C2B88 800D2388 0000428E */  lw         $v0, 0x0($s2)
    /* C2B8C 800D238C 00000000 */  nop
    /* C2B90 800D2390 0C0002AE */  sw         $v0, 0xC($s0)
    /* C2B94 800D2394 10004286 */  lh         $v0, 0x10($s2)
    /* C2B98 800D2398 00000000 */  nop
    /* C2B9C 800D239C 21106202 */  addu       $v0, $s3, $v0
    /* C2BA0 800D23A0 25186200 */  or         $v1, $v1, $v0
    /* C2BA4 800D23A4 100003AE */  sw         $v1, 0x10($s0)
    /* C2BA8 800D23A8 0400428E */  lw         $v0, 0x4($s2)
    /* C2BAC 800D23AC 00000000 */  nop
    /* C2BB0 800D23B0 140002AE */  sw         $v0, 0x14($s0)
    /* C2BB4 800D23B4 12004286 */  lh         $v0, 0x12($s2)
    /* C2BB8 800D23B8 00000000 */  nop
    /* C2BBC 800D23BC 21102202 */  addu       $v0, $s1, $v0
    /* C2BC0 800D23C0 00140200 */  sll        $v0, $v0, 16
    /* C2BC4 800D23C4 25105300 */  or         $v0, $v0, $s3
    /* C2BC8 800D23C8 180002AE */  sw         $v0, 0x18($s0)
    /* C2BCC 800D23CC 0800428E */  lw         $v0, 0x8($s2)
    /* C2BD0 800D23D0 00000000 */  nop
    /* C2BD4 800D23D4 1C0002AE */  sw         $v0, 0x1C($s0)
    /* C2BD8 800D23D8 12004286 */  lh         $v0, 0x12($s2)
    /* C2BDC 800D23DC 00000000 */  nop
    /* C2BE0 800D23E0 21882202 */  addu       $s1, $s1, $v0
    /* C2BE4 800D23E4 10004286 */  lh         $v0, 0x10($s2)
    /* C2BE8 800D23E8 008C1100 */  sll        $s1, $s1, 16
    /* C2BEC 800D23EC 21986202 */  addu       $s3, $s3, $v0
    /* C2BF0 800D23F0 25883302 */  or         $s1, $s1, $s3
    /* C2BF4 800D23F4 200011AE */  sw         $s1, 0x20($s0)
    /* C2BF8 800D23F8 0C00428E */  lw         $v0, 0xC($s2)
    /* C2BFC 800D23FC 00000000 */  nop
    /* C2C00 800D2400 240002AE */  sw         $v0, 0x24($s0)
    /* C2C04 800D2404 2400BF8F */  lw         $ra, 0x24($sp)
    /* C2C08 800D2408 2000B48F */  lw         $s4, 0x20($sp)
    /* C2C0C 800D240C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C2C10 800D2410 1800B28F */  lw         $s2, 0x18($sp)
    /* C2C14 800D2414 1400B18F */  lw         $s1, 0x14($sp)
    /* C2C18 800D2418 1000B08F */  lw         $s0, 0x10($sp)
    /* C2C1C 800D241C 0800E003 */  jr         $ra
    /* C2C20 800D2420 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
