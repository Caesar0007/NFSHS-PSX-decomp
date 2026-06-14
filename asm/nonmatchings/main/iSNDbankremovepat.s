.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDbankremovepat, 0x108

glabel iSNDbankremovepat
    /* EEDB4 800FE5B4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* EEDB8 800FE5B8 1800B2AF */  sw         $s2, 0x18($sp)
    /* EEDBC 800FE5BC 2190A000 */  addu       $s2, $a1, $zero
    /* EEDC0 800FE5C0 2000B4AF */  sw         $s4, 0x20($sp)
    /* EEDC4 800FE5C4 21A0C000 */  addu       $s4, $a2, $zero
    /* EEDC8 800FE5C8 1480033C */  lui        $v1, %hi(D_801478F8)
    /* EEDCC 800FE5CC 40100400 */  sll        $v0, $a0, 1
    /* EEDD0 800FE5D0 21104400 */  addu       $v0, $v0, $a0
    /* EEDD4 800FE5D4 F878638C */  lw         $v1, %lo(D_801478F8)($v1)
    /* EEDD8 800FE5D8 80100200 */  sll        $v0, $v0, 2
    /* EEDDC 800FE5DC 2400BFAF */  sw         $ra, 0x24($sp)
    /* EEDE0 800FE5E0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* EEDE4 800FE5E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* EEDE8 800FE5E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* EEDEC 800FE5EC 21104300 */  addu       $v0, $v0, $v1
    /* EEDF0 800FE5F0 0000508C */  lw         $s0, 0x0($v0)
    /* EEDF4 800FE5F4 00000000 */  nop
    /* EEDF8 800FE5F8 04000292 */  lbu        $v0, 0x4($s0)
    /* EEDFC 800FE5FC 04001324 */  addiu      $s3, $zero, 0x4
    /* EEE00 800FE600 02005314 */  bne        $v0, $s3, .L800FE60C
    /* EEE04 800FE604 21880000 */   addu      $s1, $zero, $zero
    /* EEE08 800FE608 21880002 */  addu       $s1, $s0, $zero
  .L800FE60C:
    /* EEE0C 800FE60C AFF9030C */  jal        iSNDvalidbank
    /* EEE10 800FE610 00000000 */   nop
    /* EEE14 800FE614 21004014 */  bnez       $v0, .L800FE69C
    /* EEE18 800FE618 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* EEE1C 800FE61C 1F004006 */  bltz       $s2, .L800FE69C
    /* EEE20 800FE620 00000000 */   nop
    /* EEE24 800FE624 06000296 */  lhu        $v0, 0x6($s0)
    /* EEE28 800FE628 00000000 */  nop
    /* EEE2C 800FE62C 2A104202 */  slt        $v0, $s2, $v0
    /* EEE30 800FE630 1A004010 */  beqz       $v0, .L800FE69C
    /* EEE34 800FE634 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* EEE38 800FE638 04000292 */  lbu        $v0, 0x4($s0)
    /* EEE3C 800FE63C 00000000 */  nop
    /* EEE40 800FE640 05005314 */  bne        $v0, $s3, .L800FE658
    /* EEE44 800FE644 80101200 */   sll       $v0, $s2, 2
    /* EEE48 800FE648 21102202 */  addu       $v0, $s1, $v0
    /* EEE4C 800FE64C 1400448C */  lw         $a0, 0x14($v0)
    /* EEE50 800FE650 98F90308 */  j          .L800FE660
    /* EEE54 800FE654 00000000 */   nop
  .L800FE658:
    /* EEE58 800FE658 21100202 */  addu       $v0, $s0, $v0
    /* EEE5C 800FE65C 0C00448C */  lw         $a0, 0xC($v0)
  .L800FE660:
    /* EEE60 800FE660 00000000 */  nop
    /* EEE64 800FE664 0D008010 */  beqz       $a0, .L800FE69C
    /* EEE68 800FE668 F8FF0224 */   addiu     $v0, $zero, -0x8
    /* EEE6C 800FE66C 7009040C */  jal        iSNDremovetaggedpatch
    /* EEE70 800FE670 21288002 */   addu      $a1, $s4, $zero
    /* EEE74 800FE674 04000392 */  lbu        $v1, 0x4($s0)
    /* EEE78 800FE678 04000224 */  addiu      $v0, $zero, 0x4
    /* EEE7C 800FE67C 04006214 */  bne        $v1, $v0, .L800FE690
    /* EEE80 800FE680 80101200 */   sll       $v0, $s2, 2
    /* EEE84 800FE684 21102202 */  addu       $v0, $s1, $v0
    /* EEE88 800FE688 A6F90308 */  j          .L800FE698
    /* EEE8C 800FE68C 140040AC */   sw        $zero, 0x14($v0)
  .L800FE690:
    /* EEE90 800FE690 21100202 */  addu       $v0, $s0, $v0
    /* EEE94 800FE694 0C0040AC */  sw         $zero, 0xC($v0)
  .L800FE698:
    /* EEE98 800FE698 21100000 */  addu       $v0, $zero, $zero
  .L800FE69C:
    /* EEE9C 800FE69C 2400BF8F */  lw         $ra, 0x24($sp)
    /* EEEA0 800FE6A0 2000B48F */  lw         $s4, 0x20($sp)
    /* EEEA4 800FE6A4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* EEEA8 800FE6A8 1800B28F */  lw         $s2, 0x18($sp)
    /* EEEAC 800FE6AC 1400B18F */  lw         $s1, 0x14($sp)
    /* EEEB0 800FE6B0 1000B08F */  lw         $s0, 0x10($sp)
    /* EEEB4 800FE6B4 0800E003 */  jr         $ra
    /* EEEB8 800FE6B8 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSNDbankremovepat
