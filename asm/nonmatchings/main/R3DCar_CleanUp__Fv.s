.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_CleanUp__Fv, 0x168

glabel R3DCar_CleanUp__Fv
    /* 9E740 800ADF40 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9E744 800ADF44 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9E748 800ADF48 21900000 */  addu       $s2, $zero, $zero
    /* 9E74C 800ADF4C 1180023C */  lui        $v0, %hi(R3DCar_LoadedSceneCounter)
    /* 9E750 800ADF50 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9E754 800ADF54 986A5124 */  addiu      $s1, $v0, %lo(R3DCar_LoadedSceneCounter)
    /* 9E758 800ADF58 1180023C */  lui        $v0, %hi(R3DCar_LoadedScenePointer)
    /* 9E75C 800ADF5C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9E760 800ADF60 08695024 */  addiu      $s0, $v0, %lo(R3DCar_LoadedScenePointer)
    /* 9E764 800ADF64 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800ADF68:
    /* 9E768 800ADF68 0000048E */  lw         $a0, 0x0($s0)
    /* 9E76C 800ADF6C 00000000 */  nop
    /* 9E770 800ADF70 05008010 */  beqz       $a0, .L800ADF88
    /* 9E774 800ADF74 00000000 */   nop
    /* 9E778 800ADF78 5095030C */  jal        purgememadr
    /* 9E77C 800ADF7C 00000000 */   nop
    /* 9E780 800ADF80 000000AE */  sw         $zero, 0x0($s0)
    /* 9E784 800ADF84 000020A2 */  sb         $zero, 0x0($s1)
  .L800ADF88:
    /* 9E788 800ADF88 C800048E */  lw         $a0, 0xC8($s0)
    /* 9E78C 800ADF8C 00000000 */  nop
    /* 9E790 800ADF90 05008010 */  beqz       $a0, .L800ADFA8
    /* 9E794 800ADF94 00000000 */   nop
    /* 9E798 800ADF98 5095030C */  jal        purgememadr
    /* 9E79C 800ADF9C 00000000 */   nop
    /* 9E7A0 800ADFA0 C80000AE */  sw         $zero, 0xC8($s0)
    /* 9E7A4 800ADFA4 320020A2 */  sb         $zero, 0x32($s1)
  .L800ADFA8:
    /* 9E7A8 800ADFA8 01003126 */  addiu      $s1, $s1, 0x1
    /* 9E7AC 800ADFAC 01005226 */  addiu      $s2, $s2, 0x1
    /* 9E7B0 800ADFB0 3200422A */  slti       $v0, $s2, 0x32
    /* 9E7B4 800ADFB4 ECFF4014 */  bnez       $v0, .L800ADF68
    /* 9E7B8 800ADFB8 04001026 */   addiu     $s0, $s0, 0x4
    /* 9E7BC 800ADFBC 3C0E848F */  lw         $a0, %gp_rel(R3DCar_orientMat)($gp)
    /* 9E7C0 800ADFC0 00000000 */  nop
    /* 9E7C4 800ADFC4 03008010 */  beqz       $a0, .L800ADFD4
    /* 9E7C8 800ADFC8 00000000 */   nop
    /* 9E7CC 800ADFCC 5095030C */  jal        purgememadr
    /* 9E7D0 800ADFD0 00000000 */   nop
  .L800ADFD4:
    /* 9E7D4 800ADFD4 400E848F */  lw         $a0, %gp_rel(R3DCar_position)($gp)
    /* 9E7D8 800ADFD8 3C0E80AF */  sw         $zero, %gp_rel(R3DCar_orientMat)($gp)
    /* 9E7DC 800ADFDC 03008010 */  beqz       $a0, .L800ADFEC
    /* 9E7E0 800ADFE0 00000000 */   nop
    /* 9E7E4 800ADFE4 5095030C */  jal        purgememadr
    /* 9E7E8 800ADFE8 00000000 */   nop
  .L800ADFEC:
    /* 9E7EC 800ADFEC 680E848F */  lw         $a0, %gp_rel(R3DCar_LicenseShapeFile)($gp)
    /* 9E7F0 800ADFF0 400E80AF */  sw         $zero, %gp_rel(R3DCar_position)($gp)
    /* 9E7F4 800ADFF4 03008010 */  beqz       $a0, .L800AE004
    /* 9E7F8 800ADFF8 1180103C */   lui       $s0, %hi(R3DCar_subOtStart)
    /* 9E7FC 800ADFFC 5095030C */  jal        purgememadr
    /* 9E800 800AE000 00000000 */   nop
  .L800AE004:
    /* 9E804 800AE004 AC6D048E */  lw         $a0, %lo(R3DCar_subOtStart)($s0)
    /* 9E808 800AE008 680E80AF */  sw         $zero, %gp_rel(R3DCar_LicenseShapeFile)($gp)
    /* 9E80C 800AE00C 03008010 */  beqz       $a0, .L800AE01C
    /* 9E810 800AE010 AC6D1126 */   addiu     $s1, $s0, %lo(R3DCar_subOtStart)
    /* 9E814 800AE014 5095030C */  jal        purgememadr
    /* 9E818 800AE018 00000000 */   nop
  .L800AE01C:
    /* 9E81C 800AE01C 0800248E */  lw         $a0, 0x8($s1)
    /* 9E820 800AE020 00000000 */  nop
    /* 9E824 800AE024 03008010 */  beqz       $a0, .L800AE034
    /* 9E828 800AE028 00000000 */   nop
    /* 9E82C 800AE02C 5095030C */  jal        purgememadr
    /* 9E830 800AE030 00000000 */   nop
  .L800AE034:
    /* 9E834 800AE034 D80D828F */  lw         $v0, %gp_rel(R3DCar_InMenu)($gp)
    /* 9E838 800AE038 080020AE */  sw         $zero, 0x8($s1)
    /* 9E83C 800AE03C 06004014 */  bnez       $v0, .L800AE058
    /* 9E840 800AE040 AC6D00AE */   sw        $zero, %lo(R3DCar_subOtStart)($s0)
    /* 9E844 800AE044 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 9E848 800AE048 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 9E84C 800AE04C 01000224 */  addiu      $v0, $zero, 0x1
    /* 9E850 800AE050 0F006214 */  bne        $v1, $v0, .L800AE090
    /* 9E854 800AE054 00000000 */   nop
  .L800AE058:
    /* 9E858 800AE058 0400248E */  lw         $a0, 0x4($s1)
    /* 9E85C 800AE05C 00000000 */  nop
    /* 9E860 800AE060 03008010 */  beqz       $a0, .L800AE070
    /* 9E864 800AE064 00000000 */   nop
    /* 9E868 800AE068 5095030C */  jal        purgememadr
    /* 9E86C 800AE06C 00000000 */   nop
  .L800AE070:
    /* 9E870 800AE070 0C00248E */  lw         $a0, 0xC($s1)
    /* 9E874 800AE074 00000000 */  nop
    /* 9E878 800AE078 03008010 */  beqz       $a0, .L800AE088
    /* 9E87C 800AE07C 00000000 */   nop
    /* 9E880 800AE080 5095030C */  jal        purgememadr
    /* 9E884 800AE084 00000000 */   nop
  .L800AE088:
    /* 9E888 800AE088 0C0020AE */  sw         $zero, 0xC($s1)
    /* 9E88C 800AE08C 040020AE */  sw         $zero, 0x4($s1)
  .L800AE090:
    /* 9E890 800AE090 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 9E894 800AE094 1800B28F */  lw         $s2, 0x18($sp)
    /* 9E898 800AE098 1400B18F */  lw         $s1, 0x14($sp)
    /* 9E89C 800AE09C 1000B08F */  lw         $s0, 0x10($sp)
    /* 9E8A0 800AE0A0 0800E003 */  jr         $ra
    /* 9E8A4 800AE0A4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel R3DCar_CleanUp__Fv
