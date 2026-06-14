.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RaceSummary__Fv, 0x574

glabel RaceSummary__Fv
    /* CA248 800D9A48 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* CA24C 800D9A4C A800B6AF */  sw         $s6, 0xA8($sp)
    /* CA250 800D9A50 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* CA254 800D9A54 EC310825 */  addiu      $t0, $t0, %lo(GameSetup_gData)
    /* CA258 800D9A58 B400BFAF */  sw         $ra, 0xB4($sp)
    /* CA25C 800D9A5C B000BEAF */  sw         $fp, 0xB0($sp)
    /* CA260 800D9A60 AC00B7AF */  sw         $s7, 0xAC($sp)
    /* CA264 800D9A64 A400B5AF */  sw         $s5, 0xA4($sp)
    /* CA268 800D9A68 A000B4AF */  sw         $s4, 0xA0($sp)
    /* CA26C 800D9A6C 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* CA270 800D9A70 9800B2AF */  sw         $s2, 0x98($sp)
    /* CA274 800D9A74 9400B1AF */  sw         $s1, 0x94($sp)
    /* CA278 800D9A78 9000B0AF */  sw         $s0, 0x90($sp)
    /* CA27C 800D9A7C 0400028D */  lw         $v0, 0x4($t0)
    /* CA280 800D9A80 01001E24 */  addiu      $fp, $zero, 0x1
    /* CA284 800D9A84 02005E14 */  bne        $v0, $fp, .L800D9A90
    /* CA288 800D9A88 08001624 */   addiu     $s6, $zero, 0x8
    /* CA28C 800D9A8C 28001624 */  addiu      $s6, $zero, 0x28
  .L800D9A90:
    /* CA290 800D9A90 30010824 */  addiu      $t0, $zero, 0x130
    /* CA294 800D9A94 03005E14 */  bne        $v0, $fp, .L800D9AA4
    /* CA298 800D9A98 4800A8A7 */   sh        $t0, 0x48($sp)
    /* CA29C 800D9A9C EF000824 */  addiu      $t0, $zero, 0xEF
    /* CA2A0 800D9AA0 4800A8A7 */  sh         $t0, 0x48($sp)
  .L800D9AA4:
    /* CA2A4 800D9AA4 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* CA2A8 800D9AA8 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* CA2AC 800D9AAC 38000424 */  addiu      $a0, $zero, 0x38
    /* CA2B0 800D9AB0 01004224 */  addiu      $v0, $v0, 0x1
    /* CA2B4 800D9AB4 40800200 */  sll        $s0, $v0, 1
    /* CA2B8 800D9AB8 21800202 */  addu       $s0, $s0, $v0
    /* CA2BC 800D9ABC 80801000 */  sll        $s0, $s0, 2
    /* CA2C0 800D9AC0 1E001026 */  addiu      $s0, $s0, 0x1E
    /* CA2C4 800D9AC4 5000B0A7 */  sh         $s0, 0x50($sp)
    /* CA2C8 800D9AC8 00841000 */  sll        $s0, $s0, 16
    /* CA2CC 800D9ACC 03441000 */  sra        $t0, $s0, 16
    /* CA2D0 800D9AD0 43841000 */  sra        $s0, $s0, 17
    /* CA2D4 800D9AD4 78000224 */  addiu      $v0, $zero, 0x78
    /* CA2D8 800D9AD8 23105000 */  subu       $v0, $v0, $s0
    /* CA2DC 800D9ADC 6000A8AF */  sw         $t0, 0x60($sp)
    /* CA2E0 800D9AE0 94E4020C */  jal        TextSys_Word__Fi
    /* CA2E4 800D9AE4 6400A2AF */   sw        $v0, 0x64($sp)
    /* CA2E8 800D9AE8 888F030C */  jal        textpixels
    /* CA2EC 800D9AEC 21204000 */   addu      $a0, $v0, $zero
    /* CA2F0 800D9AF0 06000424 */  addiu      $a0, $zero, 0x6
    /* CA2F4 800D9AF4 43100200 */  sra        $v0, $v0, 1
    /* CA2F8 800D9AF8 A0001124 */  addiu      $s1, $zero, 0xA0
    /* CA2FC 800D9AFC 23882202 */  subu       $s1, $s1, $v0
    /* CA300 800D9B00 76000224 */  addiu      $v0, $zero, 0x76
    /* CA304 800D9B04 832C030C */  jal        Font_TextColor__Fi
    /* CA308 800D9B08 23A85000 */   subu      $s5, $v0, $s0
    /* CA30C 800D9B0C 94E4020C */  jal        TextSys_Word__Fi
    /* CA310 800D9B10 38000424 */   addiu     $a0, $zero, 0x38
    /* CA314 800D9B14 21204000 */  addu       $a0, $v0, $zero
    /* CA318 800D9B18 008C1100 */  sll        $s1, $s1, 16
    /* CA31C 800D9B1C 032C1100 */  sra        $a1, $s1, 16
    /* CA320 800D9B20 A42E030C */  jal        Font_TextXY__FPcii
    /* CA324 800D9B24 2130A002 */   addu      $a2, $s5, $zero
    /* CA328 800D9B28 832C030C */  jal        Font_TextColor__Fi
    /* CA32C 800D9B2C 03000424 */   addiu     $a0, $zero, 0x3
    /* CA330 800D9B30 94E4020C */  jal        TextSys_Word__Fi
    /* CA334 800D9B34 2E000424 */   addiu     $a0, $zero, 0x2E
    /* CA338 800D9B38 21204000 */  addu       $a0, $v0, $zero
    /* CA33C 800D9B3C 1100C226 */  addiu      $v0, $s6, 0x11
    /* CA340 800D9B40 21884000 */  addu       $s1, $v0, $zero
    /* CA344 800D9B44 21282002 */  addu       $a1, $s1, $zero
    /* CA348 800D9B48 0F00A226 */  addiu      $v0, $s5, 0xF
    /* CA34C 800D9B4C 00140200 */  sll        $v0, $v0, 16
    /* CA350 800D9B50 03840200 */  sra        $s0, $v0, 16
    /* CA354 800D9B54 A42E030C */  jal        Font_TextXY__FPcii
    /* CA358 800D9B58 21300002 */   addu      $a2, $s0, $zero
    /* CA35C 800D9B5C 94E4020C */  jal        TextSys_Word__Fi
    /* CA360 800D9B60 3A000424 */   addiu     $a0, $zero, 0x3A
    /* CA364 800D9B64 21204000 */  addu       $a0, $v0, $zero
    /* CA368 800D9B68 5F00C226 */  addiu      $v0, $s6, 0x5F
    /* CA36C 800D9B6C 21A04000 */  addu       $s4, $v0, $zero
    /* CA370 800D9B70 21288002 */  addu       $a1, $s4, $zero
    /* CA374 800D9B74 A42E030C */  jal        Font_TextXY__FPcii
    /* CA378 800D9B78 21300002 */   addu      $a2, $s0, $zero
    /* CA37C 800D9B7C 94E4020C */  jal        TextSys_Word__Fi
    /* CA380 800D9B80 3B000424 */   addiu     $a0, $zero, 0x3B
    /* CA384 800D9B84 21204000 */  addu       $a0, $v0, $zero
    /* CA388 800D9B88 A700C226 */  addiu      $v0, $s6, 0xA7
    /* CA38C 800D9B8C 21904000 */  addu       $s2, $v0, $zero
    /* CA390 800D9B90 21284002 */  addu       $a1, $s2, $zero
    /* CA394 800D9B94 A42E030C */  jal        Font_TextXY__FPcii
    /* CA398 800D9B98 21300002 */   addu      $a2, $s0, $zero
    /* CA39C 800D9B9C 6400A897 */  lhu        $t0, 0x64($sp)
    /* CA3A0 800D9BA0 6800B6A7 */  sh         $s6, 0x68($sp)
    /* CA3A4 800D9BA4 7000B1A7 */  sh         $s1, 0x70($sp)
    /* CA3A8 800D9BA8 7800B4A7 */  sh         $s4, 0x78($sp)
    /* CA3AC 800D9BAC 8000B2A7 */  sh         $s2, 0x80($sp)
    /* CA3B0 800D9BB0 5800A8A7 */  sh         $t0, 0x58($sp)
    /* CA3B4 800D9BB4 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* CA3B8 800D9BB8 EC310825 */  addiu      $t0, $t0, %lo(GameSetup_gData)
    /* CA3BC 800D9BBC 0400028D */  lw         $v0, 0x4($t0)
    /* CA3C0 800D9BC0 E100D326 */  addiu      $s3, $s6, 0xE1
    /* CA3C4 800D9BC4 07005E10 */  beq        $v0, $fp, .L800D9BE4
    /* CA3C8 800D9BC8 8800B3A7 */   sh        $s3, 0x88($sp)
    /* CA3CC 800D9BCC 94E4020C */  jal        TextSys_Word__Fi
    /* CA3D0 800D9BD0 3C000424 */   addiu     $a0, $zero, 0x3C
    /* CA3D4 800D9BD4 21204000 */  addu       $a0, $v0, $zero
    /* CA3D8 800D9BD8 21286002 */  addu       $a1, $s3, $zero
    /* CA3DC 800D9BDC A42E030C */  jal        Font_TextXY__FPcii
    /* CA3E0 800D9BE0 21300002 */   addu      $a2, $s0, $zero
  .L800D9BE4:
    /* CA3E4 800D9BE4 21200000 */  addu       $a0, $zero, $zero
    /* CA3E8 800D9BE8 2128C002 */  addu       $a1, $s6, $zero
    /* CA3EC 800D9BEC 1100A226 */  addiu      $v0, $s5, 0x11
    /* CA3F0 800D9BF0 00140200 */  sll        $v0, $v0, 16
    /* CA3F4 800D9BF4 03BC0200 */  sra        $s7, $v0, 16
    /* CA3F8 800D9BF8 4800A897 */  lhu        $t0, 0x48($sp)
    /* CA3FC 800D9BFC 0C00E626 */  addiu      $a2, $s7, 0xC
    /* CA400 800D9C00 1000BEAF */  sw         $fp, 0x10($sp)
    /* CA404 800D9C04 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA408 800D9C08 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA40C 800D9C0C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* CA410 800D9C10 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA414 800D9C14 21380001 */   addu      $a3, $t0, $zero
    /* CA418 800D9C18 21200000 */  addu       $a0, $zero, $zero
    /* CA41C 800D9C1C FEFF2526 */  addiu      $a1, $s1, -0x2
    /* CA420 800D9C20 6400B18F */  lw         $s1, 0x64($sp)
    /* CA424 800D9C24 6000A88F */  lw         $t0, 0x60($sp)
    /* CA428 800D9C28 01000724 */  addiu      $a3, $zero, 0x1
    /* CA42C 800D9C2C 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA430 800D9C30 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA434 800D9C34 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* CA438 800D9C38 21302002 */  addu       $a2, $s1, $zero
    /* CA43C 800D9C3C F8FF1025 */  addiu      $s0, $t0, -0x8
    /* CA440 800D9C40 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA444 800D9C44 1000B0AF */   sw        $s0, 0x10($sp)
    /* CA448 800D9C48 21200000 */  addu       $a0, $zero, $zero
    /* CA44C 800D9C4C FEFF8526 */  addiu      $a1, $s4, -0x2
    /* CA450 800D9C50 21302002 */  addu       $a2, $s1, $zero
    /* CA454 800D9C54 01000724 */  addiu      $a3, $zero, 0x1
    /* CA458 800D9C58 1000B0AF */  sw         $s0, 0x10($sp)
    /* CA45C 800D9C5C 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA460 800D9C60 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA464 800D9C64 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA468 800D9C68 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CA46C 800D9C6C 21200000 */  addu       $a0, $zero, $zero
    /* CA470 800D9C70 FEFF4526 */  addiu      $a1, $s2, -0x2
    /* CA474 800D9C74 21302002 */  addu       $a2, $s1, $zero
    /* CA478 800D9C78 01000724 */  addiu      $a3, $zero, 0x1
    /* CA47C 800D9C7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CA480 800D9C80 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA484 800D9C84 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA488 800D9C88 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA48C 800D9C8C 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CA490 800D9C90 1180083C */  lui        $t0, %hi(GameSetup_gData)
    /* CA494 800D9C94 EC310825 */  addiu      $t0, $t0, %lo(GameSetup_gData)
    /* CA498 800D9C98 0400028D */  lw         $v0, 0x4($t0)
    /* CA49C 800D9C9C 00000000 */  nop
    /* CA4A0 800D9CA0 09005E10 */  beq        $v0, $fp, .L800D9CC8
    /* CA4A4 800D9CA4 21200000 */   addu      $a0, $zero, $zero
    /* CA4A8 800D9CA8 FEFF6526 */  addiu      $a1, $s3, -0x2
    /* CA4AC 800D9CAC 21302002 */  addu       $a2, $s1, $zero
    /* CA4B0 800D9CB0 01000724 */  addiu      $a3, $zero, 0x1
    /* CA4B4 800D9CB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* CA4B8 800D9CB8 1400A0AF */  sw         $zero, 0x14($sp)
    /* CA4BC 800D9CBC 1800A0AF */  sw         $zero, 0x18($sp)
    /* CA4C0 800D9CC0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* CA4C4 800D9CC4 1C00A0AF */   sw        $zero, 0x1C($sp)
  .L800D9CC8:
    /* CA4C8 800D9CC8 21980000 */  addu       $s3, $zero, $zero
    /* CA4CC 800D9CCC 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* CA4D0 800D9CD0 00FA5524 */  addiu      $s5, $v0, %lo(Cars_gRaceCarList)
    /* CA4D4 800D9CD4 21A0E002 */  addu       $s4, $s7, $zero
    /* CA4D8 800D9CD8 1180173C */  lui        $s7, %hi(GameSetup_gData)
  .L800D9CDC:
    /* CA4DC 800D9CDC 001C1300 */  sll        $v1, $s3, 16
    /* CA4E0 800D9CE0 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* CA4E4 800D9CE4 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* CA4E8 800D9CE8 031C0300 */  sra        $v1, $v1, 16
    /* CA4EC 800D9CEC 2A106200 */  slt        $v0, $v1, $v0
    /* CA4F0 800D9CF0 93004010 */  beqz       $v0, .L800D9F40
    /* CA4F4 800D9CF4 80100300 */   sll       $v0, $v1, 2
    /* CA4F8 800D9CF8 21105500 */  addu       $v0, $v0, $s5
    /* CA4FC 800D9CFC 0000448C */  lw         $a0, 0x0($v0)
    /* CA500 800D9D00 00000000 */  nop
    /* CA504 800D9D04 D003928C */  lw         $s2, 0x3D0($a0)
    /* CA508 800D9D08 4C14838F */  lw         $v1, %gp_rel(StatsTimer)($gp)
    /* CA50C 800D9D0C 40101200 */  sll        $v0, $s2, 1
    /* CA510 800D9D10 04004224 */  addiu      $v0, $v0, 0x4
    /* CA514 800D9D14 2A104300 */  slt        $v0, $v0, $v1
    /* CA518 800D9D18 87004010 */  beqz       $v0, .L800D9F38
    /* CA51C 800D9D1C 00000000 */   nop
    /* CA520 800D9D20 6002828C */  lw         $v0, 0x260($a0)
    /* CA524 800D9D24 00000000 */  nop
    /* CA528 800D9D28 04004230 */  andi       $v0, $v0, 0x4
    /* CA52C 800D9D2C 02004010 */  beqz       $v0, .L800D9D38
    /* CA530 800D9D30 04000424 */   addiu     $a0, $zero, 0x4
    /* CA534 800D9D34 03000424 */  addiu      $a0, $zero, 0x3
  .L800D9D38:
    /* CA538 800D9D38 832C030C */  jal        Font_TextColor__Fi
    /* CA53C 800D9D3C 40801200 */   sll       $s0, $s2, 1
    /* CA540 800D9D40 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA544 800D9D44 1480053C */  lui        $a1, %hi(D_8013D98C)
    /* CA548 800D9D48 8CD9A524 */  addiu      $a1, $a1, %lo(D_8013D98C)
    /* CA54C 800D9D4C 2F91030C */  jal        sprintf
    /* CA550 800D9D50 21304002 */   addu      $a2, $s2, $zero
    /* CA554 800D9D54 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA558 800D9D58 21801202 */  addu       $s0, $s0, $s2
    /* CA55C 800D9D5C 80801000 */  sll        $s0, $s0, 2
    /* CA560 800D9D60 21809002 */  addu       $s0, $s4, $s0
    /* CA564 800D9D64 6800A897 */  lhu        $t0, 0x68($sp)
    /* CA568 800D9D68 21300002 */  addu       $a2, $s0, $zero
    /* CA56C 800D9D6C A42E030C */  jal        Font_TextXY__FPcii
    /* CA570 800D9D70 01000535 */   ori       $a1, $t0, 0x1
    /* CA574 800D9D74 832C030C */  jal        Font_TextColor__Fi
    /* CA578 800D9D78 03000424 */   addiu     $a0, $zero, 0x3
    /* CA57C 800D9D7C 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA580 800D9D80 008C1300 */  sll        $s1, $s3, 16
    /* CA584 800D9D84 838B1100 */  sra        $s1, $s1, 14
    /* CA588 800D9D88 21883502 */  addu       $s1, $s1, $s5
    /* CA58C 800D9D8C 0000228E */  lw         $v0, 0x0($s1)
    /* CA590 800D9D90 1480053C */  lui        $a1, %hi(D_8013D990)
    /* CA594 800D9D94 8802468C */  lw         $a2, 0x288($v0)
    /* CA598 800D9D98 90D9A524 */  addiu      $a1, $a1, %lo(D_8013D990)
    /* CA59C 800D9D9C 2F91030C */  jal        sprintf
    /* CA5A0 800D9DA0 5C00C624 */   addiu     $a2, $a2, 0x5C
    /* CA5A4 800D9DA4 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA5A8 800D9DA8 7000A897 */  lhu        $t0, 0x70($sp)
    /* CA5AC 800D9DAC 21300002 */  addu       $a2, $s0, $zero
    /* CA5B0 800D9DB0 A42E030C */  jal        Font_TextXY__FPcii
    /* CA5B4 800D9DB4 21280001 */   addu      $a1, $t0, $zero
    /* CA5B8 800D9DB8 0000228E */  lw         $v0, 0x0($s1)
    /* CA5BC 800D9DBC 00000000 */  nop
    /* CA5C0 800D9DC0 6002428C */  lw         $v0, 0x260($v0)
    /* CA5C4 800D9DC4 00000000 */  nop
    /* CA5C8 800D9DC8 04004230 */  andi       $v0, $v0, 0x4
    /* CA5CC 800D9DCC 02004010 */  beqz       $v0, .L800D9DD8
    /* CA5D0 800D9DD0 04000424 */   addiu     $a0, $zero, 0x4
    /* CA5D4 800D9DD4 03000424 */  addiu      $a0, $zero, 0x3
  .L800D9DD8:
    /* CA5D8 800D9DD8 832C030C */  jal        Font_TextColor__Fi
    /* CA5DC 800D9DDC 00841300 */   sll       $s0, $s3, 16
    /* CA5E0 800D9DE0 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA5E4 800D9DE4 1480053C */  lui        $a1, %hi(D_8013D990)
    /* CA5E8 800D9DE8 03841000 */  sra        $s0, $s0, 16
    /* CA5EC 800D9DEC 80101000 */  sll        $v0, $s0, 2
    /* CA5F0 800D9DF0 21885500 */  addu       $s1, $v0, $s5
    /* CA5F4 800D9DF4 0000268E */  lw         $a2, 0x0($s1)
    /* CA5F8 800D9DF8 90D9A524 */  addiu      $a1, $a1, %lo(D_8013D990)
    /* CA5FC 800D9DFC 2F91030C */  jal        sprintf
    /* CA600 800D9E00 4902C624 */   addiu     $a2, $a2, 0x249
    /* CA604 800D9E04 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA608 800D9E08 40301200 */  sll        $a2, $s2, 1
    /* CA60C 800D9E0C 2130D200 */  addu       $a2, $a2, $s2
    /* CA610 800D9E10 80300600 */  sll        $a2, $a2, 2
    /* CA614 800D9E14 7800A897 */  lhu        $t0, 0x78($sp)
    /* CA618 800D9E18 21308602 */  addu       $a2, $s4, $a2
    /* CA61C 800D9E1C A42E030C */  jal        Font_TextXY__FPcii
    /* CA620 800D9E20 21280001 */   addu      $a1, $t0, $zero
    /* CA624 800D9E24 EC31E226 */  addiu      $v0, $s7, %lo(GameSetup_gData)
    /* CA628 800D9E28 B800428C */  lw         $v0, 0xB8($v0)
    /* CA62C 800D9E2C 00000000 */  nop
    /* CA630 800D9E30 03005014 */  bne        $v0, $s0, .L800D9E40
    /* CA634 800D9E34 01000224 */   addiu     $v0, $zero, 0x1
    /* CA638 800D9E38 A9670308 */  j          .L800D9EA4
    /* CA63C 800D9E3C 36000424 */   addiu     $a0, $zero, 0x36
  .L800D9E40:
    /* CA640 800D9E40 EC31E38E */  lw         $v1, %lo(GameSetup_gData)($s7)
    /* CA644 800D9E44 00000000 */  nop
    /* CA648 800D9E48 08006214 */  bne        $v1, $v0, .L800D9E6C
    /* CA64C 800D9E4C 00141300 */   sll       $v0, $s3, 16
    /* CA650 800D9E50 0000228E */  lw         $v0, 0x0($s1)
    /* CA654 800D9E54 00000000 */  nop
    /* CA658 800D9E58 C803428C */  lw         $v0, 0x3C8($v0)
    /* CA65C 800D9E5C 00000000 */  nop
    /* CA660 800D9E60 10004014 */  bnez       $v0, .L800D9EA4
    /* CA664 800D9E64 3D000424 */   addiu     $a0, $zero, 0x3D
    /* CA668 800D9E68 00141300 */  sll        $v0, $s3, 16
  .L800D9E6C:
    /* CA66C 800D9E6C 83130200 */  sra        $v0, $v0, 14
    /* CA670 800D9E70 21105500 */  addu       $v0, $v0, $s5
    /* CA674 800D9E74 0000448C */  lw         $a0, 0x0($v0)
    /* CA678 800D9E78 00000000 */  nop
    /* CA67C 800D9E7C CC03838C */  lw         $v1, 0x3CC($a0)
    /* CA680 800D9E80 02000224 */  addiu      $v0, $zero, 0x2
    /* CA684 800D9E84 06006214 */  bne        $v1, $v0, .L800D9EA0
    /* CA688 800D9E88 00000000 */   nop
    /* CA68C 800D9E8C D403848C */  lw         $a0, 0x3D4($a0)
    /* CA690 800D9E90 5963030C */  jal        Hud_ParseTime__FiPc
    /* CA694 800D9E94 2000A527 */   addiu     $a1, $sp, 0x20
    /* CA698 800D9E98 AF670308 */  j          .L800D9EBC
    /* CA69C 800D9E9C 2000A427 */   addiu     $a0, $sp, 0x20
  .L800D9EA0:
    /* CA6A0 800D9EA0 35000424 */  addiu      $a0, $zero, 0x35
  .L800D9EA4:
    /* CA6A4 800D9EA4 94E4020C */  jal        TextSys_Word__Fi
    /* CA6A8 800D9EA8 00000000 */   nop
    /* CA6AC 800D9EAC 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA6B0 800D9EB0 2F91030C */  jal        sprintf
    /* CA6B4 800D9EB4 21284000 */   addu      $a1, $v0, $zero
    /* CA6B8 800D9EB8 2000A427 */  addiu      $a0, $sp, 0x20
  .L800D9EBC:
    /* CA6BC 800D9EBC 40301200 */  sll        $a2, $s2, 1
    /* CA6C0 800D9EC0 2130D200 */  addu       $a2, $a2, $s2
    /* CA6C4 800D9EC4 80300600 */  sll        $a2, $a2, 2
    /* CA6C8 800D9EC8 8000A897 */  lhu        $t0, 0x80($sp)
    /* CA6CC 800D9ECC 21308602 */  addu       $a2, $s4, $a2
    /* CA6D0 800D9ED0 A42E030C */  jal        Font_TextXY__FPcii
    /* CA6D4 800D9ED4 21280001 */   addu      $a1, $t0, $zero
    /* CA6D8 800D9ED8 EC31E226 */  addiu      $v0, $s7, %lo(GameSetup_gData)
    /* CA6DC 800D9EDC 0400438C */  lw         $v1, 0x4($v0)
    /* CA6E0 800D9EE0 01000224 */  addiu      $v0, $zero, 0x1
    /* CA6E4 800D9EE4 14006210 */  beq        $v1, $v0, .L800D9F38
    /* CA6E8 800D9EE8 00141300 */   sll       $v0, $s3, 16
    /* CA6EC 800D9EEC 83130200 */  sra        $v0, $v0, 14
    /* CA6F0 800D9EF0 21105500 */  addu       $v0, $v0, $s5
    /* CA6F4 800D9EF4 0000428C */  lw         $v0, 0x0($v0)
    /* CA6F8 800D9EF8 00000000 */  nop
    /* CA6FC 800D9EFC E803448C */  lw         $a0, 0x3E8($v0)
    /* CA700 800D9F00 00000000 */  nop
    /* CA704 800D9F04 02008014 */  bnez       $a0, .L800D9F10
    /* CA708 800D9F08 00000000 */   nop
    /* CA70C 800D9F0C 21200000 */  addu       $a0, $zero, $zero
  .L800D9F10:
    /* CA710 800D9F10 5963030C */  jal        Hud_ParseTime__FiPc
    /* CA714 800D9F14 2000A527 */   addiu     $a1, $sp, 0x20
    /* CA718 800D9F18 2000A427 */  addiu      $a0, $sp, 0x20
    /* CA71C 800D9F1C 8800A897 */  lhu        $t0, 0x88($sp)
    /* CA720 800D9F20 40301200 */  sll        $a2, $s2, 1
    /* CA724 800D9F24 2130D200 */  addu       $a2, $a2, $s2
    /* CA728 800D9F28 80300600 */  sll        $a2, $a2, 2
    /* CA72C 800D9F2C 21308602 */  addu       $a2, $s4, $a2
    /* CA730 800D9F30 A42E030C */  jal        Font_TextXY__FPcii
    /* CA734 800D9F34 21280001 */   addu      $a1, $t0, $zero
  .L800D9F38:
    /* CA738 800D9F38 37670308 */  j          .L800D9CDC
    /* CA73C 800D9F3C 01007326 */   addiu     $s3, $s3, 0x1
  .L800D9F40:
    /* CA740 800D9F40 2198C002 */  addu       $s3, $s6, $zero
    /* CA744 800D9F44 5800A897 */  lhu        $t0, 0x58($sp)
    /* CA748 800D9F48 21206002 */  addu       $a0, $s3, $zero
    /* CA74C 800D9F4C 008C0800 */  sll        $s1, $t0, 16
    /* CA750 800D9F50 038C1100 */  sra        $s1, $s1, 16
    /* CA754 800D9F54 4800A897 */  lhu        $t0, 0x48($sp)
    /* CA758 800D9F58 21282002 */  addu       $a1, $s1, $zero
    /* CA75C 800D9F5C 21900001 */  addu       $s2, $t0, $zero
    /* CA760 800D9F60 5000A897 */  lhu        $t0, 0x50($sp)
    /* CA764 800D9F64 21304002 */  addu       $a2, $s2, $zero
    /* CA768 800D9F68 00840800 */  sll        $s0, $t0, 16
    /* CA76C 800D9F6C 03841000 */  sra        $s0, $s0, 16
    /* CA770 800D9F70 5A66030C */  jal        OptionsBarThing__Fiiii
    /* CA774 800D9F74 21380002 */   addu      $a3, $s0, $zero
    /* CA778 800D9F78 21206002 */  addu       $a0, $s3, $zero
    /* CA77C 800D9F7C 21282002 */  addu       $a1, $s1, $zero
    /* CA780 800D9F80 21304002 */  addu       $a2, $s2, $zero
    /* CA784 800D9F84 B463030C */  jal        Hud_RenderPauseBox__Fiiii
    /* CA788 800D9F88 21380002 */   addu      $a3, $s0, $zero
    /* CA78C 800D9F8C B400BF8F */  lw         $ra, 0xB4($sp)
    /* CA790 800D9F90 B000BE8F */  lw         $fp, 0xB0($sp)
    /* CA794 800D9F94 AC00B78F */  lw         $s7, 0xAC($sp)
    /* CA798 800D9F98 A800B68F */  lw         $s6, 0xA8($sp)
    /* CA79C 800D9F9C A400B58F */  lw         $s5, 0xA4($sp)
    /* CA7A0 800D9FA0 A000B48F */  lw         $s4, 0xA0($sp)
    /* CA7A4 800D9FA4 9C00B38F */  lw         $s3, 0x9C($sp)
    /* CA7A8 800D9FA8 9800B28F */  lw         $s2, 0x98($sp)
    /* CA7AC 800D9FAC 9400B18F */  lw         $s1, 0x94($sp)
    /* CA7B0 800D9FB0 9000B08F */  lw         $s0, 0x90($sp)
    /* CA7B4 800D9FB4 0800E003 */  jr         $ra
    /* CA7B8 800D9FB8 B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel RaceSummary__Fv
