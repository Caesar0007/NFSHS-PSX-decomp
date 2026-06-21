.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__19tScreenTrackRecords, 0x5B0

glabel DrawBackground__19tScreenTrackRecords
    /* 33348 80042B48 F8FEBD27 */  addiu      $sp, $sp, -0x108
    /* 3334C 80042B4C 0401BFAF */  sw         $ra, 0x104($sp)
    /* 33350 80042B50 0001BEAF */  sw         $fp, 0x100($sp)
    /* 33354 80042B54 FC00B7AF */  sw         $s7, 0xFC($sp)
    /* 33358 80042B58 F800B6AF */  sw         $s6, 0xF8($sp)
    /* 3335C 80042B5C F400B5AF */  sw         $s5, 0xF4($sp)
    /* 33360 80042B60 F000B4AF */  sw         $s4, 0xF0($sp)
    /* 33364 80042B64 EC00B3AF */  sw         $s3, 0xEC($sp)
    /* 33368 80042B68 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 3336C 80042B6C E400B1AF */  sw         $s1, 0xE4($sp)
    /* 33370 80042B70 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 33374 80042B74 0801A4AF */  sw         $a0, 0x108($sp)
    /* 33378 80042B78 5C008384 */  lh         $v1, 0x5C($a0)
    /* 3337C 80042B7C 00000000 */  nop
    /* 33380 80042B80 80100300 */  sll        $v0, $v1, 2
    /* 33384 80042B84 21104300 */  addu       $v0, $v0, $v1
    /* 33388 80042B88 80100200 */  sll        $v0, $v0, 2
    /* 3338C 80042B8C 23104300 */  subu       $v0, $v0, $v1
    /* 33390 80042B90 80100200 */  sll        $v0, $v0, 2
    /* 33394 80042B94 21104300 */  addu       $v0, $v0, $v1
    /* 33398 80042B98 80100200 */  sll        $v0, $v0, 2
    /* 3339C 80042B9C 03004104 */  bgez       $v0, .L80042BAC
    /* 333A0 80042BA0 C3190200 */   sra       $v1, $v0, 7
    /* 333A4 80042BA4 7F004224 */  addiu      $v0, $v0, 0x7F
    /* 333A8 80042BA8 C3190200 */  sra        $v1, $v0, 7
  .L80042BAC:
    /* 333AC 80042BAC 4CFF7224 */  addiu      $s2, $v1, -0xB4
    /* 333B0 80042BB0 03004106 */  bgez       $s2, .L80042BC0
    /* 333B4 80042BB4 8100422A */   slti      $v0, $s2, 0x81
    /* 333B8 80042BB8 21900000 */  addu       $s2, $zero, $zero
    /* 333BC 80042BBC 8100422A */  slti       $v0, $s2, 0x81
  .L80042BC0:
    /* 333C0 80042BC0 02004014 */  bnez       $v0, .L80042BCC
    /* 333C4 80042BC4 21286000 */   addu      $a1, $v1, $zero
    /* 333C8 80042BC8 80001224 */  addiu      $s2, $zero, 0x80
  .L80042BCC:
    /* 333CC 80042BCC 0300A104 */  bgez       $a1, .L80042BDC
    /* 333D0 80042BD0 B500A228 */   slti      $v0, $a1, 0xB5
    /* 333D4 80042BD4 21280000 */  addu       $a1, $zero, $zero
    /* 333D8 80042BD8 B500A228 */  slti       $v0, $a1, 0xB5
  .L80042BDC:
    /* 333DC 80042BDC 02004014 */  bnez       $v0, .L80042BE8
    /* 333E0 80042BE0 0BB6023C */   lui       $v0, (0xB60B60B7 >> 16)
    /* 333E4 80042BE4 B4000524 */  addiu      $a1, $zero, 0xB4
  .L80042BE8:
    /* 333E8 80042BE8 B7604234 */  ori        $v0, $v0, (0xB60B60B7 & 0xFFFF)
    /* 333EC 80042BEC C0190300 */  sll        $v1, $v1, 7
    /* 333F0 80042BF0 18006200 */  mult       $v1, $v0
    /* 333F4 80042BF4 10400000 */  mfhi       $t0
    /* 333F8 80042BF8 21100301 */  addu       $v0, $t0, $v1
    /* 333FC 80042BFC C3110200 */  sra        $v0, $v0, 7
    /* 33400 80042C00 C31F0300 */  sra        $v1, $v1, 31
    /* 33404 80042C04 23A84300 */  subu       $s5, $v0, $v1
    /* 33408 80042C08 0300A106 */  bgez       $s5, .L80042C18
    /* 3340C 80042C0C 8100A22A */   slti      $v0, $s5, 0x81
    /* 33410 80042C10 21A80000 */  addu       $s5, $zero, $zero
    /* 33414 80042C14 8100A22A */  slti       $v0, $s5, 0x81
  .L80042C18:
    /* 33418 80042C18 02004014 */  bnez       $v0, .L80042C24
    /* 3341C 80042C1C 00000000 */   nop
    /* 33420 80042C20 80001524 */  addiu      $s5, $zero, 0x80
  .L80042C24:
    /* 33424 80042C24 6666043C */  lui        $a0, (0x66666667 >> 16)
    /* 33428 80042C28 67668434 */  ori        $a0, $a0, (0x66666667 & 0xFFFF)
    /* 3342C 80042C2C 00140500 */  sll        $v0, $a1, 16
    /* 33430 80042C30 03140200 */  sra        $v0, $v0, 16
    /* 33434 80042C34 B4000324 */  addiu      $v1, $zero, 0xB4
    /* 33438 80042C38 23186200 */  subu       $v1, $v1, $v0
    /* 3343C 80042C3C 18006400 */  mult       $v1, $a0
    /* 33440 80042C40 48020424 */  addiu      $a0, $zero, 0x248
    /* 33444 80042C44 C31F0300 */  sra        $v1, $v1, 31
    /* 33448 80042C48 10480000 */  mfhi       $t1
    /* 3344C 80042C4C C3980900 */  sra        $s3, $t1, 3
    /* 33450 80042C50 A4E4020C */  jal        TextSys_WordX__Fi
    /* 33454 80042C54 23986302 */   subu      $s3, $s3, $v1
    /* 33458 80042C58 56020424 */  addiu      $a0, $zero, 0x256
    /* 3345C 80042C5C ACE4020C */  jal        TextSys_WordY__Fi
    /* 33460 80042C60 21A04000 */   addu      $s4, $v0, $zero
    /* 33464 80042C64 4F020424 */  addiu      $a0, $zero, 0x24F
    /* 33468 80042C68 A4E4020C */  jal        TextSys_WordX__Fi
    /* 3346C 80042C6C 21B84000 */   addu      $s7, $v0, $zero
    /* 33470 80042C70 23105400 */  subu       $v0, $v0, $s4
    /* 33474 80042C74 5F020424 */  addiu      $a0, $zero, 0x25F
    /* 33478 80042C78 ACE4020C */  jal        TextSys_WordY__Fi
    /* 3347C 80042C7C C800A2A7 */   sh        $v0, 0xC8($sp)
    /* 33480 80042C80 00941200 */  sll        $s2, $s2, 16
    /* 33484 80042C84 03941200 */  sra        $s2, $s2, 16
    /* 33488 80042C88 0580113C */  lui        $s1, %hi(kRGBVals)
    /* 3348C 80042C8C 0580103C */  lui        $s0, %hi(textDefinitions)
    /* 33490 80042C90 B8151026 */  addiu      $s0, $s0, %lo(textDefinitions)
    /* 33494 80042C94 46000392 */  lbu        $v1, 0x46($s0)
    /* 33498 80042C98 C8163126 */  addiu      $s1, $s1, %lo(kRGBVals)
    /* 3349C 80042C9C 80180300 */  sll        $v1, $v1, 2
    /* 334A0 80042CA0 21187100 */  addu       $v1, $v1, $s1
    /* 334A4 80042CA4 0000648C */  lw         $a0, 0x0($v1)
    /* 334A8 80042CA8 21284002 */  addu       $a1, $s2, $zero
    /* 334AC 80042CAC 222E010C */  jal        CalcFadeVal__Fii
    /* 334B0 80042CB0 D000A2A7 */   sh        $v0, 0xD0($sp)
    /* 334B4 80042CB4 47000392 */  lbu        $v1, 0x47($s0)
    /* 334B8 80042CB8 21284002 */  addu       $a1, $s2, $zero
    /* 334BC 80042CBC 80180300 */  sll        $v1, $v1, 2
    /* 334C0 80042CC0 21187100 */  addu       $v1, $v1, $s1
    /* 334C4 80042CC4 0000648C */  lw         $a0, 0x0($v1)
    /* 334C8 80042CC8 222E010C */  jal        CalcFadeVal__Fii
    /* 334CC 80042CCC 21F04000 */   addu      $fp, $v0, $zero
    /* 334D0 80042CD0 001C1300 */  sll        $v1, $s3, 16
    /* 334D4 80042CD4 031C0300 */  sra        $v1, $v1, 16
    /* 334D8 80042CD8 21286000 */  addu       $a1, $v1, $zero
    /* 334DC 80042CDC 0801A48F */  lw         $a0, 0x108($sp)
    /* 334E0 80042CE0 21904000 */  addu       $s2, $v0, $zero
    /* 334E4 80042CE4 5A0A010C */  jal        DrawRecords__19tScreenTrackRecordss
    /* 334E8 80042CE8 D800A3AF */   sw        $v1, 0xD8($sp)
    /* 334EC 80042CEC 94E4020C */  jal        TextSys_Word__Fi
    /* 334F0 80042CF0 51020424 */   addiu     $a0, $zero, 0x251
    /* 334F4 80042CF4 F09F000C */  jal        Front_GetLapsForType__Fv
    /* 334F8 80042CF8 21804000 */   addu      $s0, $v0, $zero
    /* 334FC 80042CFC 5800B127 */  addiu      $s1, $sp, 0x58
    /* 33500 80042D00 21202002 */  addu       $a0, $s1, $zero
    /* 33504 80042D04 21280002 */  addu       $a1, $s0, $zero
    /* 33508 80042D08 2F91030C */  jal        sprintf
    /* 3350C 80042D0C 21304000 */   addu      $a2, $v0, $zero
    /* 33510 80042D10 58AE000C */  jal        Front_GetTrackRaced__Fv
    /* 33514 80042D14 04011024 */   addiu     $s0, $zero, 0x104
    /* 33518 80042D18 00140200 */  sll        $v0, $v0, 16
    /* 3351C 80042D1C 03140200 */  sra        $v0, $v0, 16
    /* 33520 80042D20 94E4020C */  jal        TextSys_Word__Fi
    /* 33524 80042D24 D5004424 */   addiu     $a0, $v0, 0xD5
    /* 33528 80042D28 2000A427 */  addiu      $a0, $sp, 0x20
    /* 3352C 80042D2C 0180053C */  lui        $a1, %hi(D_80011FE8)
    /* 33530 80042D30 E81FA524 */  addiu      $a1, $a1, %lo(D_80011FE8)
    /* 33534 80042D34 21304000 */  addu       $a2, $v0, $zero
    /* 33538 80042D38 2F91030C */  jal        sprintf
    /* 3353C 80042D3C 21382002 */   addu      $a3, $s1, $zero
    /* 33540 80042D40 ACE4020C */  jal        TextSys_WordY__Fi
    /* 33544 80042D44 55020424 */   addiu     $a0, $zero, 0x255
    /* 33548 80042D48 2000A427 */  addiu      $a0, $sp, 0x20
    /* 3354C 80042D4C 04010524 */  addiu      $a1, $zero, 0x104
    /* 33550 80042D50 00140200 */  sll        $v0, $v0, 16
    /* 33554 80042D54 03340200 */  sra        $a2, $v0, 16
    /* 33558 80042D58 21384002 */  addu       $a3, $s2, $zero
    /* 3355C 80042D5C 02000224 */  addiu      $v0, $zero, 0x2
    /* 33560 80042D60 1000A0AF */  sw         $zero, 0x10($sp)
    /* 33564 80042D64 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 33568 80042D68 1400A2AF */   sw        $v0, 0x14($sp)
    /* 3356C 80042D6C 888F030C */  jal        textpixels
    /* 33570 80042D70 2000A427 */   addiu     $a0, $sp, 0x20
    /* 33574 80042D74 55020424 */  addiu      $a0, $zero, 0x255
    /* 33578 80042D78 43100200 */  sra        $v0, $v0, 1
    /* 3357C 80042D7C ACE4020C */  jal        TextSys_WordY__Fi
    /* 33580 80042D80 23800202 */   subu      $s0, $s0, $v0
    /* 33584 80042D84 2000A427 */  addiu      $a0, $sp, 0x20
    /* 33588 80042D88 888F030C */  jal        textpixels
    /* 3358C 80042D8C 21884000 */   addu      $s1, $v0, $zero
    /* 33590 80042D90 21200000 */  addu       $a0, $zero, $zero
    /* 33594 80042D94 21280002 */  addu       $a1, $s0, $zero
    /* 33598 80042D98 21302002 */  addu       $a2, $s1, $zero
    /* 3359C 80042D9C 21384000 */  addu       $a3, $v0, $zero
    /* 335A0 80042DA0 09000224 */  addiu      $v0, $zero, 0x9
    /* 335A4 80042DA4 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 335A8 80042DA8 1000A2AF */   sw        $v0, 0x10($sp)
    /* 335AC 80042DAC 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 335B0 80042DB0 CC17448C */  lw         $a0, %lo(gCurrentShapes)($v0)
    /* 335B4 80042DB4 1480023C */  lui        $v0, %hi(ticks)
    /* 335B8 80042DB8 C0048424 */  addiu      $a0, $a0, 0x4C0
    /* 335BC 80042DBC 10008394 */  lhu        $v1, 0x10($a0)
    /* 335C0 80042DC0 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 335C4 80042DC4 001C0300 */  sll        $v1, $v1, 16
    /* 335C8 80042DC8 032C0300 */  sra        $a1, $v1, 16
    /* 335CC 80042DCC 1A004500 */  div        $zero, $v0, $a1
    /* 335D0 80042DD0 0200A014 */  bnez       $a1, .L80042DDC
    /* 335D4 80042DD4 00000000 */   nop
    /* 335D8 80042DD8 0D000700 */  break      7
  .L80042DDC:
    /* 335DC 80042DDC FFFF0124 */  addiu      $at, $zero, -0x1
    /* 335E0 80042DE0 0400A114 */  bne        $a1, $at, .L80042DF4
    /* 335E4 80042DE4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 335E8 80042DE8 02004114 */  bne        $v0, $at, .L80042DF4
    /* 335EC 80042DEC 00000000 */   nop
    /* 335F0 80042DF0 0D000600 */  break      6
  .L80042DF4:
    /* 335F4 80042DF4 10900000 */  mfhi       $s2
    /* 335F8 80042DF8 2300163C */  lui        $s6, (0x232323 >> 16)
    /* 335FC 80042DFC 2323D636 */  ori        $s6, $s6, (0x232323 & 0xFFFF)
    /* 33600 80042E00 A800B5A7 */  sh         $s5, 0xA8($sp)
    /* 33604 80042E04 B000B3A7 */  sh         $s3, 0xB0($sp)
    /* 33608 80042E08 B800B4A7 */  sh         $s4, 0xB8($sp)
    /* 3360C 80042E0C C000B7A7 */  sh         $s7, 0xC0($sp)
    /* 33610 80042E10 14008484 */  lh         $a0, 0x14($a0)
    /* 33614 80042E14 43140300 */  sra        $v0, $v1, 17
    /* 33618 80042E18 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* 3361C 80042E1C C21F0300 */  srl        $v1, $v1, 31
    /* 33620 80042E20 2118A300 */  addu       $v1, $a1, $v1
    /* 33624 80042E24 43180300 */  sra        $v1, $v1, 1
    /* 33628 80042E28 2A187200 */  slt        $v1, $v1, $s2
    /* 3362C 80042E2C 02006010 */  beqz       $v1, .L80042E38
    /* 33630 80042E30 23984400 */   subu      $s3, $v0, $a0
    /* 33634 80042E34 2390B200 */  subu       $s2, $a1, $s2
  .L80042E38:
    /* 33638 80042E38 ACE4020C */  jal        TextSys_WordY__Fi
    /* 3363C 80042E3C 55020424 */   addiu     $a0, $zero, 0x255
    /* 33640 80042E40 27000424 */  addiu      $a0, $zero, 0x27
    /* 33644 80042E44 21280000 */  addu       $a1, $zero, $zero
    /* 33648 80042E48 21307202 */  addu       $a2, $s3, $s2
    /* 3364C 80042E4C D800A88F */  lw         $t0, 0xD8($sp)
    /* 33650 80042E50 01004724 */  addiu      $a3, $v0, 0x1
    /* 33654 80042E54 DC00A8AF */  sw         $t0, 0xDC($sp)
    /* 33658 80042E58 0801A88F */  lw         $t0, 0x108($sp)
    /* 3365C 80042E5C 2188A000 */  addu       $s1, $a1, $zero
    /* 33660 80042E60 5C000285 */  lh         $v0, 0x5C($t0)
    /* 33664 80042E64 01001024 */  addiu      $s0, $zero, 0x1
    /* 33668 80042E68 1400B0AF */  sw         $s0, 0x14($sp)
    /* 3366C 80042E6C 1800A0AF */  sw         $zero, 0x18($sp)
    /* 33670 80042E70 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 33674 80042E74 1000A2AF */   sw        $v0, 0x10($sp)
    /* 33678 80042E78 ACE4020C */  jal        TextSys_WordY__Fi
    /* 3367C 80042E7C 55020424 */   addiu     $a0, $zero, 0x255
    /* 33680 80042E80 27000424 */  addiu      $a0, $zero, 0x27
    /* 33684 80042E84 21280000 */  addu       $a1, $zero, $zero
    /* 33688 80042E88 0801A88F */  lw         $t0, 0x108($sp)
    /* 3368C 80042E8C 23307202 */  subu       $a2, $s3, $s2
    /* 33690 80042E90 5C000385 */  lh         $v1, 0x5C($t0)
    /* 33694 80042E94 21385000 */  addu       $a3, $v0, $s0
    /* 33698 80042E98 1400B0AF */  sw         $s0, 0x14($sp)
    /* 3369C 80042E9C 1800A0AF */  sw         $zero, 0x18($sp)
    /* 336A0 80042EA0 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 336A4 80042EA4 1000A3AF */   sw        $v1, 0x10($sp)
    /* 336A8 80042EA8 5000023C */  lui        $v0, (0x505050 >> 16)
    /* 336AC 80042EAC 50504234 */  ori        $v0, $v0, (0x505050 & 0xFFFF)
    /* 336B0 80042EB0 26000424 */  addiu      $a0, $zero, 0x26
    /* 336B4 80042EB4 10040524 */  addiu      $a1, $zero, 0x410
    /* 336B8 80042EB8 FEFF0624 */  addiu      $a2, $zero, -0x2
    /* 336BC 80042EBC 0801A88F */  lw         $t0, 0x108($sp)
    /* 336C0 80042EC0 21380000 */  addu       $a3, $zero, $zero
    /* 336C4 80042EC4 9400A2AF */  sw         $v0, 0x94($sp)
    /* 336C8 80042EC8 5C000385 */  lh         $v1, 0x5C($t0)
    /* 336CC 80042ECC 9000A227 */  addiu      $v0, $sp, 0x90
    /* 336D0 80042ED0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 336D4 80042ED4 1800A2AF */  sw         $v0, 0x18($sp)
    /* 336D8 80042ED8 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 336DC 80042EDC 1000A3AF */   sw        $v1, 0x10($sp)
    /* 336E0 80042EE0 0400E226 */  addiu      $v0, $s7, 0x4
    /* 336E4 80042EE4 00A40200 */  sll        $s4, $v0, 16
    /* 336E8 80042EE8 00141700 */  sll        $v0, $s7, 16
    /* 336EC 80042EEC 03140200 */  sra        $v0, $v0, 16
    /* 336F0 80042EF0 02005324 */  addiu      $s3, $v0, 0x2
    /* 336F4 80042EF4 00141500 */  sll        $v0, $s5, 16
    /* 336F8 80042EF8 03940200 */  sra        $s2, $v0, 16
  .L80042EFC:
    /* 336FC 80042EFC 00141100 */  sll        $v0, $s1, 16
    /* 33700 80042F00 03840200 */  sra        $s0, $v0, 16
    /* 33704 80042F04 0300022A */  slti       $v0, $s0, 0x3
    /* 33708 80042F08 1E004010 */  beqz       $v0, .L80042F84
    /* 3370C 80042F0C 00000000 */   nop
    /* 33710 80042F10 A4E4020C */  jal        TextSys_WordX__Fi
    /* 33714 80042F14 4C020426 */   addiu     $a0, $s0, 0x24C
    /* 33718 80042F18 52020426 */  addiu      $a0, $s0, 0x252
    /* 3371C 80042F1C 94E4020C */  jal        TextSys_Word__Fi
    /* 33720 80042F20 21804000 */   addu      $s0, $v0, $zero
    /* 33724 80042F24 21204000 */  addu       $a0, $v0, $zero
    /* 33728 80042F28 002C1000 */  sll        $a1, $s0, 16
    /* 3372C 80042F2C 032C0500 */  sra        $a1, $a1, 16
    /* 33730 80042F30 03341400 */  sra        $a2, $s4, 16
    /* 33734 80042F34 2138C003 */  addu       $a3, $fp, $zero
    /* 33738 80042F38 1000A0AF */  sw         $zero, 0x10($sp)
    /* 3373C 80042F3C 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 33740 80042F40 1400A0AF */   sw        $zero, 0x14($sp)
    /* 33744 80042F44 DC00A88F */  lw         $t0, 0xDC($sp)
    /* 33748 80042F48 00000000 */  nop
    /* 3374C 80042F4C 0B000019 */  blez       $t0, .L80042F7C
    /* 33750 80042F50 80000224 */   addiu     $v0, $zero, 0x80
    /* 33754 80042F54 23105200 */  subu       $v0, $v0, $s2
    /* 33758 80042F58 02004104 */  bgez       $v0, .L80042F64
    /* 3375C 80042F5C FAFF0526 */   addiu     $a1, $s0, -0x6
    /* 33760 80042F60 0F004224 */  addiu      $v0, $v0, 0xF
  .L80042F64:
    /* 33764 80042F64 03110200 */  sra        $v0, $v0, 4
    /* 33768 80042F68 1000A2AF */  sw         $v0, 0x10($sp)
    /* 3376C 80042F6C 2120C002 */  addu       $a0, $s6, $zero
    /* 33770 80042F70 21306002 */  addu       $a2, $s3, $zero
    /* 33774 80042F74 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 33778 80042F78 02000724 */   addiu     $a3, $zero, 0x2
  .L80042F7C:
    /* 3377C 80042F7C BF0B0108 */  j          .L80042EFC
    /* 33780 80042F80 01003126 */   addiu     $s1, $s1, 0x1
  .L80042F84:
    /* 33784 80042F84 94E4020C */  jal        TextSys_Word__Fi
    /* 33788 80042F88 62020424 */   addiu     $a0, $zero, 0x262
    /* 3378C 80042F8C 49020424 */  addiu      $a0, $zero, 0x249
    /* 33790 80042F90 A4E4020C */  jal        TextSys_WordX__Fi
    /* 33794 80042F94 21804000 */   addu      $s0, $v0, $zero
    /* 33798 80042F98 21200002 */  addu       $a0, $s0, $zero
    /* 3379C 80042F9C 00140200 */  sll        $v0, $v0, 16
    /* 337A0 80042FA0 032C0200 */  sra        $a1, $v0, 16
    /* 337A4 80042FA4 D000A897 */  lhu        $t0, 0xD0($sp)
    /* 337A8 80042FA8 2138C003 */  addu       $a3, $fp, $zero
    /* 337AC 80042FAC 1000A0AF */  sw         $zero, 0x10($sp)
    /* 337B0 80042FB0 1400A0AF */  sw         $zero, 0x14($sp)
    /* 337B4 80042FB4 03000625 */  addiu      $a2, $t0, 0x3
    /* 337B8 80042FB8 00340600 */  sll        $a2, $a2, 16
    /* 337BC 80042FBC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 337C0 80042FC0 03340600 */   sra       $a2, $a2, 16
    /* 337C4 80042FC4 2120C002 */  addu       $a0, $s6, $zero
    /* 337C8 80042FC8 B800A897 */  lhu        $t0, 0xB8($sp)
    /* 337CC 80042FCC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 337D0 80042FD0 1000A2AF */  sw         $v0, 0x10($sp)
    /* 337D4 80042FD4 02000224 */  addiu      $v0, $zero, 0x2
    /* 337D8 80042FD8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 337DC 80042FDC 23000224 */  addiu      $v0, $zero, 0x23
    /* 337E0 80042FE0 1C00A2AF */  sw         $v0, 0x1C($sp)
    /* 337E4 80042FE4 002C0800 */  sll        $a1, $t0, 16
    /* 337E8 80042FE8 C000A897 */  lhu        $t0, 0xC0($sp)
    /* 337EC 80042FEC 032C0500 */  sra        $a1, $a1, 16
    /* 337F0 80042FF0 008C0800 */  sll        $s1, $t0, 16
    /* 337F4 80042FF4 038C1100 */  sra        $s1, $s1, 16
    /* 337F8 80042FF8 C800A897 */  lhu        $t0, 0xC8($sp)
    /* 337FC 80042FFC 03002626 */  addiu      $a2, $s1, 0x3
    /* 33800 80043000 003C0800 */  sll        $a3, $t0, 16
    /* 33804 80043004 A800A897 */  lhu        $t0, 0xA8($sp)
    /* 33808 80043008 033C0700 */  sra        $a3, $a3, 16
    /* 3380C 8004300C 00840800 */  sll        $s0, $t0, 16
    /* 33810 80043010 03841000 */  sra        $s0, $s0, 16
    /* 33814 80043014 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 33818 80043018 1800B0AF */   sw        $s0, 0x18($sp)
    /* 3381C 8004301C A4E4020C */  jal        TextSys_WordX__Fi
    /* 33820 80043020 4C020424 */   addiu     $a0, $zero, 0x24C
    /* 33824 80043024 2120C002 */  addu       $a0, $s6, $zero
    /* 33828 80043028 FAFF4524 */  addiu      $a1, $v0, -0x6
    /* 3382C 8004302C 04002626 */  addiu      $a2, $s1, 0x4
    /* 33830 80043030 D000A897 */  lhu        $t0, 0xD0($sp)
    /* 33834 80043034 02000724 */  addiu      $a3, $zero, 0x2
    /* 33838 80043038 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3383C 8004303C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 33840 80043040 00140800 */  sll        $v0, $t0, 16
    /* 33844 80043044 03140200 */  sra        $v0, $v0, 16
    /* 33848 80043048 F4FF4224 */  addiu      $v0, $v0, -0xC
    /* 3384C 8004304C 23105100 */  subu       $v0, $v0, $s1
    /* 33850 80043050 1000A2AF */  sw         $v0, 0x10($sp)
    /* 33854 80043054 01000224 */  addiu      $v0, $zero, 0x1
    /* 33858 80043058 CE2E010C */  jal        PSXDrawBrightEndLine__Fiiiiiiii
    /* 3385C 8004305C 1400A2AF */   sw        $v0, 0x14($sp)
    /* 33860 80043060 B000A897 */  lhu        $t0, 0xB0($sp)
    /* 33864 80043064 00000000 */  nop
    /* 33868 80043068 00140800 */  sll        $v0, $t0, 16
    /* 3386C 8004306C 03140200 */  sra        $v0, $v0, 16
    /* 33870 80043070 09004228 */  slti       $v0, $v0, 0x9
    /* 33874 80043074 0E004014 */  bnez       $v0, .L800430B0
    /* 33878 80043078 0B000524 */   addiu     $a1, $zero, 0xB
    /* 3387C 8004307C A4E4020C */  jal        TextSys_WordX__Fi
    /* 33880 80043080 4C020424 */   addiu     $a0, $zero, 0x24C
    /* 33884 80043084 60020424 */  addiu      $a0, $zero, 0x260
    /* 33888 80043088 ACE4020C */  jal        TextSys_WordY__Fi
    /* 3388C 8004308C FAFF5024 */   addiu     $s0, $v0, -0x6
    /* 33890 80043090 08000324 */  addiu      $v1, $zero, 0x8
    /* 33894 80043094 1000A3AF */  sw         $v1, 0x10($sp)
    /* 33898 80043098 2120C002 */  addu       $a0, $s6, $zero
    /* 3389C 8004309C 21280002 */  addu       $a1, $s0, $zero
    /* 338A0 800430A0 FFFF4624 */  addiu      $a2, $v0, -0x1
    /* 338A4 800430A4 113B010C */  jal        PSXDrawSquare__Fiiiii
    /* 338A8 800430A8 02000724 */   addiu     $a3, $zero, 0x2
    /* 338AC 800430AC 0B000524 */  addiu      $a1, $zero, 0xB
  .L800430B0:
    /* 338B0 800430B0 0580023C */  lui        $v0, %hi(gCurrentShapes)
    /* 338B4 800430B4 0801A48F */  lw         $a0, 0x108($sp)
    /* 338B8 800430B8 CC17478C */  lw         $a3, %lo(gCurrentShapes)($v0)
    /* 338BC 800430BC 1B000624 */  addiu      $a2, $zero, 0x1B
    /* 338C0 800430C0 3297000C */  jal        DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi
    /* 338C4 800430C4 1000A0AF */   sw        $zero, 0x10($sp)
    /* 338C8 800430C8 0401BF8F */  lw         $ra, 0x104($sp)
    /* 338CC 800430CC 0001BE8F */  lw         $fp, 0x100($sp)
    /* 338D0 800430D0 FC00B78F */  lw         $s7, 0xFC($sp)
    /* 338D4 800430D4 F800B68F */  lw         $s6, 0xF8($sp)
    /* 338D8 800430D8 F400B58F */  lw         $s5, 0xF4($sp)
    /* 338DC 800430DC F000B48F */  lw         $s4, 0xF0($sp)
    /* 338E0 800430E0 EC00B38F */  lw         $s3, 0xEC($sp)
    /* 338E4 800430E4 E800B28F */  lw         $s2, 0xE8($sp)
    /* 338E8 800430E8 E400B18F */  lw         $s1, 0xE4($sp)
    /* 338EC 800430EC E000B08F */  lw         $s0, 0xE0($sp)
    /* 338F0 800430F0 0800E003 */  jr         $ra
    /* 338F4 800430F4 0801BD27 */   addiu     $sp, $sp, 0x108
endlabel DrawBackground__19tScreenTrackRecords
