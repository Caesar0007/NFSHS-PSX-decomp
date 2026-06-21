.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _set_clip_tl, 0x98

glabel _set_clip_tl
    /* DF098 800EE898 00140400 */  sll        $v0, $a0, 16
    /* DF09C 800EE89C 03340200 */  sra        $a2, $v0, 16
    /* DF0A0 800EE8A0 0B00C004 */  bltz       $a2, .L800EE8D0
    /* DF0A4 800EE8A4 21100000 */   addu      $v0, $zero, $zero
    /* DF0A8 800EE8A8 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DF0AC 800EE8AC A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DF0B0 800EE8B0 00000000 */  nop
    /* DF0B4 800EE8B4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DF0B8 800EE8B8 2A104600 */  slt        $v0, $v0, $a2
    /* DF0BC 800EE8BC 1280063C */  lui        $a2, %hi(D_801236A0)
    /* DF0C0 800EE8C0 A036C694 */  lhu        $a2, %lo(D_801236A0)($a2)
    /* DF0C4 800EE8C4 02004014 */  bnez       $v0, .L800EE8D0
    /* DF0C8 800EE8C8 FFFFC224 */   addiu     $v0, $a2, -0x1
    /* DF0CC 800EE8CC 21108000 */  addu       $v0, $a0, $zero
  .L800EE8D0:
    /* DF0D0 800EE8D0 21204000 */  addu       $a0, $v0, $zero
    /* DF0D4 800EE8D4 00140500 */  sll        $v0, $a1, 16
    /* DF0D8 800EE8D8 03340200 */  sra        $a2, $v0, 16
    /* DF0DC 800EE8DC 0C00C004 */  bltz       $a2, .L800EE910
    /* DF0E0 800EE8E0 00000000 */   nop
    /* DF0E4 800EE8E4 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DF0E8 800EE8E8 A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DF0EC 800EE8EC 00000000 */  nop
    /* DF0F0 800EE8F0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DF0F4 800EE8F4 2A104600 */  slt        $v0, $v0, $a2
    /* DF0F8 800EE8F8 1280063C */  lui        $a2, %hi(D_801236A2)
    /* DF0FC 800EE8FC A236C694 */  lhu        $a2, %lo(D_801236A2)($a2)
    /* DF100 800EE900 05004010 */  beqz       $v0, .L800EE918
    /* DF104 800EE904 FF03A330 */   andi      $v1, $a1, 0x3FF
    /* DF108 800EE908 45BA0308 */  j          .L800EE914
    /* DF10C 800EE90C FFFFC524 */   addiu     $a1, $a2, -0x1
  .L800EE910:
    /* DF110 800EE910 21280000 */  addu       $a1, $zero, $zero
  .L800EE914:
    /* DF114 800EE914 FF03A330 */  andi       $v1, $a1, 0x3FF
  .L800EE918:
    /* DF118 800EE918 801A0300 */  sll        $v1, $v1, 10
    /* DF11C 800EE91C FF038230 */  andi       $v0, $a0, 0x3FF
    /* DF120 800EE920 00E3043C */  lui        $a0, (0xE3000000 >> 16)
    /* DF124 800EE924 25104400 */  or         $v0, $v0, $a0
    /* DF128 800EE928 0800E003 */  jr         $ra
    /* DF12C 800EE92C 25106200 */   or        $v0, $v1, $v0
endlabel _set_clip_tl
