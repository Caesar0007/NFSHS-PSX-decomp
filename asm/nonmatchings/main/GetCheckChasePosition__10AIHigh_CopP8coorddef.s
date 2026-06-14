.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCheckChasePosition__10AIHigh_CopP8coorddef, 0xB0

glabel GetCheckChasePosition__10AIHigh_CopP8coorddef
    /* 56094 80065894 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 56098 80065898 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5609C 8006589C 21808000 */  addu       $s0, $a0, $zero
    /* 560A0 800658A0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 560A4 800658A4 2190A000 */  addu       $s2, $a1, $zero
    /* 560A8 800658A8 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 560AC 800658AC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 560B0 800658B0 0000028E */  lw         $v0, 0x0($s0)
    /* 560B4 800658B4 5800048E */  lw         $a0, 0x58($s0)
    /* 560B8 800658B8 1C00058E */  lw         $a1, 0x1C($s0)
    /* 560BC 800658BC 5402468C */  lw         $a2, 0x254($v0)
    /* 560C0 800658C0 D76F010C */  jal        CheckChaserPosition__16AIHigh_BasicPerpii
    /* 560C4 800658C4 21880000 */   addu      $s1, $zero, $zero
    /* 560C8 800658C8 6000038E */  lw         $v1, 0x60($s0)
    /* 560CC 800658CC 00000000 */  nop
    /* 560D0 800658D0 03004310 */  beq        $v0, $v1, .L800658E0
    /* 560D4 800658D4 00000000 */   nop
    /* 560D8 800658D8 01001124 */  addiu      $s1, $zero, 0x1
    /* 560DC 800658DC 600002AE */  sw         $v0, 0x60($s0)
  .L800658E0:
    /* 560E0 800658E0 21102002 */  addu       $v0, $s1, $zero
    /* 560E4 800658E4 1180063C */  lui        $a2, %hi(AIH_Cop_chasePositions)
    /* 560E8 800658E8 ECCEC624 */  addiu      $a2, $a2, %lo(AIH_Cop_chasePositions)
    /* 560EC 800658EC 6000038E */  lw         $v1, 0x60($s0)
    /* 560F0 800658F0 6800058E */  lw         $a1, 0x68($s0)
    /* 560F4 800658F4 40200300 */  sll        $a0, $v1, 1
    /* 560F8 800658F8 21208300 */  addu       $a0, $a0, $v1
    /* 560FC 800658FC 80200400 */  sll        $a0, $a0, 2
    /* 56100 80065900 C0180500 */  sll        $v1, $a1, 3
    /* 56104 80065904 21186500 */  addu       $v1, $v1, $a1
    /* 56108 80065908 C0180300 */  sll        $v1, $v1, 3
    /* 5610C 8006590C 21208300 */  addu       $a0, $a0, $v1
    /* 56110 80065910 21208600 */  addu       $a0, $a0, $a2
    /* 56114 80065914 0000878C */  lw         $a3, 0x0($a0)
    /* 56118 80065918 0400888C */  lw         $t0, 0x4($a0)
    /* 5611C 8006591C 0800898C */  lw         $t1, 0x8($a0)
    /* 56120 80065920 000047AE */  sw         $a3, 0x0($s2)
    /* 56124 80065924 040048AE */  sw         $t0, 0x4($s2)
    /* 56128 80065928 080049AE */  sw         $t1, 0x8($s2)
    /* 5612C 8006592C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 56130 80065930 1800B28F */  lw         $s2, 0x18($sp)
    /* 56134 80065934 1400B18F */  lw         $s1, 0x14($sp)
    /* 56138 80065938 1000B08F */  lw         $s0, 0x10($sp)
    /* 5613C 8006593C 0800E003 */  jr         $ra
    /* 56140 80065940 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetCheckChasePosition__10AIHigh_CopP8coorddef
