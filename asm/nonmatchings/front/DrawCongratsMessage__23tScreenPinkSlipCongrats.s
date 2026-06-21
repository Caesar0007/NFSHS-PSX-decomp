.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawCongratsMessage__23tScreenPinkSlipCongrats, 0x11C

glabel DrawCongratsMessage__23tScreenPinkSlipCongrats
    /* 39348 80048B48 C8FEBD27 */  addiu      $sp, $sp, -0x138
    /* 3934C 80048B4C 2C01B3AF */  sw         $s3, 0x12C($sp)
    /* 39350 80048B50 21988000 */  addu       $s3, $a0, $zero
    /* 39354 80048B54 29000224 */  addiu      $v0, $zero, 0x29
    /* 39358 80048B58 1800A2A7 */  sh         $v0, 0x18($sp)
    /* 3935C 80048B5C 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 39360 80048B60 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* 39364 80048B64 A4010224 */  addiu      $v0, $zero, 0x1A4
    /* 39368 80048B68 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* 3936C 80048B6C 1180023C */  lui        $v0, %hi(D_80114940)
    /* 39370 80048B70 40494290 */  lbu        $v0, %lo(D_80114940)($v0)
    /* 39374 80048B74 C8000324 */  addiu      $v1, $zero, 0xC8
    /* 39378 80048B78 3001BFAF */  sw         $ra, 0x130($sp)
    /* 3937C 80048B7C 2801B2AF */  sw         $s2, 0x128($sp)
    /* 39380 80048B80 2401B1AF */  sw         $s1, 0x124($sp)
    /* 39384 80048B84 2001B0AF */  sw         $s0, 0x120($sp)
    /* 39388 80048B88 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 3938C 80048B8C 0200422C */  sltiu      $v0, $v0, 0x2
    /* 39390 80048B90 11004010 */  beqz       $v0, .L80048BD8
    /* 39394 80048B94 1E00A3A7 */   sh        $v1, 0x1E($sp)
    /* 39398 80048B98 94E4020C */  jal        TextSys_Word__Fi
    /* 3939C 80048B9C 75020424 */   addiu     $a0, $zero, 0x275
    /* 393A0 80048BA0 84016486 */  lh         $a0, 0x184($s3)
    /* 393A4 80048BA4 7FAE000C */  jal        PlayerName__Fi
    /* 393A8 80048BA8 21904000 */   addu      $s2, $v0, $zero
    /* 393AC 80048BAC 94006482 */  lb         $a0, 0x94($s3)
    /* 393B0 80048BB0 21884000 */  addu       $s1, $v0, $zero
    /* 393B4 80048BB4 94E4020C */  jal        TextSys_Word__Fi
    /* 393B8 80048BB8 21018424 */   addiu     $a0, $a0, 0x121
    /* 393BC 80048BBC 01000424 */  addiu      $a0, $zero, 0x1
    /* 393C0 80048BC0 84016386 */  lh         $v1, 0x184($s3)
    /* 393C4 80048BC4 21804000 */  addu       $s0, $v0, $zero
    /* 393C8 80048BC8 7FAE000C */  jal        PlayerName__Fi
    /* 393CC 80048BCC 23208300 */   subu      $a0, $a0, $v1
    /* 393D0 80048BD0 05230108 */  j          .L80048C14
    /* 393D4 80048BD4 2000A427 */   addiu     $a0, $sp, 0x20
  .L80048BD8:
    /* 393D8 80048BD8 94E4020C */  jal        TextSys_Word__Fi
    /* 393DC 80048BDC 75020424 */   addiu     $a0, $zero, 0x275
    /* 393E0 80048BE0 84016486 */  lh         $a0, 0x184($s3)
    /* 393E4 80048BE4 7FAE000C */  jal        PlayerName__Fi
    /* 393E8 80048BE8 21904000 */   addu      $s2, $v0, $zero
    /* 393EC 80048BEC 01000424 */  addiu      $a0, $zero, 0x1
    /* 393F0 80048BF0 84016386 */  lh         $v1, 0x184($s3)
    /* 393F4 80048BF4 21884000 */  addu       $s1, $v0, $zero
    /* 393F8 80048BF8 7FAE000C */  jal        PlayerName__Fi
    /* 393FC 80048BFC 23208300 */   subu      $a0, $a0, $v1
    /* 39400 80048C00 94006482 */  lb         $a0, 0x94($s3)
    /* 39404 80048C04 21804000 */  addu       $s0, $v0, $zero
    /* 39408 80048C08 94E4020C */  jal        TextSys_Word__Fi
    /* 3940C 80048C0C 21018424 */   addiu     $a0, $a0, 0x121
    /* 39410 80048C10 2000A427 */  addiu      $a0, $sp, 0x20
  .L80048C14:
    /* 39414 80048C14 21284002 */  addu       $a1, $s2, $zero
    /* 39418 80048C18 21302002 */  addu       $a2, $s1, $zero
    /* 3941C 80048C1C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 39420 80048C20 84016286 */  lh         $v0, 0x184($s3)
    /* 39424 80048C24 21380002 */  addu       $a3, $s0, $zero
    /* 39428 80048C28 01004224 */  addiu      $v0, $v0, 0x1
    /* 3942C 80048C2C 2F91030C */  jal        sprintf
    /* 39430 80048C30 1400A2AF */   sw        $v0, 0x14($sp)
    /* 39434 80048C34 2000A427 */  addiu      $a0, $sp, 0x20
    /* 39438 80048C38 1800A527 */  addiu      $a1, $sp, 0x18
    /* 3943C 80048C3C 01000624 */  addiu      $a2, $zero, 0x1
    /* 39440 80048C40 FA85000C */  jal        FETextRender_WordWrapText__FPcR4RECT14tMenuTextState13tMenuTextType
    /* 39444 80048C44 0A000724 */   addiu     $a3, $zero, 0xA
    /* 39448 80048C48 3001BF8F */  lw         $ra, 0x130($sp)
    /* 3944C 80048C4C 2C01B38F */  lw         $s3, 0x12C($sp)
    /* 39450 80048C50 2801B28F */  lw         $s2, 0x128($sp)
    /* 39454 80048C54 2401B18F */  lw         $s1, 0x124($sp)
    /* 39458 80048C58 2001B08F */  lw         $s0, 0x120($sp)
    /* 3945C 80048C5C 0800E003 */  jr         $ra
    /* 39460 80048C60 3801BD27 */   addiu     $sp, $sp, 0x138
endlabel DrawCongratsMessage__23tScreenPinkSlipCongrats
