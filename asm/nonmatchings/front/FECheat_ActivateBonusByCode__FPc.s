.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FECheat_ActivateBonusByCode__FPc, 0xB8

glabel FECheat_ActivateBonusByCode__FPc
    /* 13FE0 800237E0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 13FE4 800237E4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 13FE8 800237E8 21880000 */  addu       $s1, $zero, $zero
    /* 13FEC 800237EC 1000A527 */  addiu      $a1, $sp, 0x10
    /* 13FF0 800237F0 2000BFAF */  sw         $ra, 0x20($sp)
    /* 13FF4 800237F4 278D000C */  jal        FECheat_EncodeString2__FPcT0
    /* 13FF8 800237F8 1800B0AF */   sw        $s0, 0x18($sp)
    /* 13FFC 800237FC 21382002 */  addu       $a3, $s1, $zero
    /* 14000 80023800 1000A827 */  addiu      $t0, $sp, 0x10
    /* 14004 80023804 0580023C */  lui        $v0, %hi(D_800516A0)
    /* 14008 80023808 A0164924 */  addiu      $t1, $v0, %lo(D_800516A0)
    /* 1400C 8002380C 21802001 */  addu       $s0, $t1, $zero
    /* 14010 80023810 21302002 */  addu       $a2, $s1, $zero
  .L80023814:
    /* 14014 80023814 21280000 */  addu       $a1, $zero, $zero
    /* 14018 80023818 2110A600 */  addu       $v0, $a1, $a2
  .L8002381C:
    /* 1401C 8002381C 21104900 */  addu       $v0, $v0, $t1
    /* 14020 80023820 21180501 */  addu       $v1, $t0, $a1
    /* 14024 80023824 00004490 */  lbu        $a0, 0x0($v0)
    /* 14028 80023828 00006290 */  lbu        $v0, 0x0($v1)
    /* 1402C 8002382C 00000000 */  nop
    /* 14030 80023830 06008214 */  bne        $a0, $v0, .L8002384C
    /* 14034 80023834 08000224 */   addiu     $v0, $zero, 0x8
    /* 14038 80023838 0100A524 */  addiu      $a1, $a1, 0x1
    /* 1403C 8002383C 0800A228 */  slti       $v0, $a1, 0x8
    /* 14040 80023840 F6FF4014 */  bnez       $v0, .L8002381C
    /* 14044 80023844 2110A600 */   addu      $v0, $a1, $a2
    /* 14048 80023848 08000224 */  addiu      $v0, $zero, 0x8
  .L8002384C:
    /* 1404C 8002384C 0800A214 */  bne        $a1, $v0, .L80023870
    /* 14050 80023850 0100E724 */   addiu     $a3, $a3, 0x1
    /* 14054 80023854 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* 14058 80023858 1A000424 */   addiu     $a0, $zero, 0x1A
    /* 1405C 8002385C 0800048E */  lw         $a0, 0x8($s0)
    /* 14060 80023860 768D000C */  jal        FECheat_ActivateBonus__F10tCheatCode
    /* 14064 80023864 01001124 */   addiu     $s1, $zero, 0x1
    /* 14068 80023868 218E0008 */  j          .L80023884
    /* 1406C 8002386C 21102002 */   addu      $v0, $s1, $zero
  .L80023870:
    /* 14070 80023870 0C001026 */  addiu      $s0, $s0, 0xC
    /* 14074 80023874 0300E228 */  slti       $v0, $a3, 0x3
    /* 14078 80023878 E6FF4014 */  bnez       $v0, .L80023814
    /* 1407C 8002387C 0C00C624 */   addiu     $a2, $a2, 0xC
    /* 14080 80023880 21102002 */  addu       $v0, $s1, $zero
  .L80023884:
    /* 14084 80023884 2000BF8F */  lw         $ra, 0x20($sp)
    /* 14088 80023888 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 1408C 8002388C 1800B08F */  lw         $s0, 0x18($sp)
    /* 14090 80023890 0800E003 */  jr         $ra
    /* 14094 80023894 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel FECheat_ActivateBonusByCode__FPc
