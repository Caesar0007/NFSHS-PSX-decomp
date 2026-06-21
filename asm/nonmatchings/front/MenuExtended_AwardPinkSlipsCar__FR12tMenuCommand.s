.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand, 0x228

glabel MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand
    /* 1E674 8002DE74 08FEBD27 */  addiu      $sp, $sp, -0x1F8
    /* 1E678 8002DE78 EC01B5AF */  sw         $s5, 0x1EC($sp)
    /* 1E67C 8002DE7C 21A88000 */  addu       $s5, $a0, $zero
    /* 1E680 8002DE80 D801B0AF */  sw         $s0, 0x1D8($sp)
    /* 1E684 8002DE84 6000B027 */  addiu      $s0, $sp, 0x60
    /* 1E688 8002DE88 21200002 */  addu       $a0, $s0, $zero
    /* 1E68C 8002DE8C F001BFAF */  sw         $ra, 0x1F0($sp)
    /* 1E690 8002DE90 E801B4AF */  sw         $s4, 0x1E8($sp)
    /* 1E694 8002DE94 E401B3AF */  sw         $s3, 0x1E4($sp)
    /* 1E698 8002DE98 E001B2AF */  sw         $s2, 0x1E0($sp)
    /* 1E69C 8002DE9C A366000C */  jal        __12tDialogYesNo
    /* 1E6A0 8002DEA0 DC01B1AF */   sw        $s1, 0x1DC($sp)
    /* 1E6A4 8002DEA4 91020224 */  addiu      $v0, $zero, 0x291
    /* 1E6A8 8002DEA8 A00002AE */  sw         $v0, 0xA0($s0)
    /* 1E6AC 8002DEAC 92020224 */  addiu      $v0, $zero, 0x292
    /* 1E6B0 8002DEB0 A40002AE */  sw         $v0, 0xA4($s0)
    /* 1E6B4 8002DEB4 0580023C */  lui        $v0, %hi(screenPinkSlipCongrats)
    /* 1E6B8 8002DEB8 4429438C */  lw         $v1, %lo(screenPinkSlipCongrats)($v0)
    /* 1E6BC 8002DEBC 01000224 */  addiu      $v0, $zero, 0x1
    /* 1E6C0 8002DEC0 880002A6 */  sh         $v0, 0x88($s0)
    /* 1E6C4 8002DEC4 84017384 */  lh         $s3, 0x184($v1)
    /* 1E6C8 8002DEC8 94E4020C */  jal        TextSys_Word__Fi
    /* 1E6CC 8002DECC 9A020424 */   addiu     $a0, $zero, 0x29A
    /* 1E6D0 8002DED0 21804000 */  addu       $s0, $v0, $zero
    /* 1E6D4 8002DED4 7FAE000C */  jal        PlayerName__Fi
    /* 1E6D8 8002DED8 21206002 */   addu      $a0, $s3, $zero
    /* 1E6DC 8002DEDC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 1E6E0 8002DEE0 21280002 */  addu       $a1, $s0, $zero
    /* 1E6E4 8002DEE4 21304000 */  addu       $a2, $v0, $zero
    /* 1E6E8 8002DEE8 2F91030C */  jal        sprintf
    /* 1E6EC 8002DEEC 01006726 */   addiu     $a3, $s3, 0x1
    /* 1E6F0 8002DEF0 0580023C */  lui        $v0, %hi(FEApp)
    /* 1E6F4 8002DEF4 21A04000 */  addu       $s4, $v0, $zero
    /* 1E6F8 8002DEF8 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1E6FC 8002DEFC 1000A227 */  addiu      $v0, $sp, 0x10
    /* 1E700 8002DF00 D0028424 */  addiu      $a0, $a0, 0x2D0
    /* 1E704 8002DF04 1062000C */  jal        Display__11tDialogBase
    /* 1E708 8002DF08 900082AC */   sw        $v0, 0x90($a0)
  .L8002DF0C:
    /* 1E70C 8002DF0C C014848E */  lw         $a0, %lo(FEApp)($s4)
    /* 1E710 8002DF10 00000000 */  nop
    /* 1E714 8002DF14 5403828C */  lw         $v0, 0x354($a0)
    /* 1E718 8002DF18 00000000 */  nop
    /* 1E71C 8002DF1C 01004238 */  xori       $v0, $v0, 0x1
    /* 1E720 8002DF20 05004010 */  beqz       $v0, .L8002DF38
    /* 1E724 8002DF24 00000000 */   nop
    /* 1E728 8002DF28 CF4D000C */  jal        Redraw__14tFEApplication
    /* 1E72C 8002DF2C 00000000 */   nop
    /* 1E730 8002DF30 C3B70008 */  j          .L8002DF0C
    /* 1E734 8002DF34 00000000 */   nop
  .L8002DF38:
    /* 1E738 8002DF38 CF4D000C */  jal        Redraw__14tFEApplication
    /* 1E73C 8002DF3C 1180123C */   lui       $s2, %hi(carManager)
    /* 1E740 8002DF40 21200000 */  addu       $a0, $zero, $zero
    /* 1E744 8002DF44 A9D1000C */  jal        Init_Memcard__FbT0
    /* 1E748 8002DF48 01000524 */   addiu     $a1, $zero, 0x1
    /* 1E74C 8002DF4C 74425226 */  addiu      $s2, $s2, %lo(carManager)
    /* 1E750 8002DF50 21204002 */  addu       $a0, $s2, $zero
    /* 1E754 8002DF54 0801A627 */  addiu      $a2, $sp, 0x108
    /* 1E758 8002DF58 1180113C */  lui        $s1, %hi(frontEnd)
    /* 1E75C 8002DF5C 00463126 */  addiu      $s1, $s1, %lo(frontEnd)
    /* 1E760 8002DF60 01000724 */  addiu      $a3, $zero, 0x1
    /* 1E764 8002DF64 2338F300 */  subu       $a3, $a3, $s3
    /* 1E768 8002DF68 2110F100 */  addu       $v0, $a3, $s1
    /* 1E76C 8002DF6C 003C0700 */  sll        $a3, $a3, 16
    /* 1E770 8002DF70 25014590 */  lbu        $a1, 0x125($v0)
    /* 1E774 8002DF74 165C000C */  jal        GetPinkSlipsCar__11tCarManagersR8tCarInfos
    /* 1E778 8002DF78 033C0700 */   sra       $a3, $a3, 16
    /* 1E77C 8002DF7C 21204002 */  addu       $a0, $s2, $zero
    /* 1E780 8002DF80 21806002 */  addu       $s0, $s3, $zero
    /* 1E784 8002DF84 0801A583 */  lb         $a1, 0x108($sp)
    /* 1E788 8002DF88 CD01A693 */  lbu        $a2, 0x1CD($sp)
    /* 1E78C 8002DF8C 405A000C */  jal        AddToPinkSlipsList__11tCarManagersss
    /* 1E790 8002DF90 21380002 */   addu      $a3, $s0, $zero
    /* 1E794 8002DF94 21204002 */  addu       $a0, $s2, $zero
    /* 1E798 8002DF98 21881102 */  addu       $s1, $s0, $s1
    /* 1E79C 8002DF9C 25012592 */  lbu        $a1, 0x125($s1)
    /* 1E7A0 8002DFA0 CC01A693 */  lbu        $a2, 0x1CC($sp)
    /* 1E7A4 8002DFA4 5F5A000C */  jal        AddUpgradesToPinkSlipsList__11tCarManagersss
    /* 1E7A8 8002DFA8 21380002 */   addu      $a3, $s0, $zero
    /* 1E7AC 8002DFAC 21200002 */  addu       $a0, $s0, $zero
    /* 1E7B0 8002DFB0 02000524 */  addiu      $a1, $zero, 0x2
    /* 1E7B4 8002DFB4 DED5000C */  jal        SavePinkSlipsCarsWithErrorDialogs__Fsss
    /* 1E7B8 8002DFB8 FFFF0624 */   addiu     $a2, $zero, -0x1
    /* 1E7BC 8002DFBC C014848E */  lw         $a0, %lo(FEApp)($s4)
    /* 1E7C0 8002DFC0 4162000C */  jal        Hide__11tDialogBase
    /* 1E7C4 8002DFC4 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 1E7C8 8002DFC8 74020424 */  addiu      $a0, $zero, 0x274
    /* 1E7CC 8002DFCC 02000224 */  addiu      $v0, $zero, 0x2
    /* 1E7D0 8002DFD0 0000A2AE */  sw         $v0, 0x0($s5)
    /* 1E7D4 8002DFD4 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1E7D8 8002DFD8 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E7DC 8002DFDC C014908E */  lw         $s0, %lo(FEApp)($s4)
    /* 1E7E0 8002DFE0 B0004224 */  addiu      $v0, $v0, 0xB0
    /* 1E7E4 8002DFE4 D0021026 */  addiu      $s0, $s0, 0x2D0
    /* 1E7E8 8002DFE8 94E4020C */  jal        TextSys_Word__Fi
    /* 1E7EC 8002DFEC 0400A2AE */   sw        $v0, 0x4($s5)
    /* 1E7F0 8002DFF0 C014848E */  lw         $a0, %lo(FEApp)($s4)
    /* 1E7F4 8002DFF4 0580113C */  lui        $s1, %hi(FEApp)
    /* 1E7F8 8002DFF8 900002AE */  sw         $v0, 0x90($s0)
    /* 1E7FC 8002DFFC 1062000C */  jal        Display__11tDialogBase
    /* 1E800 8002E000 D0028424 */   addiu     $a0, $a0, 0x2D0
  .L8002E004:
    /* 1E804 8002E004 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 1E808 8002E008 00000000 */  nop
    /* 1E80C 8002E00C 5403828C */  lw         $v0, 0x354($a0)
    /* 1E810 8002E010 00000000 */  nop
    /* 1E814 8002E014 01004238 */  xori       $v0, $v0, 0x1
    /* 1E818 8002E018 05004010 */  beqz       $v0, .L8002E030
    /* 1E81C 8002E01C 00000000 */   nop
    /* 1E820 8002E020 CF4D000C */  jal        Redraw__14tFEApplication
    /* 1E824 8002E024 00000000 */   nop
    /* 1E828 8002E028 01B80008 */  j          .L8002E004
    /* 1E82C 8002E02C 00000000 */   nop
  .L8002E030:
    /* 1E830 8002E030 CF4D000C */  jal        Redraw__14tFEApplication
    /* 1E834 8002E034 00000000 */   nop
    /* 1E838 8002E038 0FB6000C */  jal        GenericMenuLoadGame__Fi
    /* 1E83C 8002E03C 21200000 */   addu      $a0, $zero, $zero
    /* 1E840 8002E040 00D2000C */  jal        DeInit_Memcard__Fv
    /* 1E844 8002E044 00000000 */   nop
    /* 1E848 8002E048 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 1E84C 8002E04C 4162000C */  jal        Hide__11tDialogBase
    /* 1E850 8002E050 D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 1E854 8002E054 6000A427 */  addiu      $a0, $sp, 0x60
    /* 1E858 8002E058 02000524 */  addiu      $a1, $zero, 0x2
    /* 1E85C 8002E05C 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1E860 8002E060 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1E864 8002E064 2118A000 */  addu       $v1, $a1, $zero
    /* 1E868 8002E068 0000A3AE */  sw         $v1, 0x0($s5)
    /* 1E86C 8002E06C B0004224 */  addiu      $v0, $v0, 0xB0
    /* 1E870 8002E070 1E98000C */  jal        ___7tScreen
    /* 1E874 8002E074 0400A2AE */   sw        $v0, 0x4($s5)
    /* 1E878 8002E078 F001BF8F */  lw         $ra, 0x1F0($sp)
    /* 1E87C 8002E07C EC01B58F */  lw         $s5, 0x1EC($sp)
    /* 1E880 8002E080 E801B48F */  lw         $s4, 0x1E8($sp)
    /* 1E884 8002E084 E401B38F */  lw         $s3, 0x1E4($sp)
    /* 1E888 8002E088 E001B28F */  lw         $s2, 0x1E0($sp)
    /* 1E88C 8002E08C DC01B18F */  lw         $s1, 0x1DC($sp)
    /* 1E890 8002E090 D801B08F */  lw         $s0, 0x1D8($sp)
    /* 1E894 8002E094 0800E003 */  jr         $ra
    /* 1E898 8002E098 F801BD27 */   addiu     $sp, $sp, 0x1F8
endlabel MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand
