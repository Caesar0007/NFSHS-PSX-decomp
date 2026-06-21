.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DisplayLoadingText__7tScreen, 0x140

glabel DisplayLoadingText__7tScreen
    /* 162B8 80025AB8 0580033C */  lui        $v1, %hi(_7tScreen_fSuppressLoadingText)
    /* 162BC 80025ABC C817628C */  lw         $v0, %lo(_7tScreen_fSuppressLoadingText)($v1)
    /* 162C0 80025AC0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 162C4 80025AC4 2400BFAF */  sw         $ra, 0x24($sp)
    /* 162C8 80025AC8 2000B2AF */  sw         $s2, 0x20($sp)
    /* 162CC 80025ACC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 162D0 80025AD0 03004010 */  beqz       $v0, .L80025AE0
    /* 162D4 80025AD4 1800B0AF */   sw        $s0, 0x18($sp)
    /* 162D8 80025AD8 F8960008 */  j          .L80025BE0
    /* 162DC 80025ADC C81760AC */   sw        $zero, %lo(_7tScreen_fSuppressLoadingText)($v1)
  .L80025AE0:
    /* 162E0 80025AE0 21800000 */  addu       $s0, $zero, $zero
    /* 162E4 80025AE4 1280043C */  lui        $a0, %hi(Draw_gView)
    /* 162E8 80025AE8 1480053C */  lui        $a1, %hi(Draw_gPlayer1View)
    /* 162EC 80025AEC CCD3A38C */  lw         $v1, %lo(Draw_gPlayer1View)($a1)
    /* 162F0 80025AF0 54EC8424 */  addiu      $a0, $a0, %lo(Draw_gView)
    /* 162F4 80025AF4 40100300 */  sll        $v0, $v1, 1
    /* 162F8 80025AF8 21104300 */  addu       $v0, $v0, $v1
    /* 162FC 80025AFC C0100200 */  sll        $v0, $v0, 3
    /* 16300 80025B00 21104300 */  addu       $v0, $v0, $v1
    /* 16304 80025B04 C0100200 */  sll        $v0, $v0, 3
    /* 16308 80025B08 21104400 */  addu       $v0, $v0, $a0
    /* 1630C 80025B0C 20005290 */  lbu        $s2, 0x20($v0)
    /* 16310 80025B10 2188A000 */  addu       $s1, $a1, $zero
    /* 16314 80025B14 7C0040A0 */  sb         $zero, 0x7C($v0)
    /* 16318 80025B18 200040A0 */  sb         $zero, 0x20($v0)
  .L80025B1C:
    /* 1631C 80025B1C B0F8020C */  jal        Draw_StartFrameRender__Fv
    /* 16320 80025B20 00000000 */   nop
    /* 16324 80025B24 CCD3248E */  lw         $a0, %lo(Draw_gPlayer1View)($s1)
    /* 16328 80025B28 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* 1632C 80025B2C 00000000 */   nop
    /* 16330 80025B30 7D020424 */  addiu      $a0, $zero, 0x27D
    /* 16334 80025B34 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 16338 80025B38 DC000624 */  addiu      $a2, $zero, 0xDC
    /* 1633C 80025B3C 01000724 */  addiu      $a3, $zero, 0x1
    /* 16340 80025B40 2110E000 */  addu       $v0, $a3, $zero
    /* 16344 80025B44 1000A2AF */  sw         $v0, 0x10($sp)
    /* 16348 80025B48 04000224 */  addiu      $v0, $zero, 0x4
    /* 1634C 80025B4C 6084000C */  jal        FETextRender_MenuTextPositionedJustify__Fssss14tMenuTextState13tMenuTextType
    /* 16350 80025B50 1400A2AF */   sw        $v0, 0x14($sp)
    /* 16354 80025B54 94E4020C */  jal        TextSys_Word__Fi
    /* 16358 80025B58 7D020424 */   addiu     $a0, $zero, 0x27D
    /* 1635C 80025B5C 888F030C */  jal        textpixels
    /* 16360 80025B60 21204000 */   addu      $a0, $v0, $zero
    /* 16364 80025B64 21200000 */  addu       $a0, $zero, $zero
    /* 16368 80025B68 E0010524 */  addiu      $a1, $zero, 0x1E0
    /* 1636C 80025B6C DC000624 */  addiu      $a2, $zero, 0xDC
    /* 16370 80025B70 23100200 */  negu       $v0, $v0
    /* 16374 80025B74 FBFF4724 */  addiu      $a3, $v0, -0x5
    /* 16378 80025B78 07000224 */  addiu      $v0, $zero, 0x7
    /* 1637C 80025B7C 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 16380 80025B80 1000A2AF */   sw        $v0, 0x10($sp)
    /* 16384 80025B84 CCD3248E */  lw         $a0, %lo(Draw_gPlayer1View)($s1)
    /* 16388 80025B88 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* 1638C 80025B8C 00000000 */   nop
    /* 16390 80025B90 DBF8020C */  jal        Draw_StopFrameRender__Fv
    /* 16394 80025B94 00000000 */   nop
    /* 16398 80025B98 01000226 */  addiu      $v0, $s0, 0x1
    /* 1639C 80025B9C 21804000 */  addu       $s0, $v0, $zero
    /* 163A0 80025BA0 00140200 */  sll        $v0, $v0, 16
    /* 163A4 80025BA4 03140200 */  sra        $v0, $v0, 16
    /* 163A8 80025BA8 02004228 */  slti       $v0, $v0, 0x2
    /* 163AC 80025BAC DBFF4014 */  bnez       $v0, .L80025B1C
    /* 163B0 80025BB0 1480023C */   lui       $v0, %hi(Draw_gPlayer1View)
    /* 163B4 80025BB4 1280043C */  lui        $a0, %hi(Draw_gView)
    /* 163B8 80025BB8 CCD3438C */  lw         $v1, %lo(Draw_gPlayer1View)($v0)
    /* 163BC 80025BBC 54EC8424 */  addiu      $a0, $a0, %lo(Draw_gView)
    /* 163C0 80025BC0 40100300 */  sll        $v0, $v1, 1
    /* 163C4 80025BC4 21104300 */  addu       $v0, $v0, $v1
    /* 163C8 80025BC8 C0100200 */  sll        $v0, $v0, 3
    /* 163CC 80025BCC 21104300 */  addu       $v0, $v0, $v1
    /* 163D0 80025BD0 C0100200 */  sll        $v0, $v0, 3
    /* 163D4 80025BD4 21104400 */  addu       $v0, $v0, $a0
    /* 163D8 80025BD8 7C0052A0 */  sb         $s2, 0x7C($v0)
    /* 163DC 80025BDC 200052A0 */  sb         $s2, 0x20($v0)
  .L80025BE0:
    /* 163E0 80025BE0 2400BF8F */  lw         $ra, 0x24($sp)
    /* 163E4 80025BE4 2000B28F */  lw         $s2, 0x20($sp)
    /* 163E8 80025BE8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 163EC 80025BEC 1800B08F */  lw         $s0, 0x18($sp)
    /* 163F0 80025BF0 0800E003 */  jr         $ra
    /* 163F4 80025BF4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DisplayLoadingText__7tScreen
