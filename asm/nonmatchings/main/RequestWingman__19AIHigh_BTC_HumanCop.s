.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RequestWingman__19AIHigh_BTC_HumanCop, 0x11C

glabel RequestWingman__19AIHigh_BTC_HumanCop
    /* 4E3F8 8005DBF8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4E3FC 8005DBFC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4E400 8005DC00 21888000 */  addu       $s1, $a0, $zero
    /* 4E404 8005DC04 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4E408 8005DC08 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4E40C 8005DC0C 6000228E */  lw         $v0, 0x60($s1)
    /* 4E410 8005DC10 00000000 */  nop
    /* 4E414 8005DC14 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* 4E418 8005DC18 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4E41C 8005DC1C 38004014 */  bnez       $v0, .L8005DD00
    /* 4E420 8005DC20 1180063C */   lui       $a2, %hi(GameSetup_gData)
    /* 4E424 8005DC24 EC31C624 */  addiu      $a2, $a2, %lo(GameSetup_gData)
    /* 4E428 8005DC28 1180053C */  lui        $a1, %hi(AITune_BTC)
    /* 4E42C 8005DC2C 14DEA524 */  addiu      $a1, $a1, %lo(AITune_BTC)
    /* 4E430 8005DC30 6400228E */  lw         $v0, 0x64($s1)
    /* 4E434 8005DC34 0000248E */  lw         $a0, 0x0($s1)
    /* 4E438 8005DC38 40180200 */  sll        $v1, $v0, 1
    /* 4E43C 8005DC3C 21186200 */  addu       $v1, $v1, $v0
    /* 4E440 8005DC40 80180300 */  sll        $v1, $v1, 2
    /* 4E444 8005DC44 21186200 */  addu       $v1, $v1, $v0
    /* 4E448 8005DC48 80180300 */  sll        $v1, $v1, 2
    /* 4E44C 8005DC4C 21186600 */  addu       $v1, $v1, $a2
    /* 4E450 8005DC50 0800C68C */  lw         $a2, 0x8($a2)
    /* 4E454 8005DC54 D401638C */  lw         $v1, 0x1D4($v1)
    /* 4E458 8005DC58 C0100600 */  sll        $v0, $a2, 3
    /* 4E45C 8005DC5C 23104600 */  subu       $v0, $v0, $a2
    /* 4E460 8005DC60 80100200 */  sll        $v0, $v0, 2
    /* 4E464 8005DC64 21104500 */  addu       $v0, $v0, $a1
    /* 4E468 8005DC68 1000428C */  lw         $v0, 0x10($v0)
    /* 4E46C 8005DC6C 80190300 */  sll        $v1, $v1, 6
    /* 4E470 8005DC70 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4E474 8005DC74 21806200 */   addu      $s0, $v1, $v0
    /* 4E478 8005DC78 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E47C 8005DC7C 00000000 */  nop
    /* 4E480 8005DC80 60006484 */  lh         $a0, 0x60($v1)
    /* 4E484 8005DC84 6400638C */  lw         $v1, 0x64($v1)
    /* 4E488 8005DC88 00000000 */  nop
    /* 4E48C 8005DC8C 09F86000 */  jalr       $v1
    /* 4E490 8005DC90 21204400 */   addu      $a0, $v0, $a0
    /* 4E494 8005DC94 7400238E */  lw         $v1, 0x74($s1)
    /* 4E498 8005DC98 00000000 */  nop
    /* 4E49C 8005DC9C 0F006010 */  beqz       $v1, .L8005DCDC
    /* 4E4A0 8005DCA0 00000000 */   nop
    /* 4E4A4 8005DCA4 0D000012 */  beqz       $s0, .L8005DCDC
    /* 4E4A8 8005DCA8 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4E4AC 8005DCAC B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4E4B0 8005DCB0 00000000 */  nop
    /* 4E4B4 8005DCB4 23104300 */  subu       $v0, $v0, $v1
    /* 4E4B8 8005DCB8 2A100202 */  slt        $v0, $s0, $v0
    /* 4E4BC 8005DCBC 07004010 */  beqz       $v0, .L8005DCDC
    /* 4E4C0 8005DCC0 04000224 */   addiu     $v0, $zero, 0x4
    /* 4E4C4 8005DCC4 7800238E */  lw         $v1, 0x78($s1)
    /* 4E4C8 8005DCC8 00000000 */  nop
    /* 4E4CC 8005DCCC 03006210 */  beq        $v1, $v0, .L8005DCDC
    /* 4E4D0 8005DCD0 01000224 */   addiu     $v0, $zero, 0x1
    /* 4E4D4 8005DCD4 40770108 */  j          .L8005DD00
    /* 4E4D8 8005DCD8 780022AE */   sw        $v0, 0x78($s1)
  .L8005DCDC:
    /* 4E4DC 8005DCDC BC57020C */  jal        Dispatch__6Speech
    /* 4E4E0 8005DCE0 00000000 */   nop
    /* 4E4E4 8005DCE4 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E4E8 8005DCE8 00000000 */  nop
    /* 4E4EC 8005DCEC 18006484 */  lh         $a0, 0x18($v1)
    /* 4E4F0 8005DCF0 1C00638C */  lw         $v1, 0x1C($v1)
    /* 4E4F4 8005DCF4 00000000 */  nop
    /* 4E4F8 8005DCF8 09F86000 */  jalr       $v1
    /* 4E4FC 8005DCFC 21204400 */   addu      $a0, $v0, $a0
  .L8005DD00:
    /* 4E500 8005DD00 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4E504 8005DD04 1400B18F */  lw         $s1, 0x14($sp)
    /* 4E508 8005DD08 1000B08F */  lw         $s0, 0x10($sp)
    /* 4E50C 8005DD0C 0800E003 */  jr         $ra
    /* 4E510 8005DD10 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel RequestWingman__19AIHigh_BTC_HumanCop
