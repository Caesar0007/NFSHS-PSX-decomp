.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GenericPMX_LoadTexture__Fv, 0x944

glabel GenericPMX_LoadTexture__Fv
    /* 8BC58 8009B458 B0FEBD27 */  addiu      $sp, $sp, -0x150
    /* 8BC5C 8009B45C 3C01B5AF */  sw         $s5, 0x13C($sp)
    /* 8BC60 8009B460 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8BC64 8009B464 EC314424 */  addiu      $a0, $v0, %lo(GameSetup_gData)
    /* 8BC68 8009B468 4C01BFAF */  sw         $ra, 0x14C($sp)
    /* 8BC6C 8009B46C 4801BEAF */  sw         $fp, 0x148($sp)
    /* 8BC70 8009B470 4401B7AF */  sw         $s7, 0x144($sp)
    /* 8BC74 8009B474 4001B6AF */  sw         $s6, 0x140($sp)
    /* 8BC78 8009B478 3801B4AF */  sw         $s4, 0x138($sp)
    /* 8BC7C 8009B47C 3401B3AF */  sw         $s3, 0x134($sp)
    /* 8BC80 8009B480 3001B2AF */  sw         $s2, 0x130($sp)
    /* 8BC84 8009B484 2C01B1AF */  sw         $s1, 0x12C($sp)
    /* 8BC88 8009B488 2801B0AF */  sw         $s0, 0x128($sp)
    /* 8BC8C 8009B48C 3C00828C */  lw         $v0, 0x3C($a0)
    /* 8BC90 8009B490 04000324 */  addiu      $v1, $zero, 0x4
    /* 8BC94 8009B494 0F004230 */  andi       $v0, $v0, 0xF
    /* 8BC98 8009B498 0F004314 */  bne        $v0, $v1, .L8009B4D8
    /* 8BC9C 8009B49C 21A80000 */   addu      $s5, $zero, $zero
    /* 8BCA0 8009B4A0 4800828C */  lw         $v0, 0x48($a0)
    /* 8BCA4 8009B4A4 00000000 */  nop
    /* 8BCA8 8009B4A8 06004010 */  beqz       $v0, .L8009B4C4
    /* 8BCAC 8009B4AC 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8BCB0 8009B4B0 1180023C */  lui        $v0, %hi(D_801164CC)
    /* 8BCB4 8009B4B4 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* 8BCB8 8009B4B8 0580053C */  lui        $a1, %hi(D_80055F94)
    /* 8BCBC 8009B4BC 3B6D0208 */  j          .L8009B4EC
    /* 8BCC0 8009B4C0 945FA524 */   addiu     $a1, $a1, %lo(D_80055F94)
  .L8009B4C4:
    /* 8BCC4 8009B4C4 1180023C */  lui        $v0, %hi(D_801164CC)
    /* 8BCC8 8009B4C8 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* 8BCCC 8009B4CC 0580053C */  lui        $a1, %hi(D_80055FA0)
    /* 8BCD0 8009B4D0 3B6D0208 */  j          .L8009B4EC
    /* 8BCD4 8009B4D4 A05FA524 */   addiu     $a1, $a1, %lo(D_80055FA0)
  .L8009B4D8:
    /* 8BCD8 8009B4D8 2000A427 */  addiu      $a0, $sp, 0x20
    /* 8BCDC 8009B4DC 1180023C */  lui        $v0, %hi(D_801164CC)
    /* 8BCE0 8009B4E0 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* 8BCE4 8009B4E4 0580053C */  lui        $a1, %hi(D_80055FAC)
    /* 8BCE8 8009B4E8 AC5FA524 */  addiu      $a1, $a1, %lo(D_80055FAC)
  .L8009B4EC:
    /* 8BCEC 8009B4EC 2F91030C */  jal        sprintf
    /* 8BCF0 8009B4F0 21B80000 */   addu      $s7, $zero, $zero
    /* 8BCF4 8009B4F4 2000A427 */  addiu      $a0, $sp, 0x20
    /* 8BCF8 8009B4F8 FA95030C */  jal        loadfileadr
    /* 8BCFC 8009B4FC 21280000 */   addu      $a1, $zero, $zero
    /* 8BD00 8009B500 9E7D030C */  jal        Texture_ResetPaletteSharing__Fv
    /* 8BD04 8009B504 21B04000 */   addu      $s6, $v0, $zero
    /* 8BD08 8009B508 2190E002 */  addu       $s2, $s7, $zero
    /* 8BD0C 8009B50C 1180023C */  lui        $v0, %hi(gPixmaps)
    /* 8BD10 8009B510 D42B5424 */  addiu      $s4, $v0, %lo(gPixmaps)
    /* 8BD14 8009B514 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 8BD18 8009B518 1180023C */  lui        $v0, %hi(gDLPixmap)
    /* 8BD1C 8009B51C 2C2B5124 */  addiu      $s1, $v0, %lo(gDLPixmap)
  .L8009B520:
    /* 8BD20 8009B520 0A00422A */  slti       $v0, $s2, 0xA
    /* 8BD24 8009B524 16004010 */  beqz       $v0, .L8009B580
    /* 8BD28 8009B528 1480053C */   lui       $a1, %hi(D_8013D10C)
    /* 8BD2C 8009B52C 2000A427 */  addiu      $a0, $sp, 0x20
    /* 8BD30 8009B530 0CD1A524 */  addiu      $a1, $a1, %lo(D_8013D10C)
    /* 8BD34 8009B534 2F91030C */  jal        sprintf
    /* 8BD38 8009B538 21304002 */   addu      $a2, $s2, $zero
    /* 8BD3C 8009B53C 00811500 */  sll        $s0, $s5, 4
    /* 8BD40 8009B540 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BD44 8009B544 2120C002 */  addu       $a0, $s6, $zero
    /* 8BD48 8009B548 2000A527 */  addiu      $a1, $sp, 0x20
    /* 8BD4C 8009B54C 4000E636 */  ori        $a2, $s7, 0x40
    /* 8BD50 8009B550 21380000 */  addu       $a3, $zero, $zero
    /* 8BD54 8009B554 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BD58 8009B558 21801402 */  addu       $s0, $s0, $s4
    /* 8BD5C 8009B55C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BD60 8009B560 1400B3AF */  sw         $s3, 0x14($sp)
    /* 8BD64 8009B564 1800B3AF */  sw         $s3, 0x18($sp)
    /* 8BD68 8009B568 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BD6C 8009B56C 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8BD70 8009B570 000030AE */  sw         $s0, 0x0($s1)
    /* 8BD74 8009B574 04003126 */  addiu      $s1, $s1, 0x4
    /* 8BD78 8009B578 486D0208 */  j          .L8009B520
    /* 8BD7C 8009B57C 01005226 */   addiu     $s2, $s2, 0x1
  .L8009B580:
    /* 8BD80 8009B580 00891500 */  sll        $s1, $s5, 4
    /* 8BD84 8009B584 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BD88 8009B588 2120C002 */  addu       $a0, $s6, $zero
    /* 8BD8C 8009B58C 1480053C */  lui        $a1, %hi(D_8013D114)
    /* 8BD90 8009B590 14D1A524 */  addiu      $a1, $a1, %lo(D_8013D114)
    /* 8BD94 8009B594 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BD98 8009B598 21380000 */  addu       $a3, $zero, $zero
    /* 8BD9C 8009B59C A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BDA0 8009B5A0 FFFF1424 */  addiu      $s4, $zero, -0x1
    /* 8BDA4 8009B5A4 1180023C */  lui        $v0, %hi(gPixmaps)
    /* 8BDA8 8009B5A8 D42B5724 */  addiu      $s7, $v0, %lo(gPixmaps)
    /* 8BDAC 8009B5AC 21883702 */  addu       $s1, $s1, $s7
    /* 8BDB0 8009B5B0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BDB4 8009B5B4 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BDB8 8009B5B8 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BDBC 8009B5BC C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BDC0 8009B5C0 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8BDC4 8009B5C4 00811500 */  sll        $s0, $s5, 4
    /* 8BDC8 8009B5C8 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BDCC 8009B5CC 2120C002 */  addu       $a0, $s6, $zero
    /* 8BDD0 8009B5D0 1480053C */  lui        $a1, %hi(D_8013D11C)
    /* 8BDD4 8009B5D4 1CD1A524 */  addiu      $a1, $a1, %lo(D_8013D11C)
    /* 8BDD8 8009B5D8 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BDDC 8009B5DC 21380000 */  addu       $a3, $zero, $zero
    /* 8BDE0 8009B5E0 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BDE4 8009B5E4 21801702 */  addu       $s0, $s0, $s7
    /* 8BDE8 8009B5E8 940C91AF */  sw         $s1, %gp_rel(gSpikeBeltPixmap)($gp)
    /* 8BDEC 8009B5EC 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BDF0 8009B5F0 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BDF4 8009B5F4 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BDF8 8009B5F8 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BDFC 8009B5FC 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8BE00 8009B600 00891500 */  sll        $s1, $s5, 4
    /* 8BE04 8009B604 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BE08 8009B608 2120C002 */  addu       $a0, $s6, $zero
    /* 8BE0C 8009B60C 1480053C */  lui        $a1, %hi(D_8013D124)
    /* 8BE10 8009B610 24D1A524 */  addiu      $a1, $a1, %lo(D_8013D124)
    /* 8BE14 8009B614 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BE18 8009B618 21380000 */  addu       $a3, $zero, $zero
    /* 8BE1C 8009B61C A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BE20 8009B620 21883702 */  addu       $s1, $s1, $s7
    /* 8BE24 8009B624 900C90AF */  sw         $s0, %gp_rel(gDPixmap)($gp)
    /* 8BE28 8009B628 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BE2C 8009B62C 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BE30 8009B630 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BE34 8009B634 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BE38 8009B638 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8BE3C 8009B63C 00811500 */  sll        $s0, $s5, 4
    /* 8BE40 8009B640 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BE44 8009B644 2120C002 */  addu       $a0, $s6, $zero
    /* 8BE48 8009B648 1480053C */  lui        $a1, %hi(D_8013D12C)
    /* 8BE4C 8009B64C 2CD1A524 */  addiu      $a1, $a1, %lo(D_8013D12C)
    /* 8BE50 8009B650 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BE54 8009B654 21380000 */  addu       $a3, $zero, $zero
    /* 8BE58 8009B658 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BE5C 8009B65C 21801702 */  addu       $s0, $s0, $s7
    /* 8BE60 8009B660 980C91AF */  sw         $s1, %gp_rel(gShadowPixmap)($gp)
    /* 8BE64 8009B664 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BE68 8009B668 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BE6C 8009B66C 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BE70 8009B670 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BE74 8009B674 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8BE78 8009B678 2120C002 */  addu       $a0, $s6, $zero
    /* 8BE7C 8009B67C 1480053C */  lui        $a1, %hi(D_8013D134)
    /* 8BE80 8009B680 34D1A524 */  addiu      $a1, $a1, %lo(D_8013D134)
    /* 8BE84 8009B684 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BE88 8009B688 21380000 */  addu       $a3, $zero, $zero
    /* 8BE8C 8009B68C A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BE90 8009B690 A00C90AF */  sw         $s0, %gp_rel(gSkidMarkPixmap)($gp)
    /* 8BE94 8009B694 00811500 */  sll        $s0, $s5, 4
    /* 8BE98 8009B698 21801702 */  addu       $s0, $s0, $s7
    /* 8BE9C 8009B69C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BEA0 8009B6A0 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BEA4 8009B6A4 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BEA8 8009B6A8 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BEAC 8009B6AC 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8BEB0 8009B6B0 A00C848F */  lw         $a0, %gp_rel(gSkidMarkPixmap)($gp)
    /* 8BEB4 8009B6B4 02000524 */  addiu      $a1, $zero, 0x2
    /* 8BEB8 8009B6B8 A40C90AF */  sw         $s0, %gp_rel(D_8013D1F0)($gp)
    /* 8BEBC 8009B6BC B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8BEC0 8009B6C0 06008424 */   addiu     $a0, $a0, 0x6
    /* 8BEC4 8009B6C4 A40C848F */  lw         $a0, %gp_rel(D_8013D1F0)($gp)
    /* 8BEC8 8009B6C8 02000524 */  addiu      $a1, $zero, 0x2
    /* 8BECC 8009B6CC B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8BED0 8009B6D0 06008424 */   addiu     $a0, $a0, 0x6
    /* 8BED4 8009B6D4 1180023C */  lui        $v0, %hi(D_80113234)
    /* 8BED8 8009B6D8 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* 8BEDC 8009B6DC 00000000 */  nop
    /* 8BEE0 8009B6E0 3C004010 */  beqz       $v0, .L8009B7D4
    /* 8BEE4 8009B6E4 0100B526 */   addiu     $s5, $s5, 0x1
    /* 8BEE8 8009B6E8 00811500 */  sll        $s0, $s5, 4
    /* 8BEEC 8009B6EC 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BEF0 8009B6F0 2120C002 */  addu       $a0, $s6, $zero
    /* 8BEF4 8009B6F4 1480053C */  lui        $a1, %hi(D_8013D13C)
    /* 8BEF8 8009B6F8 3CD1A524 */  addiu      $a1, $a1, %lo(D_8013D13C)
    /* 8BEFC 8009B6FC 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BF00 8009B700 21380000 */  addu       $a3, $zero, $zero
    /* 8BF04 8009B704 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BF08 8009B708 21801702 */  addu       $s0, $s0, $s7
    /* 8BF0C 8009B70C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BF10 8009B710 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BF14 8009B714 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BF18 8009B718 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BF1C 8009B71C 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8BF20 8009B720 00911500 */  sll        $s2, $s5, 4
    /* 8BF24 8009B724 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BF28 8009B728 2120C002 */  addu       $a0, $s6, $zero
    /* 8BF2C 8009B72C 1480053C */  lui        $a1, %hi(D_8013D144)
    /* 8BF30 8009B730 44D1A524 */  addiu      $a1, $a1, %lo(D_8013D144)
    /* 8BF34 8009B734 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BF38 8009B738 21380000 */  addu       $a3, $zero, $zero
    /* 8BF3C 8009B73C 1180133C */  lui        $s3, %hi(gWeatherPixmap)
    /* 8BF40 8009B740 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BF44 8009B744 21905702 */  addu       $s2, $s2, $s7
    /* 8BF48 8009B748 7C2B70AE */  sw         $s0, %lo(gWeatherPixmap)($s3)
    /* 8BF4C 8009B74C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BF50 8009B750 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BF54 8009B754 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BF58 8009B758 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BF5C 8009B75C 1C00B2AF */   sw        $s2, 0x1C($sp)
    /* 8BF60 8009B760 00811500 */  sll        $s0, $s5, 4
    /* 8BF64 8009B764 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BF68 8009B768 2120C002 */  addu       $a0, $s6, $zero
    /* 8BF6C 8009B76C 1480053C */  lui        $a1, %hi(D_8013D14C)
    /* 8BF70 8009B770 4CD1A524 */  addiu      $a1, $a1, %lo(D_8013D14C)
    /* 8BF74 8009B774 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BF78 8009B778 21380000 */  addu       $a3, $zero, $zero
    /* 8BF7C 8009B77C 7C2B7126 */  addiu      $s1, $s3, %lo(gWeatherPixmap)
    /* 8BF80 8009B780 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BF84 8009B784 21801702 */  addu       $s0, $s0, $s7
    /* 8BF88 8009B788 040032AE */  sw         $s2, 0x4($s1)
    /* 8BF8C 8009B78C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BF90 8009B790 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8BF94 8009B794 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8BF98 8009B798 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8BF9C 8009B79C 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8BFA0 8009B7A0 7C2B648E */  lw         $a0, %lo(gWeatherPixmap)($s3)
    /* 8BFA4 8009B7A4 01000524 */  addiu      $a1, $zero, 0x1
    /* 8BFA8 8009B7A8 080030AE */  sw         $s0, 0x8($s1)
    /* 8BFAC 8009B7AC B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8BFB0 8009B7B0 06008424 */   addiu     $a0, $a0, 0x6
    /* 8BFB4 8009B7B4 0400248E */  lw         $a0, 0x4($s1)
    /* 8BFB8 8009B7B8 01000524 */  addiu      $a1, $zero, 0x1
    /* 8BFBC 8009B7BC B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8BFC0 8009B7C0 06008424 */   addiu     $a0, $a0, 0x6
    /* 8BFC4 8009B7C4 0800248E */  lw         $a0, 0x8($s1)
    /* 8BFC8 8009B7C8 01000524 */  addiu      $a1, $zero, 0x1
    /* 8BFCC 8009B7CC B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8BFD0 8009B7D0 06008424 */   addiu     $a0, $a0, 0x6
  .L8009B7D4:
    /* 8BFD4 8009B7D4 00811500 */  sll        $s0, $s5, 4
    /* 8BFD8 8009B7D8 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8BFDC 8009B7DC 2120C002 */  addu       $a0, $s6, $zero
    /* 8BFE0 8009B7E0 1480053C */  lui        $a1, %hi(D_8013D154)
    /* 8BFE4 8009B7E4 54D1A524 */  addiu      $a1, $a1, %lo(D_8013D154)
    /* 8BFE8 8009B7E8 40000624 */  addiu      $a2, $zero, 0x40
    /* 8BFEC 8009B7EC 21380000 */  addu       $a3, $zero, $zero
    /* 8BFF0 8009B7F0 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8BFF4 8009B7F4 21801702 */  addu       $s0, $s0, $s7
    /* 8BFF8 8009B7F8 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8BFFC 8009B7FC 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C000 8009B800 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C004 8009B804 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C008 8009B808 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C00C 8009B80C 00891500 */  sll        $s1, $s5, 4
    /* 8C010 8009B810 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C014 8009B814 2120C002 */  addu       $a0, $s6, $zero
    /* 8C018 8009B818 1480053C */  lui        $a1, %hi(D_8013D15C)
    /* 8C01C 8009B81C 5CD1A524 */  addiu      $a1, $a1, %lo(D_8013D15C)
    /* 8C020 8009B820 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C024 8009B824 21380000 */  addu       $a3, $zero, $zero
    /* 8C028 8009B828 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C02C 8009B82C 21883702 */  addu       $s1, $s1, $s7
    /* 8C030 8009B830 A80C90AF */  sw         $s0, %gp_rel(gSMokePixmap)($gp)
    /* 8C034 8009B834 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C038 8009B838 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C03C 8009B83C 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C040 8009B840 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C044 8009B844 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8C048 8009B848 00811500 */  sll        $s0, $s5, 4
    /* 8C04C 8009B84C 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C050 8009B850 2120C002 */  addu       $a0, $s6, $zero
    /* 8C054 8009B854 1480053C */  lui        $a1, %hi(D_8013D164)
    /* 8C058 8009B858 64D1A524 */  addiu      $a1, $a1, %lo(D_8013D164)
    /* 8C05C 8009B85C 21300000 */  addu       $a2, $zero, $zero
    /* 8C060 8009B860 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 8C064 8009B864 21801702 */  addu       $s0, $s0, $s7
    /* 8C068 8009B868 AC0C91AF */  sw         $s1, %gp_rel(D_8013D1F8)($gp)
    /* 8C06C 8009B86C 1000B4AF */  sw         $s4, 0x10($sp)
    /* 8C070 8009B870 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C074 8009B874 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C078 8009B878 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C07C 8009B87C 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C080 8009B880 00891500 */  sll        $s1, $s5, 4
    /* 8C084 8009B884 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C088 8009B888 2120C002 */  addu       $a0, $s6, $zero
    /* 8C08C 8009B88C 1480053C */  lui        $a1, %hi(D_8013D16C)
    /* 8C090 8009B890 6CD1A524 */  addiu      $a1, $a1, %lo(D_8013D16C)
    /* 8C094 8009B894 21300000 */  addu       $a2, $zero, $zero
    /* 8C098 8009B898 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 8C09C 8009B89C 21883702 */  addu       $s1, $s1, $s7
    /* 8C0A0 8009B8A0 B00C90AF */  sw         $s0, %gp_rel(gSMokePalette)($gp)
    /* 8C0A4 8009B8A4 1000B4AF */  sw         $s4, 0x10($sp)
    /* 8C0A8 8009B8A8 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C0AC 8009B8AC 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C0B0 8009B8B0 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C0B4 8009B8B4 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8C0B8 8009B8B8 00811500 */  sll        $s0, $s5, 4
    /* 8C0BC 8009B8BC 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C0C0 8009B8C0 2120C002 */  addu       $a0, $s6, $zero
    /* 8C0C4 8009B8C4 1480053C */  lui        $a1, %hi(D_8013D174)
    /* 8C0C8 8009B8C8 74D1A524 */  addiu      $a1, $a1, %lo(D_8013D174)
    /* 8C0CC 8009B8CC 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C0D0 8009B8D0 21380000 */  addu       $a3, $zero, $zero
    /* 8C0D4 8009B8D4 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C0D8 8009B8D8 21801702 */  addu       $s0, $s0, $s7
    /* 8C0DC 8009B8DC B40C91AF */  sw         $s1, %gp_rel(gDirtPalette)($gp)
    /* 8C0E0 8009B8E0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C0E4 8009B8E4 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C0E8 8009B8E8 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C0EC 8009B8EC C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C0F0 8009B8F0 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C0F4 8009B8F4 00891500 */  sll        $s1, $s5, 4
    /* 8C0F8 8009B8F8 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C0FC 8009B8FC 2120C002 */  addu       $a0, $s6, $zero
    /* 8C100 8009B900 1480053C */  lui        $a1, %hi(D_8013D17C)
    /* 8C104 8009B904 7CD1A524 */  addiu      $a1, $a1, %lo(D_8013D17C)
    /* 8C108 8009B908 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C10C 8009B90C 21380000 */  addu       $a3, $zero, $zero
    /* 8C110 8009B910 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C114 8009B914 21883702 */  addu       $s1, $s1, $s7
    /* 8C118 8009B918 B80C90AF */  sw         $s0, %gp_rel(gGravelPixmap)($gp)
    /* 8C11C 8009B91C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C120 8009B920 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C124 8009B924 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C128 8009B928 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C12C 8009B92C 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8C130 8009B930 00811500 */  sll        $s0, $s5, 4
    /* 8C134 8009B934 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C138 8009B938 2120C002 */  addu       $a0, $s6, $zero
    /* 8C13C 8009B93C 1480053C */  lui        $a1, %hi(D_8013D184)
    /* 8C140 8009B940 84D1A524 */  addiu      $a1, $a1, %lo(D_8013D184)
    /* 8C144 8009B944 21300000 */  addu       $a2, $zero, $zero
    /* 8C148 8009B948 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 8C14C 8009B94C 21801702 */  addu       $s0, $s0, $s7
    /* 8C150 8009B950 BC0C91AF */  sw         $s1, %gp_rel(D_8013D208)($gp)
    /* 8C154 8009B954 1000B4AF */  sw         $s4, 0x10($sp)
    /* 8C158 8009B958 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C15C 8009B95C 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C160 8009B960 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C164 8009B964 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C168 8009B968 00891500 */  sll        $s1, $s5, 4
    /* 8C16C 8009B96C 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C170 8009B970 2120C002 */  addu       $a0, $s6, $zero
    /* 8C174 8009B974 1480053C */  lui        $a1, %hi(D_8013D18C)
    /* 8C178 8009B978 8CD1A524 */  addiu      $a1, $a1, %lo(D_8013D18C)
    /* 8C17C 8009B97C 21300000 */  addu       $a2, $zero, $zero
    /* 8C180 8009B980 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 8C184 8009B984 21883702 */  addu       $s1, $s1, $s7
    /* 8C188 8009B988 C00C90AF */  sw         $s0, %gp_rel(gGravelPalette)($gp)
    /* 8C18C 8009B98C 1000B4AF */  sw         $s4, 0x10($sp)
    /* 8C190 8009B990 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C194 8009B994 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C198 8009B998 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C19C 8009B99C 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8C1A0 8009B9A0 00811500 */  sll        $s0, $s5, 4
    /* 8C1A4 8009B9A4 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C1A8 8009B9A8 2120C002 */  addu       $a0, $s6, $zero
    /* 8C1AC 8009B9AC 1480053C */  lui        $a1, %hi(D_8013D194)
    /* 8C1B0 8009B9B0 94D1A524 */  addiu      $a1, $a1, %lo(D_8013D194)
    /* 8C1B4 8009B9B4 21300000 */  addu       $a2, $zero, $zero
    /* 8C1B8 8009B9B8 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 8C1BC 8009B9BC 21801702 */  addu       $s0, $s0, $s7
    /* 8C1C0 8009B9C0 C40C91AF */  sw         $s1, %gp_rel(gGrassPalette)($gp)
    /* 8C1C4 8009B9C4 1000B4AF */  sw         $s4, 0x10($sp)
    /* 8C1C8 8009B9C8 1400B4AF */  sw         $s4, 0x14($sp)
    /* 8C1CC 8009B9CC 1800B4AF */  sw         $s4, 0x18($sp)
    /* 8C1D0 8009B9D0 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C1D4 8009B9D4 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C1D8 8009B9D8 21900000 */  addu       $s2, $zero, $zero
    /* 8C1DC 8009B9DC 21A0E002 */  addu       $s4, $s7, $zero
    /* 8C1E0 8009B9E0 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 8C1E4 8009B9E4 1180023C */  lui        $v0, %hi(gSparkHPixmap)
    /* 8C1E8 8009B9E8 542B5124 */  addiu      $s1, $v0, %lo(gSparkHPixmap)
    /* 8C1EC 8009B9EC C80C90AF */  sw         $s0, %gp_rel(gSnowPalette)($gp)
  .L8009B9F0:
    /* 8C1F0 8009B9F0 0600422A */  slti       $v0, $s2, 0x6
    /* 8C1F4 8009B9F4 16004010 */  beqz       $v0, .L8009BA50
    /* 8C1F8 8009B9F8 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8C1FC 8009B9FC 1480053C */  lui        $a1, %hi(D_8013D19C)
    /* 8C200 8009BA00 9CD1A524 */  addiu      $a1, $a1, %lo(D_8013D19C)
    /* 8C204 8009BA04 2F91030C */  jal        sprintf
    /* 8C208 8009BA08 21304002 */   addu      $a2, $s2, $zero
    /* 8C20C 8009BA0C 00811500 */  sll        $s0, $s5, 4
    /* 8C210 8009BA10 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C214 8009BA14 2120C002 */  addu       $a0, $s6, $zero
    /* 8C218 8009BA18 2000A527 */  addiu      $a1, $sp, 0x20
    /* 8C21C 8009BA1C 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C220 8009BA20 21380000 */  addu       $a3, $zero, $zero
    /* 8C224 8009BA24 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C228 8009BA28 21801402 */  addu       $s0, $s0, $s4
    /* 8C22C 8009BA2C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C230 8009BA30 1400B3AF */  sw         $s3, 0x14($sp)
    /* 8C234 8009BA34 1800B3AF */  sw         $s3, 0x18($sp)
    /* 8C238 8009BA38 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C23C 8009BA3C 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C240 8009BA40 000030AE */  sw         $s0, 0x0($s1)
    /* 8C244 8009BA44 04003126 */  addiu      $s1, $s1, 0x4
    /* 8C248 8009BA48 7C6E0208 */  j          .L8009B9F0
    /* 8C24C 8009BA4C 01005226 */   addiu     $s2, $s2, 0x1
  .L8009BA50:
    /* 8C250 8009BA50 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 8C254 8009BA54 EC314524 */  addiu      $a1, $v0, %lo(GameSetup_gData)
    /* 8C258 8009BA58 5400A28C */  lw         $v0, 0x54($a1)
    /* 8C25C 8009BA5C 00000000 */  nop
    /* 8C260 8009BA60 21004014 */  bnez       $v0, .L8009BAE8
    /* 8C264 8009BA64 01000224 */   addiu     $v0, $zero, 0x1
    /* 8C268 8009BA68 0C00A38C */  lw         $v1, 0xC($a1)
    /* 8C26C 8009BA6C 00000000 */  nop
    /* 8C270 8009BA70 1D006210 */  beq        $v1, $v0, .L8009BAE8
    /* 8C274 8009BA74 2001B027 */   addiu     $s0, $sp, 0x120
    /* 8C278 8009BA78 21200002 */  addu       $a0, $s0, $zero
    /* 8C27C 8009BA7C 3C00A68C */  lw         $a2, 0x3C($a1)
    /* 8C280 8009BA80 1480053C */  lui        $a1, %hi(D_8013D1A4)
    /* 8C284 8009BA84 2F91030C */  jal        sprintf
    /* 8C288 8009BA88 A4D1A524 */   addiu     $a1, $a1, %lo(D_8013D1A4)
    /* 8C28C 8009BA8C 2120C002 */  addu       $a0, $s6, $zero
    /* 8C290 8009BA90 5CAC030C */  jal        locateshapez
    /* 8C294 8009BA94 21280002 */   addu      $a1, $s0, $zero
    /* 8C298 8009BA98 13004010 */  beqz       $v0, .L8009BAE8
    /* 8C29C 8009BA9C 00811500 */   sll       $s0, $s5, 4
    /* 8C2A0 8009BAA0 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C2A4 8009BAA4 21200000 */  addu       $a0, $zero, $zero
    /* 8C2A8 8009BAA8 21284000 */  addu       $a1, $v0, $zero
    /* 8C2AC 8009BAAC 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C2B0 8009BAB0 21388000 */  addu       $a3, $a0, $zero
    /* 8C2B4 8009BAB4 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C2B8 8009BAB8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8C2BC 8009BABC 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8C2C0 8009BAC0 1800A2AF */  sw         $v0, 0x18($sp)
    /* 8C2C4 8009BAC4 1180023C */  lui        $v0, %hi(gPixmaps)
    /* 8C2C8 8009BAC8 D42B4224 */  addiu      $v0, $v0, %lo(gPixmaps)
    /* 8C2CC 8009BACC 21800202 */  addu       $s0, $s0, $v0
    /* 8C2D0 8009BAD0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C2D4 8009BAD4 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C2D8 8009BAD8 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C2DC 8009BADC CC0C90AF */  sw         $s0, %gp_rel(gLeafPixmap)($gp)
    /* 8C2E0 8009BAE0 BC6E0208 */  j          .L8009BAF0
    /* 8C2E4 8009BAE4 2120C002 */   addu      $a0, $s6, $zero
  .L8009BAE8:
    /* 8C2E8 8009BAE8 CC0C80AF */  sw         $zero, %gp_rel(gLeafPixmap)($gp)
    /* 8C2EC 8009BAEC 2120C002 */  addu       $a0, $s6, $zero
  .L8009BAF0:
    /* 8C2F0 8009BAF0 1480053C */  lui        $a1, %hi(D_8013D1AC)
    /* 8C2F4 8009BAF4 ACD1A524 */  addiu      $a1, $a1, %lo(D_8013D1AC)
    /* 8C2F8 8009BAF8 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C2FC 8009BAFC 21380000 */  addu       $a3, $zero, $zero
    /* 8C300 8009BB00 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C304 8009BB04 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8C308 8009BB08 00811500 */  sll        $s0, $s5, 4
    /* 8C30C 8009BB0C 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8C310 8009BB10 1800A2AF */  sw         $v0, 0x18($sp)
    /* 8C314 8009BB14 1180023C */  lui        $v0, %hi(gPixmaps)
    /* 8C318 8009BB18 D42B5124 */  addiu      $s1, $v0, %lo(gPixmaps)
    /* 8C31C 8009BB1C 21801102 */  addu       $s0, $s0, $s1
    /* 8C320 8009BB20 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C324 8009BB24 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C328 8009BB28 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C32C 8009BB2C 1180023C */  lui        $v0, %hi(D_80113234)
    /* 8C330 8009BB30 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* 8C334 8009BB34 D00C90AF */  sw         $s0, %gp_rel(gDamagePixmap)($gp)
    /* 8C338 8009BB38 30004010 */  beqz       $v0, .L8009BBFC
    /* 8C33C 8009BB3C 0100B526 */   addiu     $s5, $s5, 0x1
    /* 8C340 8009BB40 21900000 */  addu       $s2, $zero, $zero
    /* 8C344 8009BB44 21F02002 */  addu       $fp, $s1, $zero
    /* 8C348 8009BB48 FFFF1724 */  addiu      $s7, $zero, -0x1
    /* 8C34C 8009BB4C 1180023C */  lui        $v0, %hi(gLightningPixmap)
    /* 8C350 8009BB50 942B5324 */  addiu      $s3, $v0, %lo(gLightningPixmap)
    /* 8C354 8009BB54 20001424 */  addiu      $s4, $zero, 0x20
    /* 8C358 8009BB58 0800422A */  slti       $v0, $s2, 0x8
  .L8009BB5C:
    /* 8C35C 8009BB5C 81004010 */  beqz       $v0, .L8009BD64
    /* 8C360 8009BB60 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8C364 8009BB64 1480053C */  lui        $a1, %hi(D_8013D1B4)
    /* 8C368 8009BB68 B4D1A524 */  addiu      $a1, $a1, %lo(D_8013D1B4)
    /* 8C36C 8009BB6C 2F91030C */  jal        sprintf
    /* 8C370 8009BB70 21304002 */   addu      $a2, $s2, $zero
    /* 8C374 8009BB74 00811500 */  sll        $s0, $s5, 4
    /* 8C378 8009BB78 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C37C 8009BB7C 2120C002 */  addu       $a0, $s6, $zero
    /* 8C380 8009BB80 2000A527 */  addiu      $a1, $sp, 0x20
    /* 8C384 8009BB84 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C388 8009BB88 21380000 */  addu       $a3, $zero, $zero
    /* 8C38C 8009BB8C A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C390 8009BB90 21801E02 */  addu       $s0, $s0, $fp
    /* 8C394 8009BB94 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C398 8009BB98 1400B7AF */  sw         $s7, 0x14($sp)
    /* 8C39C 8009BB9C 1800B7AF */  sw         $s7, 0x18($sp)
    /* 8C3A0 8009BBA0 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C3A4 8009BBA4 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C3A8 8009BBA8 00111500 */  sll        $v0, $s5, 4
    /* 8C3AC 8009BBAC 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C3B0 8009BBB0 01000524 */  addiu      $a1, $zero, 0x1
    /* 8C3B4 8009BBB4 1180083C */  lui        $t0, %hi(gLightningPixmap)
    /* 8C3B8 8009BBB8 942B0825 */  addiu      $t0, $t0, %lo(gLightningPixmap)
    /* 8C3BC 8009BBBC 21888802 */  addu       $s1, $s4, $t0
    /* 8C3C0 8009BBC0 04009426 */  addiu      $s4, $s4, 0x4
    /* 8C3C4 8009BBC4 21105E00 */  addu       $v0, $v0, $fp
    /* 8C3C8 8009BBC8 000070AE */  sw         $s0, 0x0($s3)
    /* 8C3CC 8009BBCC 000022AE */  sw         $v0, 0x0($s1)
    /* 8C3D0 8009BBD0 0000648E */  lw         $a0, 0x0($s3)
    /* 8C3D4 8009BBD4 21904502 */  addu       $s2, $s2, $a1
    /* 8C3D8 8009BBD8 B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8C3DC 8009BBDC 06008424 */   addiu     $a0, $a0, 0x6
    /* 8C3E0 8009BBE0 21280000 */  addu       $a1, $zero, $zero
    /* 8C3E4 8009BBE4 0000648E */  lw         $a0, 0x0($s3)
    /* 8C3E8 8009BBE8 0000268E */  lw         $a2, 0x0($s1)
    /* 8C3EC 8009BBEC D680030C */  jal        Texture_CloneUVPmx__FP12Draw_tPixMapiT0
    /* 8C3F0 8009BBF0 04007326 */   addiu     $s3, $s3, 0x4
    /* 8C3F4 8009BBF4 D76E0208 */  j          .L8009BB5C
    /* 8C3F8 8009BBF8 0800422A */   slti      $v0, $s2, 0x8
  .L8009BBFC:
    /* 8C3FC 8009BBFC 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
    /* 8C400 8009BC00 7C325124 */  addiu      $s1, $v0, %lo(TrackSpec_gSpec)
    /* 8C404 8009BC04 5C00228E */  lw         $v0, 0x5C($s1)
    /* 8C408 8009BC08 00000000 */  nop
    /* 8C40C 8009BC0C 08004230 */  andi       $v0, $v0, 0x8
    /* 8C410 8009BC10 13004010 */  beqz       $v0, .L8009BC60
    /* 8C414 8009BC14 00811500 */   sll       $s0, $s5, 4
    /* 8C418 8009BC18 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C41C 8009BC1C 2120C002 */  addu       $a0, $s6, $zero
    /* 8C420 8009BC20 1480053C */  lui        $a1, %hi(D_8013D1BC)
    /* 8C424 8009BC24 BCD1A524 */  addiu      $a1, $a1, %lo(D_8013D1BC)
    /* 8C428 8009BC28 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C42C 8009BC2C 21380000 */  addu       $a3, $zero, $zero
    /* 8C430 8009BC30 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C434 8009BC34 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8C438 8009BC38 1400A2AF */  sw         $v0, 0x14($sp)
    /* 8C43C 8009BC3C 1800A2AF */  sw         $v0, 0x18($sp)
    /* 8C440 8009BC40 1180023C */  lui        $v0, %hi(gPixmaps)
    /* 8C444 8009BC44 D42B4224 */  addiu      $v0, $v0, %lo(gPixmaps)
    /* 8C448 8009BC48 21800202 */  addu       $s0, $s0, $v0
    /* 8C44C 8009BC4C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C450 8009BC50 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C454 8009BC54 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C458 8009BC58 1180023C */  lui        $v0, %hi(gFlarePixmap)
    /* 8C45C 8009BC5C 882B50AC */  sw         $s0, %lo(gFlarePixmap)($v0)
  .L8009BC60:
    /* 8C460 8009BC60 5C00228E */  lw         $v0, 0x5C($s1)
    /* 8C464 8009BC64 00000000 */  nop
    /* 8C468 8009BC68 04004230 */  andi       $v0, $v0, 0x4
    /* 8C46C 8009BC6C 3D004010 */  beqz       $v0, .L8009BD64
    /* 8C470 8009BC70 00891500 */   sll       $s1, $s5, 4
    /* 8C474 8009BC74 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C478 8009BC78 2120C002 */  addu       $a0, $s6, $zero
    /* 8C47C 8009BC7C 1480053C */  lui        $a1, %hi(D_8013D1C4)
    /* 8C480 8009BC80 C4D1A524 */  addiu      $a1, $a1, %lo(D_8013D1C4)
    /* 8C484 8009BC84 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C488 8009BC88 21380000 */  addu       $a3, $zero, $zero
    /* 8C48C 8009BC8C A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C490 8009BC90 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* 8C494 8009BC94 1180133C */  lui        $s3, %hi(gPixmaps)
    /* 8C498 8009BC98 D42B7326 */  addiu      $s3, $s3, %lo(gPixmaps)
    /* 8C49C 8009BC9C 21883302 */  addu       $s1, $s1, $s3
    /* 8C4A0 8009BCA0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C4A4 8009BCA4 1400B2AF */  sw         $s2, 0x14($sp)
    /* 8C4A8 8009BCA8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8C4AC 8009BCAC C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C4B0 8009BCB0 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* 8C4B4 8009BCB4 00811500 */  sll        $s0, $s5, 4
    /* 8C4B8 8009BCB8 0100B526 */  addiu      $s5, $s5, 0x1
    /* 8C4BC 8009BCBC 2120C002 */  addu       $a0, $s6, $zero
    /* 8C4C0 8009BCC0 1480053C */  lui        $a1, %hi(D_8013D1CC)
    /* 8C4C4 8009BCC4 CCD1A524 */  addiu      $a1, $a1, %lo(D_8013D1CC)
    /* 8C4C8 8009BCC8 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C4CC 8009BCCC 21380000 */  addu       $a3, $zero, $zero
    /* 8C4D0 8009BCD0 1180143C */  lui        $s4, %hi(gFlarePixmap)
    /* 8C4D4 8009BCD4 A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C4D8 8009BCD8 21801302 */  addu       $s0, $s0, $s3
    /* 8C4DC 8009BCDC 882B91AE */  sw         $s1, %lo(gFlarePixmap)($s4)
    /* 8C4E0 8009BCE0 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C4E4 8009BCE4 1400B2AF */  sw         $s2, 0x14($sp)
    /* 8C4E8 8009BCE8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8C4EC 8009BCEC C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C4F0 8009BCF0 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C4F4 8009BCF4 2120C002 */  addu       $a0, $s6, $zero
    /* 8C4F8 8009BCF8 1480053C */  lui        $a1, %hi(D_8013D1D4)
    /* 8C4FC 8009BCFC D4D1A524 */  addiu      $a1, $a1, %lo(D_8013D1D4)
    /* 8C500 8009BD00 40000624 */  addiu      $a2, $zero, 0x40
    /* 8C504 8009BD04 21380000 */  addu       $a3, $zero, $zero
    /* 8C508 8009BD08 882B9126 */  addiu      $s1, $s4, %lo(gFlarePixmap)
    /* 8C50C 8009BD0C A0000824 */  addiu      $t0, $zero, 0xA0
    /* 8C510 8009BD10 040030AE */  sw         $s0, 0x4($s1)
    /* 8C514 8009BD14 00811500 */  sll        $s0, $s5, 4
    /* 8C518 8009BD18 21801302 */  addu       $s0, $s0, $s3
    /* 8C51C 8009BD1C 1000A8AF */  sw         $t0, 0x10($sp)
    /* 8C520 8009BD20 1400B2AF */  sw         $s2, 0x14($sp)
    /* 8C524 8009BD24 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8C528 8009BD28 C67F030C */  jal        Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap
    /* 8C52C 8009BD2C 1C00B0AF */   sw        $s0, 0x1C($sp)
    /* 8C530 8009BD30 882B848E */  lw         $a0, %lo(gFlarePixmap)($s4)
    /* 8C534 8009BD34 01000524 */  addiu      $a1, $zero, 0x1
    /* 8C538 8009BD38 080030AE */  sw         $s0, 0x8($s1)
    /* 8C53C 8009BD3C B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8C540 8009BD40 06008424 */   addiu     $a0, $a0, 0x6
    /* 8C544 8009BD44 0400248E */  lw         $a0, 0x4($s1)
    /* 8C548 8009BD48 01000524 */  addiu      $a1, $zero, 0x1
    /* 8C54C 8009BD4C B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8C550 8009BD50 06008424 */   addiu     $a0, $a0, 0x6
    /* 8C554 8009BD54 0800248E */  lw         $a0, 0x8($s1)
    /* 8C558 8009BD58 01000524 */  addiu      $a1, $zero, 0x1
    /* 8C55C 8009BD5C B4F9020C */  jal        ChangeTPage__FPUsi
    /* 8C560 8009BD60 06008424 */   addiu     $a0, $a0, 0x6
  .L8009BD64:
    /* 8C564 8009BD64 5095030C */  jal        purgememadr
    /* 8C568 8009BD68 2120C002 */   addu      $a0, $s6, $zero
    /* 8C56C 8009BD6C 4C01BF8F */  lw         $ra, 0x14C($sp)
    /* 8C570 8009BD70 4801BE8F */  lw         $fp, 0x148($sp)
    /* 8C574 8009BD74 4401B78F */  lw         $s7, 0x144($sp)
    /* 8C578 8009BD78 4001B68F */  lw         $s6, 0x140($sp)
    /* 8C57C 8009BD7C 3C01B58F */  lw         $s5, 0x13C($sp)
    /* 8C580 8009BD80 3801B48F */  lw         $s4, 0x138($sp)
    /* 8C584 8009BD84 3401B38F */  lw         $s3, 0x134($sp)
    /* 8C588 8009BD88 3001B28F */  lw         $s2, 0x130($sp)
    /* 8C58C 8009BD8C 2C01B18F */  lw         $s1, 0x12C($sp)
    /* 8C590 8009BD90 2801B08F */  lw         $s0, 0x128($sp)
    /* 8C594 8009BD94 0800E003 */  jr         $ra
    /* 8C598 8009BD98 5001BD27 */   addiu     $sp, $sp, 0x150
endlabel GenericPMX_LoadTexture__Fv
