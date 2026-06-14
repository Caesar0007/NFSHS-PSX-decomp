.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckChaserPosition__16AIHigh_BasicPerpii, 0x15C

glabel CheckChaserPosition__16AIHigh_BasicPerpii
    /* 4C75C 8005BF5C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 4C760 8005BF60 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4C764 8005BF64 21908000 */  addu       $s2, $a0, $zero
    /* 4C768 8005BF68 2000B4AF */  sw         $s4, 0x20($sp)
    /* 4C76C 8005BF6C 21A0A000 */  addu       $s4, $a1, $zero
    /* 4C770 8005BF70 2400B5AF */  sw         $s5, 0x24($sp)
    /* 4C774 8005BF74 21A8C000 */  addu       $s5, $a2, $zero
    /* 4C778 8005BF78 80181400 */  sll        $v1, $s4, 2
    /* 4C77C 8005BF7C 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 4C780 8005BF80 38CD4424 */  addiu      $a0, $v0, %lo(highLevelAIObjs)
    /* 4C784 8005BF84 80101500 */  sll        $v0, $s5, 2
    /* 4C788 8005BF88 21104400 */  addu       $v0, $v0, $a0
    /* 4C78C 8005BF8C 3400BFAF */  sw         $ra, 0x34($sp)
    /* 4C790 8005BF90 3000BEAF */  sw         $fp, 0x30($sp)
    /* 4C794 8005BF94 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 4C798 8005BF98 2800B6AF */  sw         $s6, 0x28($sp)
    /* 4C79C 8005BF9C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 4C7A0 8005BFA0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4C7A4 8005BFA4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4C7A8 8005BFA8 0000428C */  lw         $v0, 0x0($v0)
    /* 4C7AC 8005BFAC 21184302 */  addu       $v1, $s2, $v1
    /* 4C7B0 8005BFB0 0000428C */  lw         $v0, 0x0($v0)
    /* 4C7B4 8005BFB4 4C00708C */  lw         $s0, 0x4C($v1)
    /* 4C7B8 8005BFB8 08005784 */  lh         $s7, 0x8($v0)
    /* 4C7BC 8005BFBC 3100001A */  blez       $s0, .L8005C084
    /* 4C7C0 8005BFC0 FFFF1324 */   addiu     $s3, $zero, -0x1
    /* 4C7C4 8005BFC4 21F08000 */  addu       $fp, $a0, $zero
    /* 4C7C8 8005BFC8 21B06000 */  addu       $s6, $v1, $zero
    /* 4C7CC 8005BFCC 21101302 */  addu       $v0, $s0, $s3
  .L8005BFD0:
    /* 4C7D0 8005BFD0 C0100200 */  sll        $v0, $v0, 3
    /* 4C7D4 8005BFD4 21104202 */  addu       $v0, $s2, $v0
    /* 4C7D8 8005BFD8 1C00518C */  lw         $s1, 0x1C($v0)
    /* 4C7DC 8005BFDC 2000428C */  lw         $v0, 0x20($v0)
    /* 4C7E0 8005BFE0 2800001A */  blez       $s0, .L8005C084
    /* 4C7E4 8005BFE4 00000000 */   nop
    /* 4C7E8 8005BFE8 17003312 */  beq        $s1, $s3, .L8005C048
    /* 4C7EC 8005BFEC FFFF0526 */   addiu     $a1, $s0, -0x1
    /* 4C7F0 8005BFF0 11005310 */  beq        $v0, $s3, .L8005C038
    /* 4C7F4 8005BFF4 80100200 */   sll       $v0, $v0, 2
    /* 4C7F8 8005BFF8 21105E00 */  addu       $v0, $v0, $fp
    /* 4C7FC 8005BFFC 0000428C */  lw         $v0, 0x0($v0)
    /* 4C800 8005C000 00000000 */  nop
    /* 4C804 8005C004 0000448C */  lw         $a0, 0x0($v0)
    /* 4C808 8005C008 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 4C80C 8005C00C 2128E002 */   addu      $a1, $s7, $zero
    /* 4C810 8005C010 0000438E */  lw         $v1, 0x0($s2)
    /* 4C814 8005C014 00000000 */  nop
    /* 4C818 8005C018 5405638C */  lw         $v1, 0x554($v1)
    /* 4C81C 8005C01C 00000000 */  nop
    /* 4C820 8005C020 18004300 */  mult       $v0, $v1
    /* 4C824 8005C024 F4FF023C */  lui        $v0, (0xFFF40000 >> 16)
    /* 4C828 8005C028 12380000 */  mflo       $a3
    /* 4C82C 8005C02C 2A10E200 */  slt        $v0, $a3, $v0
    /* 4C830 8005C030 15004010 */  beqz       $v0, .L8005C088
    /* 4C834 8005C034 21100002 */   addu      $v0, $s0, $zero
  .L8005C038:
    /* 4C838 8005C038 80101100 */  sll        $v0, $s1, 2
    /* 4C83C 8005C03C 21104202 */  addu       $v0, $s2, $v0
    /* 4C840 8005C040 4C0050AC */  sw         $s0, 0x4C($v0)
    /* 4C844 8005C044 FFFF0526 */  addiu      $a1, $s0, -0x1
  .L8005C048:
    /* 4C848 8005C048 C0201000 */  sll        $a0, $s0, 3
    /* 4C84C 8005C04C C0100500 */  sll        $v0, $a1, 3
    /* 4C850 8005C050 21104202 */  addu       $v0, $s2, $v0
    /* 4C854 8005C054 4C00C5AE */  sw         $a1, 0x4C($s6)
    /* 4C858 8005C058 1C00438C */  lw         $v1, 0x1C($v0)
    /* 4C85C 8005C05C 21204402 */  addu       $a0, $s2, $a0
    /* 4C860 8005C060 1C0083AC */  sw         $v1, 0x1C($a0)
    /* 4C864 8005C064 2000438C */  lw         $v1, 0x20($v0)
    /* 4C868 8005C068 2180A000 */  addu       $s0, $a1, $zero
    /* 4C86C 8005C06C 200083AC */  sw         $v1, 0x20($a0)
    /* 4C870 8005C070 1C0054AC */  sw         $s4, 0x1C($v0)
    /* 4C874 8005C074 0300001A */  blez       $s0, .L8005C084
    /* 4C878 8005C078 200055AC */   sw        $s5, 0x20($v0)
    /* 4C87C 8005C07C F46F0108 */  j          .L8005BFD0
    /* 4C880 8005C080 FFFF0226 */   addiu     $v0, $s0, -0x1
  .L8005C084:
    /* 4C884 8005C084 21100002 */  addu       $v0, $s0, $zero
  .L8005C088:
    /* 4C888 8005C088 3400BF8F */  lw         $ra, 0x34($sp)
    /* 4C88C 8005C08C 3000BE8F */  lw         $fp, 0x30($sp)
    /* 4C890 8005C090 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 4C894 8005C094 2800B68F */  lw         $s6, 0x28($sp)
    /* 4C898 8005C098 2400B58F */  lw         $s5, 0x24($sp)
    /* 4C89C 8005C09C 2000B48F */  lw         $s4, 0x20($sp)
    /* 4C8A0 8005C0A0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 4C8A4 8005C0A4 1800B28F */  lw         $s2, 0x18($sp)
    /* 4C8A8 8005C0A8 1400B18F */  lw         $s1, 0x14($sp)
    /* 4C8AC 8005C0AC 1000B08F */  lw         $s0, 0x10($sp)
    /* 4C8B0 8005C0B0 0800E003 */  jr         $ra
    /* 4C8B4 8005C0B4 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CheckChaserPosition__16AIHigh_BasicPerpii
