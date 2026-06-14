.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SirenOn__Fii, 0xA8

glabel SirenOn__Fii
    /* 69FF8 800797F8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 69FFC 800797FC 1180023C */  lui        $v0, %hi(bSirenOn)
    /* 6A000 80079800 90E74224 */  addiu      $v0, $v0, %lo(bSirenOn)
    /* 6A004 80079804 80300400 */  sll        $a2, $a0, 2
    /* 6A008 80079808 2118C200 */  addu       $v1, $a2, $v0
    /* 6A00C 8007980C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6A010 80079810 0000628C */  lw         $v0, 0x0($v1)
    /* 6A014 80079814 00000000 */  nop
    /* 6A018 80079818 1D004014 */  bnez       $v0, .L80079890
    /* 6A01C 8007981C 01000724 */   addiu     $a3, $zero, 0x1
    /* 6A020 80079820 0D00A010 */  beqz       $a1, .L80079858
    /* 6A024 80079824 000067AC */   sw        $a3, 0x0($v1)
    /* 6A028 80079828 1180023C */  lui        $v0, %hi(quickSirenActive)
    /* 6A02C 8007982C C0E74224 */  addiu      $v0, $v0, %lo(quickSirenActive)
    /* 6A030 80079830 2110C200 */  addu       $v0, $a2, $v0
    /* 6A034 80079834 000047AC */  sw         $a3, 0x0($v0)
    /* 6A038 80079838 1180023C */  lui        $v0, %hi(sirenCount)
    /* 6A03C 8007983C 20E84224 */  addiu      $v0, $v0, %lo(sirenCount)
    /* 6A040 80079840 2110C200 */  addu       $v0, $a2, $v0
    /* 6A044 80079844 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 6A048 80079848 E4E5010C */  jal        SuperCopSirenOn__Fi
    /* 6A04C 8007984C 000043AC */   sw        $v1, 0x0($v0)
    /* 6A050 80079850 24E60108 */  j          .L80079890
    /* 6A054 80079854 00000000 */   nop
  .L80079858:
    /* 6A058 80079858 1180023C */  lui        $v0, %hi(quickSirenActive)
    /* 6A05C 8007985C C0E74224 */  addiu      $v0, $v0, %lo(quickSirenActive)
    /* 6A060 80079860 2110C200 */  addu       $v0, $a2, $v0
    /* 6A064 80079864 000047AC */  sw         $a3, 0x0($v0)
    /* 6A068 80079868 1180023C */  lui        $v0, %hi(sirenCount)
    /* 6A06C 8007986C 20E84224 */  addiu      $v0, $v0, %lo(sirenCount)
    /* 6A070 80079870 C401838F */  lw         $v1, %gp_rel(gQuickSirenCount)($gp)
    /* 6A074 80079874 2110C200 */  addu       $v0, $a2, $v0
    /* 6A078 80079878 C7E5010C */  jal        quickSirenOn__Fi
    /* 6A07C 8007987C 000043AC */   sw        $v1, 0x0($v0)
    /* 6A080 80079880 C401828F */  lw         $v0, %gp_rel(gQuickSirenCount)($gp)
    /* 6A084 80079884 00000000 */  nop
    /* 6A088 80079888 01004224 */  addiu      $v0, $v0, 0x1
    /* 6A08C 8007988C C40182AF */  sw         $v0, %gp_rel(gQuickSirenCount)($gp)
  .L80079890:
    /* 6A090 80079890 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6A094 80079894 00000000 */  nop
    /* 6A098 80079898 0800E003 */  jr         $ra
    /* 6A09C 8007989C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SirenOn__Fii
