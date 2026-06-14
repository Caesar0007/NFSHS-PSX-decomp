.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetNewTargetCar__10AIDelayCarP8Car_tObj, 0xE8

glabel SetNewTargetCar__10AIDelayCarP8Car_tObj
    /* 4B25C 8005AA5C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4B260 8005AA60 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4B264 8005AA64 21808000 */  addu       $s0, $a0, $zero
    /* 4B268 8005AA68 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4B26C 8005AA6C 0400048E */  lw         $a0, 0x4($s0)
    /* 4B270 8005AA70 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 4B274 8005AA74 080005AE */   sw        $a1, 0x8($s0)
    /* 4B278 8005AA78 0800038E */  lw         $v1, 0x8($s0)
    /* 4B27C 8005AA7C 0C0002AE */  sw         $v0, 0xC($s0)
    /* 4B280 8005AA80 08006284 */  lh         $v0, 0x8($v1)
    /* 4B284 8005AA84 00000000 */  nop
    /* 4B288 8005AA88 100002AE */  sw         $v0, 0x10($s0)
    /* 4B28C 8005AA8C 0400028E */  lw         $v0, 0x4($s0)
    /* 4B290 8005AA90 A000638C */  lw         $v1, 0xA0($v1)
    /* 4B294 8005AA94 A000428C */  lw         $v0, 0xA0($v0)
    /* 4B298 8005AA98 00000000 */  nop
    /* 4B29C 8005AA9C 23104300 */  subu       $v0, $v0, $v1
    /* 4B2A0 8005AAA0 140002AE */  sw         $v0, 0x14($s0)
    /* 4B2A4 8005AAA4 0400028E */  lw         $v0, 0x4($s0)
    /* 4B2A8 8005AAA8 0800038E */  lw         $v1, 0x8($s0)
    /* 4B2AC 8005AAAC A400428C */  lw         $v0, 0xA4($v0)
    /* 4B2B0 8005AAB0 A400638C */  lw         $v1, 0xA4($v1)
    /* 4B2B4 8005AAB4 00000000 */  nop
    /* 4B2B8 8005AAB8 23104300 */  subu       $v0, $v0, $v1
    /* 4B2BC 8005AABC 180002AE */  sw         $v0, 0x18($s0)
    /* 4B2C0 8005AAC0 0400028E */  lw         $v0, 0x4($s0)
    /* 4B2C4 8005AAC4 0800038E */  lw         $v1, 0x8($s0)
    /* 4B2C8 8005AAC8 A800428C */  lw         $v0, 0xA8($v0)
    /* 4B2CC 8005AACC A800638C */  lw         $v1, 0xA8($v1)
    /* 4B2D0 8005AAD0 0800048E */  lw         $a0, 0x8($s0)
    /* 4B2D4 8005AAD4 23104300 */  subu       $v0, $v0, $v1
    /* 4B2D8 8005AAD8 1C0002AE */  sw         $v0, 0x1C($s0)
    /* 4B2DC 8005AADC A000868C */  lw         $a2, 0xA0($a0)
    /* 4B2E0 8005AAE0 A400878C */  lw         $a3, 0xA4($a0)
    /* 4B2E4 8005AAE4 A800888C */  lw         $t0, 0xA8($a0)
    /* 4B2E8 8005AAE8 200006AE */  sw         $a2, 0x20($s0)
    /* 4B2EC 8005AAEC 240007AE */  sw         $a3, 0x24($s0)
    /* 4B2F0 8005AAF0 280008AE */  sw         $t0, 0x28($s0)
    /* 4B2F4 8005AAF4 0400028E */  lw         $v0, 0x4($s0)
    /* 4B2F8 8005AAF8 0800038E */  lw         $v1, 0x8($s0)
    /* 4B2FC 8005AAFC 7405428C */  lw         $v0, 0x574($v0)
    /* 4B300 8005AB00 7405638C */  lw         $v1, 0x574($v1)
    /* 4B304 8005AB04 0800048E */  lw         $a0, 0x8($s0)
    /* 4B308 8005AB08 23104300 */  subu       $v0, $v0, $v1
    /* 4B30C 8005AB0C 2C0002AE */  sw         $v0, 0x2C($s0)
    /* 4B310 8005AB10 7405828C */  lw         $v0, 0x574($a0)
    /* 4B314 8005AB14 21188000 */  addu       $v1, $a0, $zero
    /* 4B318 8005AB18 300002AE */  sw         $v0, 0x30($s0)
    /* 4B31C 8005AB1C C406628C */  lw         $v0, 0x6C4($v1)
    /* 4B320 8005AB20 00000000 */  nop
    /* 4B324 8005AB24 340002AE */  sw         $v0, 0x34($s0)
    /* 4B328 8005AB28 6405628C */  lw         $v0, 0x564($v1)
    /* 4B32C 8005AB2C 00000000 */  nop
    /* 4B330 8005AB30 380002AE */  sw         $v0, 0x38($s0)
    /* 4B334 8005AB34 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4B338 8005AB38 1000B08F */  lw         $s0, 0x10($sp)
    /* 4B33C 8005AB3C 0800E003 */  jr         $ra
    /* 4B340 8005AB40 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SetNewTargetCar__10AIDelayCarP8Car_tObj
