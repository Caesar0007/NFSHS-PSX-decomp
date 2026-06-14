.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi, 0x558

glabel AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
    /* 5E138 8006D938 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5E13C 8006D93C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5E140 8006D940 21988000 */  addu       $s3, $a0, $zero
    /* 5E144 8006D944 2800B6AF */  sw         $s6, 0x28($sp)
    /* 5E148 8006D948 21B0A000 */  addu       $s6, $a1, $zero
    /* 5E14C 8006D94C 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 5E150 8006D950 2400B5AF */  sw         $s5, 0x24($sp)
    /* 5E154 8006D954 2000B4AF */  sw         $s4, 0x20($sp)
    /* 5E158 8006D958 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5E15C 8006D95C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5E160 8006D960 CDB7010C */  jal        AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj
    /* 5E164 8006D964 1000B0AF */   sw        $s0, 0x10($sp)
    /* 5E168 8006D968 6407638E */  lw         $v1, 0x764($s3)
    /* 5E16C 8006D96C 00000000 */  nop
    /* 5E170 8006D970 03006010 */  beqz       $v1, .L8006D980
    /* 5E174 8006D974 21A04000 */   addu      $s4, $v0, $zero
    /* 5E178 8006D978 82B60108 */  j          .L8006DA08
    /* 5E17C 8006D97C 0100103C */   lui       $s0, (0x10000 >> 16)
  .L8006D980:
    /* 5E180 8006D980 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5E184 8006D984 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5E188 8006D988 01000224 */  addiu      $v0, $zero, 0x1
    /* 5E18C 8006D98C 03006210 */  beq        $v1, $v0, .L8006D99C
    /* 5E190 8006D990 05000224 */   addiu     $v0, $zero, 0x5
    /* 5E194 8006D994 19006214 */  bne        $v1, $v0, .L8006D9FC
    /* 5E198 8006D998 00000000 */   nop
  .L8006D99C:
    /* 5E19C 8006D99C 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 5E1A0 8006D9A0 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5E1A4 8006D9A4 00000000 */  nop
    /* 5E1A8 8006D9A8 6002428C */  lw         $v0, 0x260($v0)
    /* 5E1AC 8006D9AC 00000000 */  nop
    /* 5E1B0 8006D9B0 00024230 */  andi       $v0, $v0, 0x200
    /* 5E1B4 8006D9B4 0D004014 */  bnez       $v0, .L8006D9EC
    /* 5E1B8 8006D9B8 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 5E1BC 8006D9BC 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 5E1C0 8006D9C0 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 5E1C4 8006D9C4 02000224 */  addiu      $v0, $zero, 0x2
    /* 5E1C8 8006D9C8 0C006214 */  bne        $v1, $v0, .L8006D9FC
    /* 5E1CC 8006D9CC 00000000 */   nop
    /* 5E1D0 8006D9D0 0400828C */  lw         $v0, 0x4($a0)
    /* 5E1D4 8006D9D4 00000000 */  nop
    /* 5E1D8 8006D9D8 6002428C */  lw         $v0, 0x260($v0)
    /* 5E1DC 8006D9DC 00000000 */  nop
    /* 5E1E0 8006D9E0 00024230 */  andi       $v0, $v0, 0x200
    /* 5E1E4 8006D9E4 05004010 */  beqz       $v0, .L8006D9FC
    /* 5E1E8 8006D9E8 00000000 */   nop
  .L8006D9EC:
    /* 5E1EC 8006D9EC 27B8010C */  jal        AISpeeds_BTCGetGlueFactor__FP8Car_tObj
    /* 5E1F0 8006D9F0 21206002 */   addu      $a0, $s3, $zero
    /* 5E1F4 8006D9F4 82B60108 */  j          .L8006DA08
    /* 5E1F8 8006D9F8 21804000 */   addu      $s0, $v0, $zero
  .L8006D9FC:
    /* 5E1FC 8006D9FC A3B9010C */  jal        AISpeeds_GetGlueFactor__FP8Car_tObj
    /* 5E200 8006DA00 21206002 */   addu      $a0, $s3, $zero
    /* 5E204 8006DA04 21804000 */  addu       $s0, $v0, $zero
  .L8006DA08:
    /* 5E208 8006DA08 29BC010C */  jal        AISpeeds_GetScriptFactor__FP8Car_tObj
    /* 5E20C 8006DA0C 21206002 */   addu      $a0, $s3, $zero
    /* 5E210 8006DA10 21206002 */  addu       $a0, $s3, $zero
    /* 5E214 8006DA14 4007718E */  lw         $s1, 0x740($s3)
    /* 5E218 8006DA18 26BA010C */  jal        AISpeeds_GetDamageFactor__FP8Car_tObj
    /* 5E21C 8006DA1C 21A84000 */   addu      $s5, $v0, $zero
    /* 5E220 8006DA20 21904000 */  addu       $s2, $v0, $zero
    /* 5E224 8006DA24 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5E228 8006DA28 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5E22C 8006DA2C 01000224 */  addiu      $v0, $zero, 0x1
    /* 5E230 8006DA30 0B006210 */  beq        $v1, $v0, .L8006DA60
    /* 5E234 8006DA34 0100023C */   lui       $v0, %hi(D_100FF)
    /* 5E238 8006DA38 1480023C */  lui        $v0, %hi(Cars_gNumAIRaceCars)
    /* 5E23C 8006DA3C 04C8428C */  lw         $v0, %lo(Cars_gNumAIRaceCars)($v0)
    /* 5E240 8006DA40 00000000 */  nop
    /* 5E244 8006DA44 02004228 */  slti       $v0, $v0, 0x2
    /* 5E248 8006DA48 05004014 */  bnez       $v0, .L8006DA60
    /* 5E24C 8006DA4C 0100023C */   lui       $v0, %hi(D_100FF)
    /* 5E250 8006DA50 B4B8010C */  jal        AISpeeds_GetCaravanFactor__FP8Car_tObj
    /* 5E254 8006DA54 21206002 */   addu      $a0, $s3, $zero
    /* 5E258 8006DA58 99B60108 */  j          .L8006DA64
    /* 5E25C 8006DA5C 21182002 */   addu      $v1, $s1, $zero
  .L8006DA60:
    /* 5E260 8006DA60 21182002 */  addu       $v1, $s1, $zero
  .L8006DA64:
    /* 5E264 8006DA64 02006104 */  bgez       $v1, .L8006DA70
    /* 5E268 8006DA68 00000000 */   nop
    /* 5E26C 8006DA6C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006DA70:
    /* 5E270 8006DA70 6800848F */  lw         $a0, %gp_rel(D_8013C5B4)($gp)
    /* 5E274 8006DA74 00000000 */  nop
    /* 5E278 8006DA78 02008104 */  bgez       $a0, .L8006DA84
    /* 5E27C 8006DA7C 032A0300 */   sra       $a1, $v1, 8
    /* 5E280 8006DA80 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8006DA84:
    /* 5E284 8006DA84 21304000 */  addu       $a2, $v0, $zero
    /* 5E288 8006DA88 0200C104 */  bgez       $a2, .L8006DA94
    /* 5E28C 8006DA8C 033A0400 */   sra       $a3, $a0, 8
    /* 5E290 8006DA90 FF00C624 */  addiu      $a2, $a2, %lo(D_100FF)
  .L8006DA94:
    /* 5E294 8006DA94 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* 5E298 8006DA98 EC310225 */  addiu      $v0, $t0, %lo(GameSetup_gData)
    /* 5E29C 8006DA9C 1000438C */  lw         $v1, 0x10($v0)
    /* 5E2A0 8006DAA0 00000000 */  nop
    /* 5E2A4 8006DAA4 02006104 */  bgez       $v1, .L8006DAB0
    /* 5E2A8 8006DAA8 03220600 */   sra       $a0, $a2, 8
    /* 5E2AC 8006DAAC FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006DAB0:
    /* 5E2B0 8006DAB0 21100002 */  addu       $v0, $s0, $zero
    /* 5E2B4 8006DAB4 02004104 */  bgez       $v0, .L8006DAC0
    /* 5E2B8 8006DAB8 031A0300 */   sra       $v1, $v1, 8
    /* 5E2BC 8006DABC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DAC0:
    /* 5E2C0 8006DAC0 03120200 */  sra        $v0, $v0, 8
    /* 5E2C4 8006DAC4 18006200 */  mult       $v1, $v0
    /* 5E2C8 8006DAC8 12100000 */  mflo       $v0
    /* 5E2CC 8006DACC 02004104 */  bgez       $v0, .L8006DAD8
    /* 5E2D0 8006DAD0 00000000 */   nop
    /* 5E2D4 8006DAD4 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DAD8:
    /* 5E2D8 8006DAD8 03120200 */  sra        $v0, $v0, 8
    /* 5E2DC 8006DADC 18008200 */  mult       $a0, $v0
    /* 5E2E0 8006DAE0 12100000 */  mflo       $v0
    /* 5E2E4 8006DAE4 02004104 */  bgez       $v0, .L8006DAF0
    /* 5E2E8 8006DAE8 00000000 */   nop
    /* 5E2EC 8006DAEC FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DAF0:
    /* 5E2F0 8006DAF0 03120200 */  sra        $v0, $v0, 8
    /* 5E2F4 8006DAF4 1800E200 */  mult       $a3, $v0
    /* 5E2F8 8006DAF8 12100000 */  mflo       $v0
    /* 5E2FC 8006DAFC 02004104 */  bgez       $v0, .L8006DB08
    /* 5E300 8006DB00 00000000 */   nop
    /* 5E304 8006DB04 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DB08:
    /* 5E308 8006DB08 03120200 */  sra        $v0, $v0, 8
    /* 5E30C 8006DB0C 1800A200 */  mult       $a1, $v0
    /* 5E310 8006DB10 12880000 */  mflo       $s1
    /* 5E314 8006DB14 02002106 */  bgez       $s1, .L8006DB20
    /* 5E318 8006DB18 21102002 */   addu      $v0, $s1, $zero
    /* 5E31C 8006DB1C FF002226 */  addiu      $v0, $s1, 0xFF
  .L8006DB20:
    /* 5E320 8006DB20 21184002 */  addu       $v1, $s2, $zero
    /* 5E324 8006DB24 02006104 */  bgez       $v1, .L8006DB30
    /* 5E328 8006DB28 032A0200 */   sra       $a1, $v0, 8
    /* 5E32C 8006DB2C FF006324 */  addiu      $v1, $v1, 0xFF
  .L8006DB30:
    /* 5E330 8006DB30 2110A002 */  addu       $v0, $s5, $zero
    /* 5E334 8006DB34 02004104 */  bgez       $v0, .L8006DB40
    /* 5E338 8006DB38 031A0300 */   sra       $v1, $v1, 8
    /* 5E33C 8006DB3C FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DB40:
    /* 5E340 8006DB40 03120200 */  sra        $v0, $v0, 8
    /* 5E344 8006DB44 18006200 */  mult       $v1, $v0
    /* 5E348 8006DB48 12100000 */  mflo       $v0
    /* 5E34C 8006DB4C 02004104 */  bgez       $v0, .L8006DB58
    /* 5E350 8006DB50 00000000 */   nop
    /* 5E354 8006DB54 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DB58:
    /* 5E358 8006DB58 03120200 */  sra        $v0, $v0, 8
    /* 5E35C 8006DB5C 1800A200 */  mult       $a1, $v0
    /* 5E360 8006DB60 EC31038D */  lw         $v1, %lo(GameSetup_gData)($t0)
    /* 5E364 8006DB64 01000224 */  addiu      $v0, $zero, 0x1
    /* 5E368 8006DB68 12800000 */  mflo       $s0
    /* 5E36C 8006DB6C 18006210 */  beq        $v1, $v0, .L8006DBD0
    /* 5E370 8006DB70 00000000 */   nop
    /* 5E374 8006DB74 06006296 */  lhu        $v0, 0x6($s3)
    /* 5E378 8006DB78 00000000 */  nop
    /* 5E37C 8006DB7C 9600422C */  sltiu      $v0, $v0, 0x96
    /* 5E380 8006DB80 13004010 */  beqz       $v0, .L8006DBD0
    /* 5E384 8006DB84 0100123C */   lui       $s2, (0x10000 >> 16)
    /* 5E388 8006DB88 06006296 */  lhu        $v0, 0x6($s3)
    /* 5E38C 8006DB8C 23205102 */  subu       $a0, $s2, $s1
    /* 5E390 8006DB90 18008200 */  mult       $a0, $v0
    /* 5E394 8006DB94 12200000 */  mflo       $a0
    /* 5E398 8006DB98 CA90030C */  jal        fixedmult
    /* 5E39C 8006DB9C B4010524 */   addiu     $a1, $zero, 0x1B4
    /* 5E3A0 8006DBA0 06006396 */  lhu        $v1, 0x6($s3)
    /* 5E3A4 8006DBA4 00000000 */  nop
    /* 5E3A8 8006DBA8 9600632C */  sltiu      $v1, $v1, 0x96
    /* 5E3AC 8006DBAC 08006010 */  beqz       $v1, .L8006DBD0
    /* 5E3B0 8006DBB0 23884202 */   subu      $s1, $s2, $v0
    /* 5E3B4 8006DBB4 06006296 */  lhu        $v0, 0x6($s3)
    /* 5E3B8 8006DBB8 23205002 */  subu       $a0, $s2, $s0
    /* 5E3BC 8006DBBC 18008200 */  mult       $a0, $v0
    /* 5E3C0 8006DBC0 12200000 */  mflo       $a0
    /* 5E3C4 8006DBC4 CA90030C */  jal        fixedmult
    /* 5E3C8 8006DBC8 B4010524 */   addiu     $a1, $zero, 0x1B4
    /* 5E3CC 8006DBCC 23804202 */  subu       $s0, $s2, $v0
  .L8006DBD0:
    /* 5E3D0 8006DBD0 27B6010C */  jal        AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
    /* 5E3D4 8006DBD4 21206002 */   addu      $a0, $s3, $zero
    /* 5E3D8 8006DBD8 21184000 */  addu       $v1, $v0, $zero
    /* 5E3DC 8006DBDC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 5E3E0 8006DBE0 12006210 */  beq        $v1, $v0, .L8006DC2C
    /* 5E3E4 8006DBE4 21206002 */   addu      $a0, $s3, $zero
    /* 5E3E8 8006DBE8 02002106 */  bgez       $s1, .L8006DBF4
    /* 5E3EC 8006DBEC 21102002 */   addu      $v0, $s1, $zero
    /* 5E3F0 8006DBF0 FF002226 */  addiu      $v0, $s1, 0xFF
  .L8006DBF4:
    /* 5E3F4 8006DBF4 21206000 */  addu       $a0, $v1, $zero
    /* 5E3F8 8006DBF8 02006104 */  bgez       $v1, .L8006DC04
    /* 5E3FC 8006DBFC 03120200 */   sra       $v0, $v0, 8
    /* 5E400 8006DC00 FF006424 */  addiu      $a0, $v1, 0xFF
  .L8006DC04:
    /* 5E404 8006DC04 03220400 */  sra        $a0, $a0, 8
    /* 5E408 8006DC08 18004400 */  mult       $v0, $a0
    /* 5E40C 8006DC0C 12880000 */  mflo       $s1
    /* 5E410 8006DC10 02000106 */  bgez       $s0, .L8006DC1C
    /* 5E414 8006DC14 21300002 */   addu      $a2, $s0, $zero
    /* 5E418 8006DC18 FF000626 */  addiu      $a2, $s0, 0xFF
  .L8006DC1C:
    /* 5E41C 8006DC1C 032A0600 */  sra        $a1, $a2, 8
    /* 5E420 8006DC20 1800A400 */  mult       $a1, $a0
    /* 5E424 8006DC24 12800000 */  mflo       $s0
    /* 5E428 8006DC28 21206002 */  addu       $a0, $s3, $zero
  .L8006DC2C:
    /* 5E42C 8006DC2C 6CBA010C */  jal        AISpeeds_LimitGlueMultiplier__FP8Car_tObji
    /* 5E430 8006DC30 21280002 */   addu      $a1, $s0, $zero
    /* 5E434 8006DC34 21206002 */  addu       $a0, $s3, $zero
    /* 5E438 8006DC38 21282002 */  addu       $a1, $s1, $zero
    /* 5E43C 8006DC3C 6CBA010C */  jal        AISpeeds_LimitGlueMultiplier__FP8Car_tObji
    /* 5E440 8006DC40 300762AE */   sw        $v0, 0x730($s3)
    /* 5E444 8006DC44 21884000 */  addu       $s1, $v0, $zero
    /* 5E448 8006DC48 3007638E */  lw         $v1, 0x730($s3)
    /* 5E44C 8006DC4C 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 5E450 8006DC50 2A108300 */  slt        $v0, $a0, $v1
    /* 5E454 8006DC54 03004010 */  beqz       $v0, .L8006DC64
    /* 5E458 8006DC58 00000000 */   nop
    /* 5E45C 8006DC5C 1AB70108 */  j          .L8006DC68
    /* 5E460 8006DC60 940063AE */   sw        $v1, 0x94($s3)
  .L8006DC64:
    /* 5E464 8006DC64 940064AE */  sw         $a0, 0x94($s3)
  .L8006DC68:
    /* 5E468 8006DC68 02008106 */  bgez       $s4, .L8006DC74
    /* 5E46C 8006DC6C 21188002 */   addu      $v1, $s4, $zero
    /* 5E470 8006DC70 FF008326 */  addiu      $v1, $s4, 0xFF
  .L8006DC74:
    /* 5E474 8006DC74 3007628E */  lw         $v0, 0x730($s3)
    /* 5E478 8006DC78 00000000 */  nop
    /* 5E47C 8006DC7C 02004104 */  bgez       $v0, .L8006DC88
    /* 5E480 8006DC80 031A0300 */   sra       $v1, $v1, 8
    /* 5E484 8006DC84 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DC88:
    /* 5E488 8006DC88 03120200 */  sra        $v0, $v0, 8
    /* 5E48C 8006DC8C 18006200 */  mult       $v1, $v0
    /* 5E490 8006DC90 12800000 */  mflo       $s0
    /* 5E494 8006DC94 21102002 */  addu       $v0, $s1, $zero
    /* 5E498 8006DC98 02004104 */  bgez       $v0, .L8006DCA4
    /* 5E49C 8006DC9C 00000000 */   nop
    /* 5E4A0 8006DCA0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006DCA4:
    /* 5E4A4 8006DCA4 03120200 */  sra        $v0, $v0, 8
    /* 5E4A8 8006DCA8 18006200 */  mult       $v1, $v0
    /* 5E4AC 8006DCAC 12500000 */  mflo       $t2
    /* 5E4B0 8006DCB0 0000CAAE */  sw         $t2, 0x0($s6)
    /* 5E4B4 8006DCB4 6002628E */  lw         $v0, 0x260($s3)
    /* 5E4B8 8006DCB8 00000000 */  nop
    /* 5E4BC 8006DCBC 01004230 */  andi       $v0, $v0, 0x1
    /* 5E4C0 8006DCC0 5F004010 */  beqz       $v0, .L8006DE40
    /* 5E4C4 8006DCC4 02000224 */   addiu     $v0, $zero, 0x2
    /* 5E4C8 8006DCC8 9003648E */  lw         $a0, 0x390($s3)
    /* 5E4CC 8006DCCC 00000000 */  nop
    /* 5E4D0 8006DCD0 5B008214 */  bne        $a0, $v0, .L8006DE40
    /* 5E4D4 8006DCD4 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 5E4D8 8006DCD8 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5E4DC 8006DCDC 01000224 */  addiu      $v0, $zero, 0x1
    /* 5E4E0 8006DCE0 03006210 */  beq        $v1, $v0, .L8006DCF0
    /* 5E4E4 8006DCE4 05000224 */   addiu     $v0, $zero, 0x5
    /* 5E4E8 8006DCE8 15006214 */  bne        $v1, $v0, .L8006DD40
    /* 5E4EC 8006DCEC 00000000 */   nop
  .L8006DCF0:
    /* 5E4F0 8006DCF0 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 5E4F4 8006DCF4 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5E4F8 8006DCF8 00000000 */  nop
    /* 5E4FC 8006DCFC 6002428C */  lw         $v0, 0x260($v0)
    /* 5E500 8006DD00 00000000 */  nop
    /* 5E504 8006DD04 00024230 */  andi       $v0, $v0, 0x200
    /* 5E508 8006DD08 4D004014 */  bnez       $v0, .L8006DE40
    /* 5E50C 8006DD0C 48FA6324 */   addiu     $v1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 5E510 8006DD10 1480023C */  lui        $v0, %hi(Cars_gNumHumanRaceCars)
    /* 5E514 8006DD14 00C8428C */  lw         $v0, %lo(Cars_gNumHumanRaceCars)($v0)
    /* 5E518 8006DD18 00000000 */  nop
    /* 5E51C 8006DD1C 08004414 */  bne        $v0, $a0, .L8006DD40
    /* 5E520 8006DD20 00000000 */   nop
    /* 5E524 8006DD24 0400628C */  lw         $v0, 0x4($v1)
    /* 5E528 8006DD28 00000000 */  nop
    /* 5E52C 8006DD2C 6002428C */  lw         $v0, 0x260($v0)
    /* 5E530 8006DD30 00000000 */  nop
    /* 5E534 8006DD34 00024230 */  andi       $v0, $v0, 0x200
    /* 5E538 8006DD38 41004014 */  bnez       $v0, .L8006DE40
    /* 5E53C 8006DD3C 00000000 */   nop
  .L8006DD40:
    /* 5E540 8006DD40 21206002 */  addu       $a0, $s3, $zero
    /* 5E544 8006DD44 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 5E548 8006DD48 21280000 */   addu      $a1, $zero, $zero
    /* 5E54C 8006DD4C 21280000 */  addu       $a1, $zero, $zero
    /* 5E550 8006DD50 02004104 */  bgez       $v0, .L8006DD5C
    /* 5E554 8006DD54 21404000 */   addu      $t0, $v0, $zero
    /* 5E558 8006DD58 23400800 */  negu       $t0, $t0
  .L8006DD5C:
    /* 5E55C 8006DD5C 7405648E */  lw         $a0, 0x574($s3)
    /* 5E560 8006DD60 3401638E */  lw         $v1, 0x134($s3)
    /* 5E564 8006DD64 1480063C */  lui        $a2, %hi(Cars_gNumCars)
    /* 5E568 8006DD68 F4C7C68C */  lw         $a2, %lo(Cars_gNumCars)($a2)
    /* 5E56C 8006DD6C 23488300 */  subu       $t1, $a0, $v1
    /* 5E570 8006DD70 0B00C018 */  blez       $a2, .L8006DDA0
    /* 5E574 8006DD74 21208300 */   addu      $a0, $a0, $v1
    /* 5E578 8006DD78 1180023C */  lui        $v0, %hi(Cars_gTotalSortedList)
    /* 5E57C 8006DD7C 20FB4324 */  addiu      $v1, $v0, %lo(Cars_gTotalSortedList)
  .L8006DD80:
    /* 5E580 8006DD80 0000628C */  lw         $v0, 0x0($v1)
    /* 5E584 8006DD84 00000000 */  nop
    /* 5E588 8006DD88 06005310 */  beq        $v0, $s3, .L8006DDA4
    /* 5E58C 8006DD8C 80100500 */   sll       $v0, $a1, 2
    /* 5E590 8006DD90 0100A524 */  addiu      $a1, $a1, 0x1
    /* 5E594 8006DD94 2A10A600 */  slt        $v0, $a1, $a2
    /* 5E598 8006DD98 F9FF4014 */  bnez       $v0, .L8006DD80
    /* 5E59C 8006DD9C 04006324 */   addiu     $v1, $v1, 0x4
  .L8006DDA0:
    /* 5E5A0 8006DDA0 80100500 */  sll        $v0, $a1, 2
  .L8006DDA4:
    /* 5E5A4 8006DDA4 21104500 */  addu       $v0, $v0, $a1
    /* 5E5A8 8006DDA8 C0140200 */  sll        $v0, $v0, 19
    /* 5E5AC 8006DDAC 2A100201 */  slt        $v0, $t0, $v0
    /* 5E5B0 8006DDB0 23004014 */  bnez       $v0, .L8006DE40
    /* 5E5B4 8006DDB4 00000000 */   nop
    /* 5E5B8 8006DDB8 08006286 */  lh         $v0, 0x8($s3)
    /* 5E5BC 8006DDBC 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 5E5C0 8006DDC0 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 5E5C4 8006DDC4 40110200 */  sll        $v0, $v0, 5
    /* 5E5C8 8006DDC8 21284300 */  addu       $a1, $v0, $v1
    /* 5E5CC 8006DDCC 1E00A290 */  lbu        $v0, 0x1E($a1)
    /* 5E5D0 8006DDD0 1D00A690 */  lbu        $a2, 0x1D($a1)
    /* 5E5D4 8006DDD4 C0130200 */  sll        $v0, $v0, 15
    /* 5E5D8 8006DDD8 02190600 */  srl        $v1, $a2, 4
    /* 5E5DC 8006DDDC 18004300 */  mult       $v0, $v1
    /* 5E5E0 8006DDE0 12500000 */  mflo       $t2
    /* 5E5E4 8006DDE4 23380A00 */  negu       $a3, $t2
    /* 5E5E8 8006DDE8 2A102701 */  slt        $v0, $t1, $a3
    /* 5E5EC 8006DDEC 11004014 */  bnez       $v0, .L8006DE34
    /* 5E5F0 8006DDF0 0F00C330 */   andi      $v1, $a2, 0xF
    /* 5E5F4 8006DDF4 1F00A290 */  lbu        $v0, 0x1F($a1)
    /* 5E5F8 8006DDF8 00000000 */  nop
    /* 5E5FC 8006DDFC C0130200 */  sll        $v0, $v0, 15
    /* 5E600 8006DE00 18004300 */  mult       $v0, $v1
    /* 5E604 8006DE04 12180000 */  mflo       $v1
    /* 5E608 8006DE08 2A106900 */  slt        $v0, $v1, $t1
    /* 5E60C 8006DE0C 09004014 */  bnez       $v0, .L8006DE34
    /* 5E610 8006DE10 2A108700 */   slt       $v0, $a0, $a3
    /* 5E614 8006DE14 07004014 */  bnez       $v0, .L8006DE34
    /* 5E618 8006DE18 2A106400 */   slt       $v0, $v1, $a0
    /* 5E61C 8006DE1C 08004014 */  bnez       $v0, .L8006DE40
    /* 5E620 8006DE20 21800000 */   addu      $s0, $zero, $zero
    /* 5E624 8006DE24 9001023C */  lui        $v0, (0x1900000 >> 16)
    /* 5E628 8006DE28 2A104800 */  slt        $v0, $v0, $t0
    /* 5E62C 8006DE2C 03004010 */  beqz       $v0, .L8006DE3C
    /* 5E630 8006DE30 1100103C */   lui       $s0, (0x11C71C >> 16)
  .L8006DE34:
    /* 5E634 8006DE34 90B70108 */  j          .L8006DE40
    /* 5E638 8006DE38 21800000 */   addu      $s0, $zero, $zero
  .L8006DE3C:
    /* 5E63C 8006DE3C 1CC71036 */  ori        $s0, $s0, (0x11C71C & 0xFFFF)
  .L8006DE40:
    /* 5E640 8006DE40 0000C38E */  lw         $v1, 0x0($s6)
    /* 5E644 8006DE44 5405628E */  lw         $v0, 0x554($s3)
    /* 5E648 8006DE48 00000000 */  nop
    /* 5E64C 8006DE4C 18006200 */  mult       $v1, $v0
    /* 5E650 8006DE50 12180000 */  mflo       $v1
    /* 5E654 8006DE54 0000C3AE */  sw         $v1, 0x0($s6)
    /* 5E658 8006DE58 5405628E */  lw         $v0, 0x554($s3)
    /* 5E65C 8006DE5C 00000000 */  nop
    /* 5E660 8006DE60 18000202 */  mult       $s0, $v0
    /* 5E664 8006DE64 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 5E668 8006DE68 2800B68F */  lw         $s6, 0x28($sp)
    /* 5E66C 8006DE6C 2400B58F */  lw         $s5, 0x24($sp)
    /* 5E670 8006DE70 2000B48F */  lw         $s4, 0x20($sp)
    /* 5E674 8006DE74 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5E678 8006DE78 1800B28F */  lw         $s2, 0x18($sp)
    /* 5E67C 8006DE7C 1400B18F */  lw         $s1, 0x14($sp)
    /* 5E680 8006DE80 1000B08F */  lw         $s0, 0x10($sp)
    /* 5E684 8006DE84 12100000 */  mflo       $v0
    /* 5E688 8006DE88 0800E003 */  jr         $ra
    /* 5E68C 8006DE8C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi
