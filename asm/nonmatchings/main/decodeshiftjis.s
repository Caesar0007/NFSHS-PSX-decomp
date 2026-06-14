.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching decodeshiftjis, 0x68

glabel decodeshiftjis
    /* F71EC 801069EC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F71F0 801069F0 1400B1AF */  sw         $s1, 0x14($sp)
    /* F71F4 801069F4 21888000 */  addu       $s1, $a0, $zero
    /* F71F8 801069F8 1800BFAF */  sw         $ra, 0x18($sp)
    /* F71FC 801069FC 1000B0AF */  sw         $s0, 0x10($sp)
    /* F7200 80106A00 0000308E */  lw         $s0, 0x0($s1)
    /* F7204 80106A04 00000000 */  nop
    /* F7208 80106A08 00000492 */  lbu        $a0, 0x0($s0)
    /* F720C 80106A0C 00000000 */  nop
    /* F7210 80106A10 80008230 */  andi       $v0, $a0, 0x80
    /* F7214 80106A14 06004010 */  beqz       $v0, .L80106A30
    /* F7218 80106A18 01001026 */   addiu     $s0, $s0, 0x1
    /* F721C 80106A1C 00000392 */  lbu        $v1, 0x0($s0)
    /* F7220 80106A20 01001026 */  addiu      $s0, $s0, 0x1
    /* F7224 80106A24 00120400 */  sll        $v0, $a0, 8
    /* F7228 80106A28 8E1A0408 */  j          .L80106A38
    /* F722C 80106A2C 25106200 */   or        $v0, $v1, $v0
  .L80106A30:
    /* F7230 80106A30 711A040C */  jal        remapshiftjiscode
    /* F7234 80106A34 00000000 */   nop
  .L80106A38:
    /* F7238 80106A38 000030AE */  sw         $s0, 0x0($s1)
    /* F723C 80106A3C 1800BF8F */  lw         $ra, 0x18($sp)
    /* F7240 80106A40 1400B18F */  lw         $s1, 0x14($sp)
    /* F7244 80106A44 1000B08F */  lw         $s0, 0x10($sp)
    /* F7248 80106A48 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* F724C 80106A4C 0800E003 */  jr         $ra
    /* F7250 80106A50 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel decodeshiftjis
