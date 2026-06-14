.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_SimplePhysics_LatVel__FP8Car_tObj, 0x124

glabel AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
    /* 5ADF4 8006A5F4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5ADF8 8006A5F8 2400B1AF */  sw         $s1, 0x24($sp)
    /* 5ADFC 8006A5FC 21888000 */  addu       $s1, $a0, $zero
    /* 5AE00 8006A600 2800BFAF */  sw         $ra, 0x28($sp)
    /* 5AE04 8006A604 2000B0AF */  sw         $s0, 0x20($sp)
    /* 5AE08 8006A608 6805238E */  lw         $v1, 0x568($s1)
    /* 5AE0C 8006A60C 0300023C */  lui        $v0, (0x30000 >> 16)
    /* 5AE10 8006A610 2A104300 */  slt        $v0, $v0, $v1
    /* 5AE14 8006A614 06004010 */  beqz       $v0, .L8006A630
    /* 5AE18 8006A618 21800000 */   addu      $s0, $zero, $zero
    /* 5AE1C 8006A61C 1807238E */  lw         $v1, 0x718($s1)
    /* 5AE20 8006A620 7405228E */  lw         $v0, 0x574($s1)
    /* 5AE24 8006A624 00000000 */  nop
    /* 5AE28 8006A628 23806200 */  subu       $s0, $v1, $v0
    /* 5AE2C 8006A62C 6805238E */  lw         $v1, 0x568($s1)
  .L8006A630:
    /* 5AE30 8006A630 1900023C */  lui        $v0, (0x190000 >> 16)
    /* 5AE34 8006A634 2A104300 */  slt        $v0, $v0, $v1
    /* 5AE38 8006A638 23004010 */  beqz       $v0, .L8006A6C8
    /* 5AE3C 8006A63C 00000000 */   nop
    /* 5AE40 8006A640 4401268E */  lw         $a2, 0x144($s1)
    /* 5AE44 8006A644 4801278E */  lw         $a3, 0x148($s1)
    /* 5AE48 8006A648 4C01288E */  lw         $t0, 0x14C($s1)
    /* 5AE4C 8006A64C 1000A6AF */  sw         $a2, 0x10($sp)
    /* 5AE50 8006A650 1400A7AF */  sw         $a3, 0x14($sp)
    /* 5AE54 8006A654 1800A8AF */  sw         $t0, 0x18($sp)
    /* 5AE58 8006A658 1000A58F */  lw         $a1, 0x10($sp)
    /* 5AE5C 8006A65C CA90030C */  jal        fixedmult
    /* 5AE60 8006A660 21200002 */   addu      $a0, $s0, $zero
    /* 5AE64 8006A664 1400A58F */  lw         $a1, 0x14($sp)
    /* 5AE68 8006A668 21200002 */  addu       $a0, $s0, $zero
    /* 5AE6C 8006A66C CA90030C */  jal        fixedmult
    /* 5AE70 8006A670 1000A2AF */   sw        $v0, 0x10($sp)
    /* 5AE74 8006A674 1800A58F */  lw         $a1, 0x18($sp)
    /* 5AE78 8006A678 21200002 */  addu       $a0, $s0, $zero
    /* 5AE7C 8006A67C CA90030C */  jal        fixedmult
    /* 5AE80 8006A680 1400A2AF */   sw        $v0, 0x14($sp)
    /* 5AE84 8006A684 1800A2AF */  sw         $v0, 0x18($sp)
    /* 5AE88 8006A688 A000228E */  lw         $v0, 0xA0($s1)
    /* 5AE8C 8006A68C 1000A38F */  lw         $v1, 0x10($sp)
    /* 5AE90 8006A690 00000000 */  nop
    /* 5AE94 8006A694 21104300 */  addu       $v0, $v0, $v1
    /* 5AE98 8006A698 A00022AE */  sw         $v0, 0xA0($s1)
    /* 5AE9C 8006A69C A400228E */  lw         $v0, 0xA4($s1)
    /* 5AEA0 8006A6A0 1400A38F */  lw         $v1, 0x14($sp)
    /* 5AEA4 8006A6A4 00000000 */  nop
    /* 5AEA8 8006A6A8 21104300 */  addu       $v0, $v0, $v1
    /* 5AEAC 8006A6AC A40022AE */  sw         $v0, 0xA4($s1)
    /* 5AEB0 8006A6B0 A800228E */  lw         $v0, 0xA8($s1)
    /* 5AEB4 8006A6B4 1800A38F */  lw         $v1, 0x18($sp)
    /* 5AEB8 8006A6B8 940520AE */  sw         $zero, 0x594($s1)
    /* 5AEBC 8006A6BC 21104300 */  addu       $v0, $v0, $v1
    /* 5AEC0 8006A6C0 C1A90108 */  j          .L8006A704
    /* 5AEC4 8006A6C4 A80022AE */   sw        $v0, 0xA8($s1)
  .L8006A6C8:
    /* 5AEC8 8006A6C8 6405228E */  lw         $v0, 0x564($s1)
    /* 5AECC 8006A6CC 00000000 */  nop
    /* 5AED0 8006A6D0 02004104 */  bgez       $v0, .L8006A6DC
    /* 5AED4 8006A6D4 21184000 */   addu      $v1, $v0, $zero
    /* 5AED8 8006A6D8 23180300 */  negu       $v1, $v1
  .L8006A6DC:
    /* 5AEDC 8006A6DC 23200300 */  negu       $a0, $v1
    /* 5AEE0 8006A6E0 2A100402 */  slt        $v0, $s0, $a0
    /* 5AEE4 8006A6E4 03004010 */  beqz       $v0, .L8006A6F4
    /* 5AEE8 8006A6E8 940530AE */   sw        $s0, 0x594($s1)
    /* 5AEEC 8006A6EC C1A90108 */  j          .L8006A704
    /* 5AEF0 8006A6F0 940524AE */   sw        $a0, 0x594($s1)
  .L8006A6F4:
    /* 5AEF4 8006A6F4 2A107000 */  slt        $v0, $v1, $s0
    /* 5AEF8 8006A6F8 02004010 */  beqz       $v0, .L8006A704
    /* 5AEFC 8006A6FC 00000000 */   nop
    /* 5AF00 8006A700 940523AE */  sw         $v1, 0x594($s1)
  .L8006A704:
    /* 5AF04 8006A704 2800BF8F */  lw         $ra, 0x28($sp)
    /* 5AF08 8006A708 2400B18F */  lw         $s1, 0x24($sp)
    /* 5AF0C 8006A70C 2000B08F */  lw         $s0, 0x20($sp)
    /* 5AF10 8006A710 0800E003 */  jr         $ra
    /* 5AF14 8006A714 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIPhysic_SimplePhysics_LatVel__FP8Car_tObj
