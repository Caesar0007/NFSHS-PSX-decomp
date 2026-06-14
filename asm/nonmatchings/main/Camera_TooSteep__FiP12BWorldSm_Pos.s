.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_TooSteep__FiP12BWorldSm_Pos, 0x170

glabel Camera_TooSteep__FiP12BWorldSm_Pos
    /* 74528 80083D28 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 7452C 80083D2C 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 74530 80083D30 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 74534 80083D34 00110400 */  sll        $v0, $a0, 4
    /* 74538 80083D38 21104400 */  addu       $v0, $v0, $a0
    /* 7453C 80083D3C 00110200 */  sll        $v0, $v0, 4
    /* 74540 80083D40 4800B2AF */  sw         $s2, 0x48($sp)
    /* 74544 80083D44 21904300 */  addu       $s2, $v0, $v1
    /* 74548 80083D48 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 7454C 80083D4C 4400B1AF */  sw         $s1, 0x44($sp)
    /* 74550 80083D50 4000B0AF */  sw         $s0, 0x40($sp)
    /* 74554 80083D54 0000508E */  lw         $s0, 0x0($s2)
    /* 74558 80083D58 2120A000 */  addu       $a0, $a1, $zero
    /* 7455C 80083D5C 4801020C */  jal        BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 74560 80083D60 08001026 */   addiu     $s0, $s0, 0x8
    /* 74564 80083D64 0000468C */  lw         $a2, 0x0($v0)
    /* 74568 80083D68 0400478C */  lw         $a3, 0x4($v0)
    /* 7456C 80083D6C 0800488C */  lw         $t0, 0x8($v0)
    /* 74570 80083D70 1000A6AF */  sw         $a2, 0x10($sp)
    /* 74574 80083D74 1400A7AF */  sw         $a3, 0x14($sp)
    /* 74578 80083D78 1800A8AF */  sw         $t0, 0x18($sp)
    /* 7457C 80083D7C 4801020C */  jal        BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 74580 80083D80 21200002 */   addu      $a0, $s0, $zero
    /* 74584 80083D84 0000468C */  lw         $a2, 0x0($v0)
    /* 74588 80083D88 0400478C */  lw         $a3, 0x4($v0)
    /* 7458C 80083D8C 0800488C */  lw         $t0, 0x8($v0)
    /* 74590 80083D90 2000A6AF */  sw         $a2, 0x20($sp)
    /* 74594 80083D94 2400A7AF */  sw         $a3, 0x24($sp)
    /* 74598 80083D98 2800A8AF */  sw         $t0, 0x28($sp)
    /* 7459C 80083D9C 1000A48F */  lw         $a0, 0x10($sp)
    /* 745A0 80083DA0 2000A58F */  lw         $a1, 0x20($sp)
    /* 745A4 80083DA4 CA90030C */  jal        fixedmult
    /* 745A8 80083DA8 00000000 */   nop
    /* 745AC 80083DAC 1400A48F */  lw         $a0, 0x14($sp)
    /* 745B0 80083DB0 2400A58F */  lw         $a1, 0x24($sp)
    /* 745B4 80083DB4 CA90030C */  jal        fixedmult
    /* 745B8 80083DB8 21804000 */   addu      $s0, $v0, $zero
    /* 745BC 80083DBC 1800A48F */  lw         $a0, 0x18($sp)
    /* 745C0 80083DC0 2800A58F */  lw         $a1, 0x28($sp)
    /* 745C4 80083DC4 CA90030C */  jal        fixedmult
    /* 745C8 80083DC8 21884000 */   addu      $s1, $v0, $zero
    /* 745CC 80083DCC 21801102 */  addu       $s0, $s0, $s1
    /* 745D0 80083DD0 21800202 */  addu       $s0, $s0, $v0
    /* 745D4 80083DD4 FCB40234 */  ori        $v0, $zero, 0xB4FC
    /* 745D8 80083DD8 2A105000 */  slt        $v0, $v0, $s0
    /* 745DC 80083DDC 28004014 */  bnez       $v0, .L80083E80
    /* 745E0 80083DE0 21100000 */   addu      $v0, $zero, $zero
    /* 745E4 80083DE4 0000428E */  lw         $v0, 0x0($s2)
    /* 745E8 80083DE8 00000000 */  nop
    /* 745EC 80083DEC A000458C */  lw         $a1, 0xA0($v0)
    /* 745F0 80083DF0 0800428E */  lw         $v0, 0x8($s2)
    /* 745F4 80083DF4 00000000 */  nop
    /* 745F8 80083DF8 2328A200 */  subu       $a1, $a1, $v0
    /* 745FC 80083DFC 3000A5AF */  sw         $a1, 0x30($sp)
    /* 74600 80083E00 0000428E */  lw         $v0, 0x0($s2)
    /* 74604 80083E04 0C00438E */  lw         $v1, 0xC($s2)
    /* 74608 80083E08 A400428C */  lw         $v0, 0xA4($v0)
    /* 7460C 80083E0C 00000000 */  nop
    /* 74610 80083E10 23104300 */  subu       $v0, $v0, $v1
    /* 74614 80083E14 3400A2AF */  sw         $v0, 0x34($sp)
    /* 74618 80083E18 0000428E */  lw         $v0, 0x0($s2)
    /* 7461C 80083E1C 1000438E */  lw         $v1, 0x10($s2)
    /* 74620 80083E20 A800428C */  lw         $v0, 0xA8($v0)
    /* 74624 80083E24 1000A48F */  lw         $a0, 0x10($sp)
    /* 74628 80083E28 23104300 */  subu       $v0, $v0, $v1
    /* 7462C 80083E2C CA90030C */  jal        fixedmult
    /* 74630 80083E30 3800A2AF */   sw        $v0, 0x38($sp)
    /* 74634 80083E34 1400A48F */  lw         $a0, 0x14($sp)
    /* 74638 80083E38 3400A58F */  lw         $a1, 0x34($sp)
    /* 7463C 80083E3C CA90030C */  jal        fixedmult
    /* 74640 80083E40 21804000 */   addu      $s0, $v0, $zero
    /* 74644 80083E44 1800A48F */  lw         $a0, 0x18($sp)
    /* 74648 80083E48 3800A58F */  lw         $a1, 0x38($sp)
    /* 7464C 80083E4C CA90030C */  jal        fixedmult
    /* 74650 80083E50 21884000 */   addu      $s1, $v0, $zero
    /* 74654 80083E54 21801102 */  addu       $s0, $s0, $s1
    /* 74658 80083E58 21800202 */  addu       $s0, $s0, $v0
    /* 7465C 80083E5C 0700001A */  blez       $s0, .L80083E7C
    /* 74660 80083E60 00000000 */   nop
    /* 74664 80083E64 0000428E */  lw         $v0, 0x0($s2)
    /* 74668 80083E68 00000000 */  nop
    /* 7466C 80083E6C 7C014394 */  lhu        $v1, 0x17C($v0)
    /* 74670 80083E70 00000000 */  nop
    /* 74674 80083E74 02006010 */  beqz       $v1, .L80083E80
    /* 74678 80083E78 01000224 */   addiu     $v0, $zero, 0x1
  .L80083E7C:
    /* 7467C 80083E7C 21100000 */  addu       $v0, $zero, $zero
  .L80083E80:
    /* 74680 80083E80 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 74684 80083E84 4800B28F */  lw         $s2, 0x48($sp)
    /* 74688 80083E88 4400B18F */  lw         $s1, 0x44($sp)
    /* 7468C 80083E8C 4000B08F */  lw         $s0, 0x40($sp)
    /* 74690 80083E90 0800E003 */  jr         $ra
    /* 74694 80083E94 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Camera_TooSteep__FiP12BWorldSm_Pos
