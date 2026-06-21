.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawOneRecord__19tScreenTrackRecordsibi, 0x268

glabel DrawOneRecord__19tScreenTrackRecordsibi
    /* 32F00 80042700 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 32F04 80042704 8000B4AF */  sw         $s4, 0x80($sp)
    /* 32F08 80042708 21A08000 */  addu       $s4, $a0, $zero
    /* 32F0C 8004270C 7800B2AF */  sw         $s2, 0x78($sp)
    /* 32F10 80042710 2190A000 */  addu       $s2, $a1, $zero
    /* 32F14 80042714 8800B6AF */  sw         $s6, 0x88($sp)
    /* 32F18 80042718 21B0C000 */  addu       $s6, $a2, $zero
    /* 32F1C 8004271C 8400B5AF */  sw         $s5, 0x84($sp)
    /* 32F20 80042720 21A8E000 */  addu       $s5, $a3, $zero
    /* 32F24 80042724 2B201600 */  sltu       $a0, $zero, $s6
    /* 32F28 80042728 80101200 */  sll        $v0, $s2, 2
    /* 32F2C 8004272C 21105200 */  addu       $v0, $v0, $s2
    /* 32F30 80042730 8C00BFAF */  sw         $ra, 0x8C($sp)
    /* 32F34 80042734 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 32F38 80042738 7400B1AF */  sw         $s1, 0x74($sp)
    /* 32F3C 8004273C 7000B0AF */  sw         $s0, 0x70($sp)
    /* 32F40 80042740 6400838E */  lw         $v1, 0x64($s4)
    /* 32F44 80042744 80800200 */  sll        $s0, $v0, 2
    /* 32F48 80042748 21180302 */  addu       $v1, $s0, $v1
    /* 32F4C 8004274C 1000628C */  lw         $v0, 0x10($v1)
    /* 32F50 80042750 00000000 */  nop
    /* 32F54 80042754 7A004004 */  bltz       $v0, .L80042940
    /* 32F58 80042758 40980400 */   sll       $s3, $a0, 1
    /* 32F5C 8004275C 1D00C012 */  beqz       $s6, .L800427D4
    /* 32F60 80042760 00000000 */   nop
    /* 32F64 80042764 A4E4020C */  jal        TextSys_WordX__Fi
    /* 32F68 80042768 47020424 */   addiu     $a0, $zero, 0x247
    /* 32F6C 8004276C 5555033C */  lui        $v1, (0x55555556 >> 16)
    /* 32F70 80042770 6800868E */  lw         $a2, 0x68($s4)
    /* 32F74 80042774 56556334 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* 32F78 80042778 40380600 */  sll        $a3, $a2, 1
    /* 32F7C 8004277C 1800E300 */  mult       $a3, $v1
    /* 32F80 80042780 03004424 */  addiu      $a0, $v0, 0x3
    /* 32F84 80042784 0400A526 */  addiu      $a1, $s5, 0x4
    /* 32F88 80042788 17000224 */  addiu      $v0, $zero, 0x17
    /* 32F8C 8004278C 1000A2AF */  sw         $v0, 0x10($sp)
    /* 32F90 80042790 C2170600 */  srl        $v0, $a2, 31
    /* 32F94 80042794 2130C200 */  addu       $a2, $a2, $v0
    /* 32F98 80042798 43300600 */  sra        $a2, $a2, 1
    /* 32F9C 8004279C C33F0700 */  sra        $a3, $a3, 31
    /* 32FA0 800427A0 10400000 */  mfhi       $t0
    /* 32FA4 800427A4 DC37030C */  jal        Flare_2DHalo__Fiiiii
    /* 32FA8 800427A8 23380701 */   subu      $a3, $t0, $a3
    /* 32FAC 800427AC A4E4020C */  jal        TextSys_WordX__Fi
    /* 32FB0 800427B0 47020424 */   addiu     $a0, $zero, 0x247
    /* 32FB4 800427B4 21200000 */  addu       $a0, $zero, $zero
    /* 32FB8 800427B8 21288000 */  addu       $a1, $a0, $zero
    /* 32FBC 800427BC 21304000 */  addu       $a2, $v0, $zero
    /* 32FC0 800427C0 2138A002 */  addu       $a3, $s5, $zero
    /* 32FC4 800427C4 1000A0AF */  sw         $zero, 0x10($sp)
    /* 32FC8 800427C8 1400A0AF */  sw         $zero, 0x14($sp)
    /* 32FCC 800427CC 9E39010C */  jal        DrawShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 32FD0 800427D0 1800A0AF */   sw        $zero, 0x18($sp)
  .L800427D4:
    /* 32FD4 800427D4 A4E4020C */  jal        TextSys_WordX__Fi
    /* 32FD8 800427D8 4B020424 */   addiu     $a0, $zero, 0x24B
    /* 32FDC 800427DC 00140200 */  sll        $v0, $v0, 16
    /* 32FE0 800427E0 6400838E */  lw         $v1, 0x64($s4)
    /* 32FE4 800427E4 032C0200 */  sra        $a1, $v0, 16
    /* 32FE8 800427E8 00141500 */  sll        $v0, $s5, 16
    /* 32FEC 800427EC 03340200 */  sra        $a2, $v0, 16
    /* 32FF0 800427F0 0300C012 */  beqz       $s6, .L80042800
    /* 32FF4 800427F4 21207000 */   addu      $a0, $v1, $s0
    /* 32FF8 800427F8 010A0108 */  j          .L80042804
    /* 32FFC 800427FC 02000224 */   addiu     $v0, $zero, 0x2
  .L80042800:
    /* 33000 80042800 01000224 */  addiu      $v0, $zero, 0x1
  .L80042804:
    /* 33004 80042804 1000A2AF */  sw         $v0, 0x10($sp)
    /* 33008 80042808 0B000724 */  addiu      $a3, $zero, 0xB
    /* 3300C 8004280C B083000C */  jal        FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 33010 80042810 1400A0AF */   sw        $zero, 0x14($sp)
    /* 33014 80042814 80801200 */  sll        $s0, $s2, 2
    /* 33018 80042818 21801202 */  addu       $s0, $s0, $s2
    /* 3301C 8004281C 6400828E */  lw         $v0, 0x64($s4)
    /* 33020 80042820 80801000 */  sll        $s0, $s0, 2
    /* 33024 80042824 21100202 */  addu       $v0, $s0, $v0
    /* 33028 80042828 0800448C */  lw         $a0, 0x8($v0)
    /* 3302C 8004282C 94E4020C */  jal        TextSys_Word__Fi
    /* 33030 80042830 53018424 */   addiu     $a0, $a0, 0x153
    /* 33034 80042834 4C020424 */  addiu      $a0, $zero, 0x24C
    /* 33038 80042838 A4E4020C */  jal        TextSys_WordX__Fi
    /* 3303C 8004283C 21884000 */   addu      $s1, $v0, $zero
    /* 33040 80042840 21202002 */  addu       $a0, $s1, $zero
    /* 33044 80042844 00140200 */  sll        $v0, $v0, 16
    /* 33048 80042848 032C0200 */  sra        $a1, $v0, 16
    /* 3304C 8004284C 00341500 */  sll        $a2, $s5, 16
    /* 33050 80042850 03340600 */  sra        $a2, $a2, 16
    /* 33054 80042854 0B000724 */  addiu      $a3, $zero, 0xB
    /* 33058 80042858 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3305C 8004285C B083000C */  jal        FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 33060 80042860 1400A0AF */   sw        $zero, 0x14($sp)
    /* 33064 80042864 6400828E */  lw         $v0, 0x64($s4)
    /* 33068 80042868 00000000 */  nop
    /* 3306C 8004286C 21800202 */  addu       $s0, $s0, $v0
    /* 33070 80042870 0C00048E */  lw         $a0, 0xC($s0)
    /* 33074 80042874 00000000 */  nop
    /* 33078 80042878 05008010 */  beqz       $a0, .L80042890
    /* 3307C 8004287C 00000000 */   nop
    /* 33080 80042880 672A010C */  jal        Stattool_ParseTime__FiPc
    /* 33084 80042884 2000A527 */   addiu     $a1, $sp, 0x20
    /* 33088 80042888 290A0108 */  j          .L800428A4
    /* 3308C 8004288C 00000000 */   nop
  .L80042890:
    /* 33090 80042890 94E4020C */  jal        TextSys_Word__Fi
    /* 33094 80042894 61020424 */   addiu     $a0, $zero, 0x261
    /* 33098 80042898 2000A427 */  addiu      $a0, $sp, 0x20
    /* 3309C 8004289C 2F91030C */  jal        sprintf
    /* 330A0 800428A0 21284000 */   addu      $a1, $v0, $zero
  .L800428A4:
    /* 330A4 800428A4 A4E4020C */  jal        TextSys_WordX__Fi
    /* 330A8 800428A8 4D020424 */   addiu     $a0, $zero, 0x24D
    /* 330AC 800428AC 00140200 */  sll        $v0, $v0, 16
    /* 330B0 800428B0 032C0200 */  sra        $a1, $v0, 16
    /* 330B4 800428B4 00141500 */  sll        $v0, $s5, 16
    /* 330B8 800428B8 0300C012 */  beqz       $s6, .L800428C8
    /* 330BC 800428BC 03340200 */   sra       $a2, $v0, 16
    /* 330C0 800428C0 330A0108 */  j          .L800428CC
    /* 330C4 800428C4 02000224 */   addiu     $v0, $zero, 0x2
  .L800428C8:
    /* 330C8 800428C8 2B101200 */  sltu       $v0, $zero, $s2
  .L800428CC:
    /* 330CC 800428CC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 330D0 800428D0 2000A427 */  addiu      $a0, $sp, 0x20
    /* 330D4 800428D4 0B000724 */  addiu      $a3, $zero, 0xB
    /* 330D8 800428D8 B083000C */  jal        FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 330DC 800428DC 1400A0AF */   sw        $zero, 0x14($sp)
    /* 330E0 800428E0 80101200 */  sll        $v0, $s2, 2
    /* 330E4 800428E4 21105200 */  addu       $v0, $v0, $s2
    /* 330E8 800428E8 6400838E */  lw         $v1, 0x64($s4)
    /* 330EC 800428EC 80100200 */  sll        $v0, $v0, 2
    /* 330F0 800428F0 21104300 */  addu       $v0, $v0, $v1
    /* 330F4 800428F4 1000448C */  lw         $a0, 0x10($v0)
    /* 330F8 800428F8 672A010C */  jal        Stattool_ParseTime__FiPc
    /* 330FC 800428FC 2000A527 */   addiu     $a1, $sp, 0x20
    /* 33100 80042900 A4E4020C */  jal        TextSys_WordX__Fi
    /* 33104 80042904 4E020424 */   addiu     $a0, $zero, 0x24E
    /* 33108 80042908 00140200 */  sll        $v0, $v0, 16
    /* 3310C 8004290C 032C0200 */  sra        $a1, $v0, 16
    /* 33110 80042910 00141500 */  sll        $v0, $s5, 16
    /* 33114 80042914 03004016 */  bnez       $s2, .L80042924
    /* 33118 80042918 03340200 */   sra       $a2, $v0, 16
    /* 3311C 8004291C 03006012 */  beqz       $s3, .L8004292C
    /* 33120 80042920 01000224 */   addiu     $v0, $zero, 0x1
  .L80042924:
    /* 33124 80042924 4C0A0108 */  j          .L80042930
    /* 33128 80042928 1000B3AF */   sw        $s3, 0x10($sp)
  .L8004292C:
    /* 3312C 8004292C 1000A2AF */  sw         $v0, 0x10($sp)
  .L80042930:
    /* 33130 80042930 1400A0AF */  sw         $zero, 0x14($sp)
    /* 33134 80042934 2000A427 */  addiu      $a0, $sp, 0x20
    /* 33138 80042938 B083000C */  jal        FETextRender_FullText__FPcss13tMenuTextType14tMenuTextStates
    /* 3313C 8004293C 0B000724 */   addiu     $a3, $zero, 0xB
  .L80042940:
    /* 33140 80042940 8C00BF8F */  lw         $ra, 0x8C($sp)
    /* 33144 80042944 8800B68F */  lw         $s6, 0x88($sp)
    /* 33148 80042948 8400B58F */  lw         $s5, 0x84($sp)
    /* 3314C 8004294C 8000B48F */  lw         $s4, 0x80($sp)
    /* 33150 80042950 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 33154 80042954 7800B28F */  lw         $s2, 0x78($sp)
    /* 33158 80042958 7400B18F */  lw         $s1, 0x74($sp)
    /* 3315C 8004295C 7000B08F */  lw         $s0, 0x70($sp)
    /* 33160 80042960 0800E003 */  jr         $ra
    /* 33164 80042964 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel DrawOneRecord__19tScreenTrackRecordsibi
