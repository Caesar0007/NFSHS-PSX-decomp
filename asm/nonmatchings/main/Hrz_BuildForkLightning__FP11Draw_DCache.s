.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_BuildForkLightning__FP11Draw_DCache, 0x11C

glabel Hrz_BuildForkLightning__FP11Draw_DCache
    /* C0E44 800D0644 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* C0E48 800D0648 1280023C */  lui        $v0, %hi(gHrz_Lightning)
    /* C0E4C 800D064C 3400B1AF */  sw         $s1, 0x34($sp)
    /* C0E50 800D0650 BC085124 */  addiu      $s1, $v0, %lo(gHrz_Lightning)
    /* C0E54 800D0654 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* C0E58 800D0658 3800B2AF */  sw         $s2, 0x38($sp)
    /* C0E5C 800D065C 3000B0AF */  sw         $s0, 0x30($sp)
    /* C0E60 800D0660 6000228E */  lw         $v0, 0x60($s1)
    /* C0E64 800D0664 00000000 */  nop
    /* C0E68 800D0668 37004018 */  blez       $v0, .L800D0748
    /* C0E6C 800D066C 21908000 */   addu      $s2, $a0, $zero
    /* C0E70 800D0670 2000B027 */  addiu      $s0, $sp, 0x20
    /* C0E74 800D0674 21200002 */  addu       $a0, $s0, $zero
    /* C0E78 800D0678 21280000 */  addu       $a1, $zero, $zero
    /* C0E7C 800D067C 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* C0E80 800D0680 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* C0E84 800D0684 0C000624 */  addiu      $a2, $zero, 0xC
    /* C0E88 800D0688 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* C0E8C 800D068C C690030C */  jal        memset
    /* C0E90 800D0690 940042AE */   sw        $v0, 0x94($s2)
    /* C0E94 800D0694 4742030C */  jal        HrzSetPsxTranslation__FP8coorddef
    /* C0E98 800D0698 21200002 */   addu      $a0, $s0, $zero
    /* C0E9C 800D069C 1480083C */  lui        $t0, %hi(Hrz_gLightningPosInSky)
    /* C0EA0 800D06A0 94D80825 */  addiu      $t0, $t0, %lo(Hrz_gLightningPosInSky)
    /* C0EA4 800D06A4 000000C9 */  lwc2       $0, 0x0($t0)
    /* C0EA8 800D06A8 040001C9 */  lwc2       $1, 0x4($t0)
    /* C0EAC 800D06AC 00000000 */  nop
    /* C0EB0 800D06B0 00000000 */  nop
    /* C0EB4 800D06B4 0100184A */  .word 0x4A180001  /* rtps */
    /* C0EB8 800D06B8 1800A227 */  addiu      $v0, $sp, 0x18
    /* C0EBC 800D06BC 00004EE8 */  swc2       $14, 0x0($v0)
    /* C0EC0 800D06C0 64002292 */  lbu        $v0, 0x64($s1)
    /* C0EC4 800D06C4 00000000 */  nop
    /* C0EC8 800D06C8 19004010 */  beqz       $v0, .L800D0730
    /* C0ECC 800D06CC 21800000 */   addu      $s0, $zero, $zero
    /* C0ED0 800D06D0 1000A427 */  addiu      $a0, $sp, 0x10
  .L800D06D4:
    /* C0ED4 800D06D4 FF000232 */  andi       $v0, $s0, 0xFF
    /* C0ED8 800D06D8 40180200 */  sll        $v1, $v0, 1
    /* C0EDC 800D06DC 21186200 */  addu       $v1, $v1, $v0
    /* C0EE0 800D06E0 40180300 */  sll        $v1, $v1, 1
    /* C0EE4 800D06E4 21187100 */  addu       $v1, $v1, $s1
    /* C0EE8 800D06E8 00006294 */  lhu        $v0, 0x0($v1)
    /* C0EEC 800D06EC 1800A597 */  lhu        $a1, 0x18($sp)
    /* C0EF0 800D06F0 01001026 */  addiu      $s0, $s0, 0x1
    /* C0EF4 800D06F4 21104500 */  addu       $v0, $v0, $a1
    /* C0EF8 800D06F8 1000A2A7 */  sh         $v0, 0x10($sp)
    /* C0EFC 800D06FC 02006294 */  lhu        $v0, 0x2($v1)
    /* C0F00 800D0700 1A00A597 */  lhu        $a1, 0x1A($sp)
    /* C0F04 800D0704 60002692 */  lbu        $a2, 0x60($s1)
    /* C0F08 800D0708 21104500 */  addu       $v0, $v0, $a1
    /* C0F0C 800D070C 1200A2A7 */  sh         $v0, 0x12($sp)
    /* C0F10 800D0710 04006590 */  lbu        $a1, 0x4($v1)
    /* C0F14 800D0714 0141030C */  jal        Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache
    /* C0F18 800D0718 21384002 */   addu      $a3, $s2, $zero
    /* C0F1C 800D071C 64002392 */  lbu        $v1, 0x64($s1)
    /* C0F20 800D0720 FF000232 */  andi       $v0, $s0, 0xFF
    /* C0F24 800D0724 2B104300 */  sltu       $v0, $v0, $v1
    /* C0F28 800D0728 EAFF4014 */  bnez       $v0, .L800D06D4
    /* C0F2C 800D072C 1000A427 */   addiu     $a0, $sp, 0x10
  .L800D0730:
    /* C0F30 800D0730 1280033C */  lui        $v1, %hi(gHrz_Lightning)
    /* C0F34 800D0734 BC086324 */  addiu      $v1, $v1, %lo(gHrz_Lightning)
    /* C0F38 800D0738 6000628C */  lw         $v0, 0x60($v1)
    /* C0F3C 800D073C 00000000 */  nop
    /* C0F40 800D0740 F0FF4224 */  addiu      $v0, $v0, -0x10
    /* C0F44 800D0744 600062AC */  sw         $v0, 0x60($v1)
  .L800D0748:
    /* C0F48 800D0748 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* C0F4C 800D074C 3800B28F */  lw         $s2, 0x38($sp)
    /* C0F50 800D0750 3400B18F */  lw         $s1, 0x34($sp)
    /* C0F54 800D0754 3000B08F */  lw         $s0, 0x30($sp)
    /* C0F58 800D0758 0800E003 */  jr         $ra
    /* C0F5C 800D075C 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Hrz_BuildForkLightning__FP11Draw_DCache
