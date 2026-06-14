.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_SysStartUp__FiiPc, 0xF8

glabel AudioMus_SysStartUp__FiiPc
    /* 6B418 8007AC18 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B41C 8007AC1C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6B420 8007AC20 1000B0AF */  sw         $s0, 0x10($sp)
    /* 6B424 8007AC24 21808000 */  addu       $s0, $a0, $zero
    /* 6B428 8007AC28 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6B42C 8007AC2C 2188A000 */  addu       $s1, $a1, $zero
    /* 6B430 8007AC30 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6B434 8007AC34 2190C000 */  addu       $s2, $a2, $zero
    /* 6B438 8007AC38 2F004014 */  bnez       $v0, .L8007ACF8
    /* 6B43C 8007AC3C 1C00BFAF */   sw        $ra, 0x1C($sp)
    /* 6B440 8007AC40 0580043C */  lui        $a0, %hi(D_800557B0)
    /* 6B444 8007AC44 B0578424 */  addiu      $a0, $a0, %lo(D_800557B0)
    /* 6B448 8007AC48 58010524 */  addiu      $a1, $zero, 0x158
    /* 6B44C 8007AC4C CF94030C */  jal        reservememadr
    /* 6B450 8007AC50 21300000 */   addu      $a2, $zero, $zero
    /* 6B454 8007AC54 D40182AF */  sw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B458 8007AC58 27004010 */  beqz       $v0, .L8007ACF8
    /* 6B45C 8007AC5C 00000000 */   nop
    /* 6B460 8007AC60 95EA010C */  jal        AudioMus_InitGlobals__Fv
    /* 6B464 8007AC64 00000000 */   nop
    /* 6B468 8007AC68 02000106 */  bgez       $s0, .L8007AC74
    /* 6B46C 8007AC6C 21280002 */   addu      $a1, $s0, $zero
    /* 6B470 8007AC70 FF030526 */  addiu      $a1, $s0, 0x3FF
  .L8007AC74:
    /* 6B474 8007AC74 01000424 */  addiu      $a0, $zero, 0x1
    /* 6B478 8007AC78 25A8030C */  jal        SNDSTRM_overhead
    /* 6B47C 8007AC7C 832A0500 */   sra       $a1, $a1, 10
    /* 6B480 8007AC80 0580043C */  lui        $a0, %hi(D_800557C0)
    /* 6B484 8007AC84 C0578424 */  addiu      $a0, $a0, %lo(D_800557C0)
    /* 6B488 8007AC88 21280202 */  addu       $a1, $s0, $v0
    /* 6B48C 8007AC8C CF94030C */  jal        reservememadr
    /* 6B490 8007AC90 21300000 */   addu      $a2, $zero, $zero
    /* 6B494 8007AC94 21200002 */  addu       $a0, $s0, $zero
    /* 6B498 8007AC98 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B49C 8007AC9C 21282002 */  addu       $a1, $s1, $zero
    /* 6B4A0 8007ACA0 B5EA010C */  jal        AudioMus_DriverStartUp__Fii
    /* 6B4A4 8007ACA4 700062AC */   sw        $v0, 0x70($v1)
    /* 6B4A8 8007ACA8 0580053C */  lui        $a1, %hi(D_800557D0)
    /* 6B4AC 8007ACAC D057A524 */  addiu      $a1, $a1, %lo(D_800557D0)
    /* 6B4B0 8007ACB0 1180023C */  lui        $v0, %hi(D_801164D4)
    /* 6B4B4 8007ACB4 21384002 */  addu       $a3, $s2, $zero
    /* 6B4B8 8007ACB8 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6B4BC 8007ACBC D464468C */  lw         $a2, %lo(D_801164D4)($v0)
    /* 6B4C0 8007ACC0 2F91030C */  jal        sprintf
    /* 6B4C4 8007ACC4 AC008424 */   addiu     $a0, $a0, 0xAC
    /* 6B4C8 8007ACC8 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6B4CC 8007ACCC 21280000 */  addu       $a1, $zero, $zero
    /* 6B4D0 8007ACD0 9F96030C */  jal        loadbigfileheader
    /* 6B4D4 8007ACD4 AC008424 */   addiu     $a0, $a0, 0xAC
    /* 6B4D8 8007ACD8 D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B4DC 8007ACDC 06004010 */  beqz       $v0, .L8007ACF8
    /* 6B4E0 8007ACE0 8C0062AC */   sw        $v0, 0x8C($v1)
    /* 6B4E4 8007ACE4 9698030C */  jal        bigcount
    /* 6B4E8 8007ACE8 21204000 */   addu      $a0, $v0, $zero
    /* 6B4EC 8007ACEC D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6B4F0 8007ACF0 00000000 */  nop
    /* 6B4F4 8007ACF4 040062AC */  sw         $v0, 0x4($v1)
  .L8007ACF8:
    /* 6B4F8 8007ACF8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6B4FC 8007ACFC 1800B28F */  lw         $s2, 0x18($sp)
    /* 6B500 8007AD00 1400B18F */  lw         $s1, 0x14($sp)
    /* 6B504 8007AD04 1000B08F */  lw         $s0, 0x10($sp)
    /* 6B508 8007AD08 0800E003 */  jr         $ra
    /* 6B50C 8007AD0C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioMus_SysStartUp__FiiPc
