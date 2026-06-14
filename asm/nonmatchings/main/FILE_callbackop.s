.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_callbackop, 0x80

glabel FILE_callbackop
    /* DC64C 800EBE4C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DC650 800EBE50 2138A000 */  addu       $a3, $a1, $zero
    /* DC654 800EBE54 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DC658 800EBE58 2000B0AF */  sw         $s0, 0x20($sp)
    /* DC65C 800EBE5C 88EA5024 */  addiu      $s0, $v0, %lo(gFileDevice)
    /* DC660 800EBE60 021E0400 */  srl        $v1, $a0, 24
    /* DC664 800EBE64 40100300 */  sll        $v0, $v1, 1
    /* DC668 800EBE68 21104300 */  addu       $v0, $v0, $v1
    /* DC66C 800EBE6C 2400BFAF */  sw         $ra, 0x24($sp)
    /* DC670 800EBE70 1800038E */  lw         $v1, 0x18($s0)
    /* DC674 800EBE74 00110200 */  sll        $v0, $v0, 4
    /* DC678 800EBE78 21186200 */  addu       $v1, $v1, $v0
    /* DC67C 800EBE7C 0800628C */  lw         $v0, 0x8($v1)
    /* DC680 800EBE80 00000000 */  nop
    /* DC684 800EBE84 0D004010 */  beqz       $v0, .L800EBEBC
    /* DC688 800EBE88 280067AC */   sw        $a3, 0x28($v1)
    /* DC68C 800EBE8C 1000028E */  lw         $v0, 0x10($s0)
    /* DC690 800EBE90 00000000 */  nop
    /* DC694 800EBE94 01004224 */  addiu      $v0, $v0, 0x1
    /* DC698 800EBE98 100002AE */  sw         $v0, 0x10($s0)
    /* DC69C 800EBE9C 0800658C */  lw         $a1, 0x8($v1)
    /* DC6A0 800EBEA0 1400668C */  lw         $a2, 0x14($v1)
    /* DC6A4 800EBEA4 09F8E000 */  jalr       $a3
    /* DC6A8 800EBEA8 00000000 */   nop
    /* DC6AC 800EBEAC 1000028E */  lw         $v0, 0x10($s0)
    /* DC6B0 800EBEB0 00000000 */  nop
    /* DC6B4 800EBEB4 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* DC6B8 800EBEB8 100002AE */  sw         $v0, 0x10($s0)
  .L800EBEBC:
    /* DC6BC 800EBEBC 2400BF8F */  lw         $ra, 0x24($sp)
    /* DC6C0 800EBEC0 2000B08F */  lw         $s0, 0x20($sp)
    /* DC6C4 800EBEC4 0800E003 */  jr         $ra
    /* DC6C8 800EBEC8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FILE_callbackop
