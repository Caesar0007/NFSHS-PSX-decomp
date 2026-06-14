.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Texture_Vramcf__FP8shapetbliiii, 0x168

glabel Texture_Vramcf__FP8shapetbliiii
    /* D0538 800DFD38 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* D053C 800DFD3C 3000B4AF */  sw         $s4, 0x30($sp)
    /* D0540 800DFD40 21A08000 */  addu       $s4, $a0, $zero
    /* D0544 800DFD44 3400B5AF */  sw         $s5, 0x34($sp)
    /* D0548 800DFD48 21A8A000 */  addu       $s5, $a1, $zero
    /* D054C 800DFD4C 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* D0550 800DFD50 21B8C000 */  addu       $s7, $a2, $zero
    /* D0554 800DFD54 4000BEAF */  sw         $fp, 0x40($sp)
    /* D0558 800DFD58 5800BE8F */  lw         $fp, 0x58($sp)
    /* D055C 800DFD5C 4400BFAF */  sw         $ra, 0x44($sp)
    /* D0560 800DFD60 3800B6AF */  sw         $s6, 0x38($sp)
    /* D0564 800DFD64 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* D0568 800DFD68 2800B2AF */  sw         $s2, 0x28($sp)
    /* D056C 800DFD6C 2400B1AF */  sw         $s1, 0x24($sp)
    /* D0570 800DFD70 2000B0AF */  sw         $s0, 0x20($sp)
    /* D0574 800DFD74 F9D0030C */  jal        shapedepth
    /* D0578 800DFD78 5400A7AF */   sw        $a3, 0x54($sp)
    /* D057C 800DFD7C 04008386 */  lh         $v1, 0x4($s4)
    /* D0580 800DFD80 00000000 */  nop
    /* D0584 800DFD84 18006200 */  mult       $v1, $v0
    /* D0588 800DFD88 F0FF0224 */  addiu      $v0, $zero, -0x10
    /* D058C 800DFD8C 12400000 */  mflo       $t0
    /* D0590 800DFD90 0F000325 */  addiu      $v1, $t0, 0xF
    /* D0594 800DFD94 24B06200 */  and        $s6, $v1, $v0
    /* D0598 800DFD98 C3801600 */  sra        $s0, $s6, 3
    /* D059C 800DFD9C 02000232 */  andi       $v0, $s0, 0x2
    /* D05A0 800DFDA0 2E004010 */  beqz       $v0, .L800DFE5C
    /* D05A4 800DFDA4 21208002 */   addu      $a0, $s4, $zero
    /* D05A8 800DFDA8 06009296 */  lhu        $s2, 0x6($s4)
    /* D05AC 800DFDAC 00000000 */  nop
    /* D05B0 800DFDB0 01004232 */  andi       $v0, $s2, 0x1
    /* D05B4 800DFDB4 2A004014 */  bnez       $v0, .L800DFE60
    /* D05B8 800DFDB8 2128A002 */   addu      $a1, $s5, $zero
    /* D05BC 800DFDBC 00941200 */  sll        $s2, $s2, 16
    /* D05C0 800DFDC0 03941200 */  sra        $s2, $s2, 16
    /* D05C4 800DFDC4 FFFF4226 */  addiu      $v0, $s2, -0x1
    /* D05C8 800DFDC8 18005000 */  mult       $v0, $s0
    /* D05CC 800DFDCC 1800A427 */  addiu      $a0, $sp, 0x18
    /* D05D0 800DFDD0 2188F202 */  addu       $s1, $s7, $s2
    /* D05D4 800DFDD4 FEFF2226 */  addiu      $v0, $s1, -0x2
    /* D05D8 800DFDD8 01001324 */  addiu      $s3, $zero, 0x1
    /* D05DC 800DFDDC 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* D05E0 800DFDE0 02000224 */  addiu      $v0, $zero, 0x2
    /* D05E4 800DFDE4 1800B5A7 */  sh         $s5, 0x18($sp)
    /* D05E8 800DFDE8 1C00B3A7 */  sh         $s3, 0x1C($sp)
    /* D05EC 800DFDEC 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* D05F0 800DFDF0 12400000 */  mflo       $t0
    /* D05F4 800DFDF4 10001025 */  addiu      $s0, $t0, 0x10
    /* D05F8 800DFDF8 21809002 */  addu       $s0, $s4, $s0
    /* D05FC 800DFDFC A4B6030C */  jal        LoadImage
    /* D0600 800DFE00 FEFF0526 */   addiu     $a1, $s0, -0x2
    /* D0604 800DFE04 1800A427 */  addiu      $a0, $sp, 0x18
    /* D0608 800DFE08 02000526 */  addiu      $a1, $s0, 0x2
    /* D060C 800DFE0C 0100A226 */  addiu      $v0, $s5, 0x1
    /* D0610 800DFE10 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D0614 800DFE14 1800A2A7 */  sh         $v0, 0x18($sp)
    /* D0618 800DFE18 03111600 */  sra        $v0, $s6, 4
    /* D061C 800DFE1C FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D0620 800DFE20 1A00B1A7 */  sh         $s1, 0x1A($sp)
    /* D0624 800DFE24 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* D0628 800DFE28 A4B6030C */  jal        LoadImage
    /* D062C 800DFE2C 1E00B3A7 */   sh        $s3, 0x1E($sp)
    /* D0630 800DFE30 21208002 */  addu       $a0, $s4, $zero
    /* D0634 800DFE34 2128A002 */  addu       $a1, $s5, $zero
    /* D0638 800DFE38 2130E002 */  addu       $a2, $s7, $zero
    /* D063C 800DFE3C 06008296 */  lhu        $v0, 0x6($s4)
    /* D0640 800DFE40 5400A78F */  lw         $a3, 0x54($sp)
    /* D0644 800DFE44 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D0648 800DFE48 060082A6 */  sh         $v0, 0x6($s4)
    /* D064C 800DFE4C E37E030C */  jal        Texture_Vramf__FP8shapetbliiii
    /* D0650 800DFE50 1000BEAF */   sw        $fp, 0x10($sp)
    /* D0654 800DFE54 9C7F0308 */  j          .L800DFE70
    /* D0658 800DFE58 060092A6 */   sh        $s2, 0x6($s4)
  .L800DFE5C:
    /* D065C 800DFE5C 2128A002 */  addu       $a1, $s5, $zero
  .L800DFE60:
    /* D0660 800DFE60 5400A78F */  lw         $a3, 0x54($sp)
    /* D0664 800DFE64 2130E002 */  addu       $a2, $s7, $zero
    /* D0668 800DFE68 E37E030C */  jal        Texture_Vramf__FP8shapetbliiii
    /* D066C 800DFE6C 1000BEAF */   sw        $fp, 0x10($sp)
  .L800DFE70:
    /* D0670 800DFE70 4400BF8F */  lw         $ra, 0x44($sp)
    /* D0674 800DFE74 4000BE8F */  lw         $fp, 0x40($sp)
    /* D0678 800DFE78 3C00B78F */  lw         $s7, 0x3C($sp)
    /* D067C 800DFE7C 3800B68F */  lw         $s6, 0x38($sp)
    /* D0680 800DFE80 3400B58F */  lw         $s5, 0x34($sp)
    /* D0684 800DFE84 3000B48F */  lw         $s4, 0x30($sp)
    /* D0688 800DFE88 2C00B38F */  lw         $s3, 0x2C($sp)
    /* D068C 800DFE8C 2800B28F */  lw         $s2, 0x28($sp)
    /* D0690 800DFE90 2400B18F */  lw         $s1, 0x24($sp)
    /* D0694 800DFE94 2000B08F */  lw         $s0, 0x20($sp)
    /* D0698 800DFE98 0800E003 */  jr         $ra
    /* D069C 800DFE9C 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Texture_Vramcf__FP8shapetbliiii
