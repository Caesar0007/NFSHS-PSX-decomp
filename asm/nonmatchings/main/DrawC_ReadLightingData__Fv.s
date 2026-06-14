.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawC_ReadLightingData__Fv, 0x208

glabel DrawC_ReadLightingData__Fv
    /* AEEF0 800BE6F0 D0FEBD27 */  addiu      $sp, $sp, -0x130
    /* AEEF4 800BE6F4 1000A427 */  addiu      $a0, $sp, 0x10
    /* AEEF8 800BE6F8 1180023C */  lui        $v0, %hi(D_80116480)
    /* AEEFC 800BE6FC 8064468C */  lw         $a2, %lo(D_80116480)($v0)
    /* AEF00 800BE700 1180023C */  lui        $v0, %hi(D_80113228)
    /* AEF04 800BE704 0580053C */  lui        $a1, %hi(D_80056814)
    /* AEF08 800BE708 2832478C */  lw         $a3, %lo(D_80113228)($v0)
    /* AEF0C 800BE70C 1468A524 */  addiu      $a1, $a1, %lo(D_80056814)
    /* AEF10 800BE710 2801BFAF */  sw         $ra, 0x128($sp)
    /* AEF14 800BE714 2401B3AF */  sw         $s3, 0x124($sp)
    /* AEF18 800BE718 2001B2AF */  sw         $s2, 0x120($sp)
    /* AEF1C 800BE71C 1C01B1AF */  sw         $s1, 0x11C($sp)
    /* AEF20 800BE720 2F91030C */  jal        sprintf
    /* AEF24 800BE724 1801B0AF */   sw        $s0, 0x118($sp)
    /* AEF28 800BE728 1000A427 */  addiu      $a0, $sp, 0x10
    /* AEF2C 800BE72C FA95030C */  jal        loadfileadr
    /* AEF30 800BE730 10000524 */   addiu     $a1, $zero, 0x10
    /* AEF34 800BE734 1001B027 */  addiu      $s0, $sp, 0x110
    /* AEF38 800BE738 21200002 */  addu       $a0, $s0, $zero
    /* AEF3C 800BE73C 21984000 */  addu       $s3, $v0, $zero
    /* AEF40 800BE740 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AEF44 800BE744 1001B3AF */   sw        $s3, 0x110($sp)
    /* AEF48 800BE748 1480043C */  lui        $a0, %hi(D_8013D7D0)
    /* AEF4C 800BE74C D0D78424 */  addiu      $a0, $a0, %lo(D_8013D7D0)
    /* AEF50 800BE750 40280200 */  sll        $a1, $v0, 1
    /* AEF54 800BE754 2128A200 */  addu       $a1, $a1, $v0
    /* AEF58 800BE758 40280500 */  sll        $a1, $a1, 1
    /* AEF5C 800BE75C AC1282AF */  sw         $v0, %gp_rel(DrawC_gEnvMapMax)($gp)
    /* AEF60 800BE760 CF94030C */  jal        reservememadr
    /* AEF64 800BE764 21300000 */   addu      $a2, $zero, $zero
    /* AEF68 800BE768 AC12838F */  lw         $v1, %gp_rel(DrawC_gEnvMapMax)($gp)
    /* AEF6C 800BE76C A41282AF */  sw         $v0, %gp_rel(DrawC_gEnvMap)($gp)
    /* AEF70 800BE770 25006018 */  blez       $v1, .L800BE808
    /* AEF74 800BE774 21880000 */   addu      $s1, $zero, $zero
    /* AEF78 800BE778 21900002 */  addu       $s2, $s0, $zero
    /* AEF7C 800BE77C 21802002 */  addu       $s0, $s1, $zero
  .L800BE780:
    /* AEF80 800BE780 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AEF84 800BE784 21204002 */   addu      $a0, $s2, $zero
    /* AEF88 800BE788 A412838F */  lw         $v1, %gp_rel(DrawC_gEnvMap)($gp)
    /* AEF8C 800BE78C 21204002 */  addu       $a0, $s2, $zero
    /* AEF90 800BE790 21180302 */  addu       $v1, $s0, $v1
    /* AEF94 800BE794 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AEF98 800BE798 000062A4 */   sh        $v0, 0x0($v1)
    /* AEF9C 800BE79C A412838F */  lw         $v1, %gp_rel(DrawC_gEnvMap)($gp)
    /* AEFA0 800BE7A0 21204002 */  addu       $a0, $s2, $zero
    /* AEFA4 800BE7A4 21180302 */  addu       $v1, $s0, $v1
    /* AEFA8 800BE7A8 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AEFAC 800BE7AC 020062A4 */   sh        $v0, 0x2($v1)
    /* AEFB0 800BE7B0 21204002 */  addu       $a0, $s2, $zero
    /* AEFB4 800BE7B4 A412838F */  lw         $v1, %gp_rel(DrawC_gEnvMap)($gp)
    /* AEFB8 800BE7B8 00120200 */  sll        $v0, $v0, 8
    /* AEFBC 800BE7BC 21180302 */  addu       $v1, $s0, $v1
    /* AEFC0 800BE7C0 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AEFC4 800BE7C4 040062A4 */   sh        $v0, 0x4($v1)
    /* AEFC8 800BE7C8 A412838F */  lw         $v1, %gp_rel(DrawC_gEnvMap)($gp)
    /* AEFCC 800BE7CC 00000000 */  nop
    /* AEFD0 800BE7D0 21280302 */  addu       $a1, $s0, $v1
    /* AEFD4 800BE7D4 0400A394 */  lhu        $v1, 0x4($a1)
    /* AEFD8 800BE7D8 0000A484 */  lh         $a0, 0x0($a1)
    /* AEFDC 800BE7DC 21186200 */  addu       $v1, $v1, $v0
    /* AEFE0 800BE7E0 04008104 */  bgez       $a0, .L800BE7F4
    /* AEFE4 800BE7E4 0400A3A4 */   sh        $v1, 0x4($a1)
    /* AEFE8 800BE7E8 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* AEFEC 800BE7EC 02FA0208 */  j          .L800BE808
    /* AEFF0 800BE7F0 0000A2A4 */   sh        $v0, 0x0($a1)
  .L800BE7F4:
    /* AEFF4 800BE7F4 AC12828F */  lw         $v0, %gp_rel(DrawC_gEnvMapMax)($gp)
    /* AEFF8 800BE7F8 01003126 */  addiu      $s1, $s1, 0x1
    /* AEFFC 800BE7FC 2A102202 */  slt        $v0, $s1, $v0
    /* AF000 800BE800 DFFF4014 */  bnez       $v0, .L800BE780
    /* AF004 800BE804 06001026 */   addiu     $s0, $s0, 0x6
  .L800BE808:
    /* AF008 800BE808 1001B027 */  addiu      $s0, $sp, 0x110
    /* AF00C 800BE80C BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AF010 800BE810 21200002 */   addu      $a0, $s0, $zero
    /* AF014 800BE814 1480043C */  lui        $a0, %hi(D_8013D7D8)
    /* AF018 800BE818 D8D78424 */  addiu      $a0, $a0, %lo(D_8013D7D8)
    /* AF01C 800BE81C 40280200 */  sll        $a1, $v0, 1
    /* AF020 800BE820 2128A200 */  addu       $a1, $a1, $v0
    /* AF024 800BE824 40280500 */  sll        $a1, $a1, 1
    /* AF028 800BE828 B01282AF */  sw         $v0, %gp_rel(DrawC_gShadowMax)($gp)
    /* AF02C 800BE82C CF94030C */  jal        reservememadr
    /* AF030 800BE830 21300000 */   addu      $a2, $zero, $zero
    /* AF034 800BE834 B012838F */  lw         $v1, %gp_rel(DrawC_gShadowMax)($gp)
    /* AF038 800BE838 A81282AF */  sw         $v0, %gp_rel(DrawC_gShadow)($gp)
    /* AF03C 800BE83C 25006018 */  blez       $v1, .L800BE8D4
    /* AF040 800BE840 21880000 */   addu      $s1, $zero, $zero
    /* AF044 800BE844 21900002 */  addu       $s2, $s0, $zero
    /* AF048 800BE848 21802002 */  addu       $s0, $s1, $zero
  .L800BE84C:
    /* AF04C 800BE84C BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AF050 800BE850 21204002 */   addu      $a0, $s2, $zero
    /* AF054 800BE854 A812838F */  lw         $v1, %gp_rel(DrawC_gShadow)($gp)
    /* AF058 800BE858 21204002 */  addu       $a0, $s2, $zero
    /* AF05C 800BE85C 21180302 */  addu       $v1, $s0, $v1
    /* AF060 800BE860 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AF064 800BE864 000062A4 */   sh        $v0, 0x0($v1)
    /* AF068 800BE868 A812838F */  lw         $v1, %gp_rel(DrawC_gShadow)($gp)
    /* AF06C 800BE86C 21204002 */  addu       $a0, $s2, $zero
    /* AF070 800BE870 21180302 */  addu       $v1, $s0, $v1
    /* AF074 800BE874 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AF078 800BE878 020062A4 */   sh        $v0, 0x2($v1)
    /* AF07C 800BE87C 21204002 */  addu       $a0, $s2, $zero
    /* AF080 800BE880 A812838F */  lw         $v1, %gp_rel(DrawC_gShadow)($gp)
    /* AF084 800BE884 00120200 */  sll        $v0, $v0, 8
    /* AF088 800BE888 21180302 */  addu       $v1, $s0, $v1
    /* AF08C 800BE88C BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* AF090 800BE890 040062A4 */   sh        $v0, 0x4($v1)
    /* AF094 800BE894 A812838F */  lw         $v1, %gp_rel(DrawC_gShadow)($gp)
    /* AF098 800BE898 00000000 */  nop
    /* AF09C 800BE89C 21280302 */  addu       $a1, $s0, $v1
    /* AF0A0 800BE8A0 0400A394 */  lhu        $v1, 0x4($a1)
    /* AF0A4 800BE8A4 0000A484 */  lh         $a0, 0x0($a1)
    /* AF0A8 800BE8A8 21186200 */  addu       $v1, $v1, $v0
    /* AF0AC 800BE8AC 04008104 */  bgez       $a0, .L800BE8C0
    /* AF0B0 800BE8B0 0400A3A4 */   sh        $v1, 0x4($a1)
    /* AF0B4 800BE8B4 FF7F0224 */  addiu      $v0, $zero, 0x7FFF
    /* AF0B8 800BE8B8 35FA0208 */  j          .L800BE8D4
    /* AF0BC 800BE8BC 0000A2A4 */   sh        $v0, 0x0($a1)
  .L800BE8C0:
    /* AF0C0 800BE8C0 B012828F */  lw         $v0, %gp_rel(DrawC_gShadowMax)($gp)
    /* AF0C4 800BE8C4 01003126 */  addiu      $s1, $s1, 0x1
    /* AF0C8 800BE8C8 2A102202 */  slt        $v0, $s1, $v0
    /* AF0CC 800BE8CC DFFF4014 */  bnez       $v0, .L800BE84C
    /* AF0D0 800BE8D0 06001026 */   addiu     $s0, $s0, 0x6
  .L800BE8D4:
    /* AF0D4 800BE8D4 5095030C */  jal        purgememadr
    /* AF0D8 800BE8D8 21206002 */   addu      $a0, $s3, $zero
    /* AF0DC 800BE8DC 2801BF8F */  lw         $ra, 0x128($sp)
    /* AF0E0 800BE8E0 2401B38F */  lw         $s3, 0x124($sp)
    /* AF0E4 800BE8E4 2001B28F */  lw         $s2, 0x120($sp)
    /* AF0E8 800BE8E8 1C01B18F */  lw         $s1, 0x11C($sp)
    /* AF0EC 800BE8EC 1801B08F */  lw         $s0, 0x118($sp)
    /* AF0F0 800BE8F0 0800E003 */  jr         $ra
    /* AF0F4 800BE8F4 3001BD27 */   addiu     $sp, $sp, 0x130
endlabel DrawC_ReadLightingData__Fv
