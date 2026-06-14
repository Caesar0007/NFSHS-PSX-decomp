.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005C5E4, 0x1AC

glabel func_8005C5E4
    /* 4CDE4 8005C5E4 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 4CDE8 8005C5E8 C400B3AF */  sw         $s3, 0xC4($sp)
    /* 4CDEC 8005C5EC 2198A000 */  addu       $s3, $a1, $zero
    /* 4CDF0 8005C5F0 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 4CDF4 8005C5F4 48FA428C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v0)
    /* 4CDF8 8005C5F8 2000A627 */  addiu      $a2, $sp, 0x20
    /* 4CDFC 8005C5FC C800BFAF */  sw         $ra, 0xC8($sp)
    /* 4CE00 8005C600 C000B2AF */  sw         $s2, 0xC0($sp)
    /* 4CE04 8005C604 BC00B1AF */  sw         $s1, 0xBC($sp)
    /* 4CE08 8005C608 B800B0AF */  sw         $s0, 0xB8($sp)
    /* 4CE0C 8005C60C 0000678E */  lw         $a3, 0x0($s3)
    /* 4CE10 8005C610 0400688E */  lw         $t0, 0x4($s3)
    /* 4CE14 8005C614 0800698E */  lw         $t1, 0x8($s3)
    /* 4CE18 8005C618 A800A7AF */  sw         $a3, 0xA8($sp)
    /* 4CE1C 8005C61C AC00A8AF */  sw         $t0, 0xAC($sp)
    /* 4CE20 8005C620 B000A9AF */  sw         $t1, 0xB0($sp)
    /* 4CE24 8005C624 08004524 */  addiu      $a1, $v0, 0x8
    /* 4CE28 8005C628 88004224 */  addiu      $v0, $v0, 0x88
  .L8005C62C:
    /* 4CE2C 8005C62C 0000A78C */  lw         $a3, 0x0($a1)
    /* 4CE30 8005C630 0400A88C */  lw         $t0, 0x4($a1)
    /* 4CE34 8005C634 0800A98C */  lw         $t1, 0x8($a1)
    /* 4CE38 8005C638 0C00AA8C */  lw         $t2, 0xC($a1)
    /* 4CE3C 8005C63C 0000C7AC */  sw         $a3, 0x0($a2)
    /* 4CE40 8005C640 0400C8AC */  sw         $t0, 0x4($a2)
    /* 4CE44 8005C644 0800C9AC */  sw         $t1, 0x8($a2)
    /* 4CE48 8005C648 0C00CAAC */  sw         $t2, 0xC($a2)
    /* 4CE4C 8005C64C 1000A524 */  addiu      $a1, $a1, 0x10
    /* 4CE50 8005C650 F6FFA214 */  bne        $a1, $v0, .L8005C62C
    /* 4CE54 8005C654 1000C624 */   addiu     $a2, $a2, 0x10
    /* 4CE58 8005C658 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 4CE5C 8005C65C C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 4CE60 8005C660 40190400 */  sll        $v1, $a0, 5
    /* 4CE64 8005C664 0000A78C */  lw         $a3, 0x0($a1)
    /* 4CE68 8005C668 00000000 */  nop
    /* 4CE6C 8005C66C 0000C7AC */  sw         $a3, 0x0($a2)
    /* 4CE70 8005C670 2000A4A7 */  sh         $a0, 0x20($sp)
    /* 4CE74 8005C674 21106200 */  addu       $v0, $v1, $v0
    /* 4CE78 8005C678 0000478C */  lw         $a3, 0x0($v0)
    /* 4CE7C 8005C67C 0400488C */  lw         $t0, 0x4($v0)
    /* 4CE80 8005C680 0800498C */  lw         $t1, 0x8($v0)
    /* 4CE84 8005C684 1000A7AF */  sw         $a3, 0x10($sp)
    /* 4CE88 8005C688 1400A8AF */  sw         $t0, 0x14($sp)
    /* 4CE8C 8005C68C 1800A9AF */  sw         $t1, 0x18($sp)
    /* 4CE90 8005C690 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 4CE94 8005C694 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 4CE98 8005C698 A800A58F */  lw         $a1, 0xA8($sp)
    /* 4CE9C 8005C69C 21186200 */  addu       $v1, $v1, $v0
    /* 4CEA0 8005C6A0 12006480 */  lb         $a0, 0x12($v1)
    /* 4CEA4 8005C6A4 14007280 */  lb         $s2, 0x14($v1)
    /* 4CEA8 8005C6A8 0F007080 */  lb         $s0, 0xF($v1)
    /* 4CEAC 8005C6AC 11007180 */  lb         $s1, 0x11($v1)
    /* 4CEB0 8005C6B0 40220400 */  sll        $a0, $a0, 9
    /* 4CEB4 8005C6B4 40921200 */  sll        $s2, $s2, 9
    /* 4CEB8 8005C6B8 40821000 */  sll        $s0, $s0, 9
    /* 4CEBC 8005C6BC CA90030C */  jal        fixedmult
    /* 4CEC0 8005C6C0 408A1100 */   sll       $s1, $s1, 9
    /* 4CEC4 8005C6C4 21200002 */  addu       $a0, $s0, $zero
    /* 4CEC8 8005C6C8 B000A58F */  lw         $a1, 0xB0($sp)
    /* 4CECC 8005C6CC CA90030C */  jal        fixedmult
    /* 4CED0 8005C6D0 21804000 */   addu      $s0, $v0, $zero
    /* 4CED4 8005C6D4 1000A38F */  lw         $v1, 0x10($sp)
    /* 4CED8 8005C6D8 00000000 */  nop
    /* 4CEDC 8005C6DC 21187000 */  addu       $v1, $v1, $s0
    /* 4CEE0 8005C6E0 21186200 */  addu       $v1, $v1, $v0
    /* 4CEE4 8005C6E4 000063AE */  sw         $v1, 0x0($s3)
    /* 4CEE8 8005C6E8 1400A28F */  lw         $v0, 0x14($sp)
    /* 4CEEC 8005C6EC 00000000 */  nop
    /* 4CEF0 8005C6F0 040062AE */  sw         $v0, 0x4($s3)
    /* 4CEF4 8005C6F4 A800A58F */  lw         $a1, 0xA8($sp)
    /* 4CEF8 8005C6F8 CA90030C */  jal        fixedmult
    /* 4CEFC 8005C6FC 21204002 */   addu      $a0, $s2, $zero
    /* 4CF00 8005C700 21202002 */  addu       $a0, $s1, $zero
    /* 4CF04 8005C704 B000A58F */  lw         $a1, 0xB0($sp)
    /* 4CF08 8005C708 CA90030C */  jal        fixedmult
    /* 4CF0C 8005C70C 21884000 */   addu      $s1, $v0, $zero
    /* 4CF10 8005C710 21206002 */  addu       $a0, $s3, $zero
    /* 4CF14 8005C714 2000B027 */  addiu      $s0, $sp, 0x20
    /* 4CF18 8005C718 21280002 */  addu       $a1, $s0, $zero
    /* 4CF1C 8005C71C 1800A38F */  lw         $v1, 0x18($sp)
    /* 4CF20 8005C720 01000624 */  addiu      $a2, $zero, 0x1
    /* 4CF24 8005C724 21187100 */  addu       $v1, $v1, $s1
    /* 4CF28 8005C728 21186200 */  addu       $v1, $v1, $v0
    /* 4CF2C 8005C72C B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 4CF30 8005C730 080063AE */   sw        $v1, 0x8($s3)
    /* 4CF34 8005C734 4801020C */  jal        BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 4CF38 8005C738 21200002 */   addu      $a0, $s0, $zero
    /* 4CF3C 8005C73C 9800A38F */  lw         $v1, 0x98($sp)
    /* 4CF40 8005C740 00000000 */  nop
    /* 4CF44 8005C744 03006010 */  beqz       $v1, .L8005C754
    /* 4CF48 8005C748 21204000 */   addu      $a0, $v0, $zero
    /* 4CF4C 8005C74C DA710108 */  j          .L8005C768
    /* 4CF50 8005C750 2800A527 */   addiu     $a1, $sp, 0x28
  .L8005C754:
    /* 4CF54 8005C754 2000A287 */  lh         $v0, 0x20($sp)
    /* 4CF58 8005C758 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 4CF5C 8005C75C C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 4CF60 8005C760 40110200 */  sll        $v0, $v0, 5
    /* 4CF64 8005C764 21286200 */  addu       $a1, $v1, $v0
  .L8005C768:
    /* 4CF68 8005C768 45D8020C */  jal        GetPlaneY__FPC8coorddefN20
    /* 4CF6C 8005C76C 21306002 */   addu      $a2, $s3, $zero
    /* 4CF70 8005C770 040062AE */  sw         $v0, 0x4($s3)
    /* 4CF74 8005C774 C800BF8F */  lw         $ra, 0xC8($sp)
    /* 4CF78 8005C778 C400B38F */  lw         $s3, 0xC4($sp)
    /* 4CF7C 8005C77C C000B28F */  lw         $s2, 0xC0($sp)
    /* 4CF80 8005C780 BC00B18F */  lw         $s1, 0xBC($sp)
    /* 4CF84 8005C784 B800B08F */  lw         $s0, 0xB8($sp)
    /* 4CF88 8005C788 0800E003 */  jr         $ra
    /* 4CF8C 8005C78C D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel func_8005C5E4
