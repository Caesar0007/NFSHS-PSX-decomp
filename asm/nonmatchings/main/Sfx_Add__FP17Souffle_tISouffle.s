.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sfx_Add__FP17Souffle_tISouffle, 0xBC

glabel Sfx_Add__FP17Souffle_tISouffle
    /* CEE38 800DE638 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CEE3C 800DE63C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CEE40 800DE640 21808000 */  addu       $s0, $a0, $zero
    /* CEE44 800DE644 1400BFAF */  sw         $ra, 0x14($sp)
    /* CEE48 800DE648 00000292 */  lbu        $v0, 0x0($s0)
    /* CEE4C 800DE64C 00000000 */  nop
    /* CEE50 800DE650 FFFF4324 */  addiu      $v1, $v0, -0x1
    /* CEE54 800DE654 0D00622C */  sltiu      $v0, $v1, 0xD
    /* CEE58 800DE658 22004010 */  beqz       $v0, .L800DE6E4
    /* CEE5C 800DE65C 0580023C */   lui       $v0, %hi(jtbl_800569D4)
    /* CEE60 800DE660 D4694224 */  addiu      $v0, $v0, %lo(jtbl_800569D4)
    /* CEE64 800DE664 80180300 */  sll        $v1, $v1, 2
    /* CEE68 800DE668 21186200 */  addu       $v1, $v1, $v0
    /* CEE6C 800DE66C 0000628C */  lw         $v0, 0x0($v1)
    /* CEE70 800DE670 00000000 */  nop
    /* CEE74 800DE674 08004000 */  jr         $v0
    /* CEE78 800DE678 00000000 */   nop
  jlabel .L800DE67C
    /* CEE7C 800DE67C A2790308 */  j          .L800DE688
    /* CEE80 800DE680 1F000224 */   addiu     $v0, $zero, 0x1F
  jlabel .L800DE684
    /* CEE84 800DE684 08000224 */  addiu      $v0, $zero, 0x8
  .L800DE688:
    /* CEE88 800DE688 EA9D030C */  jal        random
    /* CEE8C 800DE68C 030002A2 */   sb        $v0, 0x3($s0)
    /* CEE90 800DE690 01004230 */  andi       $v0, $v0, 0x1
    /* CEE94 800DE694 B9790308 */  j          .L800DE6E4
    /* CEE98 800DE698 380002AE */   sw        $v0, 0x38($s0)
  jlabel .L800DE69C
    /* CEE9C 800DE69C EA9D030C */  jal        random
    /* CEEA0 800DE6A0 00000000 */   nop
    /* CEEA4 800DE6A4 01004230 */  andi       $v0, $v0, 0x1
    /* CEEA8 800DE6A8 380002AE */  sw         $v0, 0x38($s0)
    /* CEEAC 800DE6AC 02000224 */  addiu      $v0, $zero, 0x2
    /* CEEB0 800DE6B0 B9790308 */  j          .L800DE6E4
    /* CEEB4 800DE6B4 030002A2 */   sb        $v0, 0x3($s0)
  jlabel .L800DE6B8
    /* CEEB8 800DE6B8 06000224 */  addiu      $v0, $zero, 0x6
    /* CEEBC 800DE6BC B9790308 */  j          .L800DE6E4
    /* CEEC0 800DE6C0 030002A2 */   sb        $v0, 0x3($s0)
  jlabel .L800DE6C4
    /* CEEC4 800DE6C4 40000224 */  addiu      $v0, $zero, 0x40
    /* CEEC8 800DE6C8 030002A2 */  sb         $v0, 0x3($s0)
    /* CEECC 800DE6CC 2000028E */  lw         $v0, 0x20($s0)
    /* CEED0 800DE6D0 1800038E */  lw         $v1, 0x18($s0)
    /* CEED4 800DE6D4 280000AE */  sw         $zero, 0x28($s0)
    /* CEED8 800DE6D8 23100200 */  negu       $v0, $v0
    /* CEEDC 800DE6DC 240002AE */  sw         $v0, 0x24($s0)
    /* CEEE0 800DE6E0 2C0003AE */  sw         $v1, 0x2C($s0)
  jlabel .L800DE6E4
    /* CEEE4 800DE6E4 1400BF8F */  lw         $ra, 0x14($sp)
    /* CEEE8 800DE6E8 1000B08F */  lw         $s0, 0x10($sp)
    /* CEEEC 800DE6EC 0800E003 */  jr         $ra
    /* CEEF0 800DE6F0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sfx_Add__FP17Souffle_tISouffle
