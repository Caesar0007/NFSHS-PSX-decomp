.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetDamageFactor__FP8Car_tObj, 0x118

glabel AISpeeds_GetDamageFactor__FP8Car_tObj
    /* 5F098 8006E898 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5F09C 8006E89C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F0A0 8006E8A0 21808000 */  addu       $s0, $a0, $zero
    /* 5F0A4 8006E8A4 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5F0A8 8006E8A8 1802028E */  lw         $v0, 0x218($s0)
    /* 5F0AC 8006E8AC 1C02038E */  lw         $v1, 0x21C($s0)
    /* 5F0B0 8006E8B0 2402048E */  lw         $a0, 0x224($s0)
    /* 5F0B4 8006E8B4 21104300 */  addu       $v0, $v0, $v1
    /* 5F0B8 8006E8B8 2002038E */  lw         $v1, 0x220($s0)
    /* 5F0BC 8006E8BC 780700AE */  sw         $zero, 0x778($s0)
    /* 5F0C0 8006E8C0 21104300 */  addu       $v0, $v0, $v1
    /* 5F0C4 8006E8C4 21104400 */  addu       $v0, $v0, $a0
    /* 5F0C8 8006E8C8 2802038E */  lw         $v1, 0x228($s0)
    /* 5F0CC 8006E8CC 2C02048E */  lw         $a0, 0x22C($s0)
    /* 5F0D0 8006E8D0 21104300 */  addu       $v0, $v0, $v1
    /* 5F0D4 8006E8D4 21104400 */  addu       $v0, $v0, $a0
    /* 5F0D8 8006E8D8 3002038E */  lw         $v1, 0x230($s0)
    /* 5F0DC 8006E8DC 3402048E */  lw         $a0, 0x234($s0)
    /* 5F0E0 8006E8E0 21104300 */  addu       $v0, $v0, $v1
    /* 5F0E4 8006E8E4 21204400 */  addu       $a0, $v0, $a0
    /* 5F0E8 8006E8E8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5F0EC 8006E8EC 780704AE */  sw         $a0, 0x778($s0)
    /* 5F0F0 8006E8F0 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5F0F4 8006E8F4 01000224 */  addiu      $v0, $zero, 0x1
    /* 5F0F8 8006E8F8 03006210 */  beq        $v1, $v0, .L8006E908
    /* 5F0FC 8006E8FC 05000224 */   addiu     $v0, $zero, 0x5
    /* 5F100 8006E900 17006214 */  bne        $v1, $v0, .L8006E960
    /* 5F104 8006E904 00000000 */   nop
  .L8006E908:
    /* 5F108 8006E908 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 5F10C 8006E90C 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5F110 8006E910 00000000 */  nop
    /* 5F114 8006E914 6002428C */  lw         $v0, 0x260($v0)
    /* 5F118 8006E918 00000000 */  nop
    /* 5F11C 8006E91C 00024230 */  andi       $v0, $v0, 0x200
    /* 5F120 8006E920 0D004014 */  bnez       $v0, .L8006E958
    /* 5F124 8006E924 48FA6524 */   addiu     $a1, $v1, %lo(Cars_gHumanRaceCarList)
    /* 5F128 8006E928 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 5F12C 8006E92C 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 5F130 8006E930 02000224 */  addiu      $v0, $zero, 0x2
    /* 5F134 8006E934 0A006214 */  bne        $v1, $v0, .L8006E960
    /* 5F138 8006E938 00000000 */   nop
    /* 5F13C 8006E93C 0400A28C */  lw         $v0, 0x4($a1)
    /* 5F140 8006E940 00000000 */  nop
    /* 5F144 8006E944 6002428C */  lw         $v0, 0x260($v0)
    /* 5F148 8006E948 00000000 */  nop
    /* 5F14C 8006E94C 00024230 */  andi       $v0, $v0, 0x200
    /* 5F150 8006E950 03004010 */  beqz       $v0, .L8006E960
    /* 5F154 8006E954 00000000 */   nop
  .L8006E958:
    /* 5F158 8006E958 5ABA0108 */  j          .L8006E968
    /* 5F15C 8006E95C 47010524 */   addiu     $a1, $zero, 0x147
  .L8006E960:
    /* 5F160 8006E960 7807048E */  lw         $a0, 0x778($s0)
    /* 5F164 8006E964 48000524 */  addiu      $a1, $zero, 0x48
  .L8006E968:
    /* 5F168 8006E968 CA90030C */  jal        fixedmult
    /* 5F16C 8006E96C 00000000 */   nop
    /* 5F170 8006E970 780702AE */  sw         $v0, 0x778($s0)
    /* 5F174 8006E974 00800434 */  ori        $a0, $zero, 0x8000
    /* 5F178 8006E978 7807038E */  lw         $v1, 0x778($s0)
    /* 5F17C 8006E97C 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 5F180 8006E980 23184300 */  subu       $v1, $v0, $v1
    /* 5F184 8006E984 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* 5F188 8006E988 2A104300 */  slt        $v0, $v0, $v1
    /* 5F18C 8006E98C 02004010 */  beqz       $v0, .L8006E998
    /* 5F190 8006E990 780703AE */   sw        $v1, 0x778($s0)
    /* 5F194 8006E994 21206000 */  addu       $a0, $v1, $zero
  .L8006E998:
    /* 5F198 8006E998 780704AE */  sw         $a0, 0x778($s0)
    /* 5F19C 8006E99C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5F1A0 8006E9A0 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F1A4 8006E9A4 21108000 */  addu       $v0, $a0, $zero
    /* 5F1A8 8006E9A8 0800E003 */  jr         $ra
    /* 5F1AC 8006E9AC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AISpeeds_GetDamageFactor__FP8Car_tObj
