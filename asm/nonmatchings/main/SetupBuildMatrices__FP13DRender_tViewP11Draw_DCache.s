.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache, 0x2D4

glabel SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
    /* 6E140 8007D940 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 6E144 8007D944 6400B1AF */  sw         $s1, 0x64($sp)
    /* 6E148 8007D948 21888000 */  addu       $s1, $a0, $zero
    /* 6E14C 8007D94C 6C00BFAF */  sw         $ra, 0x6C($sp)
    /* 6E150 8007D950 6800B2AF */  sw         $s2, 0x68($sp)
    /* 6E154 8007D954 6000B0AF */  sw         $s0, 0x60($sp)
    /* 6E158 8007D958 0000238E */  lw         $v1, 0x0($s1)
    /* 6E15C 8007D95C 1480023C */  lui        $v0, %hi(Draw_gPlayer1View)
    /* 6E160 8007D960 CCD3428C */  lw         $v0, %lo(Draw_gPlayer1View)($v0)
    /* 6E164 8007D964 00000000 */  nop
    /* 6E168 8007D968 06006210 */  beq        $v1, $v0, .L8007D984
    /* 6E16C 8007D96C 2190A000 */   addu      $s2, $a1, $zero
    /* 6E170 8007D970 1480023C */  lui        $v0, %hi(Draw_gPlayer2View)
    /* 6E174 8007D974 D0D3428C */  lw         $v0, %lo(Draw_gPlayer2View)($v0)
    /* 6E178 8007D978 00000000 */  nop
    /* 6E17C 8007D97C 04006214 */  bne        $v1, $v0, .L8007D990
    /* 6E180 8007D980 21202002 */   addu      $a0, $s1, $zero
  .L8007D984:
    /* 6E184 8007D984 0400258E */  lw         $a1, 0x4($s1)
    /* 6E188 8007D988 65F60108 */  j          .L8007D994
    /* 6E18C 8007D98C 21202002 */   addu      $a0, $s1, $zero
  .L8007D990:
    /* 6E190 8007D990 01000524 */  addiu      $a1, $zero, 0x1
  .L8007D994:
    /* 6E194 8007D994 82F5010C */  jal        UpdateContext__FP13DRender_tViewi
    /* 6E198 8007D998 00000000 */   nop
    /* 6E19C 8007D99C 4400248E */  lw         $a0, 0x44($s1)
    /* 6E1A0 8007D9A0 4800228E */  lw         $v0, 0x48($s1)
    /* 6E1A4 8007D9A4 4C00258E */  lw         $a1, 0x4C($s1)
    /* 6E1A8 8007D9A8 1180033C */  lui        $v1, %hi(gWorldMat)
    /* 6E1AC 8007D9AC 40EE64AC */  sw         $a0, %lo(gWorldMat)($v1)
    /* 6E1B0 8007D9B0 40EE6324 */  addiu      $v1, $v1, %lo(gWorldMat)
    /* 6E1B4 8007D9B4 23100200 */  negu       $v0, $v0
    /* 6E1B8 8007D9B8 040062AC */  sw         $v0, 0x4($v1)
    /* 6E1BC 8007D9BC 080065AC */  sw         $a1, 0x8($v1)
    /* 6E1C0 8007D9C0 5000248E */  lw         $a0, 0x50($s1)
    /* 6E1C4 8007D9C4 5400228E */  lw         $v0, 0x54($s1)
    /* 6E1C8 8007D9C8 5800258E */  lw         $a1, 0x58($s1)
    /* 6E1CC 8007D9CC 23100200 */  negu       $v0, $v0
    /* 6E1D0 8007D9D0 0C0064AC */  sw         $a0, 0xC($v1)
    /* 6E1D4 8007D9D4 100062AC */  sw         $v0, 0x10($v1)
    /* 6E1D8 8007D9D8 140065AC */  sw         $a1, 0x14($v1)
    /* 6E1DC 8007D9DC 5C00248E */  lw         $a0, 0x5C($s1)
    /* 6E1E0 8007D9E0 6000228E */  lw         $v0, 0x60($s1)
    /* 6E1E4 8007D9E4 6400258E */  lw         $a1, 0x64($s1)
    /* 6E1E8 8007D9E8 180064AC */  sw         $a0, 0x18($v1)
    /* 6E1EC 8007D9EC 1480043C */  lui        $a0, %hi(gNight_renderNight)
    /* 6E1F0 8007D9F0 28DA848C */  lw         $a0, %lo(gNight_renderNight)($a0)
    /* 6E1F4 8007D9F4 23100200 */  negu       $v0, $v0
    /* 6E1F8 8007D9F8 1C0062AC */  sw         $v0, 0x1C($v1)
    /* 6E1FC 8007D9FC 7F008010 */  beqz       $a0, .L8007DBFC
    /* 6E200 8007DA00 200065AC */   sw        $a1, 0x20($v1)
    /* 6E204 8007DA04 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 6E208 8007DA08 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 6E20C 8007DA0C 1180103C */  lui        $s0, %hi(gNightMat)
    /* 6E210 8007DA10 0400248E */  lw         $a0, 0x4($s1)
    /* 6E214 8007DA14 64EE1026 */  addiu      $s0, $s0, %lo(gNightMat)
    /* 6E218 8007DA18 00110400 */  sll        $v0, $a0, 4
    /* 6E21C 8007DA1C 21104400 */  addu       $v0, $v0, $a0
    /* 6E220 8007DA20 00110200 */  sll        $v0, $v0, 4
    /* 6E224 8007DA24 21104300 */  addu       $v0, $v0, $v1
    /* 6E228 8007DA28 0400448C */  lw         $a0, 0x4($v0)
    /* 6E22C 8007DA2C 21280002 */  addu       $a1, $s0, $zero
    /* 6E230 8007DA30 D690030C */  jal        transpose
    /* 6E234 8007DA34 F0008424 */   addiu     $a0, $a0, 0xF0
    /* 6E238 8007DA38 21200002 */  addu       $a0, $s0, $zero
    /* 6E23C 8007DA3C 34004526 */  addiu      $a1, $s2, 0x34
    /* 6E240 8007DA40 0400828C */  lw         $v0, 0x4($a0)
    /* 6E244 8007DA44 1C00838C */  lw         $v1, 0x1C($a0)
    /* 6E248 8007DA48 23100200 */  negu       $v0, $v0
    /* 6E24C 8007DA4C 040082AC */  sw         $v0, 0x4($a0)
    /* 6E250 8007DA50 1000828C */  lw         $v0, 0x10($a0)
    /* 6E254 8007DA54 23180300 */  negu       $v1, $v1
    /* 6E258 8007DA58 1C0083AC */  sw         $v1, 0x1C($a0)
    /* 6E25C 8007DA5C 23100200 */  negu       $v0, $v0
    /* 6E260 8007DA60 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* 6E264 8007DA64 100082AC */   sw        $v0, 0x10($a0)
    /* 6E268 8007DA68 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 6E26C 8007DA6C F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 6E270 8007DA70 01000224 */  addiu      $v0, $zero, 0x1
    /* 6E274 8007DA74 680280AF */  sw         $zero, %gp_rel(BW_gCopCarObj)($gp)
    /* 6E278 8007DA78 60006210 */  beq        $v1, $v0, .L8007DBFC
    /* 6E27C 8007DA7C B400093C */   lui       $t1, (0xB40000 >> 16)
    /* 6E280 8007DA80 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 6E284 8007DA84 14800B3C */  lui        $t3, %hi(Cars_gNumCopCars)
    /* 6E288 8007DA88 0CC86B8D */  lw         $t3, %lo(Cars_gNumCopCars)($t3)
    /* 6E28C 8007DA8C 11800C3C */  lui        $t4, %hi(Cars_gList)
    /* 6E290 8007DA90 08002A26 */  addiu      $t2, $s1, 0x8
    /* 6E294 8007DA94 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* 6E298 8007DA98 B4FA4224 */  addiu      $v0, $v0, %lo(Cars_gCopCarList)
    /* 6E29C 8007DA9C FCFF4824 */  addiu      $t0, $v0, -0x4
  .L8007DAA0:
    /* 6E2A0 8007DAA0 2A10EB00 */  slt        $v0, $a3, $t3
    /* 6E2A4 8007DAA4 31004010 */  beqz       $v0, .L8007DB6C
    /* 6E2A8 8007DAA8 00000000 */   nop
    /* 6E2AC 8007DAAC 0400E104 */  bgez       $a3, .L8007DAC0
    /* 6E2B0 8007DAB0 00000000 */   nop
    /* 6E2B4 8007DAB4 DCF9868D */  lw         $a2, %lo(Cars_gList)($t4)
    /* 6E2B8 8007DAB8 B1F60108 */  j          .L8007DAC4
    /* 6E2BC 8007DABC 00000000 */   nop
  .L8007DAC0:
    /* 6E2C0 8007DAC0 0000068D */  lw         $a2, 0x0($t0)
  .L8007DAC4:
    /* 6E2C4 8007DAC4 00000000 */  nop
    /* 6E2C8 8007DAC8 9100C290 */  lbu        $v0, 0x91($a2)
    /* 6E2CC 8007DACC 00000000 */  nop
    /* 6E2D0 8007DAD0 23004010 */  beqz       $v0, .L8007DB60
    /* 6E2D4 8007DAD4 00000000 */   nop
    /* 6E2D8 8007DAD8 7005C28C */  lw         $v0, 0x570($a2)
    /* 6E2DC 8007DADC 00000000 */  nop
    /* 6E2E0 8007DAE0 02004230 */  andi       $v0, $v0, 0x2
    /* 6E2E4 8007DAE4 1E004010 */  beqz       $v0, .L8007DB60
    /* 6E2E8 8007DAE8 00000000 */   nop
    /* 6E2EC 8007DAEC 7E08C294 */  lhu        $v0, 0x87E($a2)
    /* 6E2F0 8007DAF0 00000000 */  nop
    /* 6E2F4 8007DAF4 04004230 */  andi       $v0, $v0, 0x4
    /* 6E2F8 8007DAF8 19004014 */  bnez       $v0, .L8007DB60
    /* 6E2FC 8007DAFC 00000000 */   nop
    /* 6E300 8007DB00 A000C58C */  lw         $a1, 0xA0($a2)
    /* 6E304 8007DB04 0800238E */  lw         $v1, 0x8($s1)
    /* 6E308 8007DB08 A800C48C */  lw         $a0, 0xA8($a2)
    /* 6E30C 8007DB0C 0800428D */  lw         $v0, 0x8($t2)
    /* 6E310 8007DB10 2328A300 */  subu       $a1, $a1, $v1
    /* 6E314 8007DB14 23208200 */  subu       $a0, $a0, $v0
    /* 6E318 8007DB18 0200A104 */  bgez       $a1, .L8007DB24
    /* 6E31C 8007DB1C 00000000 */   nop
    /* 6E320 8007DB20 23280500 */  negu       $a1, $a1
  .L8007DB24:
    /* 6E324 8007DB24 02008104 */  bgez       $a0, .L8007DB30
    /* 6E328 8007DB28 00000000 */   nop
    /* 6E32C 8007DB2C 23200400 */  negu       $a0, $a0
  .L8007DB30:
    /* 6E330 8007DB30 2A108500 */  slt        $v0, $a0, $a1
    /* 6E334 8007DB34 03004010 */  beqz       $v0, .L8007DB44
    /* 6E338 8007DB38 83100400 */   sra       $v0, $a0, 2
    /* 6E33C 8007DB3C D3F60108 */  j          .L8007DB4C
    /* 6E340 8007DB40 2120A200 */   addu      $a0, $a1, $v0
  .L8007DB44:
    /* 6E344 8007DB44 83100500 */  sra        $v0, $a1, 2
    /* 6E348 8007DB48 21208200 */  addu       $a0, $a0, $v0
  .L8007DB4C:
    /* 6E34C 8007DB4C 2A108900 */  slt        $v0, $a0, $t1
    /* 6E350 8007DB50 03004010 */  beqz       $v0, .L8007DB60
    /* 6E354 8007DB54 00000000 */   nop
    /* 6E358 8007DB58 21488000 */  addu       $t1, $a0, $zero
    /* 6E35C 8007DB5C 680286AF */  sw         $a2, %gp_rel(BW_gCopCarObj)($gp)
  .L8007DB60:
    /* 6E360 8007DB60 04000825 */  addiu      $t0, $t0, 0x4
    /* 6E364 8007DB64 A8F60108 */  j          .L8007DAA0
    /* 6E368 8007DB68 0100E724 */   addiu     $a3, $a3, 0x1
  .L8007DB6C:
    /* 6E36C 8007DB6C 6802828F */  lw         $v0, %gp_rel(BW_gCopCarObj)($gp)
    /* 6E370 8007DB70 00000000 */  nop
    /* 6E374 8007DB74 21004010 */  beqz       $v0, .L8007DBFC
    /* 6E378 8007DB78 00000000 */   nop
    /* 6E37C 8007DB7C 8802448C */  lw         $a0, 0x288($v0)
    /* 6E380 8007DB80 126E030C */  jal        Night_SetCopColor__FP18GameSetup_tCarData
    /* 6E384 8007DB84 00000000 */   nop
    /* 6E388 8007DB88 3800B027 */  addiu      $s0, $sp, 0x38
    /* 6E38C 8007DB8C 1002858F */  lw         $a1, %gp_rel(D_8013C75C)($gp)
    /* 6E390 8007DB90 00000000 */  nop
    /* 6E394 8007DB94 4000A524 */  addiu      $a1, $a1, 0x40
    /* 6E398 8007DB98 100285AF */  sw         $a1, %gp_rel(D_8013C75C)($gp)
    /* 6E39C 8007DB9C B196030C */  jal        xformy
    /* 6E3A0 8007DBA0 21200002 */   addu      $a0, $s0, $zero
    /* 6E3A4 8007DBA4 6802848F */  lw         $a0, %gp_rel(BW_gCopCarObj)($gp)
    /* 6E3A8 8007DBA8 1000A527 */  addiu      $a1, $sp, 0x10
    /* 6E3AC 8007DBAC D690030C */  jal        transpose
    /* 6E3B0 8007DBB0 F0008424 */   addiu     $a0, $a0, 0xF0
    /* 6E3B4 8007DBB4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 6E3B8 8007DBB8 21280002 */  addu       $a1, $s0, $zero
    /* 6E3BC 8007DBBC 1180103C */  lui        $s0, %hi(gCopMat)
    /* 6E3C0 8007DBC0 88EE1026 */  addiu      $s0, $s0, %lo(gCopMat)
    /* 6E3C4 8007DBC4 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 6E3C8 8007DBC8 21300002 */   addu      $a2, $s0, $zero
    /* 6E3CC 8007DBCC 21200002 */  addu       $a0, $s0, $zero
    /* 6E3D0 8007DBD0 54004526 */  addiu      $a1, $s2, 0x54
    /* 6E3D4 8007DBD4 0400828C */  lw         $v0, 0x4($a0)
    /* 6E3D8 8007DBD8 1C00838C */  lw         $v1, 0x1C($a0)
    /* 6E3DC 8007DBDC 23100200 */  negu       $v0, $v0
    /* 6E3E0 8007DBE0 040082AC */  sw         $v0, 0x4($a0)
    /* 6E3E4 8007DBE4 1000828C */  lw         $v0, 0x10($a0)
    /* 6E3E8 8007DBE8 23180300 */  negu       $v1, $v1
    /* 6E3EC 8007DBEC 1C0083AC */  sw         $v1, 0x1C($a0)
    /* 6E3F0 8007DBF0 23100200 */  negu       $v0, $v0
    /* 6E3F4 8007DBF4 4F1D030C */  jal        DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX
    /* 6E3F8 8007DBF8 100082AC */   sw        $v0, 0x10($a0)
  .L8007DBFC:
    /* 6E3FC 8007DBFC 6C00BF8F */  lw         $ra, 0x6C($sp)
    /* 6E400 8007DC00 6800B28F */  lw         $s2, 0x68($sp)
    /* 6E404 8007DC04 6400B18F */  lw         $s1, 0x64($sp)
    /* 6E408 8007DC08 6000B08F */  lw         $s0, 0x60($sp)
    /* 6E40C 8007DC0C 0800E003 */  jr         $ra
    /* 6E410 8007DC10 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache
