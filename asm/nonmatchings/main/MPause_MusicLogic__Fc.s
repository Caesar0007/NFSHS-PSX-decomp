.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_MusicLogic__Fc, 0x2B8

glabel MPause_MusicLogic__Fc
    /* 8EBE8 8009E3E8 1180023C */  lui        $v0, %hi(D_801132D8)
    /* 8EBEC 8009E3EC D832438C */  lw         $v1, %lo(D_801132D8)($v0)
    /* 8EBF0 8009E3F0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8EBF4 8009E3F4 2000B2AF */  sw         $s2, 0x20($sp)
    /* 8EBF8 8009E3F8 21908000 */  addu       $s2, $a0, $zero
    /* 8EBFC 8009E3FC 1800B0AF */  sw         $s0, 0x18($sp)
    /* 8EC00 8009E400 01001024 */  addiu      $s0, $zero, 0x1
    /* 8EC04 8009E404 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 8EC08 8009E408 10001124 */  addiu      $s1, $zero, 0x10
    /* 8EC0C 8009E40C 12007010 */  beq        $v1, $s0, .L8009E458
    /* 8EC10 8009E410 2400BFAF */   sw        $ra, 0x24($sp)
    /* 8EC14 8009E414 02006228 */  slti       $v0, $v1, 0x2
    /* 8EC18 8009E418 05004010 */  beqz       $v0, .L8009E430
    /* 8EC1C 8009E41C 02000224 */   addiu     $v0, $zero, 0x2
    /* 8EC20 8009E420 07006010 */  beqz       $v1, .L8009E440
    /* 8EC24 8009E424 FF004232 */   andi      $v0, $s2, 0xFF
    /* 8EC28 8009E428 20790208 */  j          .L8009E480
    /* 8EC2C 8009E42C 00000000 */   nop
  .L8009E430:
    /* 8EC30 8009E430 0F006210 */  beq        $v1, $v0, .L8009E470
    /* 8EC34 8009E434 FF004232 */   andi      $v0, $s2, 0xFF
    /* 8EC38 8009E438 20790208 */  j          .L8009E480
    /* 8EC3C 8009E43C 00000000 */   nop
  .L8009E440:
    /* 8EC40 8009E440 1480013C */  lui        $at, %hi(gStereoMode)
    /* 8EC44 8009E444 74C630AC */  sw         $s0, %lo(gStereoMode)($at)
    /* 8EC48 8009E448 1480013C */  lui        $at, %hi(Audio_direct3davail)
    /* 8EC4C 8009E44C FCD420AC */  sw         $zero, %lo(Audio_direct3davail)($at)
    /* 8EC50 8009E450 20790208 */  j          .L8009E480
    /* 8EC54 8009E454 00000000 */   nop
  .L8009E458:
    /* 8EC58 8009E458 1480013C */  lui        $at, %hi(gStereoMode)
    /* 8EC5C 8009E45C 74C620AC */  sw         $zero, %lo(gStereoMode)($at)
    /* 8EC60 8009E460 1480013C */  lui        $at, %hi(Audio_direct3davail)
    /* 8EC64 8009E464 FCD420AC */  sw         $zero, %lo(Audio_direct3davail)($at)
    /* 8EC68 8009E468 20790208 */  j          .L8009E480
    /* 8EC6C 8009E46C FF004232 */   andi      $v0, $s2, 0xFF
  .L8009E470:
    /* 8EC70 8009E470 1480013C */  lui        $at, %hi(gStereoMode)
    /* 8EC74 8009E474 74C630AC */  sw         $s0, %lo(gStereoMode)($at)
    /* 8EC78 8009E478 1480013C */  lui        $at, %hi(Audio_direct3davail)
    /* 8EC7C 8009E47C FCD430AC */  sw         $s0, %lo(Audio_direct3davail)($at)
  .L8009E480:
    /* 8EC80 8009E480 76004010 */  beqz       $v0, .L8009E65C
    /* 8EC84 8009E484 00000000 */   nop
    /* 8EC88 8009E488 080D8293 */  lbu        $v0, %gp_rel(D_8013D254)($gp)
    /* 8EC8C 8009E48C 00000000 */  nop
    /* 8EC90 8009E490 08004014 */  bnez       $v0, .L8009E4B4
    /* 8EC94 8009E494 00000000 */   nop
    /* 8EC98 8009E498 1480043C */  lui        $a0, %hi(gMasterMusicLevel)
    /* 8EC9C 8009E49C 50C6848C */  lw         $a0, %lo(gMasterMusicLevel)($a0)
    /* 8ECA0 8009E4A0 08D9010C */  jal        AudioCmn_MusicLevel__Fi
    /* 8ECA4 8009E4A4 00000000 */   nop
    /* 8ECA8 8009E4A8 F4010424 */  addiu      $a0, $zero, 0x1F4
    /* 8ECAC 8009E4AC 1BED010C */  jal        AudioMus_AutoVolume__Fii
    /* 8ECB0 8009E4B0 21284000 */   addu      $a1, $v0, $zero
  .L8009E4B4:
    /* 8ECB4 8009E4B4 7418828F */  lw         $v0, %gp_rel(D_8013DDC0)($gp)
    /* 8ECB8 8009E4B8 00000000 */  nop
    /* 8ECBC 8009E4BC 0000438C */  lw         $v1, 0x0($v0)
    /* 8ECC0 8009E4C0 01000224 */  addiu      $v0, $zero, 0x1
    /* 8ECC4 8009E4C4 04006210 */  beq        $v1, $v0, .L8009E4D8
    /* 8ECC8 8009E4C8 21200000 */   addu      $a0, $zero, $zero
    /* 8ECCC 8009E4CC 02000224 */  addiu      $v0, $zero, 0x2
    /* 8ECD0 8009E4D0 02006214 */  bne        $v1, $v0, .L8009E4DC
    /* 8ECD4 8009E4D4 00000000 */   nop
  .L8009E4D8:
    /* 8ECD8 8009E4D8 01000424 */  addiu      $a0, $zero, 0x1
  .L8009E4DC:
    /* 8ECDC 8009E4DC 07008010 */  beqz       $a0, .L8009E4FC
    /* 8ECE0 8009E4E0 00000000 */   nop
    /* 8ECE4 8009E4E4 1480043C */  lui        $a0, %hi(gMasterMusicLevel)
    /* 8ECE8 8009E4E8 50C6848C */  lw         $a0, %lo(gMasterMusicLevel)($a0)
    /* 8ECEC 8009E4EC 08D9010C */  jal        AudioCmn_MusicLevel__Fi
    /* 8ECF0 8009E4F0 00000000 */   nop
    /* 8ECF4 8009E4F4 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 8ECF8 8009E4F8 21204000 */   addu      $a0, $v0, $zero
  .L8009E4FC:
    /* 8ECFC 8009E4FC 7418848F */  lw         $a0, %gp_rel(D_8013DDC0)($gp)
    /* 8ED00 8009E500 00000000 */  nop
    /* 8ED04 8009E504 0000838C */  lw         $v1, 0x0($a0)
    /* 8ED08 8009E508 03000224 */  addiu      $v0, $zero, 0x3
    /* 8ED0C 8009E50C 090D80A3 */  sb         $zero, %gp_rel(D_8013D254 + 0x1)($gp)
    /* 8ED10 8009E510 06006214 */  bne        $v1, $v0, .L8009E52C
    /* 8ED14 8009E514 01000224 */   addiu     $v0, $zero, 0x1
    /* 8ED18 8009E518 10001124 */  addiu      $s1, $zero, 0x10
    /* 8ED1C 8009E51C 1480033C */  lui        $v1, %hi(gMasterSFXLevel)
    /* 8ED20 8009E520 54C6638C */  lw         $v1, %lo(gMasterSFXLevel)($v1)
    /* 8ED24 8009E524 090D82A3 */  sb         $v0, %gp_rel(D_8013D254 + 0x1)($gp)
    /* 8ED28 8009E528 0C0D83AF */  sw         $v1, %gp_rel(D_8013D258)($gp)
  .L8009E52C:
    /* 8ED2C 8009E52C 0000838C */  lw         $v1, 0x0($a0)
    /* 8ED30 8009E530 04000224 */  addiu      $v0, $zero, 0x4
    /* 8ED34 8009E534 09006214 */  bne        $v1, $v0, .L8009E55C
    /* 8ED38 8009E538 05000224 */   addiu     $v0, $zero, 0x5
    /* 8ED3C 8009E53C 10001124 */  addiu      $s1, $zero, 0x10
    /* 8ED40 8009E540 1480033C */  lui        $v1, %hi(gMasterFENarrationLevel)
    /* 8ED44 8009E544 5CC6638C */  lw         $v1, %lo(gMasterFENarrationLevel)($v1)
    /* 8ED48 8009E548 01000224 */  addiu      $v0, $zero, 0x1
    /* 8ED4C 8009E54C 090D82A3 */  sb         $v0, %gp_rel(D_8013D254 + 0x1)($gp)
    /* 8ED50 8009E550 0C0D83AF */  sw         $v1, %gp_rel(D_8013D258)($gp)
    /* 8ED54 8009E554 0000838C */  lw         $v1, 0x0($a0)
    /* 8ED58 8009E558 05000224 */  addiu      $v0, $zero, 0x5
  .L8009E55C:
    /* 8ED5C 8009E55C 06006214 */  bne        $v1, $v0, .L8009E578
    /* 8ED60 8009E560 01000224 */   addiu     $v0, $zero, 0x1
    /* 8ED64 8009E564 10001124 */  addiu      $s1, $zero, 0x10
    /* 8ED68 8009E568 1480033C */  lui        $v1, %hi(gMasterEngineLevel)
    /* 8ED6C 8009E56C 58C6638C */  lw         $v1, %lo(gMasterEngineLevel)($v1)
    /* 8ED70 8009E570 090D82A3 */  sb         $v0, %gp_rel(D_8013D254 + 0x1)($gp)
    /* 8ED74 8009E574 0C0D83AF */  sw         $v1, %gp_rel(D_8013D258)($gp)
  .L8009E578:
    /* 8ED78 8009E578 0000838C */  lw         $v1, 0x0($a0)
    /* 8ED7C 8009E57C 06000224 */  addiu      $v0, $zero, 0x6
    /* 8ED80 8009E580 06006214 */  bne        $v1, $v0, .L8009E59C
    /* 8ED84 8009E584 01000224 */   addiu     $v0, $zero, 0x1
    /* 8ED88 8009E588 10001124 */  addiu      $s1, $zero, 0x10
    /* 8ED8C 8009E58C 1480033C */  lui        $v1, %hi(gMasterAmbientLevel)
    /* 8ED90 8009E590 60C6638C */  lw         $v1, %lo(gMasterAmbientLevel)($v1)
    /* 8ED94 8009E594 090D82A3 */  sb         $v0, %gp_rel(D_8013D254 + 0x1)($gp)
    /* 8ED98 8009E598 0C0D83AF */  sw         $v1, %gp_rel(D_8013D258)($gp)
  .L8009E59C:
    /* 8ED9C 8009E59C 090D8293 */  lbu        $v0, %gp_rel(D_8013D254 + 0x1)($gp)
    /* 8EDA0 8009E5A0 00000000 */  nop
    /* 8EDA4 8009E5A4 23004010 */  beqz       $v0, .L8009E634
    /* 8EDA8 8009E5A8 01000224 */   addiu     $v0, $zero, 0x1
    /* 8EDAC 8009E5AC 0A0D8293 */  lbu        $v0, %gp_rel(D_8013D254 + 0x2)($gp)
    /* 8EDB0 8009E5B0 00000000 */  nop
    /* 8EDB4 8009E5B4 04004014 */  bnez       $v0, .L8009E5C8
    /* 8EDB8 8009E5B8 01000224 */   addiu     $v0, $zero, 0x1
    /* 8EDBC 8009E5BC 0A0D82A3 */  sb         $v0, %gp_rel(D_8013D254 + 0x2)($gp)
    /* 8EDC0 8009E5C0 76790208 */  j          .L8009E5D8
    /* 8EDC4 8009E5C4 00000000 */   nop
  .L8009E5C8:
    /* 8EDC8 8009E5C8 100D848F */  lw         $a0, %gp_rel(D_8013D25C)($gp)
    /* 8EDCC 8009E5CC C59E030C */  jal        SNDover
    /* 8EDD0 8009E5D0 00000000 */   nop
    /* 8EDD4 8009E5D4 21804000 */  addu       $s0, $v0, $zero
  .L8009E5D8:
    /* 8EDD8 8009E5D8 2A000012 */  beqz       $s0, .L8009E684
    /* 8EDDC 8009E5DC 00000000 */   nop
    /* 8EDE0 8009E5E0 1480023C */  lui        $v0, %hi(ticks)
    /* 8EDE4 8009E5E4 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 8EDE8 8009E5E8 140D838F */  lw         $v1, %gp_rel(D_8013D260)($gp)
    /* 8EDEC 8009E5EC 00000000 */  nop
    /* 8EDF0 8009E5F0 23104300 */  subu       $v0, $v0, $v1
    /* 8EDF4 8009E5F4 C1004228 */  slti       $v0, $v0, 0xC1
    /* 8EDF8 8009E5F8 22004014 */  bnez       $v0, .L8009E684
    /* 8EDFC 8009E5FC 1180023C */   lui       $v0, %hi(D_8010E8CC)
    /* 8EE00 8009E600 21282002 */  addu       $a1, $s1, $zero
    /* 8EE04 8009E604 CCE8448C */  lw         $a0, %lo(D_8010E8CC)($v0)
    /* 8EE08 8009E608 40000224 */  addiu      $v0, $zero, 0x40
    /* 8EE0C 8009E60C 1480033C */  lui        $v1, %hi(ticks)
    /* 8EE10 8009E610 ACDC638C */  lw         $v1, %lo(ticks)($v1)
    /* 8EE14 8009E614 0C0D878F */  lw         $a3, %gp_rel(D_8013D258)($gp)
    /* 8EE18 8009E618 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8EE1C 8009E61C 140D83AF */  sw         $v1, %gp_rel(D_8013D260)($gp)
    /* 8EE20 8009E620 E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* 8EE24 8009E624 21300000 */   addu      $a2, $zero, $zero
    /* 8EE28 8009E628 100D82AF */  sw         $v0, %gp_rel(D_8013D25C)($gp)
    /* 8EE2C 8009E62C A1790208 */  j          .L8009E684
    /* 8EE30 8009E630 00000000 */   nop
  .L8009E634:
    /* 8EE34 8009E634 0A0D8393 */  lbu        $v1, %gp_rel(D_8013D254 + 0x2)($gp)
    /* 8EE38 8009E638 00000000 */  nop
    /* 8EE3C 8009E63C 11006214 */  bne        $v1, $v0, .L8009E684
    /* 8EE40 8009E640 00000000 */   nop
    /* 8EE44 8009E644 100D848F */  lw         $a0, %gp_rel(D_8013D25C)($gp)
    /* 8EE48 8009E648 A09F030C */  jal        SNDstop
    /* 8EE4C 8009E64C 00000000 */   nop
    /* 8EE50 8009E650 0A0D80A3 */  sb         $zero, %gp_rel(D_8013D254 + 0x2)($gp)
    /* 8EE54 8009E654 A1790208 */  j          .L8009E684
    /* 8EE58 8009E658 00000000 */   nop
  .L8009E65C:
    /* 8EE5C 8009E65C 080D8293 */  lbu        $v0, %gp_rel(D_8013D254)($gp)
    /* 8EE60 8009E660 00000000 */  nop
    /* 8EE64 8009E664 07004010 */  beqz       $v0, .L8009E684
    /* 8EE68 8009E668 00000000 */   nop
    /* 8EE6C 8009E66C 100D848F */  lw         $a0, %gp_rel(D_8013D25C)($gp)
    /* 8EE70 8009E670 A09F030C */  jal        SNDstop
    /* 8EE74 8009E674 00000000 */   nop
    /* 8EE78 8009E678 F4010424 */  addiu      $a0, $zero, 0x1F4
    /* 8EE7C 8009E67C 1BED010C */  jal        AudioMus_AutoVolume__Fii
    /* 8EE80 8009E680 21280000 */   addu      $a1, $zero, $zero
  .L8009E684:
    /* 8EE84 8009E684 2400BF8F */  lw         $ra, 0x24($sp)
    /* 8EE88 8009E688 080D92A3 */  sb         $s2, %gp_rel(D_8013D254)($gp)
    /* 8EE8C 8009E68C 2000B28F */  lw         $s2, 0x20($sp)
    /* 8EE90 8009E690 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 8EE94 8009E694 1800B08F */  lw         $s0, 0x18($sp)
    /* 8EE98 8009E698 0800E003 */  jr         $ra
    /* 8EE9C 8009E69C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel MPause_MusicLogic__Fc
