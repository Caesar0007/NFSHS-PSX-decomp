.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Display__11tDialogBase, 0xC4

glabel Display__11tDialogBase
    /* 9040 80018840 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9044 80018844 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9048 80018848 21888000 */  addu       $s1, $a0, $zero
    /* 904C 8001884C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 9050 80018850 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9054 80018854 7000228E */  lw         $v0, 0x70($s1)
    /* 9058 80018858 00000000 */  nop
    /* 905C 8001885C 24004014 */  bnez       $v0, .L800188F0
    /* 9060 80018860 07000524 */   addiu     $a1, $zero, 0x7
    /* 9064 80018864 0580023C */  lui        $v0, %hi(_front_data_orgend)
    /* 9068 80018868 382B4624 */  addiu      $a2, $v0, %lo(_front_data_orgend)
    /* 906C 8001886C 88002396 */  lhu        $v1, 0x88($s1)
    /* 9070 80018870 01000224 */  addiu      $v0, $zero, 0x1
    /* 9074 80018874 700022AE */  sw         $v0, 0x70($s1)
    /* 9078 80018878 840020AE */  sw         $zero, 0x84($s1)
    /* 907C 8001887C 8A0023A6 */  sh         $v1, 0x8A($s1)
  .L80018880:
    /* 9080 80018880 00140500 */  sll        $v0, $a1, 16
    /* 9084 80018884 FFFFA424 */  addiu      $a0, $a1, -0x1
    /* 9088 80018888 21288000 */  addu       $a1, $a0, $zero
    /* 908C 8001888C 03140200 */  sra        $v0, $v0, 16
    /* 9090 80018890 80180200 */  sll        $v1, $v0, 2
    /* 9094 80018894 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 9098 80018898 80100200 */  sll        $v0, $v0, 2
    /* 909C 8001889C 21104600 */  addu       $v0, $v0, $a2
    /* 90A0 800188A0 21186600 */  addu       $v1, $v1, $a2
    /* 90A4 800188A4 0000428C */  lw         $v0, 0x0($v0)
    /* 90A8 800188A8 00240400 */  sll        $a0, $a0, 16
    /* 90AC 800188AC F4FF801C */  bgtz       $a0, .L80018880
    /* 90B0 800188B0 000062AC */   sw        $v0, 0x0($v1)
    /* 90B4 800188B4 21202002 */  addu       $a0, $s1, $zero
    /* 90B8 800188B8 0580103C */  lui        $s0, %hi(_front_data_orgend)
    /* 90BC 800188BC B261000C */  jal        ShouldTimeOut__11tDialogBase
    /* 90C0 800188C0 382B11AE */   sw        $s1, %lo(_front_data_orgend)($s0)
    /* 90C4 800188C4 382B048E */  lw         $a0, %lo(_front_data_orgend)($s0)
    /* 90C8 800188C8 B261000C */  jal        ShouldTimeOut__11tDialogBase
    /* 90CC 800188CC 00000000 */   nop
    /* 90D0 800188D0 1480023C */  lui        $v0, %hi(ticks)
    /* 90D4 800188D4 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 90D8 800188D8 0F000424 */  addiu      $a0, $zero, 0xF
    /* 90DC 800188DC 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 90E0 800188E0 740022AE */   sw        $v0, 0x74($s1)
    /* 90E4 800188E4 80000224 */  addiu      $v0, $zero, 0x80
    /* 90E8 800188E8 840020AE */  sw         $zero, 0x84($s1)
    /* 90EC 800188EC 8C0022AE */  sw         $v0, 0x8C($s1)
  .L800188F0:
    /* 90F0 800188F0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 90F4 800188F4 1400B18F */  lw         $s1, 0x14($sp)
    /* 90F8 800188F8 1000B08F */  lw         $s0, 0x10($sp)
    /* 90FC 800188FC 0800E003 */  jr         $ra
    /* 9100 80018900 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Display__11tDialogBase
