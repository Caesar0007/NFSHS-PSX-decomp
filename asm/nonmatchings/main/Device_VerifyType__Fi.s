.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Device_VerifyType__Fi, 0xA8

glabel Device_VerifyType__Fi
    /* ADBC0 800BD3C0 1480023C */  lui        $v0, %hi(gUseFrontend)
    /* ADBC4 800BD3C4 74D2428C */  lw         $v0, %lo(gUseFrontend)($v0)
    /* ADBC8 800BD3C8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* ADBCC 800BD3CC 1800BFAF */  sw         $ra, 0x18($sp)
    /* ADBD0 800BD3D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* ADBD4 800BD3D4 1E004010 */  beqz       $v0, .L800BD450
    /* ADBD8 800BD3D8 1000B0AF */   sw        $s0, 0x10($sp)
    /* ADBDC 800BD3DC 1480023C */  lui        $v0, %hi(gPadinfo)
    /* ADBE0 800BD3E0 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* ADBE4 800BD3E4 C0180400 */  sll        $v1, $a0, 3
    /* ADBE8 800BD3E8 21806200 */  addu       $s0, $v1, $v0
    /* ADBEC 800BD3EC 04000292 */  lbu        $v0, 0x4($s0)
    /* ADBF0 800BD3F0 00000000 */  nop
    /* ADBF4 800BD3F4 17004014 */  bnez       $v0, .L800BD454
    /* ADBF8 800BD3F8 21100000 */   addu      $v0, $zero, $zero
    /* ADBFC 800BD3FC 1180033C */  lui        $v1, %hi(frontEnd)
    /* ADC00 800BD400 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* ADC04 800BD404 2B200400 */  sltu       $a0, $zero, $a0
    /* ADC08 800BD408 23280400 */  negu       $a1, $a0
    /* ADC0C 800BD40C 0200A230 */  andi       $v0, $a1, 0x2
    /* ADC10 800BD410 21884300 */  addu       $s1, $v0, $v1
    /* ADC14 800BD414 05000392 */  lbu        $v1, 0x5($s0)
    /* ADC18 800BD418 5E032286 */  lh         $v0, 0x35E($s1)
    /* ADC1C 800BD41C 00000000 */  nop
    /* ADC20 800BD420 0B006210 */  beq        $v1, $v0, .L800BD450
    /* ADC24 800BD424 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* ADC28 800BD428 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* ADC2C 800BD42C 0400A330 */  andi       $v1, $a1, 0x4
    /* ADC30 800BD430 21186200 */  addu       $v1, $v1, $v0
    /* ADC34 800BD434 6000658C */  lw         $a1, 0x60($v1)
    /* ADC38 800BD438 3371030C */  jal        InGame_ResetPSXController__Fii
    /* ADC3C 800BD43C 00000000 */   nop
    /* ADC40 800BD440 05000392 */  lbu        $v1, 0x5($s0)
    /* ADC44 800BD444 01000224 */  addiu      $v0, $zero, 0x1
    /* ADC48 800BD448 15F50208 */  j          .L800BD454
    /* ADC4C 800BD44C 5E0323A6 */   sh        $v1, 0x35E($s1)
  .L800BD450:
    /* ADC50 800BD450 01000224 */  addiu      $v0, $zero, 0x1
  .L800BD454:
    /* ADC54 800BD454 1800BF8F */  lw         $ra, 0x18($sp)
    /* ADC58 800BD458 1400B18F */  lw         $s1, 0x14($sp)
    /* ADC5C 800BD45C 1000B08F */  lw         $s0, 0x10($sp)
    /* ADC60 800BD460 0800E003 */  jr         $ra
    /* ADC64 800BD464 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Device_VerifyType__Fi
