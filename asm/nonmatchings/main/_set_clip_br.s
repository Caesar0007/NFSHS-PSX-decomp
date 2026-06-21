.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _set_clip_br, 0x98

glabel _set_clip_br
    /* DF130 800EE930 00140400 */  sll        $v0, $a0, 16
    /* DF134 800EE934 03340200 */  sra        $a2, $v0, 16
    /* DF138 800EE938 0B00C004 */  bltz       $a2, .L800EE968
    /* DF13C 800EE93C 21100000 */   addu      $v0, $zero, $zero
    /* DF140 800EE940 1280023C */  lui        $v0, %hi(D_801236A0)
    /* DF144 800EE944 A0364284 */  lh         $v0, %lo(D_801236A0)($v0)
    /* DF148 800EE948 00000000 */  nop
    /* DF14C 800EE94C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DF150 800EE950 2A104600 */  slt        $v0, $v0, $a2
    /* DF154 800EE954 1280063C */  lui        $a2, %hi(D_801236A0)
    /* DF158 800EE958 A036C694 */  lhu        $a2, %lo(D_801236A0)($a2)
    /* DF15C 800EE95C 02004014 */  bnez       $v0, .L800EE968
    /* DF160 800EE960 FFFFC224 */   addiu     $v0, $a2, -0x1
    /* DF164 800EE964 21108000 */  addu       $v0, $a0, $zero
  .L800EE968:
    /* DF168 800EE968 21204000 */  addu       $a0, $v0, $zero
    /* DF16C 800EE96C 00140500 */  sll        $v0, $a1, 16
    /* DF170 800EE970 03340200 */  sra        $a2, $v0, 16
    /* DF174 800EE974 0C00C004 */  bltz       $a2, .L800EE9A8
    /* DF178 800EE978 00000000 */   nop
    /* DF17C 800EE97C 1280023C */  lui        $v0, %hi(D_801236A2)
    /* DF180 800EE980 A2364284 */  lh         $v0, %lo(D_801236A2)($v0)
    /* DF184 800EE984 00000000 */  nop
    /* DF188 800EE988 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DF18C 800EE98C 2A104600 */  slt        $v0, $v0, $a2
    /* DF190 800EE990 1280063C */  lui        $a2, %hi(D_801236A2)
    /* DF194 800EE994 A236C694 */  lhu        $a2, %lo(D_801236A2)($a2)
    /* DF198 800EE998 05004010 */  beqz       $v0, .L800EE9B0
    /* DF19C 800EE99C FF03A330 */   andi      $v1, $a1, 0x3FF
    /* DF1A0 800EE9A0 6BBA0308 */  j          .L800EE9AC
    /* DF1A4 800EE9A4 FFFFC524 */   addiu     $a1, $a2, -0x1
  .L800EE9A8:
    /* DF1A8 800EE9A8 21280000 */  addu       $a1, $zero, $zero
  .L800EE9AC:
    /* DF1AC 800EE9AC FF03A330 */  andi       $v1, $a1, 0x3FF
  .L800EE9B0:
    /* DF1B0 800EE9B0 801A0300 */  sll        $v1, $v1, 10
    /* DF1B4 800EE9B4 FF038230 */  andi       $v0, $a0, 0x3FF
    /* DF1B8 800EE9B8 00E4043C */  lui        $a0, (0xE4000000 >> 16)
    /* DF1BC 800EE9BC 25104400 */  or         $v0, $v0, $a0
    /* DF1C0 800EE9C0 0800E003 */  jr         $ra
    /* DF1C4 800EE9C4 25106200 */   or        $v0, $v1, $v0
endlabel _set_clip_br
