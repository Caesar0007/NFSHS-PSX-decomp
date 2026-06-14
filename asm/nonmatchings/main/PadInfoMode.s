.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadInfoMode, 0xF8

glabel PadInfoMode
    /* E0760 800EFF60 1380023C */  lui        $v0, %hi(_padFuncPort2Info)
    /* E0764 800EFF64 8C7C428C */  lw         $v0, %lo(_padFuncPort2Info)($v0)
    /* E0768 800EFF68 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E076C 800EFF6C 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0770 800EFF70 2180A000 */  addu       $s0, $a1, $zero
    /* E0774 800EFF74 1400B1AF */  sw         $s1, 0x14($sp)
    /* E0778 800EFF78 1800BFAF */  sw         $ra, 0x18($sp)
    /* E077C 800EFF7C 09F84000 */  jalr       $v0
    /* E0780 800EFF80 2188C000 */   addu      $s1, $a2, $zero
    /* E0784 800EFF84 21184000 */  addu       $v1, $v0, $zero
    /* E0788 800EFF88 03000224 */  addiu      $v0, $zero, 0x3
    /* E078C 800EFF8C 16000212 */  beq        $s0, $v0, .L800EFFE8
    /* E0790 800EFF90 0400022A */   slti      $v0, $s0, 0x4
    /* E0794 800EFF94 07004010 */  beqz       $v0, .L800EFFB4
    /* E0798 800EFF98 01000224 */   addiu     $v0, $zero, 0x1
    /* E079C 800EFF9C 0C000212 */  beq        $s0, $v0, .L800EFFD0
    /* E07A0 800EFFA0 02000224 */   addiu     $v0, $zero, 0x2
    /* E07A4 800EFFA4 0D000212 */  beq        $s0, $v0, .L800EFFDC
    /* E07A8 800EFFA8 21100000 */   addu      $v0, $zero, $zero
    /* E07AC 800EFFAC 11C00308 */  j          .L800F0044
    /* E07B0 800EFFB0 00000000 */   nop
  .L800EFFB4:
    /* E07B4 800EFFB4 04000224 */  addiu      $v0, $zero, 0x4
    /* E07B8 800EFFB8 0E000212 */  beq        $s0, $v0, .L800EFFF4
    /* E07BC 800EFFBC 64000224 */   addiu     $v0, $zero, 0x64
    /* E07C0 800EFFC0 1C000212 */  beq        $s0, $v0, .L800F0034
    /* E07C4 800EFFC4 21100000 */   addu      $v0, $zero, $zero
    /* E07C8 800EFFC8 11C00308 */  j          .L800F0044
    /* E07CC 800EFFCC 00000000 */   nop
  .L800EFFD0:
    /* E07D0 800EFFD0 E8006290 */  lbu        $v0, 0xE8($v1)
    /* E07D4 800EFFD4 11C00308 */  j          .L800F0044
    /* E07D8 800EFFD8 00000000 */   nop
  .L800EFFDC:
    /* E07DC 800EFFDC E6006294 */  lhu        $v0, 0xE6($v1)
    /* E07E0 800EFFE0 11C00308 */  j          .L800F0044
    /* E07E4 800EFFE4 00000000 */   nop
  .L800EFFE8:
    /* E07E8 800EFFE8 E4006290 */  lbu        $v0, 0xE4($v1)
    /* E07EC 800EFFEC 11C00308 */  j          .L800F0044
    /* E07F0 800EFFF0 00000000 */   nop
  .L800EFFF4:
    /* E07F4 800EFFF4 04002106 */  bgez       $s1, .L800F0008
    /* E07F8 800EFFF8 00000000 */   nop
    /* E07FC 800EFFFC E3006290 */  lbu        $v0, 0xE3($v1)
    /* E0800 800F0000 11C00308 */  j          .L800F0044
    /* E0804 800F0004 00000000 */   nop
  .L800F0008:
    /* E0808 800F0008 E3006290 */  lbu        $v0, 0xE3($v1)
    /* E080C 800F000C 00000000 */  nop
    /* E0810 800F0010 2A102202 */  slt        $v0, $s1, $v0
    /* E0814 800F0014 0A004010 */  beqz       $v0, .L800F0040
    /* E0818 800F0018 40101100 */   sll       $v0, $s1, 1
    /* E081C 800F001C 0000638C */  lw         $v1, 0x0($v1)
    /* E0820 800F0020 00000000 */  nop
    /* E0824 800F0024 21104300 */  addu       $v0, $v0, $v1
    /* E0828 800F0028 00004294 */  lhu        $v0, 0x0($v0)
    /* E082C 800F002C 11C00308 */  j          .L800F0044
    /* E0830 800F0030 00000000 */   nop
  .L800F0034:
    /* E0834 800F0034 4C00628C */  lw         $v0, 0x4C($v1)
    /* E0838 800F0038 11C00308 */  j          .L800F0044
    /* E083C 800F003C 00000000 */   nop
  .L800F0040:
    /* E0840 800F0040 21100000 */  addu       $v0, $zero, $zero
  .L800F0044:
    /* E0844 800F0044 1800BF8F */  lw         $ra, 0x18($sp)
    /* E0848 800F0048 1400B18F */  lw         $s1, 0x14($sp)
    /* E084C 800F004C 1000B08F */  lw         $s0, 0x10($sp)
    /* E0850 800F0050 0800E003 */  jr         $ra
    /* E0854 800F0054 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PadInfoMode
