.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_cachefile, 0x29C

glabel CD_cachefile
    /* E9EE8 800F96E8 1380023C */  lui        $v0, %hi(D_80136C68)
    /* E9EEC 800F96EC 686C428C */  lw         $v0, %lo(D_80136C68)($v0)
    /* E9EF0 800F96F0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* E9EF4 800F96F4 3800B6AF */  sw         $s6, 0x38($sp)
    /* E9EF8 800F96F8 21B08000 */  addu       $s6, $a0, $zero
    /* E9EFC 800F96FC 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* E9F00 800F9700 3400B5AF */  sw         $s5, 0x34($sp)
    /* E9F04 800F9704 3000B4AF */  sw         $s4, 0x30($sp)
    /* E9F08 800F9708 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* E9F0C 800F970C 2800B2AF */  sw         $s2, 0x28($sp)
    /* E9F10 800F9710 2400B1AF */  sw         $s1, 0x24($sp)
    /* E9F14 800F9714 9000C212 */  beq        $s6, $v0, .L800F9958
    /* E9F18 800F9718 2000B0AF */   sw        $s0, 0x20($sp)
    /* E9F1C 800F971C 01000424 */  addiu      $a0, $zero, 0x1
    /* E9F20 800F9720 40101600 */  sll        $v0, $s6, 1
    /* E9F24 800F9724 21105600 */  addu       $v0, $v0, $s6
    /* E9F28 800F9728 80100200 */  sll        $v0, $v0, 2
    /* E9F2C 800F972C 23105600 */  subu       $v0, $v0, $s6
    /* E9F30 800F9730 80100200 */  sll        $v0, $v0, 2
    /* E9F34 800F9734 1480053C */  lui        $a1, %hi(D_80144E58)
    /* E9F38 800F9738 2128A200 */  addu       $a1, $a1, $v0
    /* E9F3C 800F973C 584EA58C */  lw         $a1, %lo(D_80144E58)($a1)
    /* E9F40 800F9740 1480103C */  lui        $s0, %hi(D_8014647C)
    /* E9F44 800F9744 7C641026 */  addiu      $s0, $s0, %lo(D_8014647C)
    /* E9F48 800F9748 61E6030C */  jal        cd_read
    /* E9F4C 800F974C 21300002 */   addu      $a2, $s0, $zero
    /* E9F50 800F9750 01000324 */  addiu      $v1, $zero, 0x1
    /* E9F54 800F9754 0B004310 */  beq        $v0, $v1, .L800F9784
    /* E9F58 800F9758 00000000 */   nop
    /* E9F5C 800F975C 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9F60 800F9760 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9F64 800F9764 00000000 */  nop
    /* E9F68 800F9768 7C004018 */  blez       $v0, .L800F995C
    /* E9F6C 800F976C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* E9F70 800F9770 0580043C */  lui        $a0, %hi(D_800572EC)
    /* E9F74 800F9774 2B0A040C */  jal        printf
    /* E9F78 800F9778 EC728424 */   addiu     $a0, $a0, %lo(D_800572EC)
    /* E9F7C 800F977C 57E60308 */  j          .L800F995C
    /* E9F80 800F9780 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800F9784:
    /* E9F84 800F9784 1480023C */  lui        $v0, %hi(CD_debug)
    /* E9F88 800F9788 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* E9F8C 800F978C 00000000 */  nop
    /* E9F90 800F9790 02004228 */  slti       $v0, $v0, 0x2
    /* E9F94 800F9794 05004014 */  bnez       $v0, .L800F97AC
    /* E9F98 800F9798 00080226 */   addiu     $v0, $s0, 0x800
    /* E9F9C 800F979C 0580043C */  lui        $a0, %hi(D_8005730C)
    /* E9FA0 800F97A0 2B0A040C */  jal        printf
    /* E9FA4 800F97A4 0C738424 */   addiu     $a0, $a0, %lo(D_8005730C)
    /* E9FA8 800F97A8 00080226 */  addiu      $v0, $s0, 0x800
  .L800F97AC:
    /* E9FAC 800F97AC 2B100202 */  sltu       $v0, $s0, $v0
    /* E9FB0 800F97B0 55004010 */  beqz       $v0, .L800F9908
    /* E9FB4 800F97B4 21900000 */   addu      $s2, $zero, $zero
    /* E9FB8 800F97B8 1480153C */  lui        $s5, %hi(D_8014487C)
    /* E9FBC 800F97BC 7C48B526 */  addiu      $s5, $s5, %lo(D_8014487C)
    /* E9FC0 800F97C0 0800B326 */  addiu      $s3, $s5, 0x8
    /* E9FC4 800F97C4 21880000 */  addu       $s1, $zero, $zero
    /* E9FC8 800F97C8 21A0A002 */  addu       $s4, $s5, $zero
  .L800F97CC:
    /* E9FCC 800F97CC 00000292 */  lbu        $v0, 0x0($s0)
    /* E9FD0 800F97D0 00000000 */  nop
    /* E9FD4 800F97D4 4C004010 */  beqz       $v0, .L800F9908
    /* E9FD8 800F97D8 00000000 */   nop
    /* E9FDC 800F97DC 0500028A */  lwl        $v0, 0x5($s0)
    /* E9FE0 800F97E0 0200029A */  lwr        $v0, 0x2($s0)
    /* E9FE4 800F97E4 00000000 */  nop
    /* E9FE8 800F97E8 1B00A2AB */  swl        $v0, 0x1B($sp)
    /* E9FEC 800F97EC 1800A2BB */  swr        $v0, 0x18($sp)
    /* E9FF0 800F97F0 1800A48F */  lw         $a0, 0x18($sp)
    /* E9FF4 800F97F4 3DDF030C */  jal        CdIntToPos
    /* E9FF8 800F97F8 21288002 */   addu      $a1, $s4, $zero
    /* E9FFC 800F97FC 0400A226 */  addiu      $v0, $s5, 0x4
    /* EA000 800F9800 21102202 */  addu       $v0, $s1, $v0
    /* EA004 800F9804 0D00038A */  lwl        $v1, 0xD($s0)
    /* EA008 800F9808 0A00039A */  lwr        $v1, 0xA($s0)
    /* EA00C 800F980C 00000000 */  nop
    /* EA010 800F9810 030043A8 */  swl        $v1, 0x3($v0)
    /* EA014 800F9814 000043B8 */  swr        $v1, 0x0($v0)
    /* EA018 800F9818 05004012 */  beqz       $s2, .L800F9830
    /* EA01C 800F981C 01000224 */   addiu     $v0, $zero, 0x1
    /* EA020 800F9820 07004212 */  beq        $s2, $v0, .L800F9840
    /* EA024 800F9824 21206002 */   addu      $a0, $s3, $zero
    /* EA028 800F9828 17E60308 */  j          .L800F985C
    /* EA02C 800F982C 00000000 */   nop
  .L800F9830:
    /* EA030 800F9830 0580023C */  lui        $v0, %hi(D_80057328)
    /* EA034 800F9834 28734294 */  lhu        $v0, %lo(D_80057328)($v0)
    /* EA038 800F9838 1EE60308 */  j          .L800F9878
    /* EA03C 800F983C 0800A2A6 */   sh        $v0, 0x8($s5)
  .L800F9840:
    /* EA040 800F9840 0580023C */  lui        $v0, %hi(D_8005732C)
    /* EA044 800F9844 2C734284 */  lh         $v0, %lo(D_8005732C)($v0)
    /* EA048 800F9848 0580033C */  lui        $v1, %hi(D_8005732E)
    /* EA04C 800F984C 2E736380 */  lb         $v1, %lo(D_8005732E)($v1)
    /* EA050 800F9850 2000A2A6 */  sh         $v0, 0x20($s5)
    /* EA054 800F9854 1EE60308 */  j          .L800F9878
    /* EA058 800F9858 2200A3A2 */   sb        $v1, 0x22($s5)
  .L800F985C:
    /* EA05C 800F985C 20000692 */  lbu        $a2, 0x20($s0)
    /* EA060 800F9860 B1AA030C */  jal        memcpy
    /* EA064 800F9864 21000526 */   addiu     $a1, $s0, 0x21
    /* EA068 800F9868 20000292 */  lbu        $v0, 0x20($s0)
    /* EA06C 800F986C 00000000 */  nop
    /* EA070 800F9870 21106202 */  addu       $v0, $s3, $v0
    /* EA074 800F9874 000040A0 */  sb         $zero, 0x0($v0)
  .L800F9878:
    /* EA078 800F9878 1480023C */  lui        $v0, %hi(CD_debug)
    /* EA07C 800F987C 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* EA080 800F9880 00000000 */  nop
    /* EA084 800F9884 02004228 */  slti       $v0, $v0, 0x2
    /* EA088 800F9888 12004014 */  bnez       $v0, .L800F98D4
    /* EA08C 800F988C 00000000 */   nop
    /* EA090 800F9890 1480053C */  lui        $a1, %hi(D_8014487C)
    /* EA094 800F9894 2128B100 */  addu       $a1, $a1, $s1
    /* EA098 800F9898 7C48A590 */  lbu        $a1, %lo(D_8014487C)($a1)
    /* EA09C 800F989C 1480063C */  lui        $a2, %hi(D_8014487D)
    /* EA0A0 800F98A0 2130D100 */  addu       $a2, $a2, $s1
    /* EA0A4 800F98A4 7D48C690 */  lbu        $a2, %lo(D_8014487D)($a2)
    /* EA0A8 800F98A8 1480073C */  lui        $a3, %hi(D_8014487E)
    /* EA0AC 800F98AC 2138F100 */  addu       $a3, $a3, $s1
    /* EA0B0 800F98B0 7E48E790 */  lbu        $a3, %lo(D_8014487E)($a3)
    /* EA0B4 800F98B4 1480023C */  lui        $v0, %hi(D_80144880)
    /* EA0B8 800F98B8 21105100 */  addu       $v0, $v0, $s1
    /* EA0BC 800F98BC 8048428C */  lw         $v0, %lo(D_80144880)($v0)
    /* EA0C0 800F98C0 0580043C */  lui        $a0, %hi(D_80057330)
    /* EA0C4 800F98C4 30738424 */  addiu      $a0, $a0, %lo(D_80057330)
    /* EA0C8 800F98C8 1400B3AF */  sw         $s3, 0x14($sp)
    /* EA0CC 800F98CC 2B0A040C */  jal        printf
    /* EA0D0 800F98D0 1000A2AF */   sw        $v0, 0x10($sp)
  .L800F98D4:
    /* EA0D4 800F98D4 18007326 */  addiu      $s3, $s3, 0x18
    /* EA0D8 800F98D8 18003126 */  addiu      $s1, $s1, 0x18
    /* EA0DC 800F98DC 00000292 */  lbu        $v0, 0x0($s0)
    /* EA0E0 800F98E0 01005226 */  addiu      $s2, $s2, 0x1
    /* EA0E4 800F98E4 21800202 */  addu       $s0, $s0, $v0
    /* EA0E8 800F98E8 4000422A */  slti       $v0, $s2, 0x40
    /* EA0EC 800F98EC 06004010 */  beqz       $v0, .L800F9908
    /* EA0F0 800F98F0 18009426 */   addiu     $s4, $s4, 0x18
    /* EA0F4 800F98F4 1480023C */  lui        $v0, %hi(StEmu_Addr)
    /* EA0F8 800F98F8 7C6C4224 */  addiu      $v0, $v0, %lo(StEmu_Addr)
    /* EA0FC 800F98FC 2B100202 */  sltu       $v0, $s0, $v0
    /* EA100 800F9900 B2FF4014 */  bnez       $v0, .L800F97CC
    /* EA104 800F9904 00000000 */   nop
  .L800F9908:
    /* EA108 800F9908 1380013C */  lui        $at, %hi(D_80136C68)
    /* EA10C 800F990C 686C36AC */  sw         $s6, %lo(D_80136C68)($at)
    /* EA110 800F9910 4000422A */  slti       $v0, $s2, 0x40
    /* EA114 800F9914 06004010 */  beqz       $v0, .L800F9930
    /* EA118 800F9918 40101200 */   sll       $v0, $s2, 1
    /* EA11C 800F991C 21105200 */  addu       $v0, $v0, $s2
    /* EA120 800F9920 C0100200 */  sll        $v0, $v0, 3
    /* EA124 800F9924 1480013C */  lui        $at, %hi(D_80144884)
    /* EA128 800F9928 21082200 */  addu       $at, $at, $v0
    /* EA12C 800F992C 844820A0 */  sb         $zero, %lo(D_80144884)($at)
  .L800F9930:
    /* EA130 800F9930 1480023C */  lui        $v0, %hi(CD_debug)
    /* EA134 800F9934 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* EA138 800F9938 00000000 */  nop
    /* EA13C 800F993C 02004228 */  slti       $v0, $v0, 0x2
    /* EA140 800F9940 06004014 */  bnez       $v0, .L800F995C
    /* EA144 800F9944 01000224 */   addiu     $v0, $zero, 0x1
    /* EA148 800F9948 0580043C */  lui        $a0, %hi(D_8005734C)
    /* EA14C 800F994C 4C738424 */  addiu      $a0, $a0, %lo(D_8005734C)
    /* EA150 800F9950 2B0A040C */  jal        printf
    /* EA154 800F9954 21284002 */   addu      $a1, $s2, $zero
  .L800F9958:
    /* EA158 800F9958 01000224 */  addiu      $v0, $zero, 0x1
  .L800F995C:
    /* EA15C 800F995C 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* EA160 800F9960 3800B68F */  lw         $s6, 0x38($sp)
    /* EA164 800F9964 3400B58F */  lw         $s5, 0x34($sp)
    /* EA168 800F9968 3000B48F */  lw         $s4, 0x30($sp)
    /* EA16C 800F996C 2C00B38F */  lw         $s3, 0x2C($sp)
    /* EA170 800F9970 2800B28F */  lw         $s2, 0x28($sp)
    /* EA174 800F9974 2400B18F */  lw         $s1, 0x24($sp)
    /* EA178 800F9978 2000B08F */  lw         $s0, 0x20($sp)
    /* EA17C 800F997C 0800E003 */  jr         $ra
    /* EA180 800F9980 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel CD_cachefile
