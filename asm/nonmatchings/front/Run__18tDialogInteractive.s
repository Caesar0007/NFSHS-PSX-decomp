.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Run__18tDialogInteractive, 0x1EC

glabel Run__18tDialogInteractive
    /* 9FE8 800197E8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 9FEC 800197EC 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* 9FF0 800197F0 21988000 */  addu       $s3, $a0, $zero
    /* 9FF4 800197F4 01000224 */  addiu      $v0, $zero, 0x1
    /* 9FF8 800197F8 4000BFAF */  sw         $ra, 0x40($sp)
    /* 9FFC 800197FC 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* A000 80019800 3800B6AF */  sw         $s6, 0x38($sp)
    /* A004 80019804 3400B5AF */  sw         $s5, 0x34($sp)
    /* A008 80019808 3000B4AF */  sw         $s4, 0x30($sp)
    /* A00C 8001980C 2800B2AF */  sw         $s2, 0x28($sp)
    /* A010 80019810 2400B1AF */  sw         $s1, 0x24($sp)
    /* A014 80019814 2000B0AF */  sw         $s0, 0x20($sp)
    /* A018 80019818 1062000C */  jal        Display__11tDialogBase
    /* A01C 8001981C 9C0062AE */   sw        $v0, 0x9C($s3)
    /* A020 80019820 1000B727 */  addiu      $s7, $sp, 0x10
    /* A024 80019824 01001424 */  addiu      $s4, $zero, 0x1
    /* A028 80019828 6000628E */  lw         $v0, 0x60($s3)
    /* A02C 8001982C 0580153C */  lui        $s5, %hi(FEApp)
    /* A030 80019830 50004484 */  lh         $a0, 0x50($v0)
    /* A034 80019834 5400428C */  lw         $v0, 0x54($v0)
    /* A038 80019838 00000000 */  nop
    /* A03C 8001983C 09F84000 */  jalr       $v0
    /* A040 80019840 21206402 */   addu      $a0, $s3, $a0
    /* A044 80019844 980060AE */  sw         $zero, 0x98($s3)
  .L80019848:
    /* A048 80019848 9800628E */  lw         $v0, 0x98($s3)
    /* A04C 8001984C 00000000 */  nop
    /* A050 80019850 4B004014 */  bnez       $v0, .L80019980
    /* A054 80019854 FFFF1624 */   addiu     $s6, $zero, -0x1
    /* A058 80019858 1800A0AF */  sw         $zero, 0x18($sp)
    /* A05C 8001985C 21880000 */  addu       $s1, $zero, $zero
    /* A060 80019860 2180E002 */  addu       $s0, $s7, $zero
    /* A064 80019864 21902002 */  addu       $s2, $s1, $zero
  .L80019868:
    /* A068 80019868 0200222A */  slti       $v0, $s1, 0x2
    /* A06C 8001986C 3F004010 */  beqz       $v0, .L8001996C
    /* A070 80019870 21202002 */   addu      $a0, $s1, $zero
    /* A074 80019874 228F000C */  jal        FEInput_GetKeyFromPlayer__F7tPlayerl
    /* A078 80019878 2128C002 */   addu      $a1, $s6, $zero
    /* A07C 8001987C 02004014 */  bnez       $v0, .L80019888
    /* A080 80019880 000002AE */   sw        $v0, 0x0($s0)
    /* A084 80019884 000014AE */  sw         $s4, 0x0($s0)
  .L80019888:
    /* A088 80019888 0000038E */  lw         $v1, 0x0($s0)
    /* A08C 8001988C 04000224 */  addiu      $v0, $zero, 0x4
    /* A090 80019890 18006214 */  bne        $v1, $v0, .L800198F4
    /* A094 80019894 00000000 */   nop
    /* A098 80019898 C014A48E */  lw         $a0, %lo(FEApp)($s5)
    /* A09C 8001989C 00000000 */  nop
    /* A0A0 800198A0 C801828C */  lw         $v0, 0x1C8($a0)
    /* A0A4 800198A4 00000000 */  nop
    /* A0A8 800198A8 05004014 */  bnez       $v0, .L800198C0
    /* A0AC 800198AC 21180000 */   addu      $v1, $zero, $zero
    /* A0B0 800198B0 21109200 */  addu       $v0, $a0, $s2
    /* A0B4 800198B4 0400428C */  lw         $v0, 0x4($v0)
    /* A0B8 800198B8 00000000 */  nop
    /* A0BC 800198BC 2B186200 */  sltu       $v1, $v1, $v0
  .L800198C0:
    /* A0C0 800198C0 0C006010 */  beqz       $v1, .L800198F4
    /* A0C4 800198C4 21282002 */   addu      $a1, $s1, $zero
    /* A0C8 800198C8 21109200 */  addu       $v0, $a0, $s2
    /* A0CC 800198CC 0400438C */  lw         $v1, 0x4($v0)
    /* A0D0 800198D0 21300002 */  addu       $a2, $s0, $zero
    /* A0D4 800198D4 6800628C */  lw         $v0, 0x68($v1)
    /* A0D8 800198D8 1800A727 */  addiu      $a3, $sp, 0x18
    /* A0DC 800198DC 18004484 */  lh         $a0, 0x18($v0)
    /* A0E0 800198E0 1C00428C */  lw         $v0, 0x1C($v0)
    /* A0E4 800198E4 00000000 */  nop
    /* A0E8 800198E8 09F84000 */  jalr       $v0
    /* A0EC 800198EC 21206400 */   addu      $a0, $v1, $a0
    /* A0F0 800198F0 000014AE */  sw         $s4, 0x0($s0)
  .L800198F4:
    /* A0F4 800198F4 0000028E */  lw         $v0, 0x0($s0)
    /* A0F8 800198F8 00000000 */  nop
    /* A0FC 800198FC 0C005410 */  beq        $v0, $s4, .L80019930
    /* A100 80019900 00000000 */   nop
    /* A104 80019904 C014A28E */  lw         $v0, %lo(FEApp)($s5)
    /* A108 80019908 00000000 */  nop
    /* A10C 8001990C 58014424 */  addiu      $a0, $v0, 0x158
    /* A110 80019910 7000828C */  lw         $v0, 0x70($a0)
    /* A114 80019914 00000000 */  nop
    /* A118 80019918 04004010 */  beqz       $v0, .L8001992C
    /* A11C 8001991C 00000000 */   nop
    /* A120 80019920 4162000C */  jal        Hide__11tDialogBase
    /* A124 80019924 00000000 */   nop
    /* A128 80019928 000014AE */  sw         $s4, 0x0($s0)
  .L8001992C:
    /* A12C 8001992C 0000028E */  lw         $v0, 0x0($s0)
  .L80019930:
    /* A130 80019930 00000000 */  nop
    /* A134 80019934 09004010 */  beqz       $v0, .L8001995C
    /* A138 80019938 21282002 */   addu      $a1, $s1, $zero
    /* A13C 8001993C 21300002 */  addu       $a2, $s0, $zero
    /* A140 80019940 6000628E */  lw         $v0, 0x60($s3)
    /* A144 80019944 1800A727 */  addiu      $a3, $sp, 0x18
    /* A148 80019948 48004484 */  lh         $a0, 0x48($v0)
    /* A14C 8001994C 4C00428C */  lw         $v0, 0x4C($v0)
    /* A150 80019950 00000000 */  nop
    /* A154 80019954 09F84000 */  jalr       $v0
    /* A158 80019958 21206402 */   addu      $a0, $s3, $a0
  .L8001995C:
    /* A15C 8001995C 04001026 */  addiu      $s0, $s0, 0x4
    /* A160 80019960 04005226 */  addiu      $s2, $s2, 0x4
    /* A164 80019964 1A660008 */  j          .L80019868
    /* A168 80019968 01003126 */   addiu     $s1, $s1, 0x1
  .L8001996C:
    /* A16C 8001996C C014A48E */  lw         $a0, %lo(FEApp)($s5)
    /* A170 80019970 CF4D000C */  jal        Redraw__14tFEApplication
    /* A174 80019974 00000000 */   nop
    /* A178 80019978 12660008 */  j          .L80019848
    /* A17C 8001997C 00000000 */   nop
  .L80019980:
    /* A180 80019980 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* A184 80019984 21200000 */   addu      $a0, $zero, $zero
    /* A188 80019988 4162000C */  jal        Hide__11tDialogBase
    /* A18C 8001998C 21206002 */   addu      $a0, $s3, $zero
    /* A190 80019990 0580023C */  lui        $v0, %hi(FEApp)
    /* A194 80019994 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* A198 80019998 CF4D000C */  jal        Redraw__14tFEApplication
    /* A19C 8001999C 00000000 */   nop
    /* A1A0 800199A0 8A006286 */  lh         $v0, 0x8A($s3)
    /* A1A4 800199A4 9C0060AE */  sw         $zero, 0x9C($s3)
    /* A1A8 800199A8 4000BF8F */  lw         $ra, 0x40($sp)
    /* A1AC 800199AC 3C00B78F */  lw         $s7, 0x3C($sp)
    /* A1B0 800199B0 3800B68F */  lw         $s6, 0x38($sp)
    /* A1B4 800199B4 3400B58F */  lw         $s5, 0x34($sp)
    /* A1B8 800199B8 3000B48F */  lw         $s4, 0x30($sp)
    /* A1BC 800199BC 2C00B38F */  lw         $s3, 0x2C($sp)
    /* A1C0 800199C0 2800B28F */  lw         $s2, 0x28($sp)
    /* A1C4 800199C4 2400B18F */  lw         $s1, 0x24($sp)
    /* A1C8 800199C8 2000B08F */  lw         $s0, 0x20($sp)
    /* A1CC 800199CC 0800E003 */  jr         $ra
    /* A1D0 800199D0 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Run__18tDialogInteractive
