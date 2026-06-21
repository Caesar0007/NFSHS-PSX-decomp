.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetLicensePlate__Fv, 0xA8

glabel SetLicensePlate__Fv
    /* 1BFCC 8002B7CC D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 1BFD0 8002B7D0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1BFD4 8002B7D4 21900000 */  addu       $s2, $zero, $zero
    /* 1BFD8 8002B7D8 1180023C */  lui        $v0, %hi(D_80114984)
    /* 1BFDC 8002B7DC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1BFE0 8002B7E0 84495324 */  addiu      $s3, $v0, %lo(D_80114984)
    /* 1BFE4 8002B7E4 2000BFAF */  sw         $ra, 0x20($sp)
    /* 1BFE8 8002B7E8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1BFEC 8002B7EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1BFF0 8002B7F0 008C1200 */  sll        $s1, $s2, 16
  .L8002B7F4:
    /* 1BFF4 8002B7F4 038C1100 */  sra        $s1, $s1, 16
    /* 1BFF8 8002B7F8 7FAE000C */  jal        PlayerName__Fi
    /* 1BFFC 8002B7FC 21202002 */   addu      $a0, $s1, $zero
    /* 1C000 8002B800 C0801100 */  sll        $s0, $s1, 3
    /* 1C004 8002B804 21801302 */  addu       $s0, $s0, $s3
    /* 1C008 8002B808 21200002 */  addu       $a0, $s0, $zero
    /* 1C00C 8002B80C 2F91030C */  jal        sprintf
    /* 1C010 8002B810 21284000 */   addu      $a1, $v0, $zero
    /* 1C014 8002B814 132B010C */  jal        StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters__FPc
    /* 1C018 8002B818 21200002 */   addu      $a0, $s0, $zero
    /* 1C01C 8002B81C 549A000C */  jal        s_lower__FPc
    /* 1C020 8002B820 21200002 */   addu      $a0, $s0, $zero
    /* 1C024 8002B824 7CF1020C */  jal        CarIO_CleanUpLicense__Fi
    /* 1C028 8002B828 21202002 */   addu      $a0, $s1, $zero
    /* 1C02C 8002B82C 21200002 */  addu       $a0, $s0, $zero
    /* 1C030 8002B830 21280000 */  addu       $a1, $zero, $zero
    /* 1C034 8002B834 97F0020C */  jal        CarIO_CreateLicense__FPcii
    /* 1C038 8002B838 21302002 */   addu      $a2, $s1, $zero
    /* 1C03C 8002B83C 01004226 */  addiu      $v0, $s2, 0x1
    /* 1C040 8002B840 21904000 */  addu       $s2, $v0, $zero
    /* 1C044 8002B844 00140200 */  sll        $v0, $v0, 16
    /* 1C048 8002B848 03140200 */  sra        $v0, $v0, 16
    /* 1C04C 8002B84C 02004228 */  slti       $v0, $v0, 0x2
    /* 1C050 8002B850 E8FF4014 */  bnez       $v0, .L8002B7F4
    /* 1C054 8002B854 008C1200 */   sll       $s1, $s2, 16
    /* 1C058 8002B858 2000BF8F */  lw         $ra, 0x20($sp)
    /* 1C05C 8002B85C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 1C060 8002B860 1800B28F */  lw         $s2, 0x18($sp)
    /* 1C064 8002B864 1400B18F */  lw         $s1, 0x14($sp)
    /* 1C068 8002B868 1000B08F */  lw         $s0, 0x10($sp)
    /* 1C06C 8002B86C 0800E003 */  jr         $ra
    /* 1C070 8002B870 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SetLicensePlate__Fv
