.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawOneSong__18tInsideBoxSongMenussssss, 0x22C

glabel DrawOneSong__18tInsideBoxSongMenussssss
    /* F448 8001EC48 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* F44C 8001EC4C 3000B4AF */  sw         $s4, 0x30($sp)
    /* F450 8001EC50 21A0A000 */  addu       $s4, $a1, $zero
    /* F454 8001EC54 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* F458 8001EC58 2198C000 */  addu       $s3, $a2, $zero
    /* F45C 8001EC5C 2800B2AF */  sw         $s2, 0x28($sp)
    /* F460 8001EC60 2190E000 */  addu       $s2, $a3, $zero
    /* F464 8001EC64 3400B5AF */  sw         $s5, 0x34($sp)
    /* F468 8001EC68 5000B58F */  lw         $s5, 0x50($sp)
    /* F46C 8001EC6C 5500043C */  lui        $a0, (0x551E00 >> 16)
    /* F470 8001EC70 2400B1AF */  sw         $s1, 0x24($sp)
    /* F474 8001EC74 5400B18F */  lw         $s1, 0x54($sp)
    /* F478 8001EC78 001E8434 */  ori        $a0, $a0, (0x551E00 & 0xFFFF)
    /* F47C 8001EC7C 2000B0AF */  sw         $s0, 0x20($sp)
    /* F480 8001EC80 5800B08F */  lw         $s0, 0x58($sp)
    /* F484 8001EC84 28000524 */  addiu      $a1, $zero, 0x28
    /* F488 8001EC88 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* F48C 8001EC8C 222E010C */  jal        CalcFadeVal__Fii
    /* F490 8001EC90 3800B6AF */   sw        $s6, 0x38($sp)
    /* F494 8001EC94 06000424 */  addiu      $a0, $zero, 0x6
    /* F498 8001EC98 21380000 */  addu       $a3, $zero, $zero
    /* F49C 8001EC9C 1800A327 */  addiu      $v1, $sp, 0x18
    /* F4A0 8001ECA0 1000A3AF */  sw         $v1, 0x10($sp)
    /* F4A4 8001ECA4 1C00A327 */  addiu      $v1, $sp, 0x1C
    /* F4A8 8001ECA8 21B04000 */  addu       $s6, $v0, $zero
    /* F4AC 8001ECAC 1400A3AF */  sw         $v1, 0x14($sp)
    /* F4B0 8001ECB0 008C1100 */  sll        $s1, $s1, 16
    /* F4B4 8001ECB4 032C1100 */  sra        $a1, $s1, 16
    /* F4B8 8001ECB8 00841000 */  sll        $s0, $s0, 16
    /* F4BC 8001ECBC 03841000 */  sra        $s0, $s0, 16
    /* F4C0 8001ECC0 752E010C */  jal        CalcOnOffFade__F13tMenuTextTypesssRiT4
    /* F4C4 8001ECC4 21300002 */   addu      $a2, $s0, $zero
    /* F4C8 8001ECC8 06000424 */  addiu      $a0, $zero, 0x6
    /* F4CC 8001ECCC 21280002 */  addu       $a1, $s0, $zero
    /* F4D0 8001ECD0 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* F4D4 8001ECD4 21300000 */   addu      $a2, $zero, $zero
    /* F4D8 8001ECD8 03006526 */  addiu      $a1, $s3, 0x3
    /* F4DC 8001ECDC 002C0500 */  sll        $a1, $a1, 16
    /* F4E0 8001ECE0 032C0500 */  sra        $a1, $a1, 16
    /* F4E4 8001ECE4 0580113C */  lui        $s1, %hi(screenAudio)
    /* F4E8 8001ECE8 02004626 */  addiu      $a2, $s2, 0x2
    /* F4EC 8001ECEC 00340600 */  sll        $a2, $a2, 16
    /* F4F0 8001ECF0 03340600 */  sra        $a2, $a2, 16
    /* F4F4 8001ECF4 00A41400 */  sll        $s4, $s4, 16
    /* F4F8 8001ECF8 E828238E */  lw         $v1, %lo(screenAudio)($s1)
    /* F4FC 8001ECFC 83A21400 */  sra        $s4, $s4, 10
    /* F500 8001ED00 7800638C */  lw         $v1, 0x78($v1)
    /* F504 8001ED04 21804000 */  addu       $s0, $v0, $zero
    /* F508 8001ED08 1000A0AF */  sw         $zero, 0x10($sp)
    /* F50C 8001ED0C 1400A0AF */  sw         $zero, 0x14($sp)
    /* F510 8001ED10 21187400 */  addu       $v1, $v1, $s4
    /* F514 8001ED14 0C00648C */  lw         $a0, 0xC($v1)
    /* F518 8001ED18 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* F51C 8001ED1C 21380002 */   addu      $a3, $s0, $zero
    /* F520 8001ED20 02006526 */  addiu      $a1, $s3, 0x2
    /* F524 8001ED24 002C0500 */  sll        $a1, $a1, 16
    /* F528 8001ED28 032C0500 */  sra        $a1, $a1, 16
    /* F52C 8001ED2C 0A004626 */  addiu      $a2, $s2, 0xA
    /* F530 8001ED30 E828228E */  lw         $v0, %lo(screenAudio)($s1)
    /* F534 8001ED34 00340600 */  sll        $a2, $a2, 16
    /* F538 8001ED38 7800428C */  lw         $v0, 0x78($v0)
    /* F53C 8001ED3C 03340600 */  sra        $a2, $a2, 16
    /* F540 8001ED40 1000A0AF */  sw         $zero, 0x10($sp)
    /* F544 8001ED44 1400A0AF */  sw         $zero, 0x14($sp)
    /* F548 8001ED48 21105400 */  addu       $v0, $v0, $s4
    /* F54C 8001ED4C 1000448C */  lw         $a0, 0x10($v0)
    /* F550 8001ED50 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* F554 8001ED54 21380002 */   addu      $a3, $s0, $zero
    /* F558 8001ED58 94E4020C */  jal        TextSys_Word__Fi
    /* F55C 8001ED5C 66000424 */   addiu     $a0, $zero, 0x66
    /* F560 8001ED60 21204000 */  addu       $a0, $v0, $zero
    /* F564 8001ED64 21887502 */  addu       $s1, $s3, $s5
    /* F568 8001ED68 A6FF2526 */  addiu      $a1, $s1, -0x5A
    /* F56C 8001ED6C 002C0500 */  sll        $a1, $a1, 16
    /* F570 8001ED70 032C0500 */  sra        $a1, $a1, 16
    /* F574 8001ED74 06005026 */  addiu      $s0, $s2, 0x6
    /* F578 8001ED78 00841000 */  sll        $s0, $s0, 16
    /* F57C 8001ED7C 03841000 */  sra        $s0, $s0, 16
    /* F580 8001ED80 21300002 */  addu       $a2, $s0, $zero
    /* F584 8001ED84 1800A78F */  lw         $a3, 0x18($sp)
    /* F588 8001ED88 02001424 */  addiu      $s4, $zero, 0x2
    /* F58C 8001ED8C 1000A0AF */  sw         $zero, 0x10($sp)
    /* F590 8001ED90 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* F594 8001ED94 1400B4AF */   sw        $s4, 0x14($sp)
    /* F598 8001ED98 94E4020C */  jal        TextSys_Word__Fi
    /* F59C 8001ED9C 67000424 */   addiu     $a0, $zero, 0x67
    /* F5A0 8001EDA0 21204000 */  addu       $a0, $v0, $zero
    /* F5A4 8001EDA4 E2FF3126 */  addiu      $s1, $s1, -0x1E
    /* F5A8 8001EDA8 008C1100 */  sll        $s1, $s1, 16
    /* F5AC 8001EDAC 032C1100 */  sra        $a1, $s1, 16
    /* F5B0 8001EDB0 1C00A78F */  lw         $a3, 0x1C($sp)
    /* F5B4 8001EDB4 21300002 */  addu       $a2, $s0, $zero
    /* F5B8 8001EDB8 1000A0AF */  sw         $zero, 0x10($sp)
    /* F5BC 8001EDBC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* F5C0 8001EDC0 1400B4AF */   sw        $s4, 0x14($sp)
    /* F5C4 8001EDC4 2120C002 */  addu       $a0, $s6, $zero
    /* F5C8 8001EDC8 009C1300 */  sll        $s3, $s3, 16
    /* F5CC 8001EDCC 039C1300 */  sra        $s3, $s3, 16
    /* F5D0 8001EDD0 00AC1500 */  sll        $s5, $s5, 16
    /* F5D4 8001EDD4 03AC1500 */  sra        $s5, $s5, 16
    /* F5D8 8001EDD8 21887502 */  addu       $s1, $s3, $s5
    /* F5DC 8001EDDC 88FF2526 */  addiu      $a1, $s1, -0x78
    /* F5E0 8001EDE0 00941200 */  sll        $s2, $s2, 16
    /* F5E4 8001EDE4 03941200 */  sra        $s2, $s2, 16
    /* F5E8 8001EDE8 21304002 */  addu       $a2, $s2, $zero
    /* F5EC 8001EDEC 21388002 */  addu       $a3, $s4, $zero
    /* F5F0 8001EDF0 13001024 */  addiu      $s0, $zero, 0x13
    /* F5F4 8001EDF4 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* F5F8 8001EDF8 1000B0AF */   sw        $s0, 0x10($sp)
    /* F5FC 8001EDFC 2120C002 */  addu       $a0, $s6, $zero
    /* F600 8001EE00 C4FF2526 */  addiu      $a1, $s1, -0x3C
    /* F604 8001EE04 21304002 */  addu       $a2, $s2, $zero
    /* F608 8001EE08 21388002 */  addu       $a3, $s4, $zero
    /* F60C 8001EE0C 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* F610 8001EE10 1000B0AF */   sw        $s0, 0x10($sp)
    /* F614 8001EE14 2120C002 */  addu       $a0, $s6, $zero
    /* F618 8001EE18 21286002 */  addu       $a1, $s3, $zero
    /* F61C 8001EE1C 21304002 */  addu       $a2, $s2, $zero
    /* F620 8001EE20 2138A002 */  addu       $a3, $s5, $zero
    /* F624 8001EE24 01000224 */  addiu      $v0, $zero, 0x1
    /* F628 8001EE28 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* F62C 8001EE2C 1000A2AF */   sw        $v0, 0x10($sp)
    /* F630 8001EE30 2120C002 */  addu       $a0, $s6, $zero
    /* F634 8001EE34 21286002 */  addu       $a1, $s3, $zero
    /* F638 8001EE38 21305002 */  addu       $a2, $s2, $s0
    /* F63C 8001EE3C 2138A002 */  addu       $a3, $s5, $zero
    /* F640 8001EE40 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F644 8001EE44 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* F648 8001EE48 1000A2AF */   sw        $v0, 0x10($sp)
    /* F64C 8001EE4C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* F650 8001EE50 3800B68F */  lw         $s6, 0x38($sp)
    /* F654 8001EE54 3400B58F */  lw         $s5, 0x34($sp)
    /* F658 8001EE58 3000B48F */  lw         $s4, 0x30($sp)
    /* F65C 8001EE5C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* F660 8001EE60 2800B28F */  lw         $s2, 0x28($sp)
    /* F664 8001EE64 2400B18F */  lw         $s1, 0x24($sp)
    /* F668 8001EE68 2000B08F */  lw         $s0, 0x20($sp)
    /* F66C 8001EE6C 0800E003 */  jr         $ra
    /* F670 8001EE70 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel DrawOneSong__18tInsideBoxSongMenussssss
