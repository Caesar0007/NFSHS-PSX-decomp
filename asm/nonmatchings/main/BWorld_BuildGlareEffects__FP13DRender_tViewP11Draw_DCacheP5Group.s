.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group, 0x158

glabel BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
    /* 6DEC0 8007D6C0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 6DEC4 8007D6C4 3800B4AF */  sw         $s4, 0x38($sp)
    /* 6DEC8 8007D6C8 21A08000 */  addu       $s4, $a0, $zero
    /* 6DECC 8007D6CC 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* 6DED0 8007D6D0 21A8A000 */  addu       $s5, $a1, $zero
    /* 6DED4 8007D6D4 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* 6DED8 8007D6D8 21880000 */  addu       $s1, $zero, $zero
    /* 6DEDC 8007D6DC 3000B2AF */  sw         $s2, 0x30($sp)
    /* 6DEE0 8007D6E0 0400D224 */  addiu      $s2, $a2, 0x4
    /* 6DEE4 8007D6E4 2800B0AF */  sw         $s0, 0x28($sp)
    /* 6DEE8 8007D6E8 21804002 */  addu       $s0, $s2, $zero
    /* 6DEEC 8007D6EC 4000BFAF */  sw         $ra, 0x40($sp)
    /* 6DEF0 8007D6F0 3400B3AF */  sw         $s3, 0x34($sp)
    /* 6DEF4 8007D6F4 0000D38C */  lw         $s3, 0x0($a2)
  .L8007D6F8:
    /* 6DEF8 8007D6F8 00000000 */  nop
    /* 6DEFC 8007D6FC 2A103302 */  slt        $v0, $s1, $s3
    /* 6DF00 8007D700 3C004010 */  beqz       $v0, .L8007D7F4
    /* 6DF04 8007D704 64000224 */   addiu     $v0, $zero, 0x64
    /* 6DF08 8007D708 0E000496 */  lhu        $a0, 0xE($s0)
    /* 6DF0C 8007D70C 0C000686 */  lh         $a2, 0xC($s0)
    /* 6DF10 8007D710 0C000996 */  lhu        $t1, 0xC($s0)
    /* 6DF14 8007D714 1000C214 */  bne        $a2, $v0, .L8007D758
    /* 6DF18 8007D718 00140400 */   sll       $v0, $a0, 16
    /* 6DF1C 8007D71C 0580023C */  lui        $v0, %hi(D_80055880)
    /* 6DF20 8007D720 80584D24 */  addiu      $t5, $v0, %lo(D_80055880)
    /* 6DF24 8007D724 0000AA8D */  lw         $t2, 0x0($t5)
    /* 6DF28 8007D728 0400AB8D */  lw         $t3, 0x4($t5)
    /* 6DF2C 8007D72C 0800AC8D */  lw         $t4, 0x8($t5)
    /* 6DF30 8007D730 1800AAAF */  sw         $t2, 0x18($sp)
    /* 6DF34 8007D734 1C00ABAF */  sw         $t3, 0x1C($sp)
    /* 6DF38 8007D738 2000ACAF */  sw         $t4, 0x20($sp)
    /* 6DF3C 8007D73C 21202002 */  addu       $a0, $s1, $zero
    /* 6DF40 8007D740 01010524 */  addiu      $a1, $zero, 0x101
    /* 6DF44 8007D744 21300002 */  addu       $a2, $s0, $zero
    /* 6DF48 8007D748 1AEC020C */  jal        TrgSfx_AddEnviroEffect__FiiP8coorddefT2
    /* 6DF4C 8007D74C 1800A727 */   addiu     $a3, $sp, 0x18
    /* 6DF50 8007D750 FDF50108 */  j          .L8007D7F4
    /* 6DF54 8007D754 00000000 */   nop
  .L8007D758:
    /* 6DF58 8007D758 1E004010 */  beqz       $v0, .L8007D7D4
    /* 6DF5C 8007D75C 21380000 */   addu      $a3, $zero, $zero
    /* 6DF60 8007D760 FF7F8530 */  andi       $a1, $a0, 0x7FFF
    /* 6DF64 8007D764 2140E000 */  addu       $t0, $a3, $zero
    /* 6DF68 8007D768 21184002 */  addu       $v1, $s2, $zero
  .L8007D76C:
    /* 6DF6C 8007D76C 2A101301 */  slt        $v0, $t0, $s3
    /* 6DF70 8007D770 09004010 */  beqz       $v0, .L8007D798
    /* 6DF74 8007D774 00000000 */   nop
    /* 6DF78 8007D778 0E006294 */  lhu        $v0, 0xE($v1)
    /* 6DF7C 8007D77C 00000000 */  nop
    /* 6DF80 8007D780 FF7F4230 */  andi       $v0, $v0, 0x7FFF
    /* 6DF84 8007D784 0300A210 */  beq        $a1, $v0, .L8007D794
    /* 6DF88 8007D788 10006324 */   addiu     $v1, $v1, 0x10
    /* 6DF8C 8007D78C DBF50108 */  j          .L8007D76C
    /* 6DF90 8007D790 01000825 */   addiu     $t0, $t0, 0x1
  .L8007D794:
    /* 6DF94 8007D794 01000724 */  addiu      $a3, $zero, 0x1
  .L8007D798:
    /* 6DF98 8007D798 1300E010 */  beqz       $a3, .L8007D7E8
    /* 6DF9C 8007D79C 00140400 */   sll       $v0, $a0, 16
    /* 6DFA0 8007D7A0 11004104 */  bgez       $v0, .L8007D7E8
    /* 6DFA4 8007D7A4 21208002 */   addu      $a0, $s4, $zero
    /* 6DFA8 8007D7A8 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 6DFAC 8007D7AC 00340900 */  sll        $a2, $t1, 16
    /* 6DFB0 8007D7B0 03340600 */  sra        $a2, $a2, 16
    /* 6DFB4 8007D7B4 21380002 */  addu       $a3, $s0, $zero
    /* 6DFB8 8007D7B8 00110800 */  sll        $v0, $t0, 4
    /* 6DFBC 8007D7BC 21104202 */  addu       $v0, $s2, $v0
    /* 6DFC0 8007D7C0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6DFC4 8007D7C4 4C35030C */  jal        Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache
    /* 6DFC8 8007D7C8 1400B5AF */   sw        $s5, 0x14($sp)
    /* 6DFCC 8007D7CC FBF50108 */  j          .L8007D7EC
    /* 6DFD0 8007D7D0 10001026 */   addiu     $s0, $s0, 0x10
  .L8007D7D4:
    /* 6DFD4 8007D7D4 1000B5AF */  sw         $s5, 0x10($sp)
    /* 6DFD8 8007D7D8 21208002 */  addu       $a0, $s4, $zero
    /* 6DFDC 8007D7DC FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 6DFE0 8007D7E0 A737030C */  jal        Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache
    /* 6DFE4 8007D7E4 21380002 */   addu      $a3, $s0, $zero
  .L8007D7E8:
    /* 6DFE8 8007D7E8 10001026 */  addiu      $s0, $s0, 0x10
  .L8007D7EC:
    /* 6DFEC 8007D7EC BEF50108 */  j          .L8007D6F8
    /* 6DFF0 8007D7F0 01003126 */   addiu     $s1, $s1, 0x1
  .L8007D7F4:
    /* 6DFF4 8007D7F4 4000BF8F */  lw         $ra, 0x40($sp)
    /* 6DFF8 8007D7F8 3C00B58F */  lw         $s5, 0x3C($sp)
    /* 6DFFC 8007D7FC 3800B48F */  lw         $s4, 0x38($sp)
    /* 6E000 8007D800 3400B38F */  lw         $s3, 0x34($sp)
    /* 6E004 8007D804 3000B28F */  lw         $s2, 0x30($sp)
    /* 6E008 8007D808 2C00B18F */  lw         $s1, 0x2C($sp)
    /* 6E00C 8007D80C 2800B08F */  lw         $s0, 0x28($sp)
    /* 6E010 8007D810 0800E003 */  jr         $ra
    /* 6E014 8007D814 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group
