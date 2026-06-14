.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sky_InitStars__Fv, 0x1E8

glabel Sky_InitStars__Fv
    /* BFEB4 800CF6B4 2C13828F */  lw         $v0, %gp_rel(D_8013D878)($gp)
    /* BFEB8 800CF6B8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* BFEBC 800CF6BC 2800BFAF */  sw         $ra, 0x28($sp)
    /* BFEC0 800CF6C0 2400B5AF */  sw         $s5, 0x24($sp)
    /* BFEC4 800CF6C4 2000B4AF */  sw         $s4, 0x20($sp)
    /* BFEC8 800CF6C8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* BFECC 800CF6CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* BFED0 800CF6D0 1400B1AF */  sw         $s1, 0x14($sp)
    /* BFED4 800CF6D4 68004014 */  bnez       $v0, .L800CF878
    /* BFED8 800CF6D8 1000B0AF */   sw        $s0, 0x10($sp)
    /* BFEDC 800CF6DC EA9D030C */  jal        random
    /* BFEE0 800CF6E0 21A00000 */   addu      $s4, $zero, $zero
    /* BFEE4 800CF6E4 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* BFEE8 800CF6E8 00000000 */  nop
    /* BFEEC 800CF6EC 5C00648C */  lw         $a0, 0x5C($v1)
    /* BFEF0 800CF6F0 1E9E030C */  jal        seedrandom
    /* BFEF4 800CF6F4 21A84000 */   addu      $s5, $v0, $zero
    /* BFEF8 800CF6F8 1480043C */  lui        $a0, %hi(D_8013D880)
    /* BFEFC 800CF6FC 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* BFF00 800CF700 80D88424 */  addiu      $a0, $a0, %lo(D_8013D880)
    /* BFF04 800CF704 4400458C */  lw         $a1, 0x44($v0)
    /* BFF08 800CF708 21308002 */  addu       $a2, $s4, $zero
    /* BFF0C 800CF70C CF94030C */  jal        reservememadr
    /* BFF10 800CF710 C0280500 */   sll       $a1, $a1, 3
    /* BFF14 800CF714 0580043C */  lui        $a0, %hi(D_800568B4)
    /* BFF18 800CF718 4013838F */  lw         $v1, %gp_rel(Sky_gTrackSpec)($gp)
    /* BFF1C 800CF71C B4688424 */  addiu      $a0, $a0, %lo(D_800568B4)
    /* BFF20 800CF720 4400658C */  lw         $a1, 0x44($v1)
    /* BFF24 800CF724 21308002 */  addu       $a2, $s4, $zero
    /* BFF28 800CF728 2C1382AF */  sw         $v0, %gp_rel(D_8013D878)($gp)
    /* BFF2C 800CF72C CF94030C */  jal        reservememadr
    /* BFF30 800CF730 80280500 */   sll       $a1, $a1, 2
    /* BFF34 800CF734 301382AF */  sw         $v0, %gp_rel(D_8013D87C)($gp)
  .L800CF738:
    /* BFF38 800CF738 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* BFF3C 800CF73C 00000000 */  nop
    /* BFF40 800CF740 4400428C */  lw         $v0, 0x44($v0)
    /* BFF44 800CF744 00000000 */  nop
    /* BFF48 800CF748 2A108202 */  slt        $v0, $s4, $v0
    /* BFF4C 800CF74C 48004010 */  beqz       $v0, .L800CF870
    /* BFF50 800CF750 00000000 */   nop
    /* BFF54 800CF754 EA9D030C */  jal        random
    /* BFF58 800CF758 00000000 */   nop
    /* BFF5C 800CF75C EA9D030C */  jal        random
    /* BFF60 800CF760 FFFF5330 */   andi      $s3, $v0, 0xFFFF
    /* BFF64 800CF764 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* BFF68 800CF768 00000000 */  nop
    /* BFF6C 800CF76C 4C00838C */  lw         $v1, 0x4C($a0)
    /* BFF70 800CF770 4800908C */  lw         $s0, 0x48($a0)
    /* BFF74 800CF774 00000000 */  nop
    /* BFF78 800CF778 23187000 */  subu       $v1, $v1, $s0
    /* BFF7C 800CF77C 1B004300 */  divu       $zero, $v0, $v1
    /* BFF80 800CF780 02006014 */  bnez       $v1, .L800CF78C
    /* BFF84 800CF784 00000000 */   nop
    /* BFF88 800CF788 0D000700 */  break      7
  .L800CF78C:
    /* BFF8C 800CF78C 10180000 */  mfhi       $v1
    /* BFF90 800CF790 00000000 */  nop
    /* BFF94 800CF794 21800302 */  addu       $s0, $s0, $v1
    /* BFF98 800CF798 09B5030C */  jal        fixedsin
    /* BFF9C 800CF79C 21200002 */   addu      $a0, $s0, $zero
    /* BFFA0 800CF7A0 21204000 */  addu       $a0, $v0, $zero
    /* BFFA4 800CF7A4 CA90030C */  jal        fixedmult
    /* BFFA8 800CF7A8 E8030524 */   addiu     $a1, $zero, 0x3E8
    /* BFFAC 800CF7AC 21200002 */  addu       $a0, $s0, $zero
    /* BFFB0 800CF7B0 29B5030C */  jal        fixedcos
    /* BFFB4 800CF7B4 21904000 */   addu      $s2, $v0, $zero
    /* BFFB8 800CF7B8 21204000 */  addu       $a0, $v0, $zero
    /* BFFBC 800CF7BC CA90030C */  jal        fixedmult
    /* BFFC0 800CF7C0 E8030524 */   addiu     $a1, $zero, 0x3E8
    /* BFFC4 800CF7C4 21206002 */  addu       $a0, $s3, $zero
    /* BFFC8 800CF7C8 09B5030C */  jal        fixedsin
    /* BFFCC 800CF7CC 21884000 */   addu      $s1, $v0, $zero
    /* BFFD0 800CF7D0 21204000 */  addu       $a0, $v0, $zero
    /* BFFD4 800CF7D4 CA90030C */  jal        fixedmult
    /* BFFD8 800CF7D8 21282002 */   addu      $a1, $s1, $zero
    /* BFFDC 800CF7DC 21206002 */  addu       $a0, $s3, $zero
    /* BFFE0 800CF7E0 2C13838F */  lw         $v1, %gp_rel(D_8013D878)($gp)
    /* BFFE4 800CF7E4 C0801400 */  sll        $s0, $s4, 3
    /* BFFE8 800CF7E8 21180302 */  addu       $v1, $s0, $v1
    /* BFFEC 800CF7EC 000062A4 */  sh         $v0, 0x0($v1)
    /* BFFF0 800CF7F0 29B5030C */  jal        fixedcos
    /* BFFF4 800CF7F4 020072A4 */   sh        $s2, 0x2($v1)
    /* BFFF8 800CF7F8 21204000 */  addu       $a0, $v0, $zero
    /* BFFFC 800CF7FC CA90030C */  jal        fixedmult
    /* C0000 800CF800 21282002 */   addu      $a1, $s1, $zero
    /* C0004 800CF804 2C13838F */  lw         $v1, %gp_rel(D_8013D878)($gp)
    /* C0008 800CF808 00000000 */  nop
    /* C000C 800CF80C 21800302 */  addu       $s0, $s0, $v1
    /* C0010 800CF810 EA9D030C */  jal        random
    /* C0014 800CF814 040002A6 */   sh        $v0, 0x4($s0)
    /* C0018 800CF818 4013848F */  lw         $a0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C001C 800CF81C 00000000 */  nop
    /* C0020 800CF820 5400838C */  lw         $v1, 0x54($a0)
    /* C0024 800CF824 5000848C */  lw         $a0, 0x50($a0)
    /* C0028 800CF828 00000000 */  nop
    /* C002C 800CF82C 23186400 */  subu       $v1, $v1, $a0
    /* C0030 800CF830 1B004300 */  divu       $zero, $v0, $v1
    /* C0034 800CF834 02006014 */  bnez       $v1, .L800CF840
    /* C0038 800CF838 00000000 */   nop
    /* C003C 800CF83C 0D000700 */  break      7
  .L800CF840:
    /* C0040 800CF840 10180000 */  mfhi       $v1
    /* C0044 800CF844 80281400 */  sll        $a1, $s4, 2
    /* C0048 800CF848 3013828F */  lw         $v0, %gp_rel(D_8013D87C)($gp)
    /* C004C 800CF84C 01009426 */  addiu      $s4, $s4, 0x1
    /* C0050 800CF850 2128A200 */  addu       $a1, $a1, $v0
    /* C0054 800CF854 21208300 */  addu       $a0, $a0, $v1
    /* C0058 800CF858 00140400 */  sll        $v0, $a0, 16
    /* C005C 800CF85C 001A0400 */  sll        $v1, $a0, 8
    /* C0060 800CF860 25104300 */  or         $v0, $v0, $v1
    /* C0064 800CF864 25104400 */  or         $v0, $v0, $a0
    /* C0068 800CF868 CE3D0308 */  j          .L800CF738
    /* C006C 800CF86C 0000A2AC */   sw        $v0, 0x0($a1)
  .L800CF870:
    /* C0070 800CF870 1E9E030C */  jal        seedrandom
    /* C0074 800CF874 2120A002 */   addu      $a0, $s5, $zero
  .L800CF878:
    /* C0078 800CF878 2800BF8F */  lw         $ra, 0x28($sp)
    /* C007C 800CF87C 2400B58F */  lw         $s5, 0x24($sp)
    /* C0080 800CF880 2000B48F */  lw         $s4, 0x20($sp)
    /* C0084 800CF884 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C0088 800CF888 1800B28F */  lw         $s2, 0x18($sp)
    /* C008C 800CF88C 1400B18F */  lw         $s1, 0x14($sp)
    /* C0090 800CF890 1000B08F */  lw         $s0, 0x10($sp)
    /* C0094 800CF894 0800E003 */  jr         $ra
    /* C0098 800CF898 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Sky_InitStars__Fv
