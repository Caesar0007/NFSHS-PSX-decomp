.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_SecondaryMemCardCheck__Fv, 0xC8

glabel Front_SecondaryMemCardCheck__Fv
    /* 18194 80027994 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 18198 80027998 1480023C */  lui        $v0, %hi(MEMCARDFRONTENDISINITTED)
    /* 1819C 8002799C 21200000 */  addu       $a0, $zero, $zero
    /* 181A0 800279A0 21288000 */  addu       $a1, $a0, $zero
    /* 181A4 800279A4 2000BFAF */  sw         $ra, 0x20($sp)
    /* 181A8 800279A8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 181AC 800279AC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 181B0 800279B0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 181B4 800279B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 181B8 800279B8 A9D1000C */  jal        Init_Memcard__FbT0
    /* 181BC 800279BC 84D240AC */   sw        $zero, %lo(MEMCARDFRONTENDISINITTED)($v0)
    /* 181C0 800279C0 21880000 */  addu       $s1, $zero, $zero
    /* 181C4 800279C4 0580133C */  lui        $s3, %hi(memCardReadOK)
  .L800279C8:
    /* 181C8 800279C8 0200222A */  slti       $v0, $s1, 0x2
    /* 181CC 800279CC 15004010 */  beqz       $v0, .L80027A24
    /* 181D0 800279D0 00000000 */   nop
    /* 181D4 800279D4 3819628E */  lw         $v0, %lo(memCardReadOK)($s3)
    /* 181D8 800279D8 00000000 */  nop
    /* 181DC 800279DC 0E004014 */  bnez       $v0, .L80027A18
    /* 181E0 800279E0 21800000 */   addu      $s0, $zero, $zero
    /* 181E4 800279E4 00941100 */  sll        $s2, $s1, 16
    /* 181E8 800279E8 03241200 */  sra        $a0, $s2, 16
  .L800279EC:
    /* 181EC 800279EC 21280000 */  addu       $a1, $zero, $zero
    /* 181F0 800279F0 86D3000C */  jal        LoadGame__FsbT1
    /* 181F4 800279F4 2130A000 */   addu      $a2, $a1, $zero
    /* 181F8 800279F8 00140200 */  sll        $v0, $v0, 16
    /* 181FC 800279FC 0100432C */  sltiu      $v1, $v0, 0x1
    /* 18200 80027A00 01001026 */  addiu      $s0, $s0, 0x1
    /* 18204 80027A04 0300022A */  slti       $v0, $s0, 0x3
    /* 18208 80027A08 03004010 */  beqz       $v0, .L80027A18
    /* 1820C 80027A0C 381963AE */   sw        $v1, %lo(memCardReadOK)($s3)
    /* 18210 80027A10 F6FF6010 */  beqz       $v1, .L800279EC
    /* 18214 80027A14 03241200 */   sra       $a0, $s2, 16
  .L80027A18:
    /* 18218 80027A18 381960AE */  sw         $zero, %lo(memCardReadOK)($s3)
    /* 1821C 80027A1C 729E0008 */  j          .L800279C8
    /* 18220 80027A20 01003126 */   addiu     $s1, $s1, 0x1
  .L80027A24:
    /* 18224 80027A24 00D2000C */  jal        DeInit_Memcard__Fv
    /* 18228 80027A28 00000000 */   nop
    /* 1822C 80027A2C 439D000C */  jal        SetPads__Fv
    /* 18230 80027A30 00000000 */   nop
    /* 18234 80027A34 1480033C */  lui        $v1, %hi(MEMCARDFRONTENDISINITTED)
    /* 18238 80027A38 2000BF8F */  lw         $ra, 0x20($sp)
    /* 1823C 80027A3C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 18240 80027A40 1800B28F */  lw         $s2, 0x18($sp)
    /* 18244 80027A44 1400B18F */  lw         $s1, 0x14($sp)
    /* 18248 80027A48 1000B08F */  lw         $s0, 0x10($sp)
    /* 1824C 80027A4C 01000224 */  addiu      $v0, $zero, 0x1
    /* 18250 80027A50 84D262AC */  sw         $v0, %lo(MEMCARDFRONTENDISINITTED)($v1)
    /* 18254 80027A54 0800E003 */  jr         $ra
    /* 18258 80027A58 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Front_SecondaryMemCardCheck__Fv
