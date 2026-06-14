.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap, 0x1CC

glabel Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
    /* CD9A4 800DD1A4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* CD9A8 800DD1A8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* CD9AC 800DD1AC 21988000 */  addu       $s3, $a0, $zero
    /* CD9B0 800DD1B0 2000B4AF */  sw         $s4, 0x20($sp)
    /* CD9B4 800DD1B4 21A0A000 */  addu       $s4, $a1, $zero
    /* CD9B8 800DD1B8 2400B5AF */  sw         $s5, 0x24($sp)
    /* CD9BC 800DD1BC 21A8C000 */  addu       $s5, $a2, $zero
    /* CD9C0 800DD1C0 1800B2AF */  sw         $s2, 0x18($sp)
    /* CD9C4 800DD1C4 1F001224 */  addiu      $s2, $zero, 0x1F
    /* CD9C8 800DD1C8 2800BFAF */  sw         $ra, 0x28($sp)
    /* CD9CC 800DD1CC 1400B1AF */  sw         $s1, 0x14($sp)
    /* CD9D0 800DD1D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* CD9D4 800DD1D4 03007092 */  lbu        $s0, 0x3($s3)
    /* CD9D8 800DD1D8 0800648E */  lw         $a0, 0x8($s3)
    /* CD9DC 800DD1DC 23805002 */  subu       $s0, $s2, $s0
    /* CD9E0 800DD1E0 80801000 */  sll        $s0, $s0, 2
    /* CD9E4 800DD1E4 39C6030C */  jal        intcos
    /* CD9E8 800DD1E8 26001026 */   addiu     $s0, $s0, 0x26
    /* CD9EC 800DD1EC 21204000 */  addu       $a0, $v0, $zero
    /* CD9F0 800DD1F0 CA90030C */  jal        fixedmult
    /* CD9F4 800DD1F4 21280002 */   addu      $a1, $s0, $zero
    /* CD9F8 800DD1F8 0800648E */  lw         $a0, 0x8($s3)
    /* CD9FC 800DD1FC 3AC6030C */  jal        intsin
    /* CDA00 800DD200 21884000 */   addu      $s1, $v0, $zero
    /* CDA04 800DD204 21204000 */  addu       $a0, $v0, $zero
    /* CDA08 800DD208 CA90030C */  jal        fixedmult
    /* CDA0C 800DD20C 21280002 */   addu      $a1, $s0, $zero
    /* CDA10 800DD210 30006396 */  lhu        $v1, 0x30($s3)
    /* CDA14 800DD214 00000000 */  nop
    /* CDA18 800DD218 23186200 */  subu       $v1, $v1, $v0
    /* CDA1C 800DD21C 100083A6 */  sh         $v1, 0x10($s4)
    /* CDA20 800DD220 32006396 */  lhu        $v1, 0x32($s3)
    /* CDA24 800DD224 00000000 */  nop
    /* CDA28 800DD228 21187100 */  addu       $v1, $v1, $s1
    /* CDA2C 800DD22C 120083A6 */  sh         $v1, 0x12($s4)
    /* CDA30 800DD230 34006396 */  lhu        $v1, 0x34($s3)
    /* CDA34 800DD234 00000000 */  nop
    /* CDA38 800DD238 140083A6 */  sh         $v1, 0x14($s4)
    /* CDA3C 800DD23C 30006396 */  lhu        $v1, 0x30($s3)
    /* CDA40 800DD240 00000000 */  nop
    /* CDA44 800DD244 21187100 */  addu       $v1, $v1, $s1
    /* CDA48 800DD248 180083A6 */  sh         $v1, 0x18($s4)
    /* CDA4C 800DD24C 32006396 */  lhu        $v1, 0x32($s3)
    /* CDA50 800DD250 00000000 */  nop
    /* CDA54 800DD254 21186200 */  addu       $v1, $v1, $v0
    /* CDA58 800DD258 1A0083A6 */  sh         $v1, 0x1A($s4)
    /* CDA5C 800DD25C 34006396 */  lhu        $v1, 0x34($s3)
    /* CDA60 800DD260 00000000 */  nop
    /* CDA64 800DD264 1C0083A6 */  sh         $v1, 0x1C($s4)
    /* CDA68 800DD268 30006396 */  lhu        $v1, 0x30($s3)
    /* CDA6C 800DD26C 00000000 */  nop
    /* CDA70 800DD270 21186200 */  addu       $v1, $v1, $v0
    /* CDA74 800DD274 200083A6 */  sh         $v1, 0x20($s4)
    /* CDA78 800DD278 32006396 */  lhu        $v1, 0x32($s3)
    /* CDA7C 800DD27C 00000000 */  nop
    /* CDA80 800DD280 23187100 */  subu       $v1, $v1, $s1
    /* CDA84 800DD284 220083A6 */  sh         $v1, 0x22($s4)
    /* CDA88 800DD288 34006396 */  lhu        $v1, 0x34($s3)
    /* CDA8C 800DD28C 00000000 */  nop
    /* CDA90 800DD290 240083A6 */  sh         $v1, 0x24($s4)
    /* CDA94 800DD294 30006396 */  lhu        $v1, 0x30($s3)
    /* CDA98 800DD298 00000000 */  nop
    /* CDA9C 800DD29C 23187100 */  subu       $v1, $v1, $s1
    /* CDAA0 800DD2A0 280083A6 */  sh         $v1, 0x28($s4)
    /* CDAA4 800DD2A4 32006396 */  lhu        $v1, 0x32($s3)
    /* CDAA8 800DD2A8 00000000 */  nop
    /* CDAAC 800DD2AC 23186200 */  subu       $v1, $v1, $v0
    /* CDAB0 800DD2B0 2A0083A6 */  sh         $v1, 0x2A($s4)
    /* CDAB4 800DD2B4 34006296 */  lhu        $v0, 0x34($s3)
    /* CDAB8 800DD2B8 00000000 */  nop
    /* CDABC 800DD2BC 2C0082A6 */  sh         $v0, 0x2C($s4)
    /* CDAC0 800DD2C0 03006292 */  lbu        $v0, 0x3($s3)
    /* CDAC4 800DD2C4 00000000 */  nop
    /* CDAC8 800DD2C8 23904202 */  subu       $s2, $s2, $v0
    /* CDACC 800DD2CC 43901200 */  sra        $s2, $s2, 1
    /* CDAD0 800DD2D0 1000422A */  slti       $v0, $s2, 0x10
    /* CDAD4 800DD2D4 02004014 */  bnez       $v0, .L800DD2E0
    /* CDAD8 800DD2D8 00000000 */   nop
    /* CDADC 800DD2DC 0F001224 */  addiu      $s2, $zero, 0xF
  .L800DD2E0:
    /* CDAE0 800DD2E0 3800628E */  lw         $v0, 0x38($s3)
    /* CDAE4 800DD2E4 1480033C */  lui        $v1, %hi(gSMokePixmap)
    /* CDAE8 800DD2E8 F4D16324 */  addiu      $v1, $v1, %lo(gSMokePixmap)
    /* CDAEC 800DD2EC 80100200 */  sll        $v0, $v0, 2
    /* CDAF0 800DD2F0 21104300 */  addu       $v0, $v0, $v1
    /* CDAF4 800DD2F4 0000428C */  lw         $v0, 0x0($v0)
    /* CDAF8 800DD2F8 00000000 */  nop
    /* CDAFC 800DD2FC 03004788 */  lwl        $a3, 0x3($v0)
    /* CDB00 800DD300 00004798 */  lwr        $a3, 0x0($v0)
    /* CDB04 800DD304 07004888 */  lwl        $t0, 0x7($v0)
    /* CDB08 800DD308 04004898 */  lwr        $t0, 0x4($v0)
    /* CDB0C 800DD30C 0B004988 */  lwl        $t1, 0xB($v0)
    /* CDB10 800DD310 08004998 */  lwr        $t1, 0x8($v0)
    /* CDB14 800DD314 0F004A88 */  lwl        $t2, 0xF($v0)
    /* CDB18 800DD318 0C004A98 */  lwr        $t2, 0xC($v0)
    /* CDB1C 800DD31C 030087AA */  swl        $a3, 0x3($s4)
    /* CDB20 800DD320 000087BA */  swr        $a3, 0x0($s4)
    /* CDB24 800DD324 070088AA */  swl        $t0, 0x7($s4)
    /* CDB28 800DD328 040088BA */  swr        $t0, 0x4($s4)
    /* CDB2C 800DD32C 0B0089AA */  swl        $t1, 0xB($s4)
    /* CDB30 800DD330 080089BA */  swr        $t1, 0x8($s4)
    /* CDB34 800DD334 0F008AAA */  swl        $t2, 0xF($s4)
    /* CDB38 800DD338 0C008ABA */  swr        $t2, 0xC($s4)
    /* CDB3C 800DD33C 0200A296 */  lhu        $v0, 0x2($s5)
    /* CDB40 800DD340 00000000 */  nop
    /* CDB44 800DD344 21105200 */  addu       $v0, $v0, $s2
    /* CDB48 800DD348 020082A6 */  sh         $v0, 0x2($s4)
    /* CDB4C 800DD34C 2800BF8F */  lw         $ra, 0x28($sp)
    /* CDB50 800DD350 2400B58F */  lw         $s5, 0x24($sp)
    /* CDB54 800DD354 2000B48F */  lw         $s4, 0x20($sp)
    /* CDB58 800DD358 1C00B38F */  lw         $s3, 0x1C($sp)
    /* CDB5C 800DD35C 1800B28F */  lw         $s2, 0x18($sp)
    /* CDB60 800DD360 1400B18F */  lw         $s1, 0x14($sp)
    /* CDB64 800DD364 1000B08F */  lw         $s0, 0x10($sp)
    /* CDB68 800DD368 0800E003 */  jr         $ra
    /* CDB6C 800DD36C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap
