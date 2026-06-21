.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeAudio_systemtask__Fi, 0x284

glabel FeAudio_systemtask__Fi
    /* 6148 80015948 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 614C 8001594C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 6150 80015950 019B030C */  jal        systemtask
    /* 6154 80015954 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6158 80015958 0580023C */  lui        $v0, %hi(ginfo)
    /* 615C 8001595C E8145024 */  addiu      $s0, $v0, %lo(ginfo)
    /* 6160 80015960 10000292 */  lbu        $v0, 0x10($s0)
    /* 6164 80015964 00000000 */  nop
    /* 6168 80015968 09004010 */  beqz       $v0, .L80015990
    /* 616C 8001596C 0580023C */   lui       $v0, %hi(ginfo)
    /* 6170 80015970 2000048E */  lw         $a0, 0x20($s0)
    /* 6174 80015974 B6C5030C */  jal        getasyncreadstatus
    /* 6178 80015978 00000000 */   nop
    /* 617C 8001597C 03004010 */  beqz       $v0, .L8001598C
    /* 6180 80015980 01000224 */   addiu     $v0, $zero, 0x1
    /* 6184 80015984 100000A2 */  sb         $zero, 0x10($s0)
    /* 6188 80015988 120002A2 */  sb         $v0, 0x12($s0)
  .L8001598C:
    /* 618C 8001598C 0580023C */  lui        $v0, %hi(ginfo)
  .L80015990:
    /* 6190 80015990 E8145024 */  addiu      $s0, $v0, %lo(ginfo)
    /* 6194 80015994 11000292 */  lbu        $v0, 0x11($s0)
    /* 6198 80015998 00000000 */  nop
    /* 619C 8001599C 36004010 */  beqz       $v0, .L80015A78
    /* 61A0 800159A0 0580023C */   lui       $v0, %hi(gStopCommentaryNow)
    /* 61A4 800159A4 0C00048E */  lw         $a0, 0xC($s0)
    /* 61A8 800159A8 C59E030C */  jal        SNDover
    /* 61AC 800159AC 00000000 */   nop
    /* 61B0 800159B0 30004010 */  beqz       $v0, .L80015A74
    /* 61B4 800159B4 21280000 */   addu      $a1, $zero, $zero
    /* 61B8 800159B8 0C00048E */  lw         $a0, 0xC($s0)
    /* 61BC 800159BC B4A0030C */  jal        SNDautovol
    /* 61C0 800159C0 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 61C4 800159C4 0800048E */  lw         $a0, 0x8($s0)
    /* 61C8 800159C8 9D99030C */  jal        SNDbankremove
    /* 61CC 800159CC 00000000 */   nop
    /* 61D0 800159D0 1C00048E */  lw         $a0, 0x1C($s0)
    /* 61D4 800159D4 00000000 */  nop
    /* 61D8 800159D8 04008010 */  beqz       $a0, .L800159EC
    /* 61DC 800159DC 00000000 */   nop
    /* 61E0 800159E0 5095030C */  jal        purgememadr
    /* 61E4 800159E4 00000000 */   nop
    /* 61E8 800159E8 1C0000AE */  sw         $zero, 0x1C($s0)
  .L800159EC:
    /* 61EC 800159EC 1400048E */  lw         $a0, 0x14($s0)
    /* 61F0 800159F0 00000000 */  nop
    /* 61F4 800159F4 04008010 */  beqz       $a0, .L80015A08
    /* 61F8 800159F8 00000000 */   nop
    /* 61FC 800159FC 5095030C */  jal        purgememadr
    /* 6200 80015A00 00000000 */   nop
    /* 6204 80015A04 140000AE */  sw         $zero, 0x14($s0)
  .L80015A08:
    /* 6208 80015A08 10000292 */  lbu        $v0, 0x10($s0)
    /* 620C 80015A0C 00000000 */  nop
    /* 6210 80015A10 0D004010 */  beqz       $v0, .L80015A48
    /* 6214 80015A14 FF00023C */   lui       $v0, (0xFF00FF >> 16)
  .L80015A18:
    /* 6218 80015A18 2000048E */  lw         $a0, 0x20($s0)
    /* 621C 80015A1C B6C5030C */  jal        getasyncreadstatus
    /* 6220 80015A20 00000000 */   nop
    /* 6224 80015A24 05004014 */  bnez       $v0, .L80015A3C
    /* 6228 80015A28 01000224 */   addiu     $v0, $zero, 0x1
    /* 622C 80015A2C 019B030C */  jal        systemtask
    /* 6230 80015A30 21200000 */   addu      $a0, $zero, $zero
    /* 6234 80015A34 86560008 */  j          .L80015A18
    /* 6238 80015A38 00000000 */   nop
  .L80015A3C:
    /* 623C 80015A3C 100000A2 */  sb         $zero, 0x10($s0)
    /* 6240 80015A40 120002A2 */  sb         $v0, 0x12($s0)
    /* 6244 80015A44 FF00023C */  lui        $v0, (0xFF00FF >> 16)
  .L80015A48:
    /* 6248 80015A48 0580033C */  lui        $v1, %hi(ginfo)
    /* 624C 80015A4C E8146324 */  addiu      $v1, $v1, %lo(ginfo)
    /* 6250 80015A50 110060A0 */  sb         $zero, 0x11($v1)
    /* 6254 80015A54 1000648C */  lw         $a0, 0x10($v1)
    /* 6258 80015A58 FF004234 */  ori        $v0, $v0, (0xFF00FF & 0xFFFF)
    /* 625C 80015A5C 24208200 */  and        $a0, $a0, $v0
    /* 6260 80015A60 04008014 */  bnez       $a0, .L80015A74
    /* 6264 80015A64 080060AC */   sw        $zero, 0x8($v1)
    /* 6268 80015A68 0580033C */  lui        $v1, %hi(gStopCommentaryNow)
    /* 626C 80015A6C 01000224 */  addiu      $v0, $zero, 0x1
    /* 6270 80015A70 C81462AC */  sw         $v0, %lo(gStopCommentaryNow)($v1)
  .L80015A74:
    /* 6274 80015A74 0580023C */  lui        $v0, %hi(gStopCommentaryNow)
  .L80015A78:
    /* 6278 80015A78 C814428C */  lw         $v0, %lo(gStopCommentaryNow)($v0)
    /* 627C 80015A7C 00000000 */  nop
    /* 6280 80015A80 41004010 */  beqz       $v0, .L80015B88
    /* 6284 80015A84 0580043C */   lui       $a0, %hi(gCurrentVIV)
    /* 6288 80015A88 0580023C */  lui        $v0, %hi(ginfo)
    /* 628C 80015A8C E8144524 */  addiu      $a1, $v0, %lo(ginfo)
    /* 6290 80015A90 1000A390 */  lbu        $v1, 0x10($a1)
    /* 6294 80015A94 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6298 80015A98 0B006010 */  beqz       $v1, .L80015AC8
    /* 629C 80015A9C CC1482A0 */   sb        $v0, %lo(gCurrentVIV)($a0)
    /* 62A0 80015AA0 2180A000 */  addu       $s0, $a1, $zero
  .L80015AA4:
    /* 62A4 80015AA4 2000048E */  lw         $a0, 0x20($s0)
    /* 62A8 80015AA8 B6C5030C */  jal        getasyncreadstatus
    /* 62AC 80015AAC 00000000 */   nop
    /* 62B0 80015AB0 06004014 */  bnez       $v0, .L80015ACC
    /* 62B4 80015AB4 0580023C */   lui       $v0, %hi(ginfo)
    /* 62B8 80015AB8 019B030C */  jal        systemtask
    /* 62BC 80015ABC 21200000 */   addu      $a0, $zero, $zero
    /* 62C0 80015AC0 A9560008 */  j          .L80015AA4
    /* 62C4 80015AC4 00000000 */   nop
  .L80015AC8:
    /* 62C8 80015AC8 0580023C */  lui        $v0, %hi(ginfo)
  .L80015ACC:
    /* 62CC 80015ACC E8145024 */  addiu      $s0, $v0, %lo(ginfo)
    /* 62D0 80015AD0 11000292 */  lbu        $v0, 0x11($s0)
    /* 62D4 80015AD4 00000000 */  nop
    /* 62D8 80015AD8 07004010 */  beqz       $v0, .L80015AF8
    /* 62DC 80015ADC 21280000 */   addu      $a1, $zero, $zero
    /* 62E0 80015AE0 0C00048E */  lw         $a0, 0xC($s0)
    /* 62E4 80015AE4 B4A0030C */  jal        SNDautovol
    /* 62E8 80015AE8 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 62EC 80015AEC 0800048E */  lw         $a0, 0x8($s0)
    /* 62F0 80015AF0 9D99030C */  jal        SNDbankremove
    /* 62F4 80015AF4 00000000 */   nop
  .L80015AF8:
    /* 62F8 80015AF8 1480023C */  lui        $v0, %hi(gMasterMusicLevel)
    /* 62FC 80015AFC 50C6428C */  lw         $v0, %lo(gMasterMusicLevel)($v0)
    /* 6300 80015B00 00000000 */  nop
    /* 6304 80015B04 C0200200 */  sll        $a0, $v0, 3
    /* 6308 80015B08 21208200 */  addu       $a0, $a0, $v0
    /* 630C 80015B0C 80200400 */  sll        $a0, $a0, 2
    /* 6310 80015B10 23208200 */  subu       $a0, $a0, $v0
    /* 6314 80015B14 40200400 */  sll        $a0, $a0, 1
    /* 6318 80015B18 ACEC010C */  jal        AudioMus_Volume__Fi
    /* 631C 80015B1C C3210400 */   sra       $a0, $a0, 7
    /* 6320 80015B20 1800048E */  lw         $a0, 0x18($s0)
    /* 6324 80015B24 00000000 */  nop
    /* 6328 80015B28 04008010 */  beqz       $a0, .L80015B3C
    /* 632C 80015B2C 00000000 */   nop
    /* 6330 80015B30 5095030C */  jal        purgememadr
    /* 6334 80015B34 00000000 */   nop
    /* 6338 80015B38 180000AE */  sw         $zero, 0x18($s0)
  .L80015B3C:
    /* 633C 80015B3C 1C00048E */  lw         $a0, 0x1C($s0)
    /* 6340 80015B40 00000000 */  nop
    /* 6344 80015B44 04008010 */  beqz       $a0, .L80015B58
    /* 6348 80015B48 00000000 */   nop
    /* 634C 80015B4C 5095030C */  jal        purgememadr
    /* 6350 80015B50 00000000 */   nop
    /* 6354 80015B54 1C0000AE */  sw         $zero, 0x1C($s0)
  .L80015B58:
    /* 6358 80015B58 1400048E */  lw         $a0, 0x14($s0)
    /* 635C 80015B5C 00000000 */  nop
    /* 6360 80015B60 05008010 */  beqz       $a0, .L80015B78
    /* 6364 80015B64 0580023C */   lui       $v0, %hi(gStopCommentaryNow)
    /* 6368 80015B68 5095030C */  jal        purgememadr
    /* 636C 80015B6C 00000000 */   nop
    /* 6370 80015B70 140000AE */  sw         $zero, 0x14($s0)
    /* 6374 80015B74 0580023C */  lui        $v0, %hi(gStopCommentaryNow)
  .L80015B78:
    /* 6378 80015B78 110000A2 */  sb         $zero, 0x11($s0)
    /* 637C 80015B7C 120000A2 */  sb         $zero, 0x12($s0)
    /* 6380 80015B80 C81440AC */  sw         $zero, %lo(gStopCommentaryNow)($v0)
    /* 6384 80015B84 100000A2 */  sb         $zero, 0x10($s0)
  .L80015B88:
    /* 6388 80015B88 0580023C */  lui        $v0, %hi(ginfo)
    /* 638C 80015B8C E8145024 */  addiu      $s0, $v0, %lo(ginfo)
    /* 6390 80015B90 12000292 */  lbu        $v0, 0x12($s0)
    /* 6394 80015B94 00000000 */  nop
    /* 6398 80015B98 08004010 */  beqz       $v0, .L80015BBC
    /* 639C 80015B9C 00000000 */   nop
    /* 63A0 80015BA0 10000296 */  lhu        $v0, 0x10($s0)
    /* 63A4 80015BA4 00000000 */  nop
    /* 63A8 80015BA8 04004014 */  bnez       $v0, .L80015BBC
    /* 63AC 80015BAC 00000000 */   nop
    /* 63B0 80015BB0 0956000C */  jal        Feaudio_StartPatch__FP10SPEECHINFO
    /* 63B4 80015BB4 21200002 */   addu      $a0, $s0, $zero
    /* 63B8 80015BB8 120000A2 */  sb         $zero, 0x12($s0)
  .L80015BBC:
    /* 63BC 80015BBC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 63C0 80015BC0 1000B08F */  lw         $s0, 0x10($sp)
    /* 63C4 80015BC4 0800E003 */  jr         $ra
    /* 63C8 80015BC8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FeAudio_systemtask__Fi
