.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __divsf3, 0x144

glabel __divsf3
    /* E6EE4 800F66E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E6EE8 800F66E8 21308000 */  addu       $a2, $a0, $zero
    /* E6EEC 800F66EC C31D0600 */  sra        $v1, $a2, 23
    /* E6EF0 800F66F0 FF006330 */  andi       $v1, $v1, 0xFF
    /* E6EF4 800F66F4 C3150500 */  sra        $v0, $a1, 23
    /* E6EF8 800F66F8 FF004230 */  andi       $v0, $v0, 0xFF
    /* E6EFC 800F66FC 23406200 */  subu       $t0, $v1, $v0
    /* E6F00 800F6700 7E000725 */  addiu      $a3, $t0, 0x7E
    /* E6F04 800F6704 FF7F043C */  lui        $a0, (0x7FFFFFFF >> 16)
    /* E6F08 800F6708 FFFF8434 */  ori        $a0, $a0, (0x7FFFFFFF & 0xFFFF)
    /* E6F0C 800F670C 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* E6F10 800F6710 2418C200 */  and        $v1, $a2, $v0
    /* E6F14 800F6714 2410A200 */  and        $v0, $a1, $v0
    /* E6F18 800F6718 1000B0AF */  sw         $s0, 0x10($sp)
    /* E6F1C 800F671C 26806200 */  xor        $s0, $v1, $v0
    /* E6F20 800F6720 2410A400 */  and        $v0, $a1, $a0
    /* E6F24 800F6724 06004014 */  bnez       $v0, .L800F6740
    /* E6F28 800F6728 1400BFAF */   sw        $ra, 0x14($sp)
    /* E6F2C 800F672C 004F023C */  lui        $v0, (0x4F000000 >> 16)
    /* E6F30 800F6730 39000012 */  beqz       $s0, .L800F6818
    /* E6F34 800F6734 00000000 */   nop
    /* E6F38 800F6738 06DA0308 */  j          .L800F6818
    /* E6F3C 800F673C 804F023C */   lui       $v0, (0x4F800000 >> 16)
  .L800F6740:
    /* E6F40 800F6740 2410C400 */  and        $v0, $a2, $a0
    /* E6F44 800F6744 03004014 */  bnez       $v0, .L800F6754
    /* E6F48 800F6748 7F00023C */   lui       $v0, (0x7FFFFF >> 16)
    /* E6F4C 800F674C 06DA0308 */  j          .L800F6818
    /* E6F50 800F6750 21100002 */   addu      $v0, $s0, $zero
  .L800F6754:
    /* E6F54 800F6754 FFFF4234 */  ori        $v0, $v0, (0x7FFFFF & 0xFFFF)
    /* E6F58 800F6758 2418C200 */  and        $v1, $a2, $v0
    /* E6F5C 800F675C 8000043C */  lui        $a0, (0x800000 >> 16)
    /* E6F60 800F6760 25306400 */  or         $a2, $v1, $a0
    /* E6F64 800F6764 2410A200 */  and        $v0, $a1, $v0
    /* E6F68 800F6768 25284400 */  or         $a1, $v0, $a0
    /* E6F6C 800F676C 2A10C500 */  slt        $v0, $a2, $a1
    /* E6F70 800F6770 03004010 */  beqz       $v0, .L800F6780
    /* E6F74 800F6774 0001033C */   lui       $v1, %hi(D_1000001)
    /* E6F78 800F6778 40300600 */  sll        $a2, $a2, 1
    /* E6F7C 800F677C 7D000725 */  addiu      $a3, $t0, 0x7D
  .L800F6780:
    /* E6F80 800F6780 21200000 */  addu       $a0, $zero, $zero
  .L800F6784:
    /* E6F84 800F6784 2A10C500 */  slt        $v0, $a2, $a1
    /* E6F88 800F6788 03004014 */  bnez       $v0, .L800F6798
    /* E6F8C 800F678C 00000000 */   nop
    /* E6F90 800F6790 25208300 */  or         $a0, $a0, $v1
    /* E6F94 800F6794 2330C500 */  subu       $a2, $a2, $a1
  .L800F6798:
    /* E6F98 800F6798 43180300 */  sra        $v1, $v1, 1
    /* E6F9C 800F679C F9FF6014 */  bnez       $v1, .L800F6784
    /* E6FA0 800F67A0 40300600 */   sll       $a2, $a2, 1
    /* E6FA4 800F67A4 0500E004 */  bltz       $a3, .L800F67BC
    /* E6FA8 800F67A8 23180700 */   negu      $v1, $a3
    /* E6FAC 800F67AC 01008424 */  addiu      $a0, $a0, %lo(D_1000001)
    /* E6FB0 800F67B0 0100E724 */  addiu      $a3, $a3, 0x1
    /* E6FB4 800F67B4 F5D90308 */  j          .L800F67D4
    /* E6FB8 800F67B8 43200400 */   sra       $a0, $a0, 1
  .L800F67BC:
    /* E6FBC 800F67BC 01000224 */  addiu      $v0, $zero, 0x1
    /* E6FC0 800F67C0 04106200 */  sllv       $v0, $v0, $v1
    /* E6FC4 800F67C4 21208200 */  addu       $a0, $a0, $v0
    /* E6FC8 800F67C8 01006324 */  addiu      $v1, $v1, 0x1
    /* E6FCC 800F67CC 07206400 */  srav       $a0, $a0, $v1
    /* E6FD0 800F67D0 21380000 */  addu       $a3, $zero, $zero
  .L800F67D4:
    /* E6FD4 800F67D4 7FFF023C */  lui        $v0, (0xFF7FFFFF >> 16)
    /* E6FD8 800F67D8 FFFF4234 */  ori        $v0, $v0, (0xFF7FFFFF & 0xFFFF)
    /* E6FDC 800F67DC 24208200 */  and        $a0, $a0, $v0
    /* E6FE0 800F67E0 FF00E228 */  slti       $v0, $a3, 0xFF
    /* E6FE4 800F67E4 09004014 */  bnez       $v0, .L800F680C
    /* E6FE8 800F67E8 C0150700 */   sll       $v0, $a3, 23
    /* E6FEC 800F67EC 22000424 */  addiu      $a0, $zero, 0x22
    /* E6FF0 800F67F0 951A040C */  jal        _err_math
    /* E6FF4 800F67F4 0E000524 */   addiu     $a1, $zero, 0xE
    /* E6FF8 800F67F8 02000012 */  beqz       $s0, .L800F6804
    /* E6FFC 800F67FC 807F043C */   lui       $a0, (0x7F800000 >> 16)
    /* E7000 800F6800 80FF043C */  lui        $a0, (0xFF800000 >> 16)
  .L800F6804:
    /* E7004 800F6804 05DA0308 */  j          .L800F6814
    /* E7008 800F6808 21308000 */   addu      $a2, $a0, $zero
  .L800F680C:
    /* E700C 800F680C 25100202 */  or         $v0, $s0, $v0
    /* E7010 800F6810 25304400 */  or         $a2, $v0, $a0
  .L800F6814:
    /* E7014 800F6814 2110C000 */  addu       $v0, $a2, $zero
  .L800F6818:
    /* E7018 800F6818 1400BF8F */  lw         $ra, 0x14($sp)
    /* E701C 800F681C 1000B08F */  lw         $s0, 0x10($sp)
    /* E7020 800F6820 0800E003 */  jr         $ra
    /* E7024 800F6824 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __divsf3
    /* E7028 800F6828 00000000 */  nop
    /* E702C 800F682C 00000000 */  nop
    /* E7030 800F6830 00000000 */  nop
