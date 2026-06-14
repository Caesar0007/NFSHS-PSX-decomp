.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_InitNightDriving__Fv, 0x19C

glabel Night_InitNightDriving__Fv
    /* CC5E4 800DBDE4 E0FEBD27 */  addiu      $sp, $sp, -0x120
    /* CC5E8 800DBDE8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CC5EC 800DBDEC EC314424 */  addiu      $a0, $v0, %lo(GameSetup_gData)
    /* CC5F0 800DBDF0 1801BFAF */  sw         $ra, 0x118($sp)
    /* CC5F4 800DBDF4 1401B1AF */  sw         $s1, 0x114($sp)
    /* CC5F8 800DBDF8 1001B0AF */  sw         $s0, 0x110($sp)
    /* CC5FC 800DBDFC 5400838C */  lw         $v1, 0x54($a0)
    /* CC600 800DBE00 00000000 */  nop
    /* CC604 800DBE04 05006010 */  beqz       $v1, .L800DBE1C
    /* CC608 800DBE08 21100000 */   addu      $v0, $zero, $zero
    /* CC60C 800DBE0C 0C00828C */  lw         $v0, 0xC($a0)
    /* CC610 800DBE10 00000000 */  nop
    /* CC614 800DBE14 01004238 */  xori       $v0, $v0, 0x1
    /* CC618 800DBE18 2B100200 */  sltu       $v0, $zero, $v0
  .L800DBE1C:
    /* CC61C 800DBE1C DC1482AF */  sw         $v0, %gp_rel(gNight_renderNight)($gp)
    /* CC620 800DBE20 08006010 */  beqz       $v1, .L800DBE44
    /* CC624 800DBE24 00000000 */   nop
    /* CC628 800DBE28 0A004014 */  bnez       $v0, .L800DBE54
    /* CC62C 800DBE2C 1000A427 */   addiu     $a0, $sp, 0x10
    /* CC630 800DBE30 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
    /* CC634 800DBE34 7C324224 */  addiu      $v0, $v0, %lo(TrackSpec_gSpec)
    /* CC638 800DBE38 FF000324 */  addiu      $v1, $zero, 0xFF
    /* CC63C 800DBE3C F40043AC */  sw         $v1, 0xF4($v0)
    /* CC640 800DBE40 F00040AC */  sw         $zero, 0xF0($v0)
  .L800DBE44:
    /* CC644 800DBE44 DC14828F */  lw         $v0, %gp_rel(gNight_renderNight)($gp)
    /* CC648 800DBE48 00000000 */  nop
    /* CC64C 800DBE4C 47004010 */  beqz       $v0, .L800DBF6C
    /* CC650 800DBE50 1000A427 */   addiu     $a0, $sp, 0x10
  .L800DBE54:
    /* CC654 800DBE54 1180023C */  lui        $v0, %hi(D_801164CC)
    /* CC658 800DBE58 0580053C */  lui        $a1, %hi(D_8005696C)
    /* CC65C 800DBE5C CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* CC660 800DBE60 2F91030C */  jal        sprintf
    /* CC664 800DBE64 6C69A524 */   addiu     $a1, $a1, %lo(D_8005696C)
    /* CC668 800DBE68 9B95030C */  jal        filesize
    /* CC66C 800DBE6C 1000A427 */   addiu     $a0, $sp, 0x10
    /* CC670 800DBE70 0580043C */  lui        $a0, %hi(D_80056978)
    /* CC674 800DBE74 78698424 */  addiu      $a0, $a0, %lo(D_80056978)
    /* CC678 800DBE78 21284000 */  addu       $a1, $v0, $zero
    /* CC67C 800DBE7C CF94030C */  jal        reservememadr
    /* CC680 800DBE80 21300000 */   addu      $a2, $zero, $zero
    /* CC684 800DBE84 1000A427 */  addiu      $a0, $sp, 0x10
    /* CC688 800DBE88 4C1582AF */  sw         $v0, %gp_rel(nightfile)($gp)
    /* CC68C 800DBE8C 0FC7030C */  jal        loadshapeadr
    /* CC690 800DBE90 21280000 */   addu      $a1, $zero, $zero
    /* CC694 800DBE94 1000A427 */  addiu      $a0, $sp, 0x10
    /* CC698 800DBE98 9B95030C */  jal        filesize
    /* CC69C 800DBE9C 21804000 */   addu      $s0, $v0, $zero
    /* CC6A0 800DBEA0 21200002 */  addu       $a0, $s0, $zero
    /* CC6A4 800DBEA4 4C15858F */  lw         $a1, %gp_rel(nightfile)($gp)
    /* CC6A8 800DBEA8 B798030C */  jal        blockmove
    /* CC6AC 800DBEAC 21304000 */   addu      $a2, $v0, $zero
    /* CC6B0 800DBEB0 5095030C */  jal        purgememadr
    /* CC6B4 800DBEB4 21200002 */   addu      $a0, $s0, $zero
    /* CC6B8 800DBEB8 1480053C */  lui        $a1, %hi(D_8013DA20)
    /* CC6BC 800DBEBC 4C15848F */  lw         $a0, %gp_rel(nightfile)($gp)
    /* CC6C0 800DBEC0 44AC030C */  jal        locateshape
    /* CC6C4 800DBEC4 20DAA524 */   addiu     $a1, $a1, %lo(D_8013DA20)
    /* CC6C8 800DBEC8 10004224 */  addiu      $v0, $v0, 0x10
    /* CC6CC 800DBECC F41482AF */  sw         $v0, %gp_rel(Night_gNightTbl)($gp)
    /* CC6D0 800DBED0 376E030C */  jal        Night_InitPlayerHeadLightColor__Fi
    /* CC6D4 800DBED4 21200000 */   addu      $a0, $zero, $zero
    /* CC6D8 800DBED8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CC6DC 800DBEDC EC315024 */  addiu      $s0, $v0, %lo(GameSetup_gData)
    /* CC6E0 800DBEE0 1400028E */  lw         $v0, 0x14($s0)
    /* CC6E4 800DBEE4 00000000 */  nop
    /* CC6E8 800DBEE8 03004010 */  beqz       $v0, .L800DBEF8
    /* CC6EC 800DBEEC 00000000 */   nop
    /* CC6F0 800DBEF0 5D6E030C */  jal        Night_InitCopLightColors__Fv
    /* CC6F4 800DBEF4 00000000 */   nop
  .L800DBEF8:
    /* CC6F8 800DBEF8 4800028E */  lw         $v0, 0x48($s0)
    /* CC6FC 800DBEFC 01001124 */  addiu      $s1, $zero, 0x1
    /* CC700 800DBF00 03005114 */  bne        $v0, $s1, .L800DBF10
    /* CC704 800DBF04 00000000 */   nop
    /* CC708 800DBF08 946E030C */  jal        Night_InitWeatherTables__Fv
    /* CC70C 800DBF0C 00000000 */   nop
  .L800DBF10:
    /* CC710 800DBF10 D46E030C */  jal        Night_GenerateAllLightTables__Fv
    /* CC714 800DBF14 00000000 */   nop
    /* CC718 800DBF18 4800028E */  lw         $v0, 0x48($s0)
    /* CC71C 800DBF1C 00000000 */  nop
    /* CC720 800DBF20 12005114 */  bne        $v0, $s1, .L800DBF6C
    /* CC724 800DBF24 00000000 */   nop
    /* CC728 800DBF28 181580AF */  sw         $zero, %gp_rel(Night_gLightning)($gp)
    /* CC72C 800DBF2C EA9D030C */  jal        random
    /* CC730 800DBF30 00000000 */   nop
    /* CC734 800DBF34 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* CC738 800DBF38 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* CC73C 800DBF3C FF014230 */  andi       $v0, $v0, 0x1FF
    /* CC740 800DBF40 21186200 */  addu       $v1, $v1, $v0
    /* CC744 800DBF44 1C1583AF */  sw         $v1, %gp_rel(Night_gNextLightning)($gp)
    /* CC748 800DBF48 EA9D030C */  jal        random
    /* CC74C 800DBF4C 00000000 */   nop
    /* CC750 800DBF50 1C15838F */  lw         $v1, %gp_rel(Night_gNextLightning)($gp)
    /* CC754 800DBF54 31004230 */  andi       $v0, $v0, 0x31
    /* CC758 800DBF58 21106200 */  addu       $v0, $v1, $v0
    /* CC75C 800DBF5C 201582AF */  sw         $v0, %gp_rel(Night_gEndNextLightning)($gp)
    /* CC760 800DBF60 241583AF */  sw         $v1, %gp_rel(Night_gNextFlicker)($gp)
    /* CC764 800DBF64 F240030C */  jal        Hrz_CalculateLightning__Fv
    /* CC768 800DBF68 00000000 */   nop
  .L800DBF6C:
    /* CC76C 800DBF6C 1801BF8F */  lw         $ra, 0x118($sp)
    /* CC770 800DBF70 1401B18F */  lw         $s1, 0x114($sp)
    /* CC774 800DBF74 1001B08F */  lw         $s0, 0x110($sp)
    /* CC778 800DBF78 0800E003 */  jr         $ra
    /* CC77C 800DBF7C 2001BD27 */   addiu     $sp, $sp, 0x120
endlabel Night_InitNightDriving__Fv
