.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Init_Memcard__FbT0, 0x15C

glabel Init_Memcard__FbT0
    /* 24EA4 800346A4 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 24EA8 800346A8 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 24EAC 800346AC 21888000 */  addu       $s1, $a0, $zero
    /* 24EB0 800346B0 0580043C */  lui        $a0, %hi(MEMCARD_INITIALIZED)
    /* 24EB4 800346B4 801A828C */  lw         $v0, %lo(MEMCARD_INITIALIZED)($a0)
    /* 24EB8 800346B8 3800B0AF */  sw         $s0, 0x38($sp)
    /* 24EBC 800346BC 2180A000 */  addu       $s0, $a1, $zero
    /* 24EC0 800346C0 4A004014 */  bnez       $v0, .L800347EC
    /* 24EC4 800346C4 4000BFAF */   sw        $ra, 0x40($sp)
    /* 24EC8 800346C8 1480023C */  lui        $v0, %hi(MEMCARDFRONTENDISINITTED)
    /* 24ECC 800346CC 84D2438C */  lw         $v1, %lo(MEMCARDFRONTENDISINITTED)($v0)
    /* 24ED0 800346D0 01000224 */  addiu      $v0, $zero, 0x1
    /* 24ED4 800346D4 05006010 */  beqz       $v1, .L800346EC
    /* 24ED8 800346D8 801A82AC */   sw        $v0, %lo(MEMCARD_INITIALIZED)($a0)
    /* 24EDC 800346DC 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 24EE0 800346E0 21200000 */   addu      $a0, $zero, $zero
    /* 24EE4 800346E4 A1A0030C */  jal        timedwait
    /* 24EE8 800346E8 05000424 */   addiu     $a0, $zero, 0x5
  .L800346EC:
    /* 24EEC 800346EC 5690030C */  jal        PAD_restore
    /* 24EF0 800346F0 00000000 */   nop
    /* 24EF4 800346F4 1480023C */  lui        $v0, %hi(ticks)
    /* 24EF8 800346F8 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 24EFC 800346FC 21204000 */  addu       $a0, $v0, $zero
  .L80034700:
    /* 24F00 80034700 ACDC828C */  lw         $v0, %lo(ticks)($a0)
    /* 24F04 80034704 00000000 */  nop
    /* 24F08 80034708 23104300 */  subu       $v0, $v0, $v1
    /* 24F0C 8003470C 3C004228 */  slti       $v0, $v0, 0x3C
    /* 24F10 80034710 FBFF4014 */  bnez       $v0, .L80034700
    /* 24F14 80034714 00000000 */   nop
    /* 24F18 80034718 0980043C */  lui        $a0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 24F1C 8003471C 12AC030C */  jal        deltimer
    /* 24F20 80034720 38B98424 */   addiu     $a0, $a0, %lo(Clock_MasterInterruptHandler__Fv)
    /* 24F24 80034724 A1A0030C */  jal        timedwait
    /* 24F28 80034728 14000424 */   addiu     $a0, $zero, 0x14
    /* 24F2C 8003472C F83C010C */  jal        MCRD_init
    /* 24F30 80034730 21200000 */   addu      $a0, $zero, $zero
    /* 24F34 80034734 473D010C */  jal        MCRD_getopts
    /* 24F38 80034738 1000A427 */   addiu     $a0, $sp, 0x10
    /* 24F3C 8003473C 0580023C */  lui        $v0, %hi(productCode)
    /* 24F40 80034740 6C1A4224 */  addiu      $v0, $v0, %lo(productCode)
    /* 24F44 80034744 1400A2AF */  sw         $v0, 0x14($sp)
    /* 24F48 80034748 00020224 */  addiu      $v0, $zero, 0x200
    /* 24F4C 8003474C 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* 24F50 80034750 00010224 */  addiu      $v0, $zero, 0x100
    /* 24F54 80034754 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* 24F58 80034758 20000224 */  addiu      $v0, $zero, 0x20
    /* 24F5C 8003475C 2000A2A7 */  sh         $v0, 0x20($sp)
    /* 24F60 80034760 60000224 */  addiu      $v0, $zero, 0x60
    /* 24F64 80034764 2200A2A7 */  sh         $v0, 0x22($sp)
    /* 24F68 80034768 0380023C */  lui        $v0, %hi(FormatConfirm__Fv)
    /* 24F6C 8003476C 20464224 */  addiu      $v0, $v0, %lo(FormatConfirm__Fv)
    /* 24F70 80034770 1000A0AF */  sw         $zero, 0x10($sp)
    /* 24F74 80034774 1800A0AF */  sw         $zero, 0x18($sp)
    /* 24F78 80034778 04000012 */  beqz       $s0, .L8003478C
    /* 24F7C 8003477C 2400A2AF */   sw        $v0, 0x24($sp)
    /* 24F80 80034780 0380023C */  lui        $v0, %hi(OverwriteAlwaysYes__Fv)
    /* 24F84 80034784 E5D10008 */  j          .L80034794
    /* 24F88 80034788 18464224 */   addiu     $v0, $v0, %lo(OverwriteAlwaysYes__Fv)
  .L8003478C:
    /* 24F8C 8003478C 0380023C */  lui        $v0, %hi(OverwriteConfirm__Fv)
    /* 24F90 80034790 EC454224 */  addiu      $v0, $v0, %lo(OverwriteConfirm__Fv)
  .L80034794:
    /* 24F94 80034794 04002012 */  beqz       $s1, .L800347A8
    /* 24F98 80034798 2800A2AF */   sw        $v0, 0x28($sp)
    /* 24F9C 8003479C 0380023C */  lui        $v0, %hi(LoadingRedrawProc__Fv)
    /* 24FA0 800347A0 ECD10008 */  j          .L800347B0
    /* 24FA4 800347A4 54464224 */   addiu     $v0, $v0, %lo(LoadingRedrawProc__Fv)
  .L800347A8:
    /* 24FA8 800347A8 0380023C */  lui        $v0, %hi(func_8003464C)
    /* 24FAC 800347AC 4C464224 */  addiu      $v0, $v0, %lo(func_8003464C)
  .L800347B0:
    /* 24FB0 800347B0 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 24FB4 800347B4 0380023C */  lui        $v0, %hi(SavingProc__Fv)
    /* 24FB8 800347B8 7C464224 */  addiu      $v0, $v0, %lo(SavingProc__Fv)
    /* 24FBC 800347BC 3000A2AF */  sw         $v0, 0x30($sp)
    /* 24FC0 800347C0 653D010C */  jal        MCRD_setopts
    /* 24FC4 800347C4 1000A427 */   addiu     $a0, $sp, 0x10
    /* 24FC8 800347C8 0980043C */  lui        $a0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 24FCC 800347CC FAAB030C */  jal        addtimer
    /* 24FD0 800347D0 38B98424 */   addiu     $a0, $a0, %lo(Clock_MasterInterruptHandler__Fv)
    /* 24FD4 800347D4 A1A0030C */  jal        timedwait
    /* 24FD8 800347D8 14000424 */   addiu     $a0, $zero, 0x14
    /* 24FDC 800347DC 3A90030C */  jal        padinit
    /* 24FE0 800347E0 00000000 */   nop
    /* 24FE4 800347E4 A1A0030C */  jal        timedwait
    /* 24FE8 800347E8 14000424 */   addiu     $a0, $zero, 0x14
  .L800347EC:
    /* 24FEC 800347EC 4000BF8F */  lw         $ra, 0x40($sp)
    /* 24FF0 800347F0 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 24FF4 800347F4 3800B08F */  lw         $s0, 0x38($sp)
    /* 24FF8 800347F8 0800E003 */  jr         $ra
    /* 24FFC 800347FC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Init_Memcard__FbT0
