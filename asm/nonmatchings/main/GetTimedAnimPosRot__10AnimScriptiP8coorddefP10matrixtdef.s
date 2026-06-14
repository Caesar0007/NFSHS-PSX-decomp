.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef, 0xF8

glabel GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
    /* 64E24 80074624 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 64E28 80074628 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 64E2C 8007462C 21888000 */  addu       $s1, $a0, $zero
    /* 64E30 80074630 2000B2AF */  sw         $s2, 0x20($sp)
    /* 64E34 80074634 2190A000 */  addu       $s2, $a1, $zero
    /* 64E38 80074638 2400B3AF */  sw         $s3, 0x24($sp)
    /* 64E3C 8007463C 2198C000 */  addu       $s3, $a2, $zero
    /* 64E40 80074640 1800B0AF */  sw         $s0, 0x18($sp)
    /* 64E44 80074644 2800BFAF */  sw         $ra, 0x28($sp)
    /* 64E48 80074648 C7D1010C */  jal        GetStatus__10AnimScript
    /* 64E4C 8007464C 2180E000 */   addu      $s0, $a3, $zero
    /* 64E50 80074650 01000324 */  addiu      $v1, $zero, 0x1
    /* 64E54 80074654 2A004314 */  bne        $v0, $v1, .L80074700
    /* 64E58 80074658 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 64E5C 8007465C 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 64E60 80074660 0000258E */  lw         $a1, 0x0($s1)
    /* 64E64 80074664 1000228E */  lw         $v0, 0x10($s1)
    /* 64E68 80074668 B0E0668C */  lw         $a2, %lo(D_8011E0B0)($v1)
    /* 64E6C 8007466C 80901200 */  sll        $s2, $s2, 2
    /* 64E70 80074670 1000B0AF */  sw         $s0, 0x10($sp)
    /* 64E74 80074674 21104202 */  addu       $v0, $s2, $v0
    /* 64E78 80074678 2330C500 */  subu       $a2, $a2, $a1
    /* 64E7C 8007467C 0000448C */  lw         $a0, 0x0($v0)
    /* 64E80 80074680 0800258E */  lw         $a1, 0x8($s1)
    /* 64E84 80074684 C6CF010C */  jal        Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef
    /* 64E88 80074688 21386002 */   addu      $a3, $s3, $zero
    /* 64E8C 8007468C 07004014 */  bnez       $v0, .L800746AC
    /* 64E90 80074690 21100000 */   addu      $v0, $zero, $zero
    /* 64E94 80074694 1000238E */  lw         $v1, 0x10($s1)
    /* 64E98 80074698 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* 64E9C 8007469C 000024AE */  sw         $a0, 0x0($s1)
    /* 64EA0 800746A0 21184302 */  addu       $v1, $s2, $v1
    /* 64EA4 800746A4 C0D10108 */  j          .L80074700
    /* 64EA8 800746A8 000060AC */   sw        $zero, 0x0($v1)
  .L800746AC:
    /* 64EAC 800746AC 0800228E */  lw         $v0, 0x8($s1)
    /* 64EB0 800746B0 00000000 */  nop
    /* 64EB4 800746B4 04004230 */  andi       $v0, $v0, 0x4
    /* 64EB8 800746B8 11004010 */  beqz       $v0, .L80074700
    /* 64EBC 800746BC 01000224 */   addiu     $v0, $zero, 0x1
    /* 64EC0 800746C0 0C00078E */  lw         $a3, 0xC($s0)
    /* 64EC4 800746C4 1800028E */  lw         $v0, 0x18($s0)
    /* 64EC8 800746C8 1C00038E */  lw         $v1, 0x1C($s0)
    /* 64ECC 800746CC 23280700 */  negu       $a1, $a3
    /* 64ED0 800746D0 1000078E */  lw         $a3, 0x10($s0)
    /* 64ED4 800746D4 2000048E */  lw         $a0, 0x20($s0)
    /* 64ED8 800746D8 23300700 */  negu       $a2, $a3
    /* 64EDC 800746DC 1400078E */  lw         $a3, 0x14($s0)
    /* 64EE0 800746E0 0C0002AE */  sw         $v0, 0xC($s0)
    /* 64EE4 800746E4 180005AE */  sw         $a1, 0x18($s0)
    /* 64EE8 800746E8 100003AE */  sw         $v1, 0x10($s0)
    /* 64EEC 800746EC 1C0006AE */  sw         $a2, 0x1C($s0)
    /* 64EF0 800746F0 140004AE */  sw         $a0, 0x14($s0)
    /* 64EF4 800746F4 23100700 */  negu       $v0, $a3
    /* 64EF8 800746F8 200002AE */  sw         $v0, 0x20($s0)
    /* 64EFC 800746FC 01000224 */  addiu      $v0, $zero, 0x1
  .L80074700:
    /* 64F00 80074700 2800BF8F */  lw         $ra, 0x28($sp)
    /* 64F04 80074704 2400B38F */  lw         $s3, 0x24($sp)
    /* 64F08 80074708 2000B28F */  lw         $s2, 0x20($sp)
    /* 64F0C 8007470C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 64F10 80074710 1800B08F */  lw         $s0, 0x18($sp)
    /* 64F14 80074714 0800E003 */  jr         $ra
    /* 64F18 80074718 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
