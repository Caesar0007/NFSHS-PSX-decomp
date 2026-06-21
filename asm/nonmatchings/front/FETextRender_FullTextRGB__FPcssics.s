.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FETextRender_FullTextRGB__FPcssics, 0x174

glabel FETextRender_FullTextRGB__FPcssics
    /* 1154C 80020D4C 48FFBD27 */  addiu      $sp, $sp, -0xB8
    /* 11550 80020D50 9000B0AF */  sw         $s0, 0x90($sp)
    /* 11554 80020D54 C800B093 */  lbu        $s0, 0xC8($sp)
    /* 11558 80020D58 9C00B3AF */  sw         $s3, 0x9C($sp)
    /* 1155C 80020D5C CC00B38F */  lw         $s3, 0xCC($sp)
    /* 11560 80020D60 A000B4AF */  sw         $s4, 0xA0($sp)
    /* 11564 80020D64 21A0A000 */  addu       $s4, $a1, $zero
    /* 11568 80020D68 9800B2AF */  sw         $s2, 0x98($sp)
    /* 1156C 80020D6C 21908002 */  addu       $s2, $s4, $zero
    /* 11570 80020D70 9400B1AF */  sw         $s1, 0x94($sp)
    /* 11574 80020D74 21888000 */  addu       $s1, $a0, $zero
    /* 11578 80020D78 AC00B7AF */  sw         $s7, 0xAC($sp)
    /* 1157C 80020D7C 21B8E000 */  addu       $s7, $a3, $zero
    /* 11580 80020D80 A400B5AF */  sw         $s5, 0xA4($sp)
    /* 11584 80020D84 21A8C000 */  addu       $s5, $a2, $zero
    /* 11588 80020D88 B000BFAF */  sw         $ra, 0xB0($sp)
    /* 1158C 80020D8C A800B6AF */  sw         $s6, 0xA8($sp)
    /* 11590 80020D90 21200002 */  addu       $a0, $s0, $zero
    /* 11594 80020D94 3683000C */  jal        FETextRender_SetFont__Fi
    /* 11598 80020D98 21B06002 */   addu      $s6, $s3, $zero
    /* 1159C 80020D9C 0A000016 */  bnez       $s0, .L80020DC8
    /* 115A0 80020DA0 00141300 */   sll       $v0, $s3, 16
    /* 115A4 80020DA4 1000A427 */  addiu      $a0, $sp, 0x10
    /* 115A8 80020DA8 0180053C */  lui        $a1, %hi(D_80010FC4)
    /* 115AC 80020DAC C40FA524 */  addiu      $a1, $a1, %lo(D_80010FC4)
    /* 115B0 80020DB0 2F91030C */  jal        sprintf
    /* 115B4 80020DB4 21302002 */   addu      $a2, $s1, $zero
    /* 115B8 80020DB8 549A000C */  jal        s_lower__FPc
    /* 115BC 80020DBC 1000A427 */   addiu     $a0, $sp, 0x10
    /* 115C0 80020DC0 1000B127 */  addiu      $s1, $sp, 0x10
    /* 115C4 80020DC4 00141300 */  sll        $v0, $s3, 16
  .L80020DC8:
    /* 115C8 80020DC8 031C0200 */  sra        $v1, $v0, 16
    /* 115CC 80020DCC 01000224 */  addiu      $v0, $zero, 0x1
    /* 115D0 80020DD0 05006210 */  beq        $v1, $v0, .L80020DE8
    /* 115D4 80020DD4 04000224 */   addiu     $v0, $zero, 0x4
    /* 115D8 80020DD8 03006210 */  beq        $v1, $v0, .L80020DE8
    /* 115DC 80020DDC 06000224 */   addiu     $v0, $zero, 0x6
    /* 115E0 80020DE0 05006214 */  bne        $v1, $v0, .L80020DF8
    /* 115E4 80020DE4 02000224 */   addiu     $v0, $zero, 0x2
  .L80020DE8:
    /* 115E8 80020DE8 888F030C */  jal        textpixels
    /* 115EC 80020DEC 21202002 */   addu      $a0, $s1, $zero
    /* 115F0 80020DF0 88830008 */  j          .L80020E20
    /* 115F4 80020DF4 23904202 */   subu      $s2, $s2, $v0
  .L80020DF8:
    /* 115F8 80020DF8 03006210 */  beq        $v1, $v0, .L80020E08
    /* 115FC 80020DFC 05000224 */   addiu     $v0, $zero, 0x5
    /* 11600 80020E00 08006214 */  bne        $v1, $v0, .L80020E24
    /* 11604 80020E04 0580023C */   lui       $v0, %hi(gSemiTransText)
  .L80020E08:
    /* 11608 80020E08 888F030C */  jal        textpixels
    /* 1160C 80020E0C 21202002 */   addu      $a0, $s1, $zero
    /* 11610 80020E10 C21F0200 */  srl        $v1, $v0, 31
    /* 11614 80020E14 21186200 */  addu       $v1, $v1, $v0
    /* 11618 80020E18 43180300 */  sra        $v1, $v1, 1
    /* 1161C 80020E1C 23908302 */  subu       $s2, $s4, $v1
  .L80020E20:
    /* 11620 80020E20 0580023C */  lui        $v0, %hi(gSemiTransText)
  .L80020E24:
    /* 11624 80020E24 0C16428C */  lw         $v0, %lo(gSemiTransText)($v0)
    /* 11628 80020E28 00000000 */  nop
    /* 1162C 80020E2C 02004010 */  beqz       $v0, .L80020E38
    /* 11630 80020E30 01000424 */   addiu     $a0, $zero, 0x1
    /* 11634 80020E34 0F000424 */  addiu      $a0, $zero, 0xF
  .L80020E38:
    /* 11638 80020E38 832C030C */  jal        Font_TextColor__Fi
    /* 1163C 80020E3C 00000000 */   nop
    /* 11640 80020E40 912C030C */  jal        Font_TextTint__Fi
    /* 11644 80020E44 2120E002 */   addu      $a0, $s7, $zero
    /* 11648 80020E48 21202002 */  addu       $a0, $s1, $zero
    /* 1164C 80020E4C 00141200 */  sll        $v0, $s2, 16
    /* 11650 80020E50 03940200 */  sra        $s2, $v0, 16
    /* 11654 80020E54 21284002 */  addu       $a1, $s2, $zero
    /* 11658 80020E58 00141500 */  sll        $v0, $s5, 16
    /* 1165C 80020E5C 03840200 */  sra        $s0, $v0, 16
    /* 11660 80020E60 A42E030C */  jal        Font_TextXY__FPcii
    /* 11664 80020E64 21300002 */   addu      $a2, $s0, $zero
    /* 11668 80020E68 FDFFC226 */  addiu      $v0, $s6, -0x3
    /* 1166C 80020E6C FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 11670 80020E70 0300422C */  sltiu      $v0, $v0, 0x3
    /* 11674 80020E74 07004010 */  beqz       $v0, .L80020E94
    /* 11678 80020E78 00000000 */   nop
    /* 1167C 80020E7C 912C030C */  jal        Font_TextTint__Fi
    /* 11680 80020E80 21200000 */   addu      $a0, $zero, $zero
    /* 11684 80020E84 21202002 */  addu       $a0, $s1, $zero
    /* 11688 80020E88 02004526 */  addiu      $a1, $s2, 0x2
    /* 1168C 80020E8C A42E030C */  jal        Font_TextXY__FPcii
    /* 11690 80020E90 01000626 */   addiu     $a2, $s0, 0x1
  .L80020E94:
    /* 11694 80020E94 B000BF8F */  lw         $ra, 0xB0($sp)
    /* 11698 80020E98 AC00B78F */  lw         $s7, 0xAC($sp)
    /* 1169C 80020E9C A800B68F */  lw         $s6, 0xA8($sp)
    /* 116A0 80020EA0 A400B58F */  lw         $s5, 0xA4($sp)
    /* 116A4 80020EA4 A000B48F */  lw         $s4, 0xA0($sp)
    /* 116A8 80020EA8 9C00B38F */  lw         $s3, 0x9C($sp)
    /* 116AC 80020EAC 9800B28F */  lw         $s2, 0x98($sp)
    /* 116B0 80020EB0 9400B18F */  lw         $s1, 0x94($sp)
    /* 116B4 80020EB4 9000B08F */  lw         $s0, 0x90($sp)
    /* 116B8 80020EB8 0800E003 */  jr         $ra
    /* 116BC 80020EBC B800BD27 */   addiu     $sp, $sp, 0xB8
endlabel FETextRender_FullTextRGB__FPcssics
