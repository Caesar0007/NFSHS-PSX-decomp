.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AsyncLoadShapeFile__7tScreenPcR17tShapeInformation, 0x114

glabel AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 16A40 80026240 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* 16A44 80026244 9800B2AF */  sw         $s2, 0x98($sp)
    /* 16A48 80026248 21908000 */  addu       $s2, $a0, $zero
    /* 16A4C 8002624C 9400B1AF */  sw         $s1, 0x94($sp)
    /* 16A50 80026250 2188A000 */  addu       $s1, $a1, $zero
    /* 16A54 80026254 9000B0AF */  sw         $s0, 0x90($sp)
    /* 16A58 80026258 2180C000 */  addu       $s0, $a2, $zero
    /* 16A5C 8002625C 08002016 */  bnez       $s1, .L80026280
    /* 16A60 80026260 9C00BFAF */   sw        $ra, 0x9C($sp)
    /* 16A64 80026264 0C00048E */  lw         $a0, 0xC($s0)
    /* 16A68 80026268 00000000 */  nop
    /* 16A6C 8002626C 04008010 */  beqz       $a0, .L80026280
    /* 16A70 80026270 00000000 */   nop
    /* 16A74 80026274 74C5030C */  jal        cancelasyncload
    /* 16A78 80026278 00000000 */   nop
    /* 16A7C 8002627C 0C0000AE */  sw         $zero, 0xC($s0)
  .L80026280:
    /* 16A80 80026280 21204002 */  addu       $a0, $s2, $zero
    /* 16A84 80026284 D598000C */  jal        CancelAsyncLoad__7tScreenR17tShapeInformation
    /* 16A88 80026288 21280002 */   addu      $a1, $s0, $zero
    /* 16A8C 8002628C 0400048E */  lw         $a0, 0x4($s0)
    /* 16A90 80026290 00000000 */  nop
    /* 16A94 80026294 08008010 */  beqz       $a0, .L800262B8
    /* 16A98 80026298 00000000 */   nop
    /* 16A9C 8002629C 0800028E */  lw         $v0, 0x8($s0)
    /* 16AA0 800262A0 00000000 */  nop
    /* 16AA4 800262A4 03004014 */  bnez       $v0, .L800262B4
    /* 16AA8 800262A8 00000000 */   nop
    /* 16AAC 800262AC 5095030C */  jal        purgememadr
    /* 16AB0 800262B0 00000000 */   nop
  .L800262B4:
    /* 16AB4 800262B4 040000AE */  sw         $zero, 0x4($s0)
  .L800262B8:
    /* 16AB8 800262B8 12000296 */  lhu        $v0, 0x12($s0)
    /* 16ABC 800262BC 00000000 */  nop
    /* 16AC0 800262C0 FEFF4230 */  andi       $v0, $v0, 0xFFFE
    /* 16AC4 800262C4 1D002012 */  beqz       $s1, .L8002633C
    /* 16AC8 800262C8 120002A6 */   sh        $v0, 0x12($s0)
    /* 16ACC 800262CC 14000426 */  addiu      $a0, $s0, 0x14
    /* 16AD0 800262D0 0180053C */  lui        $a1, %hi(D_800113FC)
    /* 16AD4 800262D4 FC13A524 */  addiu      $a1, $a1, %lo(D_800113FC)
    /* 16AD8 800262D8 2F91030C */  jal        sprintf
    /* 16ADC 800262DC 21302002 */   addu      $a2, $s1, $zero
    /* 16AE0 800262E0 1000A427 */  addiu      $a0, $sp, 0x10
    /* 16AE4 800262E4 0180053C */  lui        $a1, %hi(D_80011400)
    /* 16AE8 800262E8 0014A524 */  addiu      $a1, $a1, %lo(D_80011400)
    /* 16AEC 800262EC 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 16AF0 800262F0 E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 16AF4 800262F4 2F91030C */  jal        sprintf
    /* 16AF8 800262F8 21382002 */   addu      $a3, $s1, $zero
    /* 16AFC 800262FC 2400028E */  lw         $v0, 0x24($s0)
    /* 16B00 80026300 00000000 */  nop
    /* 16B04 80026304 0D004014 */  bnez       $v0, .L8002633C
    /* 16B08 80026308 00000000 */   nop
    /* 16B0C 8002630C 0800058E */  lw         $a1, 0x8($s0)
    /* 16B10 80026310 00000000 */  nop
    /* 16B14 80026314 0500A010 */  beqz       $a1, .L8002632C
    /* 16B18 80026318 240000AE */   sw        $zero, 0x24($s0)
    /* 16B1C 8002631C 0FC5030C */  jal        asyncloadfileat
    /* 16B20 80026320 1000A427 */   addiu     $a0, $sp, 0x10
    /* 16B24 80026324 CF980008 */  j          .L8002633C
    /* 16B28 80026328 0C0002AE */   sw        $v0, 0xC($s0)
  .L8002632C:
    /* 16B2C 8002632C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 16B30 80026330 DAC4030C */  jal        asyncloadfile
    /* 16B34 80026334 10000524 */   addiu     $a1, $zero, 0x10
    /* 16B38 80026338 0C0002AE */  sw         $v0, 0xC($s0)
  .L8002633C:
    /* 16B3C 8002633C 9C00BF8F */  lw         $ra, 0x9C($sp)
    /* 16B40 80026340 9800B28F */  lw         $s2, 0x98($sp)
    /* 16B44 80026344 9400B18F */  lw         $s1, 0x94($sp)
    /* 16B48 80026348 9000B08F */  lw         $s0, 0x90($sp)
    /* 16B4C 8002634C 0800E003 */  jr         $ra
    /* 16B50 80026350 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
