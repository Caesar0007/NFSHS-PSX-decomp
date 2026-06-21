.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_setopts, 0x124

glabel MCRD_setopts
    /* 3FD94 8004F594 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3FD98 8004F598 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3FD9C 8004F59C 21888000 */  addu       $s1, $a0, $zero
    /* 3FDA0 8004F5A0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3FDA4 8004F5A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3FDA8 8004F5A8 0400228E */  lw         $v0, 0x4($s1)
    /* 3FDAC 8004F5AC 00000000 */  nop
    /* 3FDB0 8004F5B0 20004010 */  beqz       $v0, .L8004F634
    /* 3FDB4 8004F5B4 0580023C */   lui       $v0, %hi(gMemCardInfo)
    /* 3FDB8 8004F5B8 682D4424 */  addiu      $a0, $v0, %lo(gMemCardInfo)
    /* 3FDBC 8004F5BC 42000224 */  addiu      $v0, $zero, 0x42
    /* 3FDC0 8004F5C0 040082A0 */  sb         $v0, 0x4($a0)
    /* 3FDC4 8004F5C4 0000238E */  lw         $v1, 0x0($s1)
    /* 3FDC8 8004F5C8 01000224 */  addiu      $v0, $zero, 0x1
    /* 3FDCC 8004F5CC 07006210 */  beq        $v1, $v0, .L8004F5EC
    /* 3FDD0 8004F5D0 49000224 */   addiu     $v0, $zero, 0x49
    /* 3FDD4 8004F5D4 0A006010 */  beqz       $v1, .L8004F600
    /* 3FDD8 8004F5D8 02000224 */   addiu     $v0, $zero, 0x2
    /* 3FDDC 8004F5DC 05006210 */  beq        $v1, $v0, .L8004F5F4
    /* 3FDE0 8004F5E0 0580033C */   lui       $v1, %hi(D_80052D6D)
    /* 3FDE4 8004F5E4 823D0108 */  j          .L8004F608
    /* 3FDE8 8004F5E8 41000224 */   addiu     $v0, $zero, 0x41
  .L8004F5EC:
    /* 3FDEC 8004F5EC 833D0108 */  j          .L8004F60C
    /* 3FDF0 8004F5F0 050082A0 */   sb        $v0, 0x5($a0)
  .L8004F5F4:
    /* 3FDF4 8004F5F4 45000224 */  addiu      $v0, $zero, 0x45
    /* 3FDF8 8004F5F8 833D0108 */  j          .L8004F60C
    /* 3FDFC 8004F5FC 050082A0 */   sb        $v0, 0x5($a0)
  .L8004F600:
    /* 3FE00 8004F600 0580033C */  lui        $v1, %hi(D_80052D6D)
    /* 3FE04 8004F604 41000224 */  addiu      $v0, $zero, 0x41
  .L8004F608:
    /* 3FE08 8004F608 6D2D62A0 */  sb         $v0, %lo(D_80052D6D)($v1)
  .L8004F60C:
    /* 3FE0C 8004F60C 0580103C */  lui        $s0, %hi(D_80052D6E)
    /* 3FE10 8004F610 6E2D1026 */  addiu      $s0, $s0, %lo(D_80052D6E)
    /* 3FE14 8004F614 21200002 */  addu       $a0, $s0, $zero
    /* 3FE18 8004F618 0400258E */  lw         $a1, 0x4($s1)
    /* 3FE1C 8004F61C 41D8030C */  jal        strncpy
    /* 3FE20 8004F620 0A000624 */   addiu     $a2, $zero, 0xA
    /* 3FE24 8004F624 0A0000A2 */  sb         $zero, 0xA($s0)
    /* 3FE28 8004F628 0000228E */  lw         $v0, 0x0($s1)
    /* 3FE2C 8004F62C 913D0108 */  j          .L8004F644
    /* 3FE30 8004F630 FAFF02AE */   sw        $v0, -0x6($s0)
  .L8004F634:
    /* 3FE34 8004F634 0580033C */  lui        $v1, %hi(gMemCardInfo)
    /* 3FE38 8004F638 682D6224 */  addiu      $v0, $v1, %lo(gMemCardInfo)
    /* 3FE3C 8004F63C 040040A0 */  sb         $zero, 0x4($v0)
    /* 3FE40 8004F640 682D60AC */  sw         $zero, %lo(gMemCardInfo)($v1)
  .L8004F644:
    /* 3FE44 8004F644 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 3FE48 8004F648 1400238E */  lw         $v1, 0x14($s1)
    /* 3FE4C 8004F64C 682D4224 */  addiu      $v0, $v0, %lo(gMemCardInfo)
    /* 3FE50 8004F650 200043AC */  sw         $v1, 0x20($v0)
    /* 3FE54 8004F654 1800238E */  lw         $v1, 0x18($s1)
    /* 3FE58 8004F658 00000000 */  nop
    /* 3FE5C 8004F65C 240043AC */  sw         $v1, 0x24($v0)
    /* 3FE60 8004F660 1C00238E */  lw         $v1, 0x1C($s1)
    /* 3FE64 8004F664 00000000 */  nop
    /* 3FE68 8004F668 280043AC */  sw         $v1, 0x28($v0)
    /* 3FE6C 8004F66C 2000238E */  lw         $v1, 0x20($s1)
    /* 3FE70 8004F670 00000000 */  nop
    /* 3FE74 8004F674 2C0043AC */  sw         $v1, 0x2C($v0)
    /* 3FE78 8004F678 0800238E */  lw         $v1, 0x8($s1)
    /* 3FE7C 8004F67C 00000000 */  nop
    /* 3FE80 8004F680 140043AC */  sw         $v1, 0x14($v0)
    /* 3FE84 8004F684 0F00278A */  lwl        $a3, 0xF($s1)
    /* 3FE88 8004F688 0C00279A */  lwr        $a3, 0xC($s1)
    /* 3FE8C 8004F68C 1300288A */  lwl        $t0, 0x13($s1)
    /* 3FE90 8004F690 1000289A */  lwr        $t0, 0x10($s1)
    /* 3FE94 8004F694 1B0047A8 */  swl        $a3, 0x1B($v0)
    /* 3FE98 8004F698 180047B8 */  swr        $a3, 0x18($v0)
    /* 3FE9C 8004F69C 1F0048A8 */  swl        $t0, 0x1F($v0)
    /* 3FEA0 8004F6A0 1C0048B8 */  swr        $t0, 0x1C($v0)
    /* 3FEA4 8004F6A4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 3FEA8 8004F6A8 1400B18F */  lw         $s1, 0x14($sp)
    /* 3FEAC 8004F6AC 1000B08F */  lw         $s0, 0x10($sp)
    /* 3FEB0 8004F6B0 0800E003 */  jr         $ra
    /* 3FEB4 8004F6B4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel MCRD_setopts
