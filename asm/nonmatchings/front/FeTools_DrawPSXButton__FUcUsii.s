.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeTools_DrawPSXButton__FUcUsii, 0x1F8

glabel FeTools_DrawPSXButton__FUcUsii
    /* 171B0 800269B0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 171B4 800269B4 4000B2AF */  sw         $s2, 0x40($sp)
    /* 171B8 800269B8 2190C000 */  addu       $s2, $a2, $zero
    /* 171BC 800269BC 21400000 */  addu       $t0, $zero, $zero
    /* 171C0 800269C0 BEBE0234 */  ori        $v0, $zero, 0xBEBE
    /* 171C4 800269C4 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 171C8 800269C8 0100F124 */  addiu      $s1, $a3, 0x1
    /* 171CC 800269CC FFFFA630 */  andi       $a2, $a1, 0xFFFF
    /* 171D0 800269D0 2400A2AF */  sw         $v0, 0x24($sp)
    /* 171D4 800269D4 50000224 */  addiu      $v0, $zero, 0x50
    /* 171D8 800269D8 4400BFAF */  sw         $ra, 0x44($sp)
    /* 171DC 800269DC 0600C210 */  beq        $a2, $v0, .L800269F8
    /* 171E0 800269E0 3800B0AF */   sw        $s0, 0x38($sp)
    /* 171E4 800269E4 A0000224 */  addiu      $v0, $zero, 0xA0
    /* 171E8 800269E8 1400C210 */  beq        $a2, $v0, .L80026A3C
    /* 171EC 800269EC FF008330 */   andi      $v1, $a0, 0xFF
    /* 171F0 800269F0 A19A0008 */  j          .L80026A84
    /* 171F4 800269F4 23000224 */   addiu     $v0, $zero, 0x23
  .L800269F8:
    /* 171F8 800269F8 1A000424 */  addiu      $a0, $zero, 0x1A
    /* 171FC 800269FC 18000524 */  addiu      $a1, $zero, 0x18
    /* 17200 80026A00 03004626 */  addiu      $a2, $s2, 0x3
    /* 17204 80026A04 FEFF2726 */  addiu      $a3, $s1, -0x2
    /* 17208 80026A08 2000B027 */  addiu      $s0, $sp, 0x20
    /* 1720C 80026A0C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 17210 80026A10 1400A0AF */  sw         $zero, 0x14($sp)
    /* 17214 80026A14 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 17218 80026A18 1800B0AF */   sw        $s0, 0x18($sp)
    /* 1721C 80026A1C 1B000424 */  addiu      $a0, $zero, 0x1B
    /* 17220 80026A20 18000524 */  addiu      $a1, $zero, 0x18
    /* 17224 80026A24 04004626 */  addiu      $a2, $s2, 0x4
    /* 17228 80026A28 04002726 */  addiu      $a3, $s1, 0x4
    /* 1722C 80026A2C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 17230 80026A30 1400A0AF */  sw         $zero, 0x14($sp)
    /* 17234 80026A34 E29A0008 */  j          .L80026B88
    /* 17238 80026A38 1800B0AF */   sw        $s0, 0x18($sp)
  .L80026A3C:
    /* 1723C 80026A3C 1C000424 */  addiu      $a0, $zero, 0x1C
    /* 17240 80026A40 18000524 */  addiu      $a1, $zero, 0x18
    /* 17244 80026A44 21304002 */  addu       $a2, $s2, $zero
    /* 17248 80026A48 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* 1724C 80026A4C 21382002 */  addu       $a3, $s1, $zero
    /* 17250 80026A50 2000B027 */  addiu      $s0, $sp, 0x20
    /* 17254 80026A54 1000A0AF */  sw         $zero, 0x10($sp)
    /* 17258 80026A58 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1725C 80026A5C 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 17260 80026A60 1800B0AF */   sw        $s0, 0x18($sp)
    /* 17264 80026A64 1D000424 */  addiu      $a0, $zero, 0x1D
    /* 17268 80026A68 18000524 */  addiu      $a1, $zero, 0x18
    /* 1726C 80026A6C 0A004626 */  addiu      $a2, $s2, 0xA
    /* 17270 80026A70 21382002 */  addu       $a3, $s1, $zero
    /* 17274 80026A74 1000A0AF */  sw         $zero, 0x10($sp)
    /* 17278 80026A78 1400A0AF */  sw         $zero, 0x14($sp)
    /* 1727C 80026A7C E29A0008 */  j          .L80026B88
    /* 17280 80026A80 1800B0AF */   sw        $s0, 0x18($sp)
  .L80026A84:
    /* 17284 80026A84 1D006214 */  bne        $v1, $v0, .L80026AFC
    /* 17288 80026A88 00100224 */   addiu     $v0, $zero, 0x1000
    /* 1728C 80026A8C FFFFA530 */  andi       $a1, $a1, 0xFFFF
    /* 17290 80026A90 0E00A210 */  beq        $a1, $v0, .L80026ACC
    /* 17294 80026A94 0110A228 */   slti      $v0, $a1, 0x1001
    /* 17298 80026A98 05004010 */  beqz       $v0, .L80026AB0
    /* 1729C 80026A9C 08000224 */   addiu     $v0, $zero, 0x8
    /* 172A0 80026AA0 1300A210 */  beq        $a1, $v0, .L80026AF0
    /* 172A4 80026AA4 21200001 */   addu      $a0, $t0, $zero
    /* 172A8 80026AA8 DC9A0008 */  j          .L80026B70
    /* 172AC 80026AAC 18000524 */   addiu     $a1, $zero, 0x18
  .L80026AB0:
    /* 172B0 80026AB0 00400224 */  addiu      $v0, $zero, 0x4000
    /* 172B4 80026AB4 0800A210 */  beq        $a1, $v0, .L80026AD8
    /* 172B8 80026AB8 00800234 */   ori       $v0, $zero, 0x8000
    /* 172BC 80026ABC 0900A210 */  beq        $a1, $v0, .L80026AE4
    /* 172C0 80026AC0 21200001 */   addu      $a0, $t0, $zero
    /* 172C4 80026AC4 DC9A0008 */  j          .L80026B70
    /* 172C8 80026AC8 18000524 */   addiu     $a1, $zero, 0x18
  .L80026ACC:
    /* 172CC 80026ACC 12000824 */  addiu      $t0, $zero, 0x12
    /* 172D0 80026AD0 DA9A0008 */  j          .L80026B68
    /* 172D4 80026AD4 FDFF3126 */   addiu     $s1, $s1, -0x3
  .L80026AD8:
    /* 172D8 80026AD8 13000824 */  addiu      $t0, $zero, 0x13
    /* 172DC 80026ADC DA9A0008 */  j          .L80026B68
    /* 172E0 80026AE0 FCFF3126 */   addiu     $s1, $s1, -0x4
  .L80026AE4:
    /* 172E4 80026AE4 14000824 */  addiu      $t0, $zero, 0x14
    /* 172E8 80026AE8 DA9A0008 */  j          .L80026B68
    /* 172EC 80026AEC FEFF3126 */   addiu     $s1, $s1, -0x2
  .L80026AF0:
    /* 172F0 80026AF0 15000824 */  addiu      $t0, $zero, 0x15
    /* 172F4 80026AF4 DA9A0008 */  j          .L80026B68
    /* 172F8 80026AF8 FFFF3126 */   addiu     $s1, $s1, -0x1
  .L80026AFC:
    /* 172FC 80026AFC FFFFA530 */  andi       $a1, $a1, 0xFFFF
    /* 17300 80026B00 0E00A210 */  beq        $a1, $v0, .L80026B3C
    /* 17304 80026B04 0110A228 */   slti      $v0, $a1, 0x1001
    /* 17308 80026B08 05004010 */  beqz       $v0, .L80026B20
    /* 1730C 80026B0C 08000224 */   addiu     $v0, $zero, 0x8
    /* 17310 80026B10 1300A210 */  beq        $a1, $v0, .L80026B60
    /* 17314 80026B14 21200001 */   addu      $a0, $t0, $zero
    /* 17318 80026B18 DC9A0008 */  j          .L80026B70
    /* 1731C 80026B1C 18000524 */   addiu     $a1, $zero, 0x18
  .L80026B20:
    /* 17320 80026B20 00400224 */  addiu      $v0, $zero, 0x4000
    /* 17324 80026B24 0800A210 */  beq        $a1, $v0, .L80026B48
    /* 17328 80026B28 00800234 */   ori       $v0, $zero, 0x8000
    /* 1732C 80026B2C 0900A210 */  beq        $a1, $v0, .L80026B54
    /* 17330 80026B30 21200001 */   addu      $a0, $t0, $zero
    /* 17334 80026B34 DC9A0008 */  j          .L80026B70
    /* 17338 80026B38 18000524 */   addiu     $a1, $zero, 0x18
  .L80026B3C:
    /* 1733C 80026B3C 0F000824 */  addiu      $t0, $zero, 0xF
    /* 17340 80026B40 DA9A0008 */  j          .L80026B68
    /* 17344 80026B44 FDFF3126 */   addiu     $s1, $s1, -0x3
  .L80026B48:
    /* 17348 80026B48 0C000824 */  addiu      $t0, $zero, 0xC
    /* 1734C 80026B4C DA9A0008 */  j          .L80026B68
    /* 17350 80026B50 FDFF3126 */   addiu     $s1, $s1, -0x3
  .L80026B54:
    /* 17354 80026B54 0E000824 */  addiu      $t0, $zero, 0xE
    /* 17358 80026B58 DA9A0008 */  j          .L80026B68
    /* 1735C 80026B5C FDFF3126 */   addiu     $s1, $s1, -0x3
  .L80026B60:
    /* 17360 80026B60 10000824 */  addiu      $t0, $zero, 0x10
    /* 17364 80026B64 02005226 */  addiu      $s2, $s2, 0x2
  .L80026B68:
    /* 17368 80026B68 21200001 */  addu       $a0, $t0, $zero
    /* 1736C 80026B6C 18000524 */  addiu      $a1, $zero, 0x18
  .L80026B70:
    /* 17370 80026B70 21304002 */  addu       $a2, $s2, $zero
    /* 17374 80026B74 21382002 */  addu       $a3, $s1, $zero
    /* 17378 80026B78 2000A227 */  addiu      $v0, $sp, 0x20
    /* 1737C 80026B7C 1000A0AF */  sw         $zero, 0x10($sp)
    /* 17380 80026B80 1400A0AF */  sw         $zero, 0x14($sp)
    /* 17384 80026B84 1800A2AF */  sw         $v0, 0x18($sp)
  .L80026B88:
    /* 17388 80026B88 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 1738C 80026B8C 00000000 */   nop
    /* 17390 80026B90 4400BF8F */  lw         $ra, 0x44($sp)
    /* 17394 80026B94 4000B28F */  lw         $s2, 0x40($sp)
    /* 17398 80026B98 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 1739C 80026B9C 3800B08F */  lw         $s0, 0x38($sp)
    /* 173A0 80026BA0 0800E003 */  jr         $ra
    /* 173A4 80026BA4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel FeTools_DrawPSXButton__FUcUsii
