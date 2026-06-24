.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_RenderHudView__Fv, 0x978

glabel Hud_RenderHudView__Fv
    /* C8AD0 800D82D0 60FFBD27 */  addiu      $sp, $sp, -0xA0
    /* C8AD4 800D82D4 9800BEAF */  sw         $fp, 0x98($sp)
    /* C8AD8 800D82D8 21F00000 */  addu       $fp, $zero, $zero
    /* C8ADC 800D82DC FF00083C */  lui        $t0, (0xFFFFFF >> 16)
    /* C8AE0 800D82E0 FFFF0835 */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* C8AE4 800D82E4 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* C8AE8 800D82E8 EC312925 */  addiu      $t1, $t1, %lo(GameSetup_gData)
    /* C8AEC 800D82EC 9C00BFAF */  sw         $ra, 0x9C($sp)
    /* C8AF0 800D82F0 9400B7AF */  sw         $s7, 0x94($sp)
    /* C8AF4 800D82F4 9000B6AF */  sw         $s6, 0x90($sp)
    /* C8AF8 800D82F8 8C00B5AF */  sw         $s5, 0x8C($sp)
    /* C8AFC 800D82FC 8800B4AF */  sw         $s4, 0x88($sp)
    /* C8B00 800D8300 8400B3AF */  sw         $s3, 0x84($sp)
    /* C8B04 800D8304 8000B2AF */  sw         $s2, 0x80($sp)
    /* C8B08 800D8308 7C00B1AF */  sw         $s1, 0x7C($sp)
    /* C8B0C 800D830C 7800B0AF */  sw         $s0, 0x78($sp)
    /* C8B10 800D8310 6800A8AF */  sw         $t0, 0x68($sp)
    /* C8B14 800D8314 6C00A0AF */  sw         $zero, 0x6C($sp)
    /* C8B18 800D8318 7000A0AF */  sw         $zero, 0x70($sp)
    /* C8B1C 800D831C 7400A9AF */  sw         $t1, 0x74($sp)
    /* C8B20 800D8320 1180083C */  lui        $t0, %hi(DashHUD_gInfo)
  .L800D8324:
    /* C8B24 800D8324 3027028D */  lw         $v0, %lo(DashHUD_gInfo)($t0)
    /* C8B28 800D8328 00000000 */  nop
    /* C8B2C 800D832C 2A105E00 */  slt        $v0, $v0, $fp
    /* C8B30 800D8330 39024014 */  bnez       $v0, .L800D8C18
    /* C8B34 800D8334 00000000 */   nop
    /* C8B38 800D8338 0300C013 */  beqz       $fp, .L800D8348
    /* C8B3C 800D833C 6000A0AF */   sw        $zero, 0x60($sp)
    /* C8B40 800D8340 F1FF0924 */  addiu      $t1, $zero, -0xF
    /* C8B44 800D8344 6000A9AF */  sw         $t1, 0x60($sp)
  .L800D8348:
    /* C8B48 800D8348 6C00A88F */  lw         $t0, 0x6C($sp)
    /* C8B4C 800D834C 1480023C */  lui        $v0, %hi(Hud_gHudView)
    /* C8B50 800D8350 50D94224 */  addiu      $v0, $v0, %lo(Hud_gHudView)
    /* C8B54 800D8354 21100201 */  addu       $v0, $t0, $v0
    /* C8B58 800D8358 0000448C */  lw         $a0, 0x0($v0)
    /* C8B5C 800D835C 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C8B60 800D8360 00000000 */   nop
    /* C8B64 800D8364 7F47030C */  jal        Hud_DebugInfo__Fv
    /* C8B68 800D8368 00000000 */   nop
    /* C8B6C 800D836C E447030C */  jal        Hud_DebugCrap__Fv
    /* C8B70 800D8370 00000000 */   nop
    /* C8B74 800D8374 1180093C */  lui        $t1, %hi(GameSetup_gData)
    /* C8B78 800D8378 EC31228D */  lw         $v0, %lo(GameSetup_gData)($t1)
    /* C8B7C 800D837C 01000824 */  addiu      $t0, $zero, 0x1
    /* C8B80 800D8380 B2004814 */  bne        $v0, $t0, .L800D864C
    /* C8B84 800D8384 1180083C */   lui       $t0, %hi(DashHUD_gInfo)
    /* C8B88 800D8388 6C00A98F */  lw         $t1, 0x6C($sp)
    /* C8B8C 800D838C 1480023C */  lui        $v0, %hi(D_8013DE38)
    /* C8B90 800D8390 38DE4224 */  addiu      $v0, $v0, %lo(D_8013DE38)
    /* C8B94 800D8394 21102201 */  addu       $v0, $t1, $v0
    /* C8B98 800D8398 0000428C */  lw         $v0, 0x0($v0)
    /* C8B9C 800D839C 00000000 */  nop
    /* C8BA0 800D83A0 AA004010 */  beqz       $v0, .L800D864C
    /* C8BA4 800D83A4 00000000 */   nop
    /* C8BA8 800D83A8 1480103C */  lui        $s0, %hi(D_8013DE40)
    /* C8BAC 800D83AC 40DE1026 */  addiu      $s0, $s0, %lo(D_8013DE40)
    /* C8BB0 800D83B0 21803001 */  addu       $s0, $t1, $s0
    /* C8BB4 800D83B4 0000048E */  lw         $a0, 0x0($s0)
    /* C8BB8 800D83B8 94E4020C */  jal        TextSys_Word__Fi
    /* C8BBC 800D83BC 41008424 */   addiu     $a0, $a0, 0x41
    /* C8BC0 800D83C0 888F030C */  jal        textpixels
    /* C8BC4 800D83C4 21204000 */   addu      $a0, $v0, $zero
    /* C8BC8 800D83C8 B818838F */  lw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C8BCC 800D83CC 6000A88F */  lw         $t0, 0x60($sp)
    /* C8BD0 800D83D0 4A006384 */  lh         $v1, 0x4A($v1)
    /* C8BD4 800D83D4 04000424 */  addiu      $a0, $zero, 0x4
    /* C8BD8 800D83D8 6400A2AF */  sw         $v0, 0x64($sp)
    /* C8BDC 800D83DC 832C030C */  jal        Font_TextColor__Fi
    /* C8BE0 800D83E0 21B06800 */   addu      $s6, $v1, $t0
    /* C8BE4 800D83E4 0000048E */  lw         $a0, 0x0($s0)
    /* C8BE8 800D83E8 94E4020C */  jal        TextSys_Word__Fi
    /* C8BEC 800D83EC 41008424 */   addiu     $a0, $a0, 0x41
    /* C8BF0 800D83F0 21204000 */  addu       $a0, $v0, $zero
    /* C8BF4 800D83F4 A0001024 */  addiu      $s0, $zero, 0xA0
    /* C8BF8 800D83F8 6400A98F */  lw         $t1, 0x64($sp)
    /* C8BFC 800D83FC 2130C002 */  addu       $a2, $s6, $zero
    /* C8C00 800D8400 42A00900 */  srl        $s4, $t1, 1
    /* C8C04 800D8404 01008526 */  addiu      $a1, $s4, 0x1
    /* C8C08 800D8408 A42E030C */  jal        Font_TextXY__FPcii
    /* C8C0C 800D840C 23280502 */   subu      $a1, $s0, $a1
    /* C8C10 800D8410 1280083C */  lui        $t0, %hi(simGlobal)
    /* C8C14 800D8414 ACE00825 */  addiu      $t0, $t0, %lo(simGlobal)
    /* C8C18 800D8418 0400068D */  lw         $a2, 0x4($t0)
    /* C8C1C 800D841C 00000000 */  nop
    /* C8C20 800D8420 03110600 */  sra        $v0, $a2, 4
    /* C8C24 800D8424 01004230 */  andi       $v0, $v0, 0x1
    /* C8C28 800D8428 02004010 */  beqz       $v0, .L800D8434
    /* C8C2C 800D842C 8000123C */   lui       $s2, (0x800000 >> 16)
    /* C8C30 800D8430 80001224 */  addiu      $s2, $zero, 0x80
  .L800D8434:
    /* C8C34 800D8434 02004010 */  beqz       $v0, .L800D8440
    /* C8C38 800D8438 0A001124 */   addiu     $s1, $zero, 0xA
    /* C8C3C 800D843C 08001124 */  addiu      $s1, $zero, 0x8
  .L800D8440:
    /* C8C40 800D8440 8888023C */  lui        $v0, (0x88888889 >> 16)
    /* C8C44 800D8444 89884234 */  ori        $v0, $v0, (0x88888889 & 0xFFFF)
    /* C8C48 800D8448 1800C200 */  mult       $a2, $v0
    /* C8C4C 800D844C 23B81402 */  subu       $s7, $s0, $s4
    /* C8C50 800D8450 DDFFE426 */  addiu      $a0, $s7, -0x23
    /* C8C54 800D8454 0800D526 */  addiu      $s5, $s6, 0x8
    /* C8C58 800D8458 2128A002 */  addu       $a1, $s5, $zero
    /* C8C5C 800D845C C31F0600 */  sra        $v1, $a2, 31
    /* C8C60 800D8460 1000B1AF */  sw         $s1, 0x10($sp)
    /* C8C64 800D8464 10400000 */  mfhi       $t0
    /* C8C68 800D8468 21100601 */  addu       $v0, $t0, $a2
    /* C8C6C 800D846C C3100200 */  sra        $v0, $v0, 3
    /* C8C70 800D8470 23104300 */  subu       $v0, $v0, $v1
    /* C8C74 800D8474 00190200 */  sll        $v1, $v0, 4
    /* C8C78 800D8478 23186200 */  subu       $v1, $v1, $v0
    /* C8C7C 800D847C 2318C300 */  subu       $v1, $a2, $v1
    /* C8C80 800D8480 40110300 */  sll        $v0, $v1, 5
    /* C8C84 800D8484 23104300 */  subu       $v0, $v0, $v1
    /* C8C88 800D8488 80100200 */  sll        $v0, $v0, 2
    /* C8C8C 800D848C 21104300 */  addu       $v0, $v0, $v1
    /* C8C90 800D8490 40100200 */  sll        $v0, $v0, 1
    /* C8C94 800D8494 A00F0324 */  addiu      $v1, $zero, 0xFA0
    /* C8C98 800D8498 23806200 */  subu       $s0, $v1, $v0
    /* C8C9C 800D849C 21300002 */  addu       $a2, $s0, $zero
    /* C8CA0 800D84A0 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* C8CA4 800D84A4 21380002 */   addu      $a3, $s0, $zero
    /* C8CA8 800D84A8 D3FFE426 */  addiu      $a0, $s7, -0x2D
    /* C8CAC 800D84AC 2128A002 */  addu       $a1, $s5, $zero
    /* C8CB0 800D84B0 21300002 */  addu       $a2, $s0, $zero
    /* C8CB4 800D84B4 21380002 */  addu       $a3, $s0, $zero
    /* C8CB8 800D84B8 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* C8CBC 800D84BC 1000B1AF */   sw        $s1, 0x10($sp)
    /* C8CC0 800D84C0 1180043C */  lui        $a0, %hi(D_8011115C)
    /* C8CC4 800D84C4 5C118424 */  addiu      $a0, $a0, %lo(D_8011115C)
    /* C8CC8 800D84C8 DAFFE526 */  addiu      $a1, $s7, -0x26
    /* C8CCC 800D84CC 0500D326 */  addiu      $s3, $s6, 0x5
    /* C8CD0 800D84D0 21306002 */  addu       $a2, $s3, $zero
    /* C8CD4 800D84D4 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8CD8 800D84D8 21384002 */   addu      $a3, $s2, $zero
    /* C8CDC 800D84DC 1180043C */  lui        $a0, %hi(D_8011115C)
    /* C8CE0 800D84E0 5C118424 */  addiu      $a0, $a0, %lo(D_8011115C)
    /* C8CE4 800D84E4 D0FFE526 */  addiu      $a1, $s7, -0x30
    /* C8CE8 800D84E8 21306002 */  addu       $a2, $s3, $zero
    /* C8CEC 800D84EC 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8CF0 800D84F0 21384002 */   addu      $a3, $s2, $zero
    /* C8CF4 800D84F4 1280093C */  lui        $t1, %hi(simGlobal)
    /* C8CF8 800D84F8 ACE02925 */  addiu      $t1, $t1, %lo(simGlobal)
    /* C8CFC 800D84FC 0400228D */  lw         $v0, 0x4($t1)
    /* C8D00 800D8500 00000000 */  nop
    /* C8D04 800D8504 03110200 */  sra        $v0, $v0, 4
    /* C8D08 800D8508 01004230 */  andi       $v0, $v0, 0x1
    /* C8D0C 800D850C 02004014 */  bnez       $v0, .L800D8518
    /* C8D10 800D8510 8000123C */   lui       $s2, (0x800000 >> 16)
    /* C8D14 800D8514 80001224 */  addiu      $s2, $zero, 0x80
  .L800D8518:
    /* C8D18 800D8518 02004014 */  bnez       $v0, .L800D8524
    /* C8D1C 800D851C 0A001124 */   addiu     $s1, $zero, 0xA
    /* C8D20 800D8520 08001124 */  addiu      $s1, $zero, 0x8
  .L800D8524:
    /* C8D24 800D8524 C0008426 */  addiu      $a0, $s4, 0xC0
    /* C8D28 800D8528 2128A002 */  addu       $a1, $s5, $zero
    /* C8D2C 800D852C 21300002 */  addu       $a2, $s0, $zero
    /* C8D30 800D8530 21380002 */  addu       $a3, $s0, $zero
    /* C8D34 800D8534 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* C8D38 800D8538 1000B1AF */   sw        $s1, 0x10($sp)
    /* C8D3C 800D853C CA008426 */  addiu      $a0, $s4, 0xCA
    /* C8D40 800D8540 2128A002 */  addu       $a1, $s5, $zero
    /* C8D44 800D8544 21300002 */  addu       $a2, $s0, $zero
    /* C8D48 800D8548 2138C000 */  addu       $a3, $a2, $zero
    /* C8D4C 800D854C DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* C8D50 800D8550 1000B1AF */   sw        $s1, 0x10($sp)
    /* C8D54 800D8554 1180043C */  lui        $a0, %hi(D_8011115C)
    /* C8D58 800D8558 5C118424 */  addiu      $a0, $a0, %lo(D_8011115C)
    /* C8D5C 800D855C BD008526 */  addiu      $a1, $s4, 0xBD
    /* C8D60 800D8560 21306002 */  addu       $a2, $s3, $zero
    /* C8D64 800D8564 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8D68 800D8568 21384002 */   addu      $a3, $s2, $zero
    /* C8D6C 800D856C 1180043C */  lui        $a0, %hi(D_8011115C)
    /* C8D70 800D8570 5C118424 */  addiu      $a0, $a0, %lo(D_8011115C)
    /* C8D74 800D8574 C7008526 */  addiu      $a1, $s4, 0xC7
    /* C8D78 800D8578 21306002 */  addu       $a2, $s3, $zero
    /* C8D7C 800D857C 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C8D80 800D8580 21384002 */   addu      $a3, $s2, $zero
    /* C8D84 800D8584 CFFFF026 */  addiu      $s0, $s7, -0x31
    /* C8D88 800D8588 21200002 */  addu       $a0, $s0, $zero
    /* C8D8C 800D858C 2128C002 */  addu       $a1, $s6, $zero
    /* C8D90 800D8590 6400A88F */  lw         $t0, 0x64($sp)
    /* C8D94 800D8594 11000724 */  addiu      $a3, $zero, 0x11
    /* C8D98 800D8598 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C8D9C 800D859C 62000625 */   addiu     $a2, $t0, 0x62
    /* C8DA0 800D85A0 21200000 */  addu       $a0, $zero, $zero
    /* C8DA4 800D85A4 21280002 */  addu       $a1, $s0, $zero
    /* C8DA8 800D85A8 2130C002 */  addu       $a2, $s6, $zero
    /* C8DAC 800D85AC 17000724 */  addiu      $a3, $zero, 0x17
    /* C8DB0 800D85B0 11001124 */  addiu      $s1, $zero, 0x11
    /* C8DB4 800D85B4 1000B1AF */  sw         $s1, 0x10($sp)
    /* C8DB8 800D85B8 1400A0AF */  sw         $zero, 0x14($sp)
    /* C8DBC 800D85BC 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8DC0 800D85C0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8DC4 800D85C4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C8DC8 800D85C8 21200000 */  addu       $a0, $zero, $zero
    /* C8DCC 800D85CC BA009026 */  addiu      $s0, $s4, 0xBA
    /* C8DD0 800D85D0 21280002 */  addu       $a1, $s0, $zero
    /* C8DD4 800D85D4 2130C002 */  addu       $a2, $s6, $zero
    /* C8DD8 800D85D8 15000724 */  addiu      $a3, $zero, 0x15
    /* C8DDC 800D85DC 1000B1AF */  sw         $s1, 0x10($sp)
    /* C8DE0 800D85E0 1400A0AF */  sw         $zero, 0x14($sp)
    /* C8DE4 800D85E4 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8DE8 800D85E8 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8DEC 800D85EC 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C8DF0 800D85F0 21200000 */  addu       $a0, $zero, $zero
    /* C8DF4 800D85F4 21280002 */  addu       $a1, $s0, $zero
    /* C8DF8 800D85F8 0300C626 */  addiu      $a2, $s6, 0x3
    /* C8DFC 800D85FC 16000724 */  addiu      $a3, $zero, 0x16
    /* C8E00 800D8600 0B000224 */  addiu      $v0, $zero, 0xB
    /* C8E04 800D8604 1000A2AF */  sw         $v0, 0x10($sp)
    /* C8E08 800D8608 1400A0AF */  sw         $zero, 0x14($sp)
    /* C8E0C 800D860C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8E10 800D8610 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8E14 800D8614 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C8E18 800D8618 4600023C */  lui        $v0, (0x461414 >> 16)
    /* C8E1C 800D861C 14144234 */  ori        $v0, $v0, (0x461414 & 0xFFFF)
    /* C8E20 800D8620 01000424 */  addiu      $a0, $zero, 0x1
    /* C8E24 800D8624 E6FFE526 */  addiu      $a1, $s7, -0x1A
    /* C8E28 800D8628 6400A98F */  lw         $t1, 0x64($sp)
    /* C8E2C 800D862C 2130C002 */  addu       $a2, $s6, $zero
    /* C8E30 800D8630 1000B1AF */  sw         $s1, 0x10($sp)
    /* C8E34 800D8634 1400A2AF */  sw         $v0, 0x14($sp)
    /* C8E38 800D8638 1800A0AF */  sw         $zero, 0x18($sp)
    /* C8E3C 800D863C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C8E40 800D8640 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C8E44 800D8644 36002725 */   addiu     $a3, $t1, 0x36
    /* C8E48 800D8648 1180083C */  lui        $t0, %hi(DashHUD_gInfo)
  .L800D864C:
    /* C8E4C 800D864C 3027028D */  lw         $v0, %lo(DashHUD_gInfo)($t0)
    /* C8E50 800D8650 00000000 */  nop
    /* C8E54 800D8654 2000C217 */  bne        $fp, $v0, .L800D86D8
    /* C8E58 800D8658 1180093C */   lui       $t1, %hi(DashHUD_gInfo)
    /* C8E5C 800D865C E813828F */  lw         $v0, %gp_rel(BTC_Countdown)($gp)
    /* C8E60 800D8660 00000000 */  nop
    /* C8E64 800D8664 83210200 */  sra        $a0, $v0, 6
    /* C8E68 800D8668 FFFF8224 */  addiu      $v0, $a0, -0x1
    /* C8E6C 800D866C 1E00422C */  sltiu      $v0, $v0, 0x1E
    /* C8E70 800D8670 05004010 */  beqz       $v0, .L800D8688
    /* C8E74 800D8674 1280093C */   lui       $t1, %hi(simGlobal)
    /* C8E78 800D8678 EC5F030C */  jal        BigBTCTime__Fi
    /* C8E7C 800D867C 00000000 */   nop
    /* C8E80 800D8680 B6610308 */  j          .L800D86D8
    /* C8E84 800D8684 1180093C */   lui       $t1, %hi(DashHUD_gInfo)
  .L800D8688:
    /* C8E88 800D8688 ACE02925 */  addiu      $t1, $t1, %lo(simGlobal)
    /* C8E8C 800D868C 0400228D */  lw         $v0, 0x4($t1)
    /* C8E90 800D8690 00000000 */  nop
    /* C8E94 800D8694 40024228 */  slti       $v0, $v0, 0x240
    /* C8E98 800D8698 0C004014 */  bnez       $v0, .L800D86CC
    /* C8E9C 800D869C 21200000 */   addu      $a0, $zero, $zero
    /* C8EA0 800D86A0 1480023C */  lui        $v0, %hi(countdown)
    /* C8EA4 800D86A4 3CC64290 */  lbu        $v0, %lo(countdown)($v0)
    /* C8EA8 800D86A8 00000000 */  nop
    /* C8EAC 800D86AC 0400422C */  sltiu      $v0, $v0, 0x4
    /* C8EB0 800D86B0 06004010 */  beqz       $v0, .L800D86CC
    /* C8EB4 800D86B4 01000424 */   addiu     $a0, $zero, 0x1
    /* C8EB8 800D86B8 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C8EBC 800D86BC 00000000 */  nop
    /* C8EC0 800D86C0 02004014 */  bnez       $v0, .L800D86CC
    /* C8EC4 800D86C4 00000000 */   nop
    /* C8EC8 800D86C8 21200000 */  addu       $a0, $zero, $zero
  .L800D86CC:
    /* C8ECC 800D86CC F758030C */  jal        Hud_BuildCdPlayer__Fii
    /* C8ED0 800D86D0 2128C003 */   addu      $a1, $fp, $zero
    /* C8ED4 800D86D4 1180093C */  lui        $t1, %hi(DashHUD_gInfo)
  .L800D86D8:
    /* C8ED8 800D86D8 6C00A88F */  lw         $t0, 0x6C($sp)
    /* C8EDC 800D86DC 30272925 */  addiu      $t1, $t1, %lo(DashHUD_gInfo)
    /* C8EE0 800D86E0 21100901 */  addu       $v0, $t0, $t1
    /* C8EE4 800D86E4 1C00428C */  lw         $v0, 0x1C($v0)
    /* C8EE8 800D86E8 00000000 */  nop
    /* C8EEC 800D86EC EC004010 */  beqz       $v0, .L800D8AA0
    /* C8EF0 800D86F0 00000000 */   nop
    /* C8EF4 800D86F4 0400C013 */  beqz       $fp, .L800D8708
    /* C8EF8 800D86F8 00000000 */   nop
    /* C8EFC 800D86FC C018948F */  lw         $s4, %gp_rel(D_8013DE0C)($gp)
    /* C8F00 800D8700 C3610308 */  j          .L800D870C
    /* C8F04 800D8704 00000000 */   nop
  .L800D8708:
    /* C8F08 800D8708 BC18948F */  lw         $s4, %gp_rel(D_8013DE08)($gp)
  .L800D870C:
    /* C8F0C 800D870C 266C020C */  jal        DashHUD_CheckWrongWay__Fi
    /* C8F10 800D8710 2120C003 */   addu      $a0, $fp, $zero
    /* C8F14 800D8714 426C020C */  jal        DashHUD_HUDCalc__Fi
    /* C8F18 800D8718 2120C003 */   addu      $a0, $fp, $zero
    /* C8F1C 800D871C 8951030C */  jal        Hud_BuildNumbers0__Fi
    /* C8F20 800D8720 2120C003 */   addu      $a0, $fp, $zero
    /* C8F24 800D8724 9C53030C */  jal        Hud_BuildNumbers__Fi
    /* C8F28 800D8728 2120C003 */   addu      $a0, $fp, $zero
    /* C8F2C 800D872C 1480043C */  lui        $a0, %hi(D_8013E390)
    /* C8F30 800D8730 90E38424 */  addiu      $a0, $a0, %lo(D_8013E390)
    /* C8F34 800D8734 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C8F38 800D8738 7000A88F */  lw         $t0, 0x70($sp)
    /* C8F3C 800D873C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C8F40 800D8740 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C8F44 800D8744 21200401 */  addu       $a0, $t0, $a0
    /* C8F48 800D8748 0000838C */  lw         $v1, 0x0($a0)
    /* C8F4C 800D874C 0000A28C */  lw         $v0, 0x0($a1)
    /* C8F50 800D8750 6800A88F */  lw         $t0, 0x68($sp)
    /* C8F54 800D8754 24186900 */  and        $v1, $v1, $t1
    /* C8F58 800D8758 24104800 */  and        $v0, $v0, $t0
    /* C8F5C 800D875C 25186200 */  or         $v1, $v1, $v0
    /* C8F60 800D8760 000083AC */  sw         $v1, 0x0($a0)
    /* C8F64 800D8764 0000A28C */  lw         $v0, 0x0($a1)
    /* C8F68 800D8768 24208800 */  and        $a0, $a0, $t0
    /* C8F6C 800D876C 24184900 */  and        $v1, $v0, $t1
    /* C8F70 800D8770 25186400 */  or         $v1, $v1, $a0
    /* C8F74 800D8774 0000A3AC */  sw         $v1, 0x0($a1)
    /* C8F78 800D8778 7400A98F */  lw         $t1, 0x74($sp)
    /* C8F7C 800D877C 00000000 */  nop
    /* C8F80 800D8780 4C04228D */  lw         $v0, 0x44C($t1)
    /* C8F84 800D8784 00000000 */  nop
    /* C8F88 800D8788 0D004010 */  beqz       $v0, .L800D87C0
    /* C8F8C 800D878C 00FF083C */   lui       $t0, (0xFF000000 >> 16)
    /* C8F90 800D8790 1400828E */  lw         $v0, 0x14($s4)
    /* C8F94 800D8794 6800A98F */  lw         $t1, 0x68($sp)
    /* C8F98 800D8798 24104800 */  and        $v0, $v0, $t0
    /* C8F9C 800D879C 24186900 */  and        $v1, $v1, $t1
    /* C8FA0 800D87A0 25104300 */  or         $v0, $v0, $v1
    /* C8FA4 800D87A4 140082AE */  sw         $v0, 0x14($s4)
    /* C8FA8 800D87A8 14008226 */  addiu      $v0, $s4, 0x14
    /* C8FAC 800D87AC 0000A38C */  lw         $v1, 0x0($a1)
    /* C8FB0 800D87B0 24104900 */  and        $v0, $v0, $t1
    /* C8FB4 800D87B4 24186800 */  and        $v1, $v1, $t0
    /* C8FB8 800D87B8 25186200 */  or         $v1, $v1, $v0
    /* C8FBC 800D87BC 0000A3AC */  sw         $v1, 0x0($a1)
  .L800D87C0:
    /* C8FC0 800D87C0 7400A88F */  lw         $t0, 0x74($sp)
    /* C8FC4 800D87C4 00000000 */  nop
    /* C8FC8 800D87C8 5004028D */  lw         $v0, 0x450($t0)
    /* C8FCC 800D87CC 00000000 */  nop
    /* C8FD0 800D87D0 B3004010 */  beqz       $v0, .L800D8AA0
    /* C8FD4 800D87D4 00000000 */   nop
    /* C8FD8 800D87D8 5404028D */  lw         $v0, 0x454($t0)
    /* C8FDC 800D87DC 00000000 */  nop
    /* C8FE0 800D87E0 9A004010 */  beqz       $v0, .L800D8A4C
    /* C8FE4 800D87E4 3F000624 */   addiu     $a2, $zero, 0x3F
    /* C8FE8 800D87E8 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C8FEC 800D87EC 00000000 */  nop
    /* C8FF0 800D87F0 96004014 */  bnez       $v0, .L800D8A4C
    /* C8FF4 800D87F4 1180093C */   lui       $t1, %hi(GameSetup_gData)
    /* C8FF8 800D87F8 EC312925 */  addiu      $t1, $t1, %lo(GameSetup_gData)
    /* C8FFC 800D87FC 0C00228D */  lw         $v0, 0xC($t1)
    /* C9000 800D8800 01000824 */  addiu      $t0, $zero, 0x1
    /* C9004 800D8804 91004810 */  beq        $v0, $t0, .L800D8A4C
    /* C9008 800D8808 00000000 */   nop
    /* C900C 800D880C 535D030C */  jal        Hud_NextPlayer__Fi
    /* C9010 800D8810 2120C003 */   addu      $a0, $fp, $zero
    /* C9014 800D8814 8C004004 */  bltz       $v0, .L800D8A48
    /* C9018 800D8818 09004228 */   slti      $v0, $v0, 0x9
    /* C901C 800D881C 8B004010 */  beqz       $v0, .L800D8A4C
    /* C9020 800D8820 3F000624 */   addiu     $a2, $zero, 0x3F
    /* C9024 800D8824 F013828F */  lw         $v0, %gp_rel(Hud_BeTheCop)($gp)
    /* C9028 800D8828 00000000 */  nop
    /* C902C 800D882C 87004014 */  bnez       $v0, .L800D8A4C
    /* C9030 800D8830 1180023C */   lui       $v0, %hi(HudPmx_gShapes)
    /* C9034 800D8834 980C5124 */  addiu      $s1, $v0, %lo(HudPmx_gShapes)
    /* C9038 800D8838 2120C003 */  addu       $a0, $fp, $zero
    /* C903C 800D883C 70093086 */  lh         $s0, 0x970($s1)
    /* C9040 800D8840 28013286 */  lh         $s2, 0x128($s1)
    /* C9044 800D8844 A0013386 */  lh         $s3, 0x1A0($s1)
    /* C9048 800D8848 AC5D030C */  jal        Hud_NextPlayerNameOrCarOrTime__Fi
    /* C904C 800D884C 02001026 */   addiu     $s0, $s0, 0x2
    /* C9050 800D8850 2000A427 */  addiu      $a0, $sp, 0x20
    /* C9054 800D8854 1480053C */  lui        $a1, %hi(D_8013D904)
    /* C9058 800D8858 04D9A524 */  addiu      $a1, $a1, %lo(D_8013D904)
    /* C905C 800D885C 2F91030C */  jal        sprintf
    /* C9060 800D8860 21304000 */   addu      $a2, $v0, $zero
    /* C9064 800D8864 5B47030C */  jal        Hud_GoTpage__Fi
    /* C9068 800D8868 01000424 */   addiu     $a0, $zero, 0x1
    /* C906C 800D886C 914A030C */  jal        uppercase__FPc
    /* C9070 800D8870 2000A427 */   addiu     $a0, $sp, 0x20
    /* C9074 800D8874 2000A427 */  addiu      $a0, $sp, 0x20
    /* C9078 800D8878 21280000 */  addu       $a1, $zero, $zero
    /* C907C 800D887C 2130A000 */  addu       $a2, $a1, $zero
    /* C9080 800D8880 2138A000 */  addu       $a3, $a1, $zero
    /* C9084 800D8884 01000924 */  addiu      $t1, $zero, 0x1
    /* C9088 800D8888 1000A0AF */  sw         $zero, 0x10($sp)
    /* C908C 800D888C B250030C */  jal        Hud_BuildString__FPciiiib
    /* C9090 800D8890 1400A9AF */   sw        $t1, 0x14($sp)
    /* C9094 800D8894 2000A427 */  addiu      $a0, $sp, 0x20
    /* C9098 800D8898 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C909C 800D889C 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C90A0 800D88A0 23800202 */  subu       $s0, $s0, $v0
    /* C90A4 800D88A4 B818838F */  lw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C90A8 800D88A8 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C90AC 800D88AC 6000A88F */  lw         $t0, 0x60($sp)
    /* C90B0 800D88B0 38006584 */  lh         $a1, 0x38($v1)
    /* C90B4 800D88B4 3A006684 */  lh         $a2, 0x3A($v1)
    /* C90B8 800D88B8 43801000 */  sra        $s0, $s0, 1
    /* C90BC 800D88BC 1000A0AF */  sw         $zero, 0x10($sp)
    /* C90C0 800D88C0 1400A0AF */  sw         $zero, 0x14($sp)
    /* C90C4 800D88C4 2128B000 */  addu       $a1, $a1, $s0
    /* C90C8 800D88C8 2130C200 */  addu       $a2, $a2, $v0
    /* C90CC 800D88CC 2A012286 */  lh         $v0, 0x12A($s1)
    /* C90D0 800D88D0 2130C800 */  addu       $a2, $a2, $t0
    /* C90D4 800D88D4 2330C200 */  subu       $a2, $a2, $v0
    /* C90D8 800D88D8 B250030C */  jal        Hud_BuildString__FPciiiib
    /* C90DC 800D88DC 0100C624 */   addiu     $a2, $a2, 0x1
    /* C90E0 800D88E0 5B47030C */  jal        Hud_GoTpage__Fi
    /* C90E4 800D88E4 21200000 */   addu      $a0, $zero, $zero
    /* C90E8 800D88E8 18012426 */  addiu      $a0, $s1, 0x118
    /* C90EC 800D88EC 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C90F0 800D88F0 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C90F4 800D88F4 B818838F */  lw         $v1, %gp_rel(D_8013DE04)($gp)
    /* C90F8 800D88F8 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C90FC 800D88FC 6000A98F */  lw         $t1, 0x60($sp)
    /* C9100 800D8900 3A006684 */  lh         $a2, 0x3A($v1)
    /* C9104 800D8904 38006584 */  lh         $a1, 0x38($v1)
    /* C9108 800D8908 2130C200 */  addu       $a2, $a2, $v0
    /* C910C 800D890C 2A012286 */  lh         $v0, 0x12A($s1)
    /* C9110 800D8910 2130C900 */  addu       $a2, $a2, $t1
    /* C9114 800D8914 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C9118 800D8918 2330C200 */   subu      $a2, $a2, $v0
    /* C911C 800D891C 2C012426 */  addiu      $a0, $s1, 0x12C
    /* C9120 800D8920 8000073C */  lui        $a3, (0x808080 >> 16)
    /* C9124 800D8924 8080E734 */  ori        $a3, $a3, (0x808080 & 0xFFFF)
    /* C9128 800D8928 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C912C 800D892C 6000A88F */  lw         $t0, 0x60($sp)
    /* C9130 800D8930 38004584 */  lh         $a1, 0x38($v0)
    /* C9134 800D8934 3A004684 */  lh         $a2, 0x3A($v0)
    /* C9138 800D8938 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C913C 800D893C 2128B200 */  addu       $a1, $a1, $s2
    /* C9140 800D8940 2128B300 */  addu       $a1, $a1, $s3
    /* C9144 800D8944 2130C200 */  addu       $a2, $a2, $v0
    /* C9148 800D8948 3E012286 */  lh         $v0, 0x13E($s1)
    /* C914C 800D894C 2130C800 */  addu       $a2, $a2, $t0
    /* C9150 800D8950 1A4A030C */  jal        Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C9154 800D8954 2330C200 */   subu      $a2, $a2, $v0
    /* C9158 800D8958 21200000 */  addu       $a0, $zero, $zero
    /* C915C 800D895C 21385302 */  addu       $a3, $s2, $s3
    /* C9160 800D8960 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C9164 800D8964 2A012386 */  lh         $v1, 0x12A($s1)
    /* C9168 800D8968 6000A98F */  lw         $t1, 0x60($sp)
    /* C916C 800D896C 38004584 */  lh         $a1, 0x38($v0)
    /* C9170 800D8970 3A004684 */  lh         $a2, 0x3A($v0)
    /* C9174 800D8974 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C9178 800D8978 0300E724 */  addiu      $a3, $a3, 0x3
    /* C917C 800D897C 1000A3AF */  sw         $v1, 0x10($sp)
    /* C9180 800D8980 1400A0AF */  sw         $zero, 0x14($sp)
    /* C9184 800D8984 1800A0AF */  sw         $zero, 0x18($sp)
    /* C9188 800D8988 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C918C 800D898C 0200A524 */  addiu      $a1, $a1, 0x2
    /* C9190 800D8990 2130C200 */  addu       $a2, $a2, $v0
    /* C9194 800D8994 2130C900 */  addu       $a2, $a2, $t1
    /* C9198 800D8998 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C919C 800D899C 2330C300 */   subu      $a2, $a2, $v1
    /* C91A0 800D89A0 1480023C */  lui        $v0, %hi(Hud_gWingmanInterface)
    /* C91A4 800D89A4 B0D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanInterface)
    /* C91A8 800D89A8 2110C203 */  addu       $v0, $fp, $v0
    /* C91AC 800D89AC 00004290 */  lbu        $v0, 0x0($v0)
    /* C91B0 800D89B0 00000000 */  nop
    /* C91B4 800D89B4 02004014 */  bnez       $v0, .L800D89C0
    /* C91B8 800D89B8 02000324 */   addiu     $v1, $zero, 0x2
    /* C91BC 800D89BC 03000324 */  addiu      $v1, $zero, 0x3
  .L800D89C0:
    /* C91C0 800D89C0 21200000 */  addu       $a0, $zero, $zero
    /* C91C4 800D89C4 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C91C8 800D89C8 6000A88F */  lw         $t0, 0x60($sp)
    /* C91CC 800D89CC 38004584 */  lh         $a1, 0x38($v0)
    /* C91D0 800D89D0 3A004684 */  lh         $a2, 0x3A($v0)
    /* C91D4 800D89D4 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C91D8 800D89D8 03000724 */  addiu      $a3, $zero, 0x3
    /* C91DC 800D89DC 1000A3AF */  sw         $v1, 0x10($sp)
    /* C91E0 800D89E0 1400A0AF */  sw         $zero, 0x14($sp)
    /* C91E4 800D89E4 1800A0AF */  sw         $zero, 0x18($sp)
    /* C91E8 800D89E8 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C91EC 800D89EC 2130C200 */  addu       $a2, $a2, $v0
    /* C91F0 800D89F0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C91F4 800D89F4 2130C800 */   addu      $a2, $a2, $t0
    /* C91F8 800D89F8 21200000 */  addu       $a0, $zero, $zero
    /* C91FC 800D89FC 03000724 */  addiu      $a3, $zero, 0x3
    /* C9200 800D8A00 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C9204 800D8A04 6000A98F */  lw         $t1, 0x60($sp)
    /* C9208 800D8A08 38004584 */  lh         $a1, 0x38($v0)
    /* C920C 800D8A0C 3A004684 */  lh         $a2, 0x3A($v0)
    /* C9210 800D8A10 2110E000 */  addu       $v0, $a3, $zero
    /* C9214 800D8A14 1000A2AF */  sw         $v0, 0x10($sp)
    /* C9218 800D8A18 1400A0AF */  sw         $zero, 0x14($sp)
    /* C921C 800D8A1C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C9220 800D8A20 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* C9224 800D8A24 3C012286 */  lh         $v0, 0x13C($s1)
    /* C9228 800D8A28 2128B200 */  addu       $a1, $a1, $s2
    /* C922C 800D8A2C 2128B300 */  addu       $a1, $a1, $s3
    /* C9230 800D8A30 2128A200 */  addu       $a1, $a1, $v0
    /* C9234 800D8A34 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C9238 800D8A38 FDFFA524 */  addiu      $a1, $a1, -0x3
    /* C923C 800D8A3C 2130C200 */  addu       $a2, $a2, $v0
    /* C9240 800D8A40 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C9244 800D8A44 2130C900 */   addu      $a2, $a2, $t1
  .L800D8A48:
    /* C9248 800D8A48 3F000624 */  addiu      $a2, $zero, 0x3F
  .L800D8A4C:
    /* C924C 800D8A4C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C9250 800D8A50 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C9254 800D8A54 EC048426 */  addiu      $a0, $s4, 0x4EC
  .L800D8A58:
    /* C9258 800D8A58 0100C624 */  addiu      $a2, $a2, 0x1
    /* C925C 800D8A5C 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C9260 800D8A60 0000828C */  lw         $v0, 0x0($a0)
    /* C9264 800D8A64 0000A38C */  lw         $v1, 0x0($a1)
    /* C9268 800D8A68 6800A98F */  lw         $t1, 0x68($sp)
    /* C926C 800D8A6C 24104800 */  and        $v0, $v0, $t0
    /* C9270 800D8A70 24186900 */  and        $v1, $v1, $t1
    /* C9274 800D8A74 25104300 */  or         $v0, $v0, $v1
    /* C9278 800D8A78 24188900 */  and        $v1, $a0, $t1
    /* C927C 800D8A7C 000082AC */  sw         $v0, 0x0($a0)
    /* C9280 800D8A80 0000A28C */  lw         $v0, 0x0($a1)
    /* C9284 800D8A84 00000000 */  nop
    /* C9288 800D8A88 24104800 */  and        $v0, $v0, $t0
    /* C928C 800D8A8C 25104300 */  or         $v0, $v0, $v1
    /* C9290 800D8A90 0000A2AC */  sw         $v0, 0x0($a1)
    /* C9294 800D8A94 4700C228 */  slti       $v0, $a2, 0x47
    /* C9298 800D8A98 EFFF4014 */  bnez       $v0, .L800D8A58
    /* C929C 800D8A9C 14008424 */   addiu     $a0, $a0, 0x14
  .L800D8AA0:
    /* C92A0 800D8AA0 0F00C017 */  bnez       $fp, .L800D8AE0
    /* C92A4 800D8AA4 1480043C */   lui       $a0, %hi(D_8013E3F0)
    /* C92A8 800D8AA8 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C92AC 800D8AAC F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C92B0 800D8AB0 00000000 */  nop
    /* C92B4 800D8AB4 02004228 */  slti       $v0, $v0, 0x2
    /* C92B8 800D8AB8 09004014 */  bnez       $v0, .L800D8AE0
    /* C92BC 800D8ABC 00000000 */   nop
    /* C92C0 800D8AC0 1180023C */  lui        $v0, %hi(D_80117048)
    /* C92C4 800D8AC4 4870428C */  lw         $v0, %lo(D_80117048)($v0)
    /* C92C8 800D8AC8 00000000 */  nop
    /* C92CC 800D8ACC 05004014 */  bnez       $v0, .L800D8AE4
    /* C92D0 800D8AD0 F0E38424 */   addiu     $a0, $a0, %lo(D_8013E3F0)
    /* C92D4 800D8AD4 945C030C */  jal        Hud_BuildReplay__Fv
    /* C92D8 800D8AD8 00000000 */   nop
    /* C92DC 800D8ADC 1480043C */  lui        $a0, %hi(D_8013E3F0)
  .L800D8AE0:
    /* C92E0 800D8AE0 F0E38424 */  addiu      $a0, $a0, %lo(D_8013E3F0)
  .L800D8AE4:
    /* C92E4 800D8AE4 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C92E8 800D8AE8 7000A88F */  lw         $t0, 0x70($sp)
    /* C92EC 800D8AEC 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C92F0 800D8AF0 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C92F4 800D8AF4 21200401 */  addu       $a0, $t0, $a0
    /* C92F8 800D8AF8 0000838C */  lw         $v1, 0x0($a0)
    /* C92FC 800D8AFC 0000A28C */  lw         $v0, 0x0($a1)
    /* C9300 800D8B00 6800A88F */  lw         $t0, 0x68($sp)
    /* C9304 800D8B04 24186900 */  and        $v1, $v1, $t1
    /* C9308 800D8B08 24104800 */  and        $v0, $v0, $t0
    /* C930C 800D8B0C 25186200 */  or         $v1, $v1, $v0
    /* C9310 800D8B10 000083AC */  sw         $v1, 0x0($a0)
    /* C9314 800D8B14 24208800 */  and        $a0, $a0, $t0
    /* C9318 800D8B18 0000A28C */  lw         $v0, 0x0($a1)
    /* C931C 800D8B1C 1180083C */  lui        $t0, %hi(DashHUD_gInfo)
    /* C9320 800D8B20 24104900 */  and        $v0, $v0, $t1
    /* C9324 800D8B24 25104400 */  or         $v0, $v0, $a0
    /* C9328 800D8B28 0000A2AC */  sw         $v0, 0x0($a1)
    /* C932C 800D8B2C 6C00A98F */  lw         $t1, 0x6C($sp)
    /* C9330 800D8B30 30270825 */  addiu      $t0, $t0, %lo(DashHUD_gInfo)
    /* C9334 800D8B34 21102801 */  addu       $v0, $t1, $t0
    /* C9338 800D8B38 1C00428C */  lw         $v0, 0x1C($v0)
    /* C933C 800D8B3C 00000000 */  nop
    /* C9340 800D8B40 10004010 */  beqz       $v0, .L800D8B84
    /* C9344 800D8B44 00000000 */   nop
    /* C9348 800D8B48 1480023C */  lui        $v0, %hi(Hud_gWingmanInterface)
    /* C934C 800D8B4C B0D84224 */  addiu      $v0, $v0, %lo(Hud_gWingmanInterface)
    /* C9350 800D8B50 2110C203 */  addu       $v0, $fp, $v0
    /* C9354 800D8B54 00004290 */  lbu        $v0, 0x0($v0)
    /* C9358 800D8B58 00000000 */  nop
    /* C935C 800D8B5C 09004010 */  beqz       $v0, .L800D8B84
    /* C9360 800D8B60 00000000 */   nop
    /* C9364 800D8B64 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9368 800D8B68 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C936C 800D8B6C 00000000 */  nop
    /* C9370 800D8B70 02004228 */  slti       $v0, $v0, 0x2
    /* C9374 800D8B74 03004010 */  beqz       $v0, .L800D8B84
    /* C9378 800D8B78 00000000 */   nop
    /* C937C 800D8B7C 1B58030C */  jal        Hud_BuildWingmanInterface__Fi
    /* C9380 800D8B80 2120C003 */   addu      $a0, $fp, $zero
  .L800D8B84:
    /* C9384 800D8B84 1480063C */  lui        $a2, %hi(Hud_gHudView)
    /* C9388 800D8B88 50D9C624 */  addiu      $a2, $a2, %lo(Hud_gHudView)
    /* C938C 800D8B8C 1480043C */  lui        $a0, %hi(D_8013E39C)
    /* C9390 800D8B90 9CE38424 */  addiu      $a0, $a0, %lo(D_8013E39C)
    /* C9394 800D8B94 6C00A98F */  lw         $t1, 0x6C($sp)
    /* C9398 800D8B98 7000A88F */  lw         $t0, 0x70($sp)
    /* C939C 800D8B9C 801F053C */  lui        $a1, (0x1F800000 >> 16)
    /* C93A0 800D8BA0 0000A58C */  lw         $a1, (0x1F800000 & 0xFFFF)($a1)
    /* C93A4 800D8BA4 21302601 */  addu       $a2, $t1, $a2
    /* C93A8 800D8BA8 04002925 */  addiu      $t1, $t1, 0x4
    /* C93AC 800D8BAC 21200401 */  addu       $a0, $t0, $a0
    /* C93B0 800D8BB0 30000825 */  addiu      $t0, $t0, 0x30
    /* C93B4 800D8BB4 6C00A9AF */  sw         $t1, 0x6C($sp)
    /* C93B8 800D8BB8 00FF093C */  lui        $t1, (0xFF000000 >> 16)
    /* C93BC 800D8BBC 7000A8AF */  sw         $t0, 0x70($sp)
    /* C93C0 800D8BC0 0000838C */  lw         $v1, 0x0($a0)
    /* C93C4 800D8BC4 0000A28C */  lw         $v0, 0x0($a1)
    /* C93C8 800D8BC8 6800A88F */  lw         $t0, 0x68($sp)
    /* C93CC 800D8BCC 24186900 */  and        $v1, $v1, $t1
    /* C93D0 800D8BD0 24104800 */  and        $v0, $v0, $t0
    /* C93D4 800D8BD4 25186200 */  or         $v1, $v1, $v0
    /* C93D8 800D8BD8 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C93DC 800D8BDC 000083AC */  sw         $v1, 0x0($a0)
    /* C93E0 800D8BE0 7400A98F */  lw         $t1, 0x74($sp)
    /* C93E4 800D8BE4 0000A28C */  lw         $v0, 0x0($a1)
    /* C93E8 800D8BE8 B4002925 */  addiu      $t1, $t1, 0xB4
    /* C93EC 800D8BEC 7400A9AF */  sw         $t1, 0x74($sp)
    /* C93F0 800D8BF0 6800A98F */  lw         $t1, 0x68($sp)
    /* C93F4 800D8BF4 24104800 */  and        $v0, $v0, $t0
    /* C93F8 800D8BF8 24208900 */  and        $a0, $a0, $t1
    /* C93FC 800D8BFC 25104400 */  or         $v0, $v0, $a0
    /* C9400 800D8C00 0000A2AC */  sw         $v0, 0x0($a1)
    /* C9404 800D8C04 0000C48C */  lw         $a0, 0x0($a2)
    /* C9408 800D8C08 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C940C 800D8C0C 0100DE27 */   addiu     $fp, $fp, 0x1
    /* C9410 800D8C10 C9600308 */  j          .L800D8324
    /* C9414 800D8C14 1180083C */   lui       $t0, %hi(DashHUD_gInfo)
  .L800D8C18:
    /* C9418 800D8C18 9C00BF8F */  lw         $ra, 0x9C($sp)
    /* C941C 800D8C1C 9800BE8F */  lw         $fp, 0x98($sp)
    /* C9420 800D8C20 9400B78F */  lw         $s7, 0x94($sp)
    /* C9424 800D8C24 9000B68F */  lw         $s6, 0x90($sp)
    /* C9428 800D8C28 8C00B58F */  lw         $s5, 0x8C($sp)
    /* C942C 800D8C2C 8800B48F */  lw         $s4, 0x88($sp)
    /* C9430 800D8C30 8400B38F */  lw         $s3, 0x84($sp)
    /* C9434 800D8C34 8000B28F */  lw         $s2, 0x80($sp)
    /* C9438 800D8C38 7C00B18F */  lw         $s1, 0x7C($sp)
    /* C943C 800D8C3C 7800B08F */  lw         $s0, 0x78($sp)
    /* C9440 800D8C40 0800E003 */  jr         $ra
    /* C9444 800D8C44 A000BD27 */   addiu     $sp, $sp, 0xA0
endlabel Hud_RenderHudView__Fv
