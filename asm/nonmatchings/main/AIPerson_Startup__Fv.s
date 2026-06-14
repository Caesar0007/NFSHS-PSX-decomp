.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_Startup__Fv, 0x1A4

glabel AIPerson_Startup__Fv
    /* 5988C 8006908C 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 59890 80069090 8800BFAF */  sw         $ra, 0x88($sp)
    /* 59894 80069094 8400B1AF */  sw         $s1, 0x84($sp)
    /* 59898 80069098 7AA2010C */  jal        AIPerson_LoadGridAndSetPersonalityIndexes__Fv
    /* 5989C 8006909C 8000B0AF */   sw        $s0, 0x80($sp)
    /* 598A0 800690A0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 598A4 800690A4 1180023C */  lui        $v0, %hi(Paths_Paths)
    /* 598A8 800690A8 68645124 */  addiu      $s1, $v0, %lo(Paths_Paths)
    /* 598AC 800690AC 0580053C */  lui        $a1, %hi(D_80055354)
    /* 598B0 800690B0 0800268E */  lw         $a2, 0x8($s1)
    /* 598B4 800690B4 2F91030C */  jal        sprintf
    /* 598B8 800690B8 5453A524 */   addiu     $a1, $a1, %lo(D_80055354)
    /* 598BC 800690BC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 598C0 800690C0 21280000 */  addu       $a1, $zero, $zero
    /* 598C4 800690C4 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 598C8 800690C8 01000624 */   addiu     $a2, $zero, 0x1
    /* 598CC 800690CC 21804000 */  addu       $s0, $v0, $zero
    /* 598D0 800690D0 D8A2010C */  jal        AIPerson_LoadPersonalityData__FP10Udff_tInfo
    /* 598D4 800690D4 21200002 */   addu      $a0, $s0, $zero
    /* 598D8 800690D8 B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 598DC 800690DC 21200002 */   addu      $a0, $s0, $zero
    /* 598E0 800690E0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 598E4 800690E4 0580053C */  lui        $a1, %hi(D_80055364)
    /* 598E8 800690E8 0800268E */  lw         $a2, 0x8($s1)
    /* 598EC 800690EC 2F91030C */  jal        sprintf
    /* 598F0 800690F0 6453A524 */   addiu     $a1, $a1, %lo(D_80055364)
    /* 598F4 800690F4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 598F8 800690F8 21280000 */  addu       $a1, $zero, $zero
    /* 598FC 800690FC 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 59900 80069100 01000624 */   addiu     $a2, $zero, 0x1
    /* 59904 80069104 21804000 */  addu       $s0, $v0, $zero
    /* 59908 80069108 A9A3010C */  jal        AIPerson_LoadScriptData__FP10Udff_tInfo
    /* 5990C 8006910C 21200002 */   addu      $a0, $s0, $zero
    /* 59910 80069110 B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 59914 80069114 21200002 */   addu      $a0, $s0, $zero
    /* 59918 80069118 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5991C 8006911C EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 59920 80069120 01000224 */  addiu      $v0, $zero, 0x1
    /* 59924 80069124 03006210 */  beq        $v1, $v0, .L80069134
    /* 59928 80069128 05000224 */   addiu     $v0, $zero, 0x5
    /* 5992C 8006912C 1A006214 */  bne        $v1, $v0, .L80069198
    /* 59930 80069130 1180023C */   lui       $v0, %hi(GameSetup_gData)
  .L80069134:
    /* 59934 80069134 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 59938 80069138 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5993C 8006913C 00000000 */  nop
    /* 59940 80069140 6002428C */  lw         $v0, 0x260($v0)
    /* 59944 80069144 00000000 */  nop
    /* 59948 80069148 00024230 */  andi       $v0, $v0, 0x200
    /* 5994C 8006914C 0D004014 */  bnez       $v0, .L80069184
    /* 59950 80069150 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 59954 80069154 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 59958 80069158 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 5995C 8006915C 02000224 */  addiu      $v0, $zero, 0x2
    /* 59960 80069160 0D006214 */  bne        $v1, $v0, .L80069198
    /* 59964 80069164 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 59968 80069168 0400828C */  lw         $v0, 0x4($a0)
    /* 5996C 8006916C 00000000 */  nop
    /* 59970 80069170 6002428C */  lw         $v0, 0x260($v0)
    /* 59974 80069174 00000000 */  nop
    /* 59978 80069178 00024230 */  andi       $v0, $v0, 0x200
    /* 5997C 8006917C 06004010 */  beqz       $v0, .L80069198
    /* 59980 80069180 1180023C */   lui       $v0, %hi(GameSetup_gData)
  .L80069184:
    /* 59984 80069184 1000A427 */  addiu      $a0, $sp, 0x10
    /* 59988 80069188 0800268E */  lw         $a2, 0x8($s1)
    /* 5998C 8006918C 0580053C */  lui        $a1, %hi(D_80055374)
    /* 59990 80069190 7AA40108 */  j          .L800691E8
    /* 59994 80069194 7453A524 */   addiu     $a1, $a1, %lo(D_80055374)
  .L80069198:
    /* 59998 80069198 EC31428C */  lw         $v0, %lo(GameSetup_gData)($v0)
    /* 5999C 8006919C 00000000 */  nop
    /* 599A0 800691A0 0200422C */  sltiu      $v0, $v0, 0x2
    /* 599A4 800691A4 0B004010 */  beqz       $v0, .L800691D4
    /* 599A8 800691A8 01000224 */   addiu     $v0, $zero, 0x1
    /* 599AC 800691AC 1480033C */  lui        $v1, %hi(Cars_gNumAIRaceCars)
    /* 599B0 800691B0 04C8638C */  lw         $v1, %lo(Cars_gNumAIRaceCars)($v1)
    /* 599B4 800691B4 00000000 */  nop
    /* 599B8 800691B8 06006214 */  bne        $v1, $v0, .L800691D4
    /* 599BC 800691BC 1180023C */   lui       $v0, %hi(D_80116470)
    /* 599C0 800691C0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 599C4 800691C4 7064468C */  lw         $a2, %lo(D_80116470)($v0)
    /* 599C8 800691C8 0580053C */  lui        $a1, %hi(D_80055384)
    /* 599CC 800691CC 7AA40108 */  j          .L800691E8
    /* 599D0 800691D0 8453A524 */   addiu     $a1, $a1, %lo(D_80055384)
  .L800691D4:
    /* 599D4 800691D4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 599D8 800691D8 1180023C */  lui        $v0, %hi(D_80116470)
    /* 599DC 800691DC 7064468C */  lw         $a2, %lo(D_80116470)($v0)
    /* 599E0 800691E0 0580053C */  lui        $a1, %hi(D_80055394)
    /* 599E4 800691E4 9453A524 */  addiu      $a1, $a1, %lo(D_80055394)
  .L800691E8:
    /* 599E8 800691E8 2F91030C */  jal        sprintf
    /* 599EC 800691EC 00000000 */   nop
    /* 599F0 800691F0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 599F4 800691F4 21280000 */  addu       $a1, $zero, $zero
    /* 599F8 800691F8 82EE020C */  jal        Udff_Opena__FPcT0i
    /* 599FC 800691FC 01000624 */   addiu     $a2, $zero, 0x1
    /* 59A00 80069200 21804000 */  addu       $s0, $v0, $zero
    /* 59A04 80069204 E0A3010C */  jal        AIPerson_LoadGlue__FP10Udff_tInfo
    /* 59A08 80069208 21200002 */   addu      $a0, $s0, $zero
    /* 59A0C 8006920C B4EE020C */  jal        Udff_Close__FP10Udff_tInfo
    /* 59A10 80069210 21200002 */   addu      $a0, $s0, $zero
    /* 59A14 80069214 BFA2010C */  jal        AIPerson_SetPersonalityPointers__Fv
    /* 59A18 80069218 00000000 */   nop
    /* 59A1C 8006921C 8800BF8F */  lw         $ra, 0x88($sp)
    /* 59A20 80069220 8400B18F */  lw         $s1, 0x84($sp)
    /* 59A24 80069224 8000B08F */  lw         $s0, 0x80($sp)
    /* 59A28 80069228 0800E003 */  jr         $ra
    /* 59A2C 8006922C 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel AIPerson_Startup__Fv
