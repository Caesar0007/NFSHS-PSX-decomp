.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Percentage__29tMenuItemLeftRightAudioSlider, 0xD4

glabel Percentage__29tMenuItemLeftRightAudioSlider
    /* EF7C 8001E77C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* EF80 8001E780 1000B0AF */  sw         $s0, 0x10($sp)
    /* EF84 8001E784 21808000 */  addu       $s0, $a0, $zero
    /* EF88 8001E788 1400BFAF */  sw         $ra, 0x14($sp)
    /* EF8C 8001E78C 1C00038E */  lw         $v1, 0x1C($s0)
    /* EF90 8001E790 00000000 */  nop
    /* EF94 8001E794 0C00628C */  lw         $v0, 0xC($v1)
    /* EF98 8001E798 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* EF9C 8001E79C 10004484 */  lh         $a0, 0x10($v0)
    /* EFA0 8001E7A0 1400428C */  lw         $v0, 0x14($v0)
    /* EFA4 8001E7A4 00000000 */  nop
    /* EFA8 8001E7A8 09F84000 */  jalr       $v0
    /* EFAC 8001E7AC 21206400 */   addu      $a0, $v1, $a0
    /* EFB0 8001E7B0 1C00068E */  lw         $a2, 0x1C($s0)
    /* EFB4 8001E7B4 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* EFB8 8001E7B8 0800C490 */  lbu        $a0, 0x8($a2)
    /* EFBC 8001E7BC FF004230 */  andi       $v0, $v0, 0xFF
    /* EFC0 8001E7C0 23104400 */  subu       $v0, $v0, $a0
    /* EFC4 8001E7C4 40180200 */  sll        $v1, $v0, 1
    /* EFC8 8001E7C8 21186200 */  addu       $v1, $v1, $v0
    /* EFCC 8001E7CC C0180300 */  sll        $v1, $v1, 3
    /* EFD0 8001E7D0 21186200 */  addu       $v1, $v1, $v0
    /* EFD4 8001E7D4 80800300 */  sll        $s0, $v1, 2
    /* EFD8 8001E7D8 0900C290 */  lbu        $v0, 0x9($a2)
    /* EFDC 8001E7DC 0C00C38C */  lw         $v1, 0xC($a2)
    /* EFE0 8001E7E0 23104400 */  subu       $v0, $v0, $a0
    /* EFE4 8001E7E4 1A000202 */  div        $zero, $s0, $v0
    /* EFE8 8001E7E8 02004014 */  bnez       $v0, .L8001E7F4
    /* EFEC 8001E7EC 00000000 */   nop
    /* EFF0 8001E7F0 0D000700 */  break      7
  .L8001E7F4:
    /* EFF4 8001E7F4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* EFF8 8001E7F8 04004114 */  bne        $v0, $at, .L8001E80C
    /* EFFC 8001E7FC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* F000 8001E800 02000116 */  bne        $s0, $at, .L8001E80C
    /* F004 8001E804 00000000 */   nop
    /* F008 8001E808 0D000600 */  break      6
  .L8001E80C:
    /* F00C 8001E80C 12800000 */  mflo       $s0
    /* F010 8001E810 10006484 */  lh         $a0, 0x10($v1)
    /* F014 8001E814 1400628C */  lw         $v0, 0x14($v1)
    /* F018 8001E818 00000000 */  nop
    /* F01C 8001E81C 09F84000 */  jalr       $v0
    /* F020 8001E820 2120C400 */   addu      $a0, $a2, $a0
    /* F024 8001E824 FF004230 */  andi       $v0, $v0, 0xFF
    /* F028 8001E828 04004010 */  beqz       $v0, .L8001E83C
    /* F02C 8001E82C 6400022A */   slti      $v0, $s0, 0x64
    /* F030 8001E830 03004010 */  beqz       $v0, .L8001E840
    /* F034 8001E834 21100002 */   addu      $v0, $s0, $zero
    /* F038 8001E838 01001026 */  addiu      $s0, $s0, 0x1
  .L8001E83C:
    /* F03C 8001E83C 21100002 */  addu       $v0, $s0, $zero
  .L8001E840:
    /* F040 8001E840 1400BF8F */  lw         $ra, 0x14($sp)
    /* F044 8001E844 1000B08F */  lw         $s0, 0x10($sp)
    /* F048 8001E848 0800E003 */  jr         $ra
    /* F04C 8001E84C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Percentage__29tMenuItemLeftRightAudioSlider
