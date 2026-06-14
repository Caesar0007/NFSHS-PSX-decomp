.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80109F5C, 0x100

glabel func_80109F5C
    /* FA75C 80109F5C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* FA760 80109F60 1800B2AF */  sw         $s2, 0x18($sp)
    /* FA764 80109F64 21908000 */  addu       $s2, $a0, $zero
    /* FA768 80109F68 2000B4AF */  sw         $s4, 0x20($sp)
    /* FA76C 80109F6C 21A0A000 */  addu       $s4, $a1, $zero
    /* FA770 80109F70 2800BFAF */  sw         $ra, 0x28($sp)
    /* FA774 80109F74 2400B5AF */  sw         $s5, 0x24($sp)
    /* FA778 80109F78 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* FA77C 80109F7C 1400B1AF */  sw         $s1, 0x14($sp)
    /* FA780 80109F80 1000B0AF */  sw         $s0, 0x10($sp)
    /* FA784 80109F84 0000428E */  lw         $v0, 0x0($s2)
    /* FA788 80109F88 00000000 */  nop
    /* FA78C 80109F8C 03004014 */  bnez       $v0, .L80109F9C
    /* FA790 80109F90 21A8C000 */   addu      $s5, $a2, $zero
    /* FA794 80109F94 01000224 */  addiu      $v0, $zero, 0x1
    /* FA798 80109F98 000042AE */  sw         $v0, 0x0($s2)
  .L80109F9C:
    /* FA79C 80109F9C 5401038C */  lw         $v1, 0x154($zero)
    /* FA7A0 80109FA0 CCCC023C */  lui        $v0, (0xCCCCCCCD >> 16)
    /* FA7A4 80109FA4 CDCC4234 */  ori        $v0, $v0, (0xCCCCCCCD & 0xFFFF)
    /* FA7A8 80109FA8 19006200 */  multu      $v1, $v0
    /* FA7AC 80109FAC 5001108C */  lw         $s0, 0x150($zero)
    /* FA7B0 80109FB0 1580133C */  lui        $s3, %hi(D_80148A7C)
    /* FA7B4 80109FB4 7C8A738E */  lw         $s3, %lo(D_80148A7C)($s3)
    /* FA7B8 80109FB8 10380000 */  mfhi       $a3
    /* FA7BC 80109FBC 82190700 */  srl        $v1, $a3, 6
    /* FA7C0 80109FC0 80100300 */  sll        $v0, $v1, 2
    /* FA7C4 80109FC4 21104300 */  addu       $v0, $v0, $v1
    /* FA7C8 80109FC8 00110200 */  sll        $v0, $v0, 4
    /* FA7CC 80109FCC 21180202 */  addu       $v1, $s0, $v0
    /* FA7D0 80109FD0 2B100302 */  sltu       $v0, $s0, $v1
    /* FA7D4 80109FD4 12004010 */  beqz       $v0, .L8010A020
    /* FA7D8 80109FD8 21204002 */   addu      $a0, $s2, $zero
    /* FA7DC 80109FDC 21886000 */  addu       $s1, $v1, $zero
  .L80109FE0:
    /* FA7E0 80109FE0 0000048E */  lw         $a0, 0x0($s0)
    /* FA7E4 80109FE4 00000000 */  nop
    /* FA7E8 80109FE8 08008010 */  beqz       $a0, .L8010A00C
    /* FA7EC 80109FEC 00000000 */   nop
    /* FA7F0 80109FF0 1580053C */  lui        $a1, %hi(D_80148A84)
    /* FA7F4 80109FF4 5F97030C */  jal        strcmp
    /* FA7F8 80109FF8 848AA524 */   addiu     $a1, $a1, %lo(D_80148A84)
    /* FA7FC 80109FFC 03004014 */  bnez       $v0, .L8010A00C
    /* FA800 8010A000 00000000 */   nop
    /* FA804 8010A004 07280408 */  j          .L8010A01C
    /* FA808 8010A008 340013AE */   sw        $s3, 0x34($s0)
  .L8010A00C:
    /* FA80C 8010A00C 50001026 */  addiu      $s0, $s0, 0x50
    /* FA810 8010A010 2B101102 */  sltu       $v0, $s0, $s1
    /* FA814 8010A014 F2FF4014 */  bnez       $v0, .L80109FE0
    /* FA818 8010A018 00000000 */   nop
  .L8010A01C:
    /* FA81C 8010A01C 21204002 */  addu       $a0, $s2, $zero
  .L8010A020:
    /* FA820 8010A020 21288002 */  addu       $a1, $s4, $zero
    /* FA824 8010A024 1580023C */  lui        $v0, %hi(D_80148A7C)
    /* FA828 8010A028 7C8A428C */  lw         $v0, %lo(D_80148A7C)($v0)
    /* FA82C 8010A02C 00000000 */  nop
    /* FA830 8010A030 09F84000 */  jalr       $v0
    /* FA834 8010A034 2130A002 */   addu      $a2, $s5, $zero
    /* FA838 8010A038 2800BF8F */  lw         $ra, 0x28($sp)
    /* FA83C 8010A03C 2400B58F */  lw         $s5, 0x24($sp)
    /* FA840 8010A040 2000B48F */  lw         $s4, 0x20($sp)
    /* FA844 8010A044 1C00B38F */  lw         $s3, 0x1C($sp)
    /* FA848 8010A048 1800B28F */  lw         $s2, 0x18($sp)
    /* FA84C 8010A04C 1400B18F */  lw         $s1, 0x14($sp)
    /* FA850 8010A050 1000B08F */  lw         $s0, 0x10($sp)
    /* FA854 8010A054 0800E003 */  jr         $ra
    /* FA858 8010A058 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel func_80109F5C
    /* FA85C 8010A05C 00000000 */  nop
