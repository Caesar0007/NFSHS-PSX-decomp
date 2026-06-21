.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DoMemCardStuff__25tScreenPinkSlipsCarSelect, 0x318

glabel DoMemCardStuff__25tScreenPinkSlipsCarSelect
    /* 2F714 8003EF14 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 2F718 8003EF18 2400B5AF */  sw         $s5, 0x24($sp)
    /* 2F71C 8003EF1C 0580153C */  lui        $s5, %hi(FEApp)
    /* 2F720 8003EF20 C014A28E */  lw         $v0, %lo(FEApp)($s5)
    /* 2F724 8003EF24 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2F728 8003EF28 21908000 */  addu       $s2, $a0, $zero
    /* 2F72C 8003EF2C 3000BFAF */  sw         $ra, 0x30($sp)
    /* 2F730 8003EF30 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 2F734 8003EF34 2800B6AF */  sw         $s6, 0x28($sp)
    /* 2F738 8003EF38 2000B4AF */  sw         $s4, 0x20($sp)
    /* 2F73C 8003EF3C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 2F740 8003EF40 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2F744 8003EF44 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2F748 8003EF48 2C025390 */  lbu        $s3, 0x22C($v0)
    /* 2F74C 8003EF4C 00000000 */  nop
    /* 2F750 8003EF50 02006012 */  beqz       $s3, .L8003EF5C
    /* 2F754 8003EF54 01001124 */   addiu     $s1, $zero, 0x1
    /* 2F758 8003EF58 05001124 */  addiu      $s1, $zero, 0x5
  .L8003EF5C:
    /* 2F75C 8003EF5C 4804428E */  lw         $v0, 0x448($s2)
    /* 2F760 8003EF60 00000000 */  nop
    /* 2F764 8003EF64 A6004014 */  bnez       $v0, .L8003F200
    /* 2F768 8003EF68 01001624 */   addiu     $s6, $zero, 0x1
    /* 2F76C 8003EF6C 05007616 */  bne        $s3, $s6, .L8003EF84
    /* 2F770 8003EF70 0580023C */   lui       $v0, %hi(PinkSlipsScreenState)
    /* 2F774 8003EF74 3420438C */  lw         $v1, %lo(PinkSlipsScreenState)($v0)
    /* 2F778 8003EF78 06000224 */  addiu      $v0, $zero, 0x6
    /* 2F77C 8003EF7C A0006214 */  bne        $v1, $v0, .L8003F200
    /* 2F780 8003EF80 0580023C */   lui       $v0, %hi(PinkSlipsScreenState)
  .L8003EF84:
    /* 2F784 8003EF84 34204324 */  addiu      $v1, $v0, %lo(PinkSlipsScreenState)
    /* 2F788 8003EF88 3420428C */  lw         $v0, %lo(PinkSlipsScreenState)($v0)
    /* 2F78C 8003EF8C 08001424 */  addiu      $s4, $zero, 0x8
    /* 2F790 8003EF90 9B005410 */  beq        $v0, $s4, .L8003F200
    /* 2F794 8003EF94 00000000 */   nop
    /* 2F798 8003EF98 0400628C */  lw         $v0, 0x4($v1)
    /* 2F79C 8003EF9C 00000000 */  nop
    /* 2F7A0 8003EFA0 97005410 */  beq        $v0, $s4, .L8003F200
    /* 2F7A4 8003EFA4 80B81300 */   sll       $s7, $s3, 2
    /* 2F7A8 8003EFA8 2180E302 */  addu       $s0, $s7, $v1
    /* 2F7AC 8003EFAC 0000048E */  lw         $a0, 0x0($s0)
    /* 2F7B0 8003EFB0 06000224 */  addiu      $v0, $zero, 0x6
    /* 2F7B4 8003EFB4 92008210 */  beq        $a0, $v0, .L8003F200
    /* 2F7B8 8003EFB8 00000000 */   nop
    /* 2F7BC 8003EFBC 2404428E */  lw         $v0, 0x424($s2)
    /* 2F7C0 8003EFC0 00000000 */  nop
    /* 2F7C4 8003EFC4 01004238 */  xori       $v0, $v0, 0x1
    /* 2F7C8 8003EFC8 03004010 */  beqz       $v0, .L8003EFD8
    /* 2F7CC 8003EFCC 00000000 */   nop
    /* 2F7D0 8003EFD0 80FC0008 */  j          .L8003F200
    /* 2F7D4 8003EFD4 380440AE */   sw        $zero, 0x438($s2)
  .L8003EFD8:
    /* 2F7D8 8003EFD8 3804438E */  lw         $v1, 0x438($s2)
    /* 2F7DC 8003EFDC 00000000 */  nop
    /* 2F7E0 8003EFE0 05006228 */  slti       $v0, $v1, 0x5
    /* 2F7E4 8003EFE4 03004010 */  beqz       $v0, .L8003EFF4
    /* 2F7E8 8003EFE8 01006224 */   addiu     $v0, $v1, 0x1
    /* 2F7EC 8003EFEC 80FC0008 */  j          .L8003F200
    /* 2F7F0 8003EFF0 380442AE */   sw        $v0, 0x438($s2)
  .L8003EFF4:
    /* 2F7F4 8003EFF4 66009410 */  beq        $a0, $s4, .L8003F190
    /* 2F7F8 8003EFF8 00000000 */   nop
    /* 2F7FC 8003EFFC A03F010C */  jal        MCRD_handlecardevents
    /* 2F800 8003F000 21202002 */   addu      $a0, $s1, $zero
    /* 2F804 8003F004 9140010C */  jal        MCRD_getcard
    /* 2F808 8003F008 21202002 */   addu      $a0, $s1, $zero
    /* 2F80C 8003F00C 3C0442AE */  sw         $v0, 0x43C($s2)
    /* 2F810 8003F010 0000438C */  lw         $v1, 0x0($v0)
    /* 2F814 8003F014 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2F818 8003F018 03006214 */  bne        $v1, $v0, .L8003F028
    /* 2F81C 8003F01C 0580023C */   lui       $v0, %hi(CURRENTLYUSINGMEMCARD)
    /* 2F820 8003F020 64FC0008 */  j          .L8003F190
    /* 2F824 8003F024 000000AE */   sw        $zero, 0x0($s0)
  .L8003F028:
    /* 2F828 8003F028 7C1A428C */  lw         $v0, %lo(CURRENTLYUSINGMEMCARD)($v0)
    /* 2F82C 8003F02C 00000000 */  nop
    /* 2F830 8003F030 58004014 */  bnez       $v0, .L8003F194
    /* 2F834 8003F034 0580123C */   lui       $s2, %hi(PinkSlipsScreenState)
    /* 2F838 8003F038 0000028E */  lw         $v0, 0x0($s0)
    /* 2F83C 8003F03C 00000000 */  nop
    /* 2F840 8003F040 54004014 */  bnez       $v0, .L8003F194
    /* 2F844 8003F044 00000000 */   nop
    /* 2F848 8003F048 C014A48E */  lw         $a0, %lo(FEApp)($s5)
    /* 2F84C 8003F04C CF4D000C */  jal        Redraw__14tFEApplication
    /* 2F850 8003F050 000014AE */   sw        $s4, 0x0($s0)
    /* 2F854 8003F054 C014A48E */  lw         $a0, %lo(FEApp)($s5)
    /* 2F858 8003F058 CF4D000C */  jal        Redraw__14tFEApplication
    /* 2F85C 8003F05C 21886002 */   addu      $s1, $s3, $zero
    /* 2F860 8003F060 21202002 */  addu       $a0, $s1, $zero
    /* 2F864 8003F064 01000524 */  addiu      $a1, $zero, 0x1
    /* 2F868 8003F068 86D3000C */  jal        LoadGame__FsbT1
    /* 2F86C 8003F06C 21300000 */   addu      $a2, $zero, $zero
    /* 2F870 8003F070 00140200 */  sll        $v0, $v0, 16
    /* 2F874 8003F074 031C0200 */  sra        $v1, $v0, 16
    /* 2F878 8003F078 36006014 */  bnez       $v1, .L8003F154
    /* 2F87C 8003F07C 1180023C */   lui       $v0, %hi(carManager)
    /* 2F880 8003F080 74425224 */  addiu      $s2, $v0, %lo(carManager)
    /* 2F884 8003F084 21204002 */  addu       $a0, $s2, $zero
    /* 2F888 8003F088 085D000C */  jal        GetNumPinkSlipsCars__11tCarManagers
    /* 2F88C 8003F08C 21282002 */   addu      $a1, $s1, $zero
    /* 2F890 8003F090 BB58000C */  jal        CheapestCarStockPrice__11tCarManager
    /* 2F894 8003F094 21204002 */   addu      $a0, $s2, $zero
    /* 2F898 8003F098 21204002 */  addu       $a0, $s2, $zero
    /* 2F89C 8003F09C 085D000C */  jal        GetNumPinkSlipsCars__11tCarManagers
    /* 2F8A0 8003F0A0 21282002 */   addu      $a1, $s1, $zero
    /* 2F8A4 8003F0A4 00140200 */  sll        $v0, $v0, 16
    /* 2F8A8 8003F0A8 03140200 */  sra        $v0, $v0, 16
    /* 2F8AC 8003F0AC 20000324 */  addiu      $v1, $zero, 0x20
    /* 2F8B0 8003F0B0 04004314 */  bne        $v0, $v1, .L8003F0C4
    /* 2F8B4 8003F0B4 21A00000 */   addu      $s4, $zero, $zero
    /* 2F8B8 8003F0B8 05000224 */  addiu      $v0, $zero, 0x5
    /* 2F8BC 8003F0BC 64FC0008 */  j          .L8003F190
    /* 2F8C0 8003F0C0 000002AE */   sw        $v0, 0x0($s0)
  .L8003F0C4:
    /* 2F8C4 8003F0C4 21204002 */  addu       $a0, $s2, $zero
    /* 2F8C8 8003F0C8 085D000C */  jal        GetNumPinkSlipsCars__11tCarManagers
    /* 2F8CC 8003F0CC 21282002 */   addu      $a1, $s1, $zero
    /* 2F8D0 8003F0D0 00140200 */  sll        $v0, $v0, 16
    /* 2F8D4 8003F0D4 03140200 */  sra        $v0, $v0, 16
    /* 2F8D8 8003F0D8 02004228 */  slti       $v0, $v0, 0x2
    /* 2F8DC 8003F0DC 10004010 */  beqz       $v0, .L8003F120
    /* 2F8E0 8003F0E0 21204002 */   addu      $a0, $s2, $zero
    /* 2F8E4 8003F0E4 085D000C */  jal        GetNumPinkSlipsCars__11tCarManagers
    /* 2F8E8 8003F0E8 21282002 */   addu      $a1, $s1, $zero
    /* 2F8EC 8003F0EC 00140200 */  sll        $v0, $v0, 16
    /* 2F8F0 8003F0F0 03140200 */  sra        $v0, $v0, 16
    /* 2F8F4 8003F0F4 0B005614 */  bne        $v0, $s6, .L8003F124
    /* 2F8F8 8003F0F8 21204002 */   addu      $a0, $s2, $zero
    /* 2F8FC 8003F0FC 1180103C */  lui        $s0, %hi(frontEnd)
    /* 2F900 8003F100 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 2F904 8003F104 BB58000C */  jal        CheapestCarStockPrice__11tCarManager
    /* 2F908 8003F108 2180F002 */   addu      $s0, $s7, $s0
    /* 2F90C 8003F10C 4C00038E */  lw         $v1, 0x4C($s0)
    /* 2F910 8003F110 00000000 */  nop
    /* 2F914 8003F114 2A186200 */  slt        $v1, $v1, $v0
    /* 2F918 8003F118 02006014 */  bnez       $v1, .L8003F124
    /* 2F91C 8003F11C 00000000 */   nop
  .L8003F120:
    /* 2F920 8003F120 01001424 */  addiu      $s4, $zero, 0x1
  .L8003F124:
    /* 2F924 8003F124 06008012 */  beqz       $s4, .L8003F140
    /* 2F928 8003F128 80181300 */   sll       $v1, $s3, 2
    /* 2F92C 8003F12C 0580023C */  lui        $v0, %hi(PinkSlipsScreenState)
    /* 2F930 8003F130 34204224 */  addiu      $v0, $v0, %lo(PinkSlipsScreenState)
    /* 2F934 8003F134 21186200 */  addu       $v1, $v1, $v0
    /* 2F938 8003F138 63FC0008 */  j          .L8003F18C
    /* 2F93C 8003F13C 06000224 */   addiu     $v0, $zero, 0x6
  .L8003F140:
    /* 2F940 8003F140 0580023C */  lui        $v0, %hi(PinkSlipsScreenState)
    /* 2F944 8003F144 34204224 */  addiu      $v0, $v0, %lo(PinkSlipsScreenState)
    /* 2F948 8003F148 21186200 */  addu       $v1, $v1, $v0
    /* 2F94C 8003F14C 63FC0008 */  j          .L8003F18C
    /* 2F950 8003F150 04000224 */   addiu     $v0, $zero, 0x4
  .L8003F154:
    /* 2F954 8003F154 05007610 */  beq        $v1, $s6, .L8003F16C
    /* 2F958 8003F158 02000224 */   addiu     $v0, $zero, 0x2
    /* 2F95C 8003F15C 05006210 */  beq        $v1, $v0, .L8003F174
    /* 2F960 8003F160 0580023C */   lui       $v0, %hi(PinkSlipsScreenState)
    /* 2F964 8003F164 60FC0008 */  j          .L8003F180
    /* 2F968 8003F168 34204224 */   addiu     $v0, $v0, %lo(PinkSlipsScreenState)
  .L8003F16C:
    /* 2F96C 8003F16C 64FC0008 */  j          .L8003F190
    /* 2F970 8003F170 000003AE */   sw        $v1, 0x0($s0)
  .L8003F174:
    /* 2F974 8003F174 03000224 */  addiu      $v0, $zero, 0x3
    /* 2F978 8003F178 64FC0008 */  j          .L8003F190
    /* 2F97C 8003F17C 000002AE */   sw        $v0, 0x0($s0)
  .L8003F180:
    /* 2F980 8003F180 80181300 */  sll        $v1, $s3, 2
    /* 2F984 8003F184 21186200 */  addu       $v1, $v1, $v0
    /* 2F988 8003F188 02000224 */  addiu      $v0, $zero, 0x2
  .L8003F18C:
    /* 2F98C 8003F18C 000062AC */  sw         $v0, 0x0($v1)
  .L8003F190:
    /* 2F990 8003F190 0580123C */  lui        $s2, %hi(PinkSlipsScreenState)
  .L8003F194:
    /* 2F994 8003F194 34205426 */  addiu      $s4, $s2, %lo(PinkSlipsScreenState)
    /* 2F998 8003F198 80101300 */  sll        $v0, $s3, 2
    /* 2F99C 8003F19C 21105400 */  addu       $v0, $v0, $s4
    /* 2F9A0 8003F1A0 0000428C */  lw         $v0, 0x0($v0)
    /* 2F9A4 8003F1A4 06001124 */  addiu      $s1, $zero, 0x6
    /* 2F9A8 8003F1A8 09005114 */  bne        $v0, $s1, .L8003F1D0
    /* 2F9AC 8003F1AC 0580103C */   lui       $s0, %hi(menuDefs)
    /* 2F9B0 8003F1B0 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 2F9B4 8003F1B4 21286002 */  addu       $a1, $s3, $zero
    /* 2F9B8 8003F1B8 2D60000C */  jal        Decrement__16tListIteratorCar7tPlayer
    /* 2F9BC 8003F1BC D4198424 */   addiu     $a0, $a0, 0x19D4
    /* 2F9C0 8003F1C0 581A048E */  lw         $a0, %lo(menuDefs)($s0)
    /* 2F9C4 8003F1C4 21286002 */  addu       $a1, $s3, $zero
    /* 2F9C8 8003F1C8 2560000C */  jal        Increment__16tListIteratorCar7tPlayer
    /* 2F9CC 8003F1CC D4198424 */   addiu     $a0, $a0, 0x19D4
  .L8003F1D0:
    /* 2F9D0 8003F1D0 3420438E */  lw         $v1, %lo(PinkSlipsScreenState)($s2)
    /* 2F9D4 8003F1D4 00000000 */  nop
    /* 2F9D8 8003F1D8 09007114 */  bne        $v1, $s1, .L8003F200
    /* 2F9DC 8003F1DC 00000000 */   nop
    /* 2F9E0 8003F1E0 0400828E */  lw         $v0, 0x4($s4)
    /* 2F9E4 8003F1E4 00000000 */  nop
    /* 2F9E8 8003F1E8 05004314 */  bne        $v0, $v1, .L8003F200
    /* 2F9EC 8003F1EC 00000000 */   nop
    /* 2F9F0 8003F1F0 00D2000C */  jal        DeInit_Memcard__Fv
    /* 2F9F4 8003F1F4 00000000 */   nop
    /* 2F9F8 8003F1F8 F3AD000C */  jal        SetLicensePlate__Fv
    /* 2F9FC 8003F1FC 00000000 */   nop
  .L8003F200:
    /* 2FA00 8003F200 3000BF8F */  lw         $ra, 0x30($sp)
    /* 2FA04 8003F204 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 2FA08 8003F208 2800B68F */  lw         $s6, 0x28($sp)
    /* 2FA0C 8003F20C 2400B58F */  lw         $s5, 0x24($sp)
    /* 2FA10 8003F210 2000B48F */  lw         $s4, 0x20($sp)
    /* 2FA14 8003F214 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 2FA18 8003F218 1800B28F */  lw         $s2, 0x18($sp)
    /* 2FA1C 8003F21C 1400B18F */  lw         $s1, 0x14($sp)
    /* 2FA20 8003F220 1000B08F */  lw         $s0, 0x10($sp)
    /* 2FA24 8003F224 0800E003 */  jr         $ra
    /* 2FA28 8003F228 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel DoMemCardStuff__25tScreenPinkSlipsCarSelect
