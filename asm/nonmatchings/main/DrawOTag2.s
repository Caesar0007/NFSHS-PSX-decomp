.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawOTag2, 0xFC

glabel DrawOTag2
    /* E0510 800EFD10 1280023C */  lui        $v0, %hi(D_8012369E)
    /* E0514 800EFD14 9E364290 */  lbu        $v0, %lo(D_8012369E)($v0)
    /* E0518 800EFD18 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E051C 800EFD1C 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0520 800EFD20 21808000 */  addu       $s0, $a0, $zero
    /* E0524 800EFD24 0200422C */  sltiu      $v0, $v0, 0x2
    /* E0528 800EFD28 08004014 */  bnez       $v0, .L800EFD4C
    /* E052C 800EFD2C 1400BFAF */   sw        $ra, 0x14($sp)
    /* E0530 800EFD30 0580043C */  lui        $a0, %hi(D_80056E58)
    /* E0534 800EFD34 586E8424 */  addiu      $a0, $a0, %lo(D_80056E58)
    /* E0538 800EFD38 1280023C */  lui        $v0, %hi(GPU_printf)
    /* E053C 800EFD3C 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* E0540 800EFD40 00000000 */  nop
    /* E0544 800EFD44 09F84000 */  jalr       $v0
    /* E0548 800EFD48 21280002 */   addu      $a1, $s0, $zero
  .L800EFD4C:
    /* E054C 800EFD4C C7C8030C */  jal        VSync
    /* E0550 800EFD50 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* E0554 800EFD54 1280033C */  lui        $v1, %hi(D_801237B0)
    /* E0558 800EFD58 B037638C */  lw         $v1, %lo(D_801237B0)($v1)
    /* E055C 800EFD5C F0004224 */  addiu      $v0, $v0, 0xF0
    /* E0560 800EFD60 1280013C */  lui        $at, %hi(D_801237D8)
    /* E0564 800EFD64 D83722AC */  sw         $v0, %lo(D_801237D8)($at)
    /* E0568 800EFD68 1280013C */  lui        $at, %hi(D_801237DC)
    /* E056C 800EFD6C DC3720AC */  sw         $zero, %lo(D_801237DC)($at)
    /* E0570 800EFD70 0000628C */  lw         $v0, 0x0($v1)
    /* E0574 800EFD74 68BF0308 */  j          .L800EFDA0
    /* E0578 800EFD78 0001033C */   lui       $v1, (0x1000000 >> 16)
  .L800EFD7C:
    /* E057C 800EFD7C CBBE030C */  jal        func_800EFB2C
    /* E0580 800EFD80 00000000 */   nop
    /* E0584 800EFD84 1D004014 */  bnez       $v0, .L800EFDFC
    /* E0588 800EFD88 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* E058C 800EFD8C 1280023C */  lui        $v0, %hi(D_801237B0)
    /* E0590 800EFD90 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* E0594 800EFD94 00000000 */  nop
    /* E0598 800EFD98 0000428C */  lw         $v0, 0x0($v0)
    /* E059C 800EFD9C 0001033C */  lui        $v1, (0x1000000 >> 16)
  .L800EFDA0:
    /* E05A0 800EFDA0 24104300 */  and        $v0, $v0, $v1
    /* E05A4 800EFDA4 F5FF4014 */  bnez       $v0, .L800EFD7C
    /* E05A8 800EFDA8 00000000 */   nop
    /* E05AC 800EFDAC 1280023C */  lui        $v0, %hi(D_801237A4)
    /* E05B0 800EFDB0 A437428C */  lw         $v0, %lo(D_801237A4)($v0)
    /* E05B4 800EFDB4 00000000 */  nop
    /* E05B8 800EFDB8 0000428C */  lw         $v0, 0x0($v0)
    /* E05BC 800EFDBC 0004033C */  lui        $v1, (0x4000000 >> 16)
    /* E05C0 800EFDC0 24104300 */  and        $v0, $v0, $v1
    /* E05C4 800EFDC4 EDFF4010 */  beqz       $v0, .L800EFD7C
    /* E05C8 800EFDC8 00000000 */   nop
    /* E05CC 800EFDCC 0F80053C */  lui        $a1, %hi(func_800EFE0C)
    /* E05D0 800EFDD0 0CFEA524 */  addiu      $a1, $a1, %lo(func_800EFE0C)
    /* E05D4 800EFDD4 2BCA030C */  jal        DMACallback
    /* E05D8 800EFDD8 02000424 */   addiu     $a0, $zero, 0x2
    /* E05DC 800EFDDC 1280023C */  lui        $v0, %hi(D_80123694)
    /* E05E0 800EFDE0 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* E05E4 800EFDE4 00000000 */  nop
    /* E05E8 800EFDE8 1800428C */  lw         $v0, 0x18($v0)
    /* E05EC 800EFDEC 00000000 */  nop
    /* E05F0 800EFDF0 09F84000 */  jalr       $v0
    /* E05F4 800EFDF4 21200002 */   addu      $a0, $s0, $zero
    /* E05F8 800EFDF8 21100000 */  addu       $v0, $zero, $zero
  .L800EFDFC:
    /* E05FC 800EFDFC 1400BF8F */  lw         $ra, 0x14($sp)
    /* E0600 800EFE00 1000B08F */  lw         $s0, 0x10($sp)
    /* E0604 800EFE04 0800E003 */  jr         $ra
    /* E0608 800EFE08 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DrawOTag2
