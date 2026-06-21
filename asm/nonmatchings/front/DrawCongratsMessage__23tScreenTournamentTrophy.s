.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawCongratsMessage__23tScreenTournamentTrophy, 0x2D8

glabel DrawCongratsMessage__23tScreenTournamentTrophy
    /* 39764 80048F64 50FABD27 */  addiu      $sp, $sp, -0x5B0
    /* 39768 80048F68 A805B4AF */  sw         $s4, 0x5A8($sp)
    /* 3976C 80048F6C 21A08000 */  addu       $s4, $a0, $zero
    /* 39770 80048F70 29000224 */  addiu      $v0, $zero, 0x29
    /* 39774 80048F74 1800A2A7 */  sh         $v0, 0x18($sp)
    /* 39778 80048F78 3C000224 */  addiu      $v0, $zero, 0x3C
    /* 3977C 80048F7C 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* 39780 80048F80 C8000224 */  addiu      $v0, $zero, 0xC8
    /* 39784 80048F84 1C00A2A7 */  sh         $v0, 0x1C($sp)
    /* 39788 80048F88 90010224 */  addiu      $v0, $zero, 0x190
    /* 3978C 80048F8C AC05BFAF */  sw         $ra, 0x5AC($sp)
    /* 39790 80048F90 A405B3AF */  sw         $s3, 0x5A4($sp)
    /* 39794 80048F94 A005B2AF */  sw         $s2, 0x5A0($sp)
    /* 39798 80048F98 9C05B1AF */  sw         $s1, 0x59C($sp)
    /* 3979C 80048F9C 9805B0AF */  sw         $s0, 0x598($sp)
    /* 397A0 80048FA0 1E00A2A7 */  sh         $v0, 0x1E($sp)
    /* 397A4 80048FA4 6400828E */  lw         $v0, 0x64($s4)
    /* 397A8 80048FA8 00000000 */  nop
    /* 397AC 80048FAC 8B004014 */  bnez       $v0, .L800491DC
    /* 397B0 80048FB0 1180043C */   lui       $a0, %hi(tournamentManager)
    /* 397B4 80048FB4 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 397B8 80048FB8 21900000 */  addu       $s2, $zero, $zero
    /* 397BC 80048FBC 0400838C */  lw         $v1, 0x4($a0)
    /* 397C0 80048FC0 1800858C */  lw         $a1, 0x18($a0)
    /* 397C4 80048FC4 40100300 */  sll        $v0, $v1, 1
    /* 397C8 80048FC8 21104300 */  addu       $v0, $v0, $v1
    /* 397CC 80048FCC 80100200 */  sll        $v0, $v0, 2
    /* 397D0 80048FD0 2110A200 */  addu       $v0, $a1, $v0
    /* 397D4 80048FD4 02004390 */  lbu        $v1, 0x2($v0)
    /* 397D8 80048FD8 0800828C */  lw         $v0, 0x8($a0)
    /* 397DC 80048FDC 21984002 */  addu       $s3, $s2, $zero
    /* 397E0 80048FE0 21186200 */  addu       $v1, $v1, $v0
    /* 397E4 80048FE4 80100300 */  sll        $v0, $v1, 2
    /* 397E8 80048FE8 21104300 */  addu       $v0, $v0, $v1
    /* 397EC 80048FEC 80100200 */  sll        $v0, $v0, 2
    /* 397F0 80048FF0 21104300 */  addu       $v0, $v0, $v1
    /* 397F4 80048FF4 80100200 */  sll        $v0, $v0, 2
    /* 397F8 80048FF8 24004224 */  addiu      $v0, $v0, 0x24
    /* 397FC 80048FFC 30028380 */  lb         $v1, 0x230($a0)
    /* 39800 80049000 00000000 */  nop
    /* 39804 80049004 04006328 */  slti       $v1, $v1, 0x4
    /* 39808 80049008 1E006014 */  bnez       $v1, .L80049084
    /* 3980C 8004900C 2188A200 */   addu      $s1, $a1, $v0
    /* 39810 80049010 00002282 */  lb         $v0, 0x0($s1)
    /* 39814 80049014 6800838E */  lw         $v1, 0x68($s4)
    /* 39818 80049018 B3035224 */  addiu      $s2, $v0, 0x3B3
    /* 3981C 8004901C 01000224 */  addiu      $v0, $zero, 0x1
    /* 39820 80049020 0B006210 */  beq        $v1, $v0, .L80049050
    /* 39824 80049024 02006228 */   slti      $v0, $v1, 0x2
    /* 39828 80049028 05004010 */  beqz       $v0, .L80049040
    /* 3982C 8004902C 03000224 */   addiu     $v0, $zero, 0x3
    /* 39830 80049030 05006010 */  beqz       $v1, .L80049048
    /* 39834 80049034 00000000 */   nop
    /* 39838 80049038 17240108 */  j          .L8004905C
    /* 3983C 8004903C 02001024 */   addiu     $s0, $zero, 0x2
  .L80049040:
    /* 39840 80049040 05006214 */  bne        $v1, $v0, .L80049058
    /* 39844 80049044 00000000 */   nop
  .L80049048:
    /* 39848 80049048 17240108 */  j          .L8004905C
    /* 3984C 8004904C 21800000 */   addu      $s0, $zero, $zero
  .L80049050:
    /* 39850 80049050 17240108 */  j          .L8004905C
    /* 39854 80049054 01001024 */   addiu     $s0, $zero, 0x1
  .L80049058:
    /* 39858 80049058 02001024 */  addiu      $s0, $zero, 0x2
  .L8004905C:
    /* 3985C 8004905C 00002482 */  lb         $a0, 0x0($s1)
    /* 39860 80049060 94E4020C */  jal        TextSys_Word__Fi
    /* 39864 80049064 B3038424 */   addiu     $a0, $a0, 0x3B3
    /* 39868 80049068 E1030426 */  addiu      $a0, $s0, 0x3E1
    /* 3986C 8004906C 94E4020C */  jal        TextSys_Word__Fi
    /* 39870 80049070 21804000 */   addu      $s0, $v0, $zero
    /* 39874 80049074 6800A427 */  addiu      $a0, $sp, 0x68
    /* 39878 80049078 21280002 */  addu       $a1, $s0, $zero
    /* 3987C 8004907C 2F91030C */  jal        sprintf
    /* 39880 80049080 21304000 */   addu      $a2, $v0, $zero
  .L80049084:
    /* 39884 80049084 6800848E */  lw         $a0, 0x68($s4)
    /* 39888 80049088 00000000 */  nop
    /* 3988C 8004908C 06008014 */  bnez       $a0, .L800490A8
    /* 39890 80049090 03000224 */   addiu     $v0, $zero, 0x3
    /* 39894 80049094 1180023C */  lui        $v0, %hi(D_80114D08)
    /* 39898 80049098 084D4380 */  lb         $v1, %lo(D_80114D08)($v0)
    /* 3989C 8004909C 01000224 */  addiu      $v0, $zero, 0x1
    /* 398A0 800490A0 03006214 */  bne        $v1, $v0, .L800490B0
    /* 398A4 800490A4 03000224 */   addiu     $v0, $zero, 0x3
  .L800490A8:
    /* 398A8 800490A8 12008214 */  bne        $a0, $v0, .L800490F4
    /* 398AC 800490AC 00000000 */   nop
  .L800490B0:
    /* 398B0 800490B0 08004016 */  bnez       $s2, .L800490D4
    /* 398B4 800490B4 00000000 */   nop
    /* 398B8 800490B8 00002282 */  lb         $v0, 0x0($s1)
    /* 398BC 800490BC 00000000 */  nop
    /* 398C0 800490C0 C6035224 */  addiu      $s2, $v0, 0x3C6
    /* 398C4 800490C4 94E4020C */  jal        TextSys_Word__Fi
    /* 398C8 800490C8 21204002 */   addu      $a0, $s2, $zero
    /* 398CC 800490CC 3B240108 */  j          .L800490EC
    /* 398D0 800490D0 6800A427 */   addiu     $a0, $sp, 0x68
  .L800490D4:
    /* 398D4 800490D4 00002282 */  lb         $v0, 0x0($s1)
    /* 398D8 800490D8 00000000 */  nop
    /* 398DC 800490DC C6035324 */  addiu      $s3, $v0, 0x3C6
    /* 398E0 800490E0 94E4020C */  jal        TextSys_Word__Fi
    /* 398E4 800490E4 21206002 */   addu      $a0, $s3, $zero
    /* 398E8 800490E8 6002A427 */  addiu      $a0, $sp, 0x260
  .L800490EC:
    /* 398EC 800490EC 2F91030C */  jal        sprintf
    /* 398F0 800490F0 21284000 */   addu      $a1, $v0, $zero
  .L800490F4:
    /* 398F4 800490F4 0F004012 */  beqz       $s2, .L80049134
    /* 398F8 800490F8 1800A627 */   addiu     $a2, $sp, 0x18
    /* 398FC 800490FC 6800B027 */  addiu      $s0, $sp, 0x68
    /* 39900 80049100 21280002 */  addu       $a1, $s0, $zero
    /* 39904 80049104 01000724 */  addiu      $a3, $zero, 0x1
    /* 39908 80049108 5C008486 */  lh         $a0, 0x5C($s4)
    /* 3990C 8004910C 0A000224 */  addiu      $v0, $zero, 0xA
    /* 39910 80049110 D085000C */  jal        FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
    /* 39914 80049114 1000A2AF */   sw        $v0, 0x10($sp)
    /* 39918 80049118 1C00A487 */  lh         $a0, 0x1C($sp)
    /* 3991C 8004911C 3286000C */  jal        FETextRender_WordWrapHeight__FsPc
    /* 39920 80049120 21280002 */   addu      $a1, $s0, $zero
    /* 39924 80049124 1A00A397 */  lhu        $v1, 0x1A($sp)
    /* 39928 80049128 00000000 */  nop
    /* 3992C 8004912C 21186200 */  addu       $v1, $v1, $v0
    /* 39930 80049130 1A00A3A7 */  sh         $v1, 0x1A($sp)
  .L80049134:
    /* 39934 80049134 07006012 */  beqz       $s3, .L80049154
    /* 39938 80049138 6002A527 */   addiu     $a1, $sp, 0x260
    /* 3993C 8004913C 1800A627 */  addiu      $a2, $sp, 0x18
    /* 39940 80049140 01000724 */  addiu      $a3, $zero, 0x1
    /* 39944 80049144 5C008486 */  lh         $a0, 0x5C($s4)
    /* 39948 80049148 0A000224 */  addiu      $v0, $zero, 0xA
    /* 3994C 8004914C D085000C */  jal        FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
    /* 39950 80049150 1000A2AF */   sw        $v0, 0x10($sp)
  .L80049154:
    /* 39954 80049154 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 39958 80049158 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 3995C 8004915C 35CE000C */  jal        GetAwardInformation__18tTournamentManagerR17tAwardInformation
    /* 39960 80049160 2000A527 */   addiu     $a1, $sp, 0x20
    /* 39964 80049164 4000A28F */  lw         $v0, 0x40($sp)
    /* 39968 80049168 00000000 */  nop
    /* 3996C 8004916C 2B004010 */  beqz       $v0, .L8004921C
    /* 39970 80049170 5805B027 */   addiu     $s0, $sp, 0x558
    /* 39974 80049174 21200002 */  addu       $a0, $s0, $zero
    /* 39978 80049178 4400A58F */  lw         $a1, 0x44($sp)
    /* 3997C 8004917C 04010224 */  addiu      $v0, $zero, 0x104
    /* 39980 80049180 1800A2A7 */  sh         $v0, 0x18($sp)
    /* 39984 80049184 C8000224 */  addiu      $v0, $zero, 0xC8
    /* 39988 80049188 1A00A2A7 */  sh         $v0, 0x1A($sp)
    /* 3998C 8004918C F0000224 */  addiu      $v0, $zero, 0xF0
    /* 39990 80049190 389B000C */  jal        FeTools_FormatMoney__FPcl
    /* 39994 80049194 1C00A2A7 */   sh        $v0, 0x1C($sp)
    /* 39998 80049198 94E4020C */  jal        TextSys_Word__Fi
    /* 3999C 8004919C 40000424 */   addiu     $a0, $zero, 0x40
    /* 399A0 800491A0 5804A427 */  addiu      $a0, $sp, 0x458
    /* 399A4 800491A4 21284000 */  addu       $a1, $v0, $zero
    /* 399A8 800491A8 2F91030C */  jal        sprintf
    /* 399AC 800491AC 21300002 */   addu      $a2, $s0, $zero
    /* 399B0 800491B0 94E4020C */  jal        TextSys_Word__Fi
    /* 399B4 800491B4 40000424 */   addiu     $a0, $zero, 0x40
    /* 399B8 800491B8 21284000 */  addu       $a1, $v0, $zero
    /* 399BC 800491BC 1800A627 */  addiu      $a2, $sp, 0x18
    /* 399C0 800491C0 01000724 */  addiu      $a3, $zero, 0x1
    /* 399C4 800491C4 5C008486 */  lh         $a0, 0x5C($s4)
    /* 399C8 800491C8 0A000224 */  addiu      $v0, $zero, 0xA
    /* 399CC 800491CC D085000C */  jal        FETextRender_WordWrapTextFade__FiPcR4RECT14tMenuTextState13tMenuTextType
    /* 399D0 800491D0 1000A2AF */   sw        $v0, 0x10($sp)
    /* 399D4 800491D4 87240108 */  j          .L8004921C
    /* 399D8 800491D8 00000000 */   nop
  .L800491DC:
    /* 399DC 800491DC ACE4020C */  jal        TextSys_WordY__Fi
    /* 399E0 800491E0 20030424 */   addiu     $a0, $zero, 0x320
    /* 399E4 800491E4 20030424 */  addiu      $a0, $zero, 0x320
    /* 399E8 800491E8 94E4020C */  jal        TextSys_Word__Fi
    /* 399EC 800491EC F6FF5024 */   addiu     $s0, $v0, -0xA
    /* 399F0 800491F0 21204000 */  addu       $a0, $v0, $zero
    /* 399F4 800491F4 20010524 */  addiu      $a1, $zero, 0x120
    /* 399F8 800491F8 00841000 */  sll        $s0, $s0, 16
    /* 399FC 800491FC 03341000 */  sra        $a2, $s0, 16
    /* 39A00 80049200 4100073C */  lui        $a3, (0x414141 >> 16)
    /* 39A04 80049204 4141E734 */  ori        $a3, $a3, (0x414141 & 0xFFFF)
    /* 39A08 80049208 03000224 */  addiu      $v0, $zero, 0x3
    /* 39A0C 8004920C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 39A10 80049210 02000224 */  addiu      $v0, $zero, 0x2
    /* 39A14 80049214 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* 39A18 80049218 1400A2AF */   sw        $v0, 0x14($sp)
  .L8004921C:
    /* 39A1C 8004921C AC05BF8F */  lw         $ra, 0x5AC($sp)
    /* 39A20 80049220 A805B48F */  lw         $s4, 0x5A8($sp)
    /* 39A24 80049224 A405B38F */  lw         $s3, 0x5A4($sp)
    /* 39A28 80049228 A005B28F */  lw         $s2, 0x5A0($sp)
    /* 39A2C 8004922C 9C05B18F */  lw         $s1, 0x59C($sp)
    /* 39A30 80049230 9805B08F */  lw         $s0, 0x598($sp)
    /* 39A34 80049234 0800E003 */  jr         $ra
    /* 39A38 80049238 B005BD27 */   addiu     $sp, $sp, 0x5B0
endlabel DrawCongratsMessage__23tScreenTournamentTrophy
