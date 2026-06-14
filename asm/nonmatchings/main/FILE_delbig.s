.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_delbig, 0x194

glabel FILE_delbig
    /* DD1AC 800EC9AC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* DD1B0 800EC9B0 2000B4AF */  sw         $s4, 0x20($sp)
    /* DD1B4 800EC9B4 21A08000 */  addu       $s4, $a0, $zero
    /* DD1B8 800EC9B8 2400B5AF */  sw         $s5, 0x24($sp)
    /* DD1BC 800EC9BC 21A8A000 */  addu       $s5, $a1, $zero
    /* DD1C0 800EC9C0 1000B0AF */  sw         $s0, 0x10($sp)
    /* DD1C4 800EC9C4 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DD1C8 800EC9C8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DD1CC 800EC9CC 88EA5324 */  addiu      $s3, $v0, %lo(gFileDevice)
    /* DD1D0 800EC9D0 2800BFAF */  sw         $ra, 0x28($sp)
    /* DD1D4 800EC9D4 1800B2AF */  sw         $s2, 0x18($sp)
    /* DD1D8 800EC9D8 1400B1AF */  sw         $s1, 0x14($sp)
    /* DD1DC 800EC9DC 2400718E */  lw         $s1, 0x24($s3)
    /* DD1E0 800EC9E0 37B4030C */  jal        func_800ED0DC
    /* DD1E4 800EC9E4 2180C000 */   addu      $s0, $a2, $zero
    /* DD1E8 800EC9E8 0FFF043C */  lui        $a0, (0xFF0FFFFF >> 16)
    /* DD1EC 800EC9EC 21904000 */  addu       $s2, $v0, $zero
    /* DD1F0 800EC9F0 FFFF8434 */  ori        $a0, $a0, (0xFF0FFFFF & 0xFFFF)
    /* DD1F4 800EC9F4 1C00658E */  lw         $a1, 0x1C($s3)
    /* DD1F8 800EC9F8 0000438E */  lw         $v1, 0x0($s2)
    /* DD1FC 800EC9FC A000023C */  lui        $v0, (0xA00000 >> 16)
    /* DD200 800ECA00 140050AE */  sw         $s0, 0x14($s2)
    /* DD204 800ECA04 100055AE */  sw         $s5, 0x10($s2)
    /* DD208 800ECA08 24186400 */  and        $v1, $v1, $a0
    /* DD20C 800ECA0C 25186200 */  or         $v1, $v1, $v0
    /* DD210 800ECA10 000043AE */  sw         $v1, 0x0($s2)
    /* DD214 800ECA14 0800828E */  lw         $v0, 0x8($s4)
    /* DD218 800ECA18 00000000 */  nop
    /* DD21C 800ECA1C 03004010 */  beqz       $v0, .L800ECA2C
    /* DD220 800ECA20 21800000 */   addu      $s0, $zero, $zero
    /* DD224 800ECA24 01000224 */  addiu      $v0, $zero, 0x1
    /* DD228 800ECA28 0C0042AE */  sw         $v0, 0xC($s2)
  .L800ECA2C:
    /* DD22C 800ECA2C 0400648E */  lw         $a0, 0x4($s3)
    /* DD230 800ECA30 00000000 */  nop
    /* DD234 800ECA34 2A100402 */  slt        $v0, $s0, $a0
    /* DD238 800ECA38 11004010 */  beqz       $v0, .L800ECA80
    /* DD23C 800ECA3C 21180000 */   addu      $v1, $zero, $zero
  .L800ECA40:
    /* DD240 800ECA40 0B00A010 */  beqz       $a1, .L800ECA70
    /* DD244 800ECA44 00000000 */   nop
    /* DD248 800ECA48 0800A28C */  lw         $v0, 0x8($a1)
    /* DD24C 800ECA4C 00000000 */  nop
    /* DD250 800ECA50 07004010 */  beqz       $v0, .L800ECA70
    /* DD254 800ECA54 00000000 */   nop
    /* DD258 800ECA58 0000A28C */  lw         $v0, 0x0($a1)
    /* DD25C 800ECA5C 00000000 */  nop
    /* DD260 800ECA60 0400428C */  lw         $v0, 0x4($v0)
    /* DD264 800ECA64 00000000 */  nop
    /* DD268 800ECA68 19005410 */  beq        $v0, $s4, .L800ECAD0
    /* DD26C 800ECA6C FEFF0224 */   addiu     $v0, $zero, -0x2
  .L800ECA70:
    /* DD270 800ECA70 01006324 */  addiu      $v1, $v1, 0x1
    /* DD274 800ECA74 2A106400 */  slt        $v0, $v1, $a0
    /* DD278 800ECA78 F1FF4014 */  bnez       $v0, .L800ECA40
    /* DD27C 800ECA7C 4C00A524 */   addiu     $a1, $a1, 0x4C
  .L800ECA80:
    /* DD280 800ECA80 0400338E */  lw         $s3, 0x4($s1)
    /* DD284 800ECA84 0C002012 */  beqz       $s1, .L800ECAB8
    /* DD288 800ECA88 01000224 */   addiu     $v0, $zero, 0x1
  .L800ECA8C:
    /* DD28C 800ECA8C 0400228E */  lw         $v0, 0x4($s1)
    /* DD290 800ECA90 00000000 */  nop
    /* DD294 800ECA94 06005410 */  beq        $v0, $s4, .L800ECAB0
    /* DD298 800ECA98 00000000 */   nop
    /* DD29C 800ECA9C 21802002 */  addu       $s0, $s1, $zero
    /* DD2A0 800ECAA0 0C00318E */  lw         $s1, 0xC($s1)
    /* DD2A4 800ECAA4 00000000 */  nop
    /* DD2A8 800ECAA8 F8FF2016 */  bnez       $s1, .L800ECA8C
    /* DD2AC 800ECAAC 00000000 */   nop
  .L800ECAB0:
    /* DD2B0 800ECAB0 02002016 */  bnez       $s1, .L800ECABC
    /* DD2B4 800ECAB4 01000224 */   addiu     $v0, $zero, 0x1
  .L800ECAB8:
    /* DD2B8 800ECAB8 0C0042AE */  sw         $v0, 0xC($s2)
  .L800ECABC:
    /* DD2BC 800ECABC 08000012 */  beqz       $s0, .L800ECAE0
    /* DD2C0 800ECAC0 1480023C */   lui       $v0, %hi(D_8013EAAC)
    /* DD2C4 800ECAC4 0C00228E */  lw         $v0, 0xC($s1)
    /* DD2C8 800ECAC8 B9B20308 */  j          .L800ECAE4
    /* DD2CC 800ECACC 0C0002AE */   sw        $v0, 0xC($s0)
  .L800ECAD0:
    /* DD2D0 800ECAD0 080042AE */  sw         $v0, 0x8($s2)
    /* DD2D4 800ECAD4 01000224 */  addiu      $v0, $zero, 0x1
    /* DD2D8 800ECAD8 A0B20308 */  j          .L800ECA80
    /* DD2DC 800ECADC 0C0042AE */   sw        $v0, 0xC($s2)
  .L800ECAE0:
    /* DD2E0 800ECAE0 ACEA40AC */  sw         $zero, %lo(D_8013EAAC)($v0)
  .L800ECAE4:
    /* DD2E4 800ECAE4 0000248E */  lw         $a0, 0x0($s1)
    /* DD2E8 800ECAE8 5095030C */  jal        purgememadr
    /* DD2EC 800ECAEC 00000000 */   nop
    /* DD2F0 800ECAF0 5095030C */  jal        purgememadr
    /* DD2F4 800ECAF4 21202002 */   addu      $a0, $s1, $zero
    /* DD2F8 800ECAF8 21206002 */  addu       $a0, $s3, $zero
    /* DD2FC 800ECAFC 2128A002 */  addu       $a1, $s5, $zero
    /* DD300 800ECB00 0BB1030C */  jal        FILE_close
    /* DD304 800ECB04 21304002 */   addu      $a2, $s2, $zero
    /* DD308 800ECB08 21204000 */  addu       $a0, $v0, $zero
    /* DD30C 800ECB0C 0F80053C */  lui        $a1, %hi(iFILE_delbigclosecallback)
    /* DD310 800ECB10 93AF030C */  jal        FILE_callbackop
    /* DD314 800ECB14 80C9A524 */   addiu     $a1, $a1, %lo(iFILE_delbigclosecallback)
    /* DD318 800ECB18 0000428E */  lw         $v0, 0x0($s2)
    /* DD31C 800ECB1C 2800BF8F */  lw         $ra, 0x28($sp)
    /* DD320 800ECB20 2400B58F */  lw         $s5, 0x24($sp)
    /* DD324 800ECB24 2000B48F */  lw         $s4, 0x20($sp)
    /* DD328 800ECB28 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DD32C 800ECB2C 1800B28F */  lw         $s2, 0x18($sp)
    /* DD330 800ECB30 1400B18F */  lw         $s1, 0x14($sp)
    /* DD334 800ECB34 1000B08F */  lw         $s0, 0x10($sp)
    /* DD338 800ECB38 0800E003 */  jr         $ra
    /* DD33C 800ECB3C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel FILE_delbig
