.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadInfoAct, 0xD4

glabel PadInfoAct
    /* E0858 800F0058 1380023C */  lui        $v0, %hi(_padFuncPort2Info)
    /* E085C 800F005C 8C7C428C */  lw         $v0, %lo(_padFuncPort2Info)($v0)
    /* E0860 800F0060 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E0864 800F0064 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0868 800F0068 2180A000 */  addu       $s0, $a1, $zero
    /* E086C 800F006C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E0870 800F0070 1800BFAF */  sw         $ra, 0x18($sp)
    /* E0874 800F0074 09F84000 */  jalr       $v0
    /* E0878 800F0078 2188C000 */   addu      $s1, $a2, $zero
    /* E087C 800F007C 04000106 */  bgez       $s0, .L800F0090
    /* E0880 800F0080 21184000 */   addu      $v1, $v0, $zero
    /* E0884 800F0084 E9006290 */  lbu        $v0, 0xE9($v1)
    /* E0888 800F0088 46C00308 */  j          .L800F0118
    /* E088C 800F008C 00000000 */   nop
  .L800F0090:
    /* E0890 800F0090 E9006290 */  lbu        $v0, 0xE9($v1)
    /* E0894 800F0094 00000000 */  nop
    /* E0898 800F0098 2A100202 */  slt        $v0, $s0, $v0
    /* E089C 800F009C 1D004010 */  beqz       $v0, .L800F0114
    /* E08A0 800F00A0 80101000 */   sll       $v0, $s0, 2
    /* E08A4 800F00A4 0400638C */  lw         $v1, 0x4($v1)
    /* E08A8 800F00A8 21105000 */  addu       $v0, $v0, $s0
    /* E08AC 800F00AC FFFF2626 */  addiu      $a2, $s1, -0x1
    /* E08B0 800F00B0 21186200 */  addu       $v1, $v1, $v0
    /* E08B4 800F00B4 0500C22C */  sltiu      $v0, $a2, 0x5
    /* E08B8 800F00B8 16004010 */  beqz       $v0, .L800F0114
    /* E08BC 800F00BC 80100600 */   sll       $v0, $a2, 2
    /* E08C0 800F00C0 0580013C */  lui        $at, %hi(jtbl_80056EF8)
    /* E08C4 800F00C4 21082200 */  addu       $at, $at, $v0
    /* E08C8 800F00C8 F86E228C */  lw         $v0, %lo(jtbl_80056EF8)($at)
    /* E08CC 800F00CC 00000000 */  nop
    /* E08D0 800F00D0 08004000 */  jr         $v0
    /* E08D4 800F00D4 00000000 */   nop
  jlabel .L800F00D8
    /* E08D8 800F00D8 00006290 */  lbu        $v0, 0x0($v1)
    /* E08DC 800F00DC 46C00308 */  j          .L800F0118
    /* E08E0 800F00E0 00000000 */   nop
  jlabel .L800F00E4
    /* E08E4 800F00E4 01006290 */  lbu        $v0, 0x1($v1)
    /* E08E8 800F00E8 46C00308 */  j          .L800F0118
    /* E08EC 800F00EC 00000000 */   nop
  jlabel .L800F00F0
    /* E08F0 800F00F0 02006290 */  lbu        $v0, 0x2($v1)
    /* E08F4 800F00F4 46C00308 */  j          .L800F0118
    /* E08F8 800F00F8 00000000 */   nop
  jlabel .L800F00FC
    /* E08FC 800F00FC 03006290 */  lbu        $v0, 0x3($v1)
    /* E0900 800F0100 46C00308 */  j          .L800F0118
    /* E0904 800F0104 00000000 */   nop
  jlabel .L800F0108
    /* E0908 800F0108 04006290 */  lbu        $v0, 0x4($v1)
    /* E090C 800F010C 46C00308 */  j          .L800F0118
    /* E0910 800F0110 00000000 */   nop
  .L800F0114:
    /* E0914 800F0114 21100000 */  addu       $v0, $zero, $zero
  .L800F0118:
    /* E0918 800F0118 1800BF8F */  lw         $ra, 0x18($sp)
    /* E091C 800F011C 1400B18F */  lw         $s1, 0x14($sp)
    /* E0920 800F0120 1000B08F */  lw         $s0, 0x10($sp)
    /* E0924 800F0124 0800E003 */  jr         $ra
    /* E0928 800F0128 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PadInfoAct
