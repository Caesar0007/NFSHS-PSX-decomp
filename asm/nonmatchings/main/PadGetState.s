.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadGetState, 0xC0

glabel PadGetState
    /* E06A0 800EFEA0 1380023C */  lui        $v0, %hi(_padFuncPort2Info)
    /* E06A4 800EFEA4 8C7C428C */  lw         $v0, %lo(_padFuncPort2Info)($v0)
    /* E06A8 800EFEA8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E06AC 800EFEAC 1000BFAF */  sw         $ra, 0x10($sp)
    /* E06B0 800EFEB0 09F84000 */  jalr       $v0
    /* E06B4 800EFEB4 00000000 */   nop
    /* E06B8 800EFEB8 21204000 */  addu       $a0, $v0, $zero
    /* E06BC 800EFEBC 3400828C */  lw         $v0, 0x34($a0)
    /* E06C0 800EFEC0 FFFF033C */  lui        $v1, (0xFFFF0000 >> 16)
    /* E06C4 800EFEC4 24104300 */  and        $v0, $v0, $v1
    /* E06C8 800EFEC8 0F004014 */  bnez       $v0, .L800EFF08
    /* E06CC 800EFECC 00000000 */   nop
    /* E06D0 800EFED0 1000828C */  lw         $v0, 0x10($a0)
    /* E06D4 800EFED4 00000000 */  nop
    /* E06D8 800EFED8 05008210 */  beq        $a0, $v0, .L800EFEF0
    /* E06DC 800EFEDC 00000000 */   nop
    /* E06E0 800EFEE0 38008290 */  lbu        $v0, 0x38($a0)
    /* E06E4 800EFEE4 00000000 */  nop
    /* E06E8 800EFEE8 07004014 */  bnez       $v0, .L800EFF08
    /* E06EC 800EFEEC 00000000 */   nop
  .L800EFEF0:
    /* E06F0 800EFEF0 3000828C */  lw         $v0, 0x30($a0)
    /* E06F4 800EFEF4 00000000 */  nop
    /* E06F8 800EFEF8 00004290 */  lbu        $v0, 0x0($v0)
    /* E06FC 800EFEFC 00000000 */  nop
    /* E0700 800EFF00 12004010 */  beqz       $v0, .L800EFF4C
    /* E0704 800EFF04 00000000 */   nop
  .L800EFF08:
    /* E0708 800EFF08 49008390 */  lbu        $v1, 0x49($a0)
    /* E070C 800EFF0C 03000224 */  addiu      $v0, $zero, 0x3
    /* E0710 800EFF10 0C006210 */  beq        $v1, $v0, .L800EFF44
    /* E0714 800EFF14 04006228 */   slti      $v0, $v1, 0x4
    /* E0718 800EFF18 05004010 */  beqz       $v0, .L800EFF30
    /* E071C 800EFF1C 02000224 */   addiu     $v0, $zero, 0x2
    /* E0720 800EFF20 0B006210 */  beq        $v1, $v0, .L800EFF50
    /* E0724 800EFF24 01000224 */   addiu     $v0, $zero, 0x1
    /* E0728 800EFF28 D3BF0308 */  j          .L800EFF4C
    /* E072C 800EFF2C 00000000 */   nop
  .L800EFF30:
    /* E0730 800EFF30 06000224 */  addiu      $v0, $zero, 0x6
    /* E0734 800EFF34 06006210 */  beq        $v1, $v0, .L800EFF50
    /* E0738 800EFF38 04000224 */   addiu     $v0, $zero, 0x4
    /* E073C 800EFF3C D3BF0308 */  j          .L800EFF4C
    /* E0740 800EFF40 00000000 */   nop
  .L800EFF44:
    /* E0744 800EFF44 D4BF0308 */  j          .L800EFF50
    /* E0748 800EFF48 01000224 */   addiu     $v0, $zero, 0x1
  .L800EFF4C:
    /* E074C 800EFF4C 49008290 */  lbu        $v0, 0x49($a0)
  .L800EFF50:
    /* E0750 800EFF50 1000BF8F */  lw         $ra, 0x10($sp)
    /* E0754 800EFF54 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E0758 800EFF58 0800E003 */  jr         $ra
    /* E075C 800EFF5C 00000000 */   nop
endlabel PadGetState
