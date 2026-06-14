.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching Flare_Sun__FP7SVECTORP15Draw_FlareCache, 0x2EC

glabel Flare_Sun__FP7SVECTORP15Draw_FlareCache
    /* BF9D0 800CF1D0 98FFBD27 */  addiu      $sp, $sp, -0x68
    /* BF9D4 800CF1D4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* BF9D8 800CF1D8 EC314724 */  addiu      $a3, $v0, %lo(GameSetup_gData)
    /* BF9DC 800CF1DC 6000BFAF */  sw         $ra, 0x60($sp)
    /* BF9E0 800CF1E0 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* BF9E4 800CF1E4 5800B0AF */  sw         $s0, 0x58($sp)
    /* BF9E8 800CF1E8 0C00E28C */  lw         $v0, 0xC($a3)
    /* BF9EC 800CF1EC 01000924 */  addiu      $t1, $zero, 0x1
    /* BF9F0 800CF1F0 02004914 */  bne        $v0, $t1, .L800CF1FC
    /* BF9F4 800CF1F4 78000624 */   addiu     $a2, $zero, 0x78
    /* BF9F8 800CF1F8 3C000624 */  addiu      $a2, $zero, 0x3C
  .L800CF1FC:
    /* BF9FC 800CF1FC 0800A28C */  lw         $v0, 0x8($a1)
    /* BFA00 800CF200 0400A38C */  lw         $v1, 0x4($a1)
    /* BFA04 800CF204 00FC4224 */  addiu      $v0, $v0, -0x400
    /* BFA08 800CF208 2B186200 */  sltu       $v1, $v1, $v0
    /* BFA0C 800CF20C A6006010 */  beqz       $v1, .L800CF4A8
    /* BFA10 800CF210 00000000 */   nop
    /* BFA14 800CF214 000080C8 */  lwc2       $0, 0x0($a0)
    /* BFA18 800CF218 040081C8 */  lwc2       $1, 0x4($a0)
    /* BFA1C 800CF21C 00000000 */  nop
    /* BFA20 800CF220 00000000 */  nop
    /* BFA24 800CF224 0100184A */  .word 0x4A180001  /* rtps */
    /* BFA28 800CF228 1800A827 */  addiu      $t0, $sp, 0x18
    /* BFA2C 800CF22C 000019E9 */  swc2       $25, 0x0($t0)
    /* BFA30 800CF230 04001AE9 */  swc2       $26, 0x4($t0) /* handwritten instruction */
    /* BFA34 800CF234 08001BE9 */  swc2       $27, 0x8($t0) /* handwritten instruction */
    /* BFA38 800CF238 1800A38F */  lw         $v1, 0x18($sp)
    /* BFA3C 800CF23C 2000A48F */  lw         $a0, 0x20($sp)
    /* BFA40 800CF240 00000000 */  nop
    /* BFA44 800CF244 2A108300 */  slt        $v0, $a0, $v1
    /* BFA48 800CF248 97004014 */  bnez       $v0, .L800CF4A8
    /* BFA4C 800CF24C 23100300 */   negu      $v0, $v1
    /* BFA50 800CF250 2A108200 */  slt        $v0, $a0, $v0
    /* BFA54 800CF254 94004014 */  bnez       $v0, .L800CF4A8
    /* BFA58 800CF258 8000023C */   lui       $v0, (0x808080 >> 16)
    /* BFA5C 800CF25C 80804234 */  ori        $v0, $v0, (0x808080 & 0xFFFF)
    /* BFA60 800CF260 3000A427 */  addiu      $a0, $sp, 0x30
    /* BFA64 800CF264 2800A2AF */  sw         $v0, 0x28($sp)
    /* BFA68 800CF268 00008EE8 */  swc2       $14, 0x0($a0)
    /* BFA6C 800CF26C 78000324 */  addiu      $v1, $zero, 0x78
    /* BFA70 800CF270 1C00A28F */  lw         $v0, 0x1C($sp)
    /* BFA74 800CF274 0C00E78C */  lw         $a3, 0xC($a3)
    /* BFA78 800CF278 83100200 */  sra        $v0, $v0, 2
    /* BFA7C 800CF27C 21104600 */  addu       $v0, $v0, $a2
    /* BFA80 800CF280 0200E914 */  bne        $a3, $t1, .L800CF28C
    /* BFA84 800CF284 3200A2A7 */   sh        $v0, 0x32($sp)
    /* BFA88 800CF288 3C000324 */  addiu      $v1, $zero, 0x3C
  .L800CF28C:
    /* BFA8C 800CF28C 00140200 */  sll        $v0, $v0, 16
    /* BFA90 800CF290 03140200 */  sra        $v0, $v0, 16
    /* BFA94 800CF294 23104300 */  subu       $v0, $v0, $v1
    /* BFA98 800CF298 80100200 */  sll        $v0, $v0, 2
    /* BFA9C 800CF29C 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* BFAA0 800CF2A0 1480023C */  lui        $v0, %hi(Camera_gGeomScreen)
    /* BFAA4 800CF2A4 DCC7428C */  lw         $v0, %lo(Camera_gGeomScreen)($v0)
    /* BFAA8 800CF2A8 3000A687 */  lh         $a2, 0x30($sp)
    /* BFAAC 800CF2AC 80180200 */  sll        $v1, $v0, 2
    /* BFAB0 800CF2B0 60FFC224 */  addiu      $v0, $a2, -0xA0
    /* BFAB4 800CF2B4 80100200 */  sll        $v0, $v0, 2
    /* BFAB8 800CF2B8 1800A2AF */  sw         $v0, 0x18($sp)
    /* BFABC 800CF2BC 510B6228 */  slti       $v0, $v1, 0xB51
    /* BFAC0 800CF2C0 02004014 */  bnez       $v0, .L800CF2CC
    /* BFAC4 800CF2C4 00000000 */   nop
    /* BFAC8 800CF2C8 500B0324 */  addiu      $v1, $zero, 0xB50
  .L800CF2CC:
    /* BFACC 800CF2CC 2000A3AF */  sw         $v1, 0x20($sp)
    /* BFAD0 800CF2D0 00000C8D */  lw         $t4, 0x0($t0)
    /* BFAD4 800CF2D4 04000D8D */  lw         $t5, 0x4($t0)
    /* BFAD8 800CF2D8 08000E8D */  lw         $t6, 0x8($t0)
    /* BFADC 800CF2DC 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* BFAE0 800CF2E0 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* BFAE4 800CF2E4 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* BFAE8 800CF2E8 3D01C228 */  slti       $v0, $a2, 0x13D
    /* BFAEC 800CF2EC 0B004010 */  beqz       $v0, .L800CF31C
    /* BFAF0 800CF2F0 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
    /* BFAF4 800CF2F4 0900E910 */  beq        $a3, $t1, .L800CF31C
    /* BFAF8 800CF2F8 1280023C */   lui       $v0, %hi(D_801232D8)
    /* BFAFC 800CF2FC D832428C */  lw         $v0, %lo(D_801232D8)($v0)
    /* BFB00 800CF300 00000000 */  nop
    /* BFB04 800CF304 00014230 */  andi       $v0, $v0, 0x100
    /* BFB08 800CF308 05004014 */  bnez       $v0, .L800CF320
    /* BFB0C 800CF30C 04006B35 */   ori       $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BFB10 800CF310 DB3A030C */  jal        Flare_LensFlare__FP7DVECTORP15Draw_FlareCache
    /* BFB14 800CF314 00000000 */   nop
    /* BFB18 800CF318 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
  .L800CF31C:
    /* BFB1C 800CF31C 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
  .L800CF320:
    /* BFB20 800CF320 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BFB24 800CF324 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BFB28 800CF328 21280000 */  addu       $a1, $zero, $zero
    /* BFB2C 800CF32C 2130A000 */  addu       $a2, $a1, $zero
    /* BFB30 800CF330 20010724 */  addiu      $a3, $zero, 0x120
    /* BFB34 800CF334 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* BFB38 800CF338 B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* BFB3C 800CF33C 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BFB40 800CF340 1480193C */  lui        $t9, %hi(gfrgb)
    /* BFB44 800CF344 6CD83927 */  addiu      $t9, $t9, %lo(gfrgb)
    /* BFB48 800CF348 2B00AF8B */  lwl        $t7, 0x2B($sp)
    /* BFB4C 800CF34C 2800AF9B */  lwr        $t7, 0x28($sp)
    /* BFB50 800CF350 00000000 */  nop
    /* BFB54 800CF354 03002FAB */  swl        $t7, 0x3($t9)
    /* BFB58 800CF358 00002FBB */  swr        $t7, 0x0($t9)
    /* BFB5C 800CF35C 0000648D */  lw         $a0, 0x0($t3)
    /* BFB60 800CF360 FEFF5024 */  addiu      $s0, $v0, -0x2
    /* BFB64 800CF364 80401000 */  sll        $t0, $s0, 2
    /* BFB68 800CF368 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BFB6C 800CF36C 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BFB70 800CF370 0000838C */  lw         $v1, 0x0($a0)
    /* BFB74 800CF374 21400201 */  addu       $t0, $t0, $v0
    /* BFB78 800CF378 0000028D */  lw         $v0, 0x0($t0)
    /* BFB7C 800CF37C 24186A00 */  and        $v1, $v1, $t2
    /* BFB80 800CF380 24104900 */  and        $v0, $v0, $t1
    /* BFB84 800CF384 25186200 */  or         $v1, $v1, $v0
    /* BFB88 800CF388 000083AC */  sw         $v1, 0x0($a0)
    /* BFB8C 800CF38C 0000028D */  lw         $v0, 0x0($t0)
    /* BFB90 800CF390 0C008324 */  addiu      $v1, $a0, 0xC
    /* BFB94 800CF394 000063AD */  sw         $v1, 0x0($t3)
    /* BFB98 800CF398 24188900 */  and        $v1, $a0, $t1
    /* BFB9C 800CF39C 24104A00 */  and        $v0, $v0, $t2
    /* BFBA0 800CF3A0 25104300 */  or         $v0, $v0, $v1
    /* BFBA4 800CF3A4 000002AD */  sw         $v0, 0x0($t0)
    /* BFBA8 800CF3A8 EFB8030C */  jal        SetDrawMode
    /* BFBAC 800CF3AC 1000A0AF */   sw        $zero, 0x10($sp)
    /* BFBB0 800CF3B0 00040224 */  addiu      $v0, $zero, 0x400
    /* BFBB4 800CF3B4 3800A2AF */  sw         $v0, 0x38($sp)
    /* BFBB8 800CF3B8 4000A2AF */  sw         $v0, 0x40($sp)
    /* BFBBC 800CF3BC 3800A227 */  addiu      $v0, $sp, 0x38
    /* BFBC0 800CF3C0 4800A0AF */  sw         $zero, 0x48($sp)
    /* BFBC4 800CF3C4 3C00A0AF */  sw         $zero, 0x3C($sp)
    /* BFBC8 800CF3C8 4400A0AF */  sw         $zero, 0x44($sp)
    /* BFBCC 800CF3CC 00004C8C */  lw         $t4, 0x0($v0)
    /* BFBD0 800CF3D0 04004D8C */  lw         $t5, 0x4($v0)
    /* BFBD4 800CF3D4 0000CC48 */  ctc2       $t4, $0 /* handwritten instruction */
    /* BFBD8 800CF3D8 0008CD48 */  ctc2       $t5, $1 /* handwritten instruction */
    /* BFBDC 800CF3DC 08004C8C */  lw         $t4, 0x8($v0)
    /* BFBE0 800CF3E0 0C004D8C */  lw         $t5, 0xC($v0)
    /* BFBE4 800CF3E4 10004E8C */  lw         $t6, 0x10($v0)
    /* BFBE8 800CF3E8 0010CC48 */  ctc2       $t4, $2 /* handwritten instruction */
    /* BFBEC 800CF3EC 0018CD48 */  ctc2       $t5, $3 /* handwritten instruction */
    /* BFBF0 800CF3F0 0020CE48 */  ctc2       $t6, $4 /* handwritten instruction */
    /* BFBF4 800CF3F4 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
    /* BFBF8 800CF3F8 7C324524 */  addiu      $a1, $v0, %lo(TrackSpec_gSpec)
    /* BFBFC 800CF3FC 5C00A28C */  lw         $v0, 0x5C($a1)
    /* BFC00 800CF400 00000000 */  nop
    /* BFC04 800CF404 00014230 */  andi       $v0, $v0, 0x100
    /* BFC08 800CF408 09004010 */  beqz       $v0, .L800CF430
    /* BFC0C 800CF40C 3000A427 */   addiu     $a0, $sp, 0x30
    /* BFC10 800CF410 BC00A524 */  addiu      $a1, $a1, 0xBC
    /* BFC14 800CF414 10000624 */  addiu      $a2, $zero, 0x10
    /* BFC18 800CF418 2138C000 */  addu       $a3, $a2, $zero
    /* BFC1C 800CF41C 1000A0AF */  sw         $zero, 0x10($sp)
    /* BFC20 800CF420 BE39030C */  jal        Flare_SingleColorTex__FP7DVECTORP7CVECTORiici
    /* BFC24 800CF424 1400B0AF */   sw        $s0, 0x14($sp)
    /* BFC28 800CF428 0F3D0308 */  j          .L800CF43C
    /* BFC2C 800CF42C 801F0B3C */   lui       $t3, (0x1F800004 >> 16)
  .L800CF430:
    /* BFC30 800CF430 852F030C */  jal        Flare_OctFlare__FPli
    /* BFC34 800CF434 21280002 */   addu      $a1, $s0, $zero
    /* BFC38 800CF438 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
  .L800CF43C:
    /* BFC3C 800CF43C 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* BFC40 800CF440 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* BFC44 800CF444 FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* BFC48 800CF448 21280000 */  addu       $a1, $zero, $zero
    /* BFC4C 800CF44C 2130A000 */  addu       $a2, $a1, $zero
    /* BFC50 800CF450 20010724 */  addiu      $a3, $zero, 0x120
    /* BFC54 800CF454 80401000 */  sll        $t0, $s0, 2
    /* BFC58 800CF458 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* BFC5C 800CF45C 801F023C */  lui        $v0, (0x1F800000 >> 16)
    /* BFC60 800CF460 0000428C */  lw         $v0, (0x1F800000 & 0xFFFF)($v0)
    /* BFC64 800CF464 0000648D */  lw         $a0, 0x0($t3)
    /* BFC68 800CF468 21400201 */  addu       $t0, $t0, $v0
    /* BFC6C 800CF46C 0000838C */  lw         $v1, 0x0($a0)
    /* BFC70 800CF470 0000028D */  lw         $v0, 0x0($t0)
    /* BFC74 800CF474 24186A00 */  and        $v1, $v1, $t2
    /* BFC78 800CF478 24104900 */  and        $v0, $v0, $t1
    /* BFC7C 800CF47C 25186200 */  or         $v1, $v1, $v0
    /* BFC80 800CF480 000083AC */  sw         $v1, 0x0($a0)
    /* BFC84 800CF484 0000028D */  lw         $v0, 0x0($t0)
    /* BFC88 800CF488 0C008324 */  addiu      $v1, $a0, 0xC
    /* BFC8C 800CF48C 000063AD */  sw         $v1, 0x0($t3)
    /* BFC90 800CF490 24188900 */  and        $v1, $a0, $t1
    /* BFC94 800CF494 24104A00 */  and        $v0, $v0, $t2
    /* BFC98 800CF498 25104300 */  or         $v0, $v0, $v1
    /* BFC9C 800CF49C 000002AD */  sw         $v0, 0x0($t0)
    /* BFCA0 800CF4A0 EFB8030C */  jal        SetDrawMode
    /* BFCA4 800CF4A4 1000A0AF */   sw        $zero, 0x10($sp)
  .L800CF4A8:
    /* BFCA8 800CF4A8 6000BF8F */  lw         $ra, 0x60($sp)
    /* BFCAC 800CF4AC 5C00B18F */  lw         $s1, 0x5C($sp)
    /* BFCB0 800CF4B0 5800B08F */  lw         $s0, 0x58($sp)
    /* BFCB4 800CF4B4 0800E003 */  jr         $ra
    /* BFCB8 800CF4B8 6800BD27 */   addiu     $sp, $sp, 0x68
endlabel Flare_Sun__FP7SVECTORP15Draw_FlareCache
