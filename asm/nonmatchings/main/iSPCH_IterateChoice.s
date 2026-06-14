.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_IterateChoice, 0xB0

glabel iSPCH_IterateChoice
    /* F19AC 801011AC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F19B0 801011B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* F19B4 801011B4 1400BFAF */  sw         $ra, 0x14($sp)
    /* F19B8 801011B8 CC01040C */  jal        func_80100730
    /* F19BC 801011BC 21800000 */   addu      $s0, $zero, $zero
    /* F19C0 801011C0 FFFF4524 */  addiu      $a1, $v0, -0x1
    /* F19C4 801011C4 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F19C8 801011C8 E4844224 */  addiu      $v0, $v0, %lo(ispch_gChoice)
    /* F19CC 801011CC 40180500 */  sll        $v1, $a1, 1
    /* F19D0 801011D0 21186500 */  addu       $v1, $v1, $a1
    /* F19D4 801011D4 80180300 */  sll        $v1, $v1, 2
    /* F19D8 801011D8 21186200 */  addu       $v1, $v1, $v0
    /* F19DC 801011DC 04006484 */  lh         $a0, 0x4($v1)
    /* F19E0 801011E0 06006284 */  lh         $v0, 0x6($v1)
    /* F19E4 801011E4 21300002 */  addu       $a2, $s0, $zero
    /* F19E8 801011E8 21204400 */  addu       $a0, $v0, $a0
  .L801011EC:
    /* F19EC 801011EC 08006294 */  lhu        $v0, 0x8($v1)
    /* F19F0 801011F0 00000000 */  nop
    /* F19F4 801011F4 01004224 */  addiu      $v0, $v0, 0x1
    /* F19F8 801011F8 080062A4 */  sh         $v0, 0x8($v1)
    /* F19FC 801011FC 00140200 */  sll        $v0, $v0, 16
    /* F1A00 80101200 03140200 */  sra        $v0, $v0, 16
    /* F1A04 80101204 2A104400 */  slt        $v0, $v0, $a0
    /* F1A08 80101208 03004010 */  beqz       $v0, .L80101218
    /* F1A0C 8010120C 00000000 */   nop
    /* F1A10 80101210 91040408 */  j          .L80101244
    /* F1A14 80101214 01000624 */   addiu     $a2, $zero, 0x1
  .L80101218:
    /* F1A18 80101218 06006294 */  lhu        $v0, 0x6($v1)
    /* F1A1C 8010121C FFFFA524 */  addiu      $a1, $a1, -0x1
    /* F1A20 80101220 080062A4 */  sh         $v0, 0x8($v1)
    /* F1A24 80101224 0300A104 */  bgez       $a1, .L80101234
    /* F1A28 80101228 F4FF6324 */   addiu     $v1, $v1, -0xC
    /* F1A2C 8010122C 01000624 */  addiu      $a2, $zero, 0x1
    /* F1A30 80101230 2180C000 */  addu       $s0, $a2, $zero
  .L80101234:
    /* F1A34 80101234 04006484 */  lh         $a0, 0x4($v1)
    /* F1A38 80101238 06006284 */  lh         $v0, 0x6($v1)
    /* F1A3C 8010123C 00000000 */  nop
    /* F1A40 80101240 21204400 */  addu       $a0, $v0, $a0
  .L80101244:
    /* F1A44 80101244 E9FFC010 */  beqz       $a2, .L801011EC
    /* F1A48 80101248 21100002 */   addu      $v0, $s0, $zero
    /* F1A4C 8010124C 1400BF8F */  lw         $ra, 0x14($sp)
    /* F1A50 80101250 1000B08F */  lw         $s0, 0x10($sp)
    /* F1A54 80101254 0800E003 */  jr         $ra
    /* F1A58 80101258 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSPCH_IterateChoice
