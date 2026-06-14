.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RequestBlockader__19AIHigh_BTC_HumanCopi, 0x1D8

glabel RequestBlockader__19AIHigh_BTC_HumanCopi
    /* 4E514 8005DD14 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4E518 8005DD18 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4E51C 8005DD1C 21808000 */  addu       $s0, $a0, $zero
    /* 4E520 8005DD20 1800BFAF */  sw         $ra, 0x18($sp)
    /* 4E524 8005DD24 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4E528 8005DD28 6000028E */  lw         $v0, 0x60($s0)
    /* 4E52C 8005DD2C 00000000 */  nop
    /* 4E530 8005DD30 FDFF4224 */  addiu      $v0, $v0, -0x3
    /* 4E534 8005DD34 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4E538 8005DD38 67004014 */  bnez       $v0, .L8005DED8
    /* 4E53C 8005DD3C 2188A000 */   addu      $s1, $a1, $zero
    /* 4E540 8005DD40 1F002012 */  beqz       $s1, .L8005DDC0
    /* 4E544 8005DD44 00000000 */   nop
    /* 4E548 8005DD48 0000048E */  lw         $a0, 0x0($s0)
    /* 4E54C 8005DD4C 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4E550 8005DD50 00000000 */   nop
    /* 4E554 8005DD54 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E558 8005DD58 00000000 */  nop
    /* 4E55C 8005DD5C 58006484 */  lh         $a0, 0x58($v1)
    /* 4E560 8005DD60 5C00638C */  lw         $v1, 0x5C($v1)
    /* 4E564 8005DD64 00000000 */  nop
    /* 4E568 8005DD68 09F86000 */  jalr       $v1
    /* 4E56C 8005DD6C 21204400 */   addu      $a0, $v0, $a0
    /* 4E570 8005DD70 1180053C */  lui        $a1, %hi(GameSetup_gData)
    /* 4E574 8005DD74 EC31A524 */  addiu      $a1, $a1, %lo(GameSetup_gData)
    /* 4E578 8005DD78 1180043C */  lui        $a0, %hi(AITune_BTC)
    /* 4E57C 8005DD7C 6400028E */  lw         $v0, 0x64($s0)
    /* 4E580 8005DD80 14DE8424 */  addiu      $a0, $a0, %lo(AITune_BTC)
    /* 4E584 8005DD84 40180200 */  sll        $v1, $v0, 1
    /* 4E588 8005DD88 21186200 */  addu       $v1, $v1, $v0
    /* 4E58C 8005DD8C 80180300 */  sll        $v1, $v1, 2
    /* 4E590 8005DD90 21186200 */  addu       $v1, $v1, $v0
    /* 4E594 8005DD94 80180300 */  sll        $v1, $v1, 2
    /* 4E598 8005DD98 21186500 */  addu       $v1, $v1, $a1
    /* 4E59C 8005DD9C 0800A58C */  lw         $a1, 0x8($a1)
    /* 4E5A0 8005DDA0 D801638C */  lw         $v1, 0x1D8($v1)
    /* 4E5A4 8005DDA4 C0100500 */  sll        $v0, $a1, 3
    /* 4E5A8 8005DDA8 23104500 */  subu       $v0, $v0, $a1
    /* 4E5AC 8005DDAC 80100200 */  sll        $v0, $v0, 2
    /* 4E5B0 8005DDB0 21104400 */  addu       $v0, $v0, $a0
    /* 4E5B4 8005DDB4 1800428C */  lw         $v0, 0x18($v0)
    /* 4E5B8 8005DDB8 8D770108 */  j          .L8005DE34
    /* 4E5BC 8005DDBC 80190300 */   sll       $v1, $v1, 6
  .L8005DDC0:
    /* 4E5C0 8005DDC0 0000048E */  lw         $a0, 0x0($s0)
    /* 4E5C4 8005DDC4 175E020C */  jal        Mobile__6SpeechP8Car_tObj
    /* 4E5C8 8005DDC8 00000000 */   nop
    /* 4E5CC 8005DDCC 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E5D0 8005DDD0 00000000 */  nop
    /* 4E5D4 8005DDD4 50006484 */  lh         $a0, 0x50($v1)
    /* 4E5D8 8005DDD8 5400638C */  lw         $v1, 0x54($v1)
    /* 4E5DC 8005DDDC 00000000 */  nop
    /* 4E5E0 8005DDE0 09F86000 */  jalr       $v1
    /* 4E5E4 8005DDE4 21204400 */   addu      $a0, $v0, $a0
    /* 4E5E8 8005DDE8 1180053C */  lui        $a1, %hi(GameSetup_gData)
    /* 4E5EC 8005DDEC EC31A524 */  addiu      $a1, $a1, %lo(GameSetup_gData)
    /* 4E5F0 8005DDF0 1180043C */  lui        $a0, %hi(AITune_BTC)
    /* 4E5F4 8005DDF4 6400028E */  lw         $v0, 0x64($s0)
    /* 4E5F8 8005DDF8 14DE8424 */  addiu      $a0, $a0, %lo(AITune_BTC)
    /* 4E5FC 8005DDFC 40180200 */  sll        $v1, $v0, 1
    /* 4E600 8005DE00 21186200 */  addu       $v1, $v1, $v0
    /* 4E604 8005DE04 80180300 */  sll        $v1, $v1, 2
    /* 4E608 8005DE08 21186200 */  addu       $v1, $v1, $v0
    /* 4E60C 8005DE0C 80180300 */  sll        $v1, $v1, 2
    /* 4E610 8005DE10 21186500 */  addu       $v1, $v1, $a1
    /* 4E614 8005DE14 0800A58C */  lw         $a1, 0x8($a1)
    /* 4E618 8005DE18 DC01638C */  lw         $v1, 0x1DC($v1)
    /* 4E61C 8005DE1C C0100500 */  sll        $v0, $a1, 3
    /* 4E620 8005DE20 23104500 */  subu       $v0, $v0, $a1
    /* 4E624 8005DE24 80100200 */  sll        $v0, $v0, 2
    /* 4E628 8005DE28 21104400 */  addu       $v0, $v0, $a0
    /* 4E62C 8005DE2C 1400428C */  lw         $v0, 0x14($v0)
    /* 4E630 8005DE30 80190300 */  sll        $v1, $v1, 6
  .L8005DE34:
    /* 4E634 8005DE34 7400048E */  lw         $a0, 0x74($s0)
    /* 4E638 8005DE38 00000000 */  nop
    /* 4E63C 8005DE3C 1D008010 */  beqz       $a0, .L8005DEB4
    /* 4E640 8005DE40 21186200 */   addu      $v1, $v1, $v0
    /* 4E644 8005DE44 1B006018 */  blez       $v1, .L8005DEB4
    /* 4E648 8005DE48 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 4E64C 8005DE4C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 4E650 8005DE50 00000000 */  nop
    /* 4E654 8005DE54 23104400 */  subu       $v0, $v0, $a0
    /* 4E658 8005DE58 2A106200 */  slt        $v0, $v1, $v0
    /* 4E65C 8005DE5C 15004010 */  beqz       $v0, .L8005DEB4
    /* 4E660 8005DE60 05000224 */   addiu     $v0, $zero, 0x5
    /* 4E664 8005DE64 7800038E */  lw         $v1, 0x78($s0)
    /* 4E668 8005DE68 00000000 */  nop
    /* 4E66C 8005DE6C 11006210 */  beq        $v1, $v0, .L8005DEB4
    /* 4E670 8005DE70 00000000 */   nop
    /* 4E674 8005DE74 BC57020C */  jal        Dispatch__6Speech
    /* 4E678 8005DE78 00000000 */   nop
    /* 4E67C 8005DE7C 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E680 8005DE80 00000000 */  nop
    /* 4E684 8005DE84 20006484 */  lh         $a0, 0x20($v1)
    /* 4E688 8005DE88 2400638C */  lw         $v1, 0x24($v1)
    /* 4E68C 8005DE8C 00000000 */  nop
    /* 4E690 8005DE90 09F86000 */  jalr       $v1
    /* 4E694 8005DE94 21204400 */   addu      $a0, $v0, $a0
    /* 4E698 8005DE98 03002012 */  beqz       $s1, .L8005DEA8
    /* 4E69C 8005DE9C 03000224 */   addiu     $v0, $zero, 0x3
    /* 4E6A0 8005DEA0 B6770108 */  j          .L8005DED8
    /* 4E6A4 8005DEA4 780002AE */   sw        $v0, 0x78($s0)
  .L8005DEA8:
    /* 4E6A8 8005DEA8 02000224 */  addiu      $v0, $zero, 0x2
    /* 4E6AC 8005DEAC B6770108 */  j          .L8005DED8
    /* 4E6B0 8005DEB0 780002AE */   sw        $v0, 0x78($s0)
  .L8005DEB4:
    /* 4E6B4 8005DEB4 BC57020C */  jal        Dispatch__6Speech
    /* 4E6B8 8005DEB8 00000000 */   nop
    /* 4E6BC 8005DEBC 4C00438C */  lw         $v1, 0x4C($v0)
    /* 4E6C0 8005DEC0 00000000 */  nop
    /* 4E6C4 8005DEC4 18006484 */  lh         $a0, 0x18($v1)
    /* 4E6C8 8005DEC8 1C00638C */  lw         $v1, 0x1C($v1)
    /* 4E6CC 8005DECC 00000000 */  nop
    /* 4E6D0 8005DED0 09F86000 */  jalr       $v1
    /* 4E6D4 8005DED4 21204400 */   addu      $a0, $v0, $a0
  .L8005DED8:
    /* 4E6D8 8005DED8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 4E6DC 8005DEDC 1400B18F */  lw         $s1, 0x14($sp)
    /* 4E6E0 8005DEE0 1000B08F */  lw         $s0, 0x10($sp)
    /* 4E6E4 8005DEE4 0800E003 */  jr         $ra
    /* 4E6E8 8005DEE8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel RequestBlockader__19AIHigh_BTC_HumanCopi
