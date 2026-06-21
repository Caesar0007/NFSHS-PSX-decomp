.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__18tScreenTrackSelect, 0x4AC

glabel DrawBackground__18tScreenTrackSelect
    /* 31E00 80041600 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 31E04 80041604 C400B7AF */  sw         $s7, 0xC4($sp)
    /* 31E08 80041608 21B88000 */  addu       $s7, $a0, $zero
    /* 31E0C 8004160C FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 31E10 80041610 40010224 */  addiu      $v0, $zero, 0x140
    /* 31E14 80041614 1000A2A7 */  sh         $v0, 0x10($sp)
    /* 31E18 80041618 C8000224 */  addiu      $v0, $zero, 0xC8
    /* 31E1C 8004161C 1200A2A7 */  sh         $v0, 0x12($sp)
    /* 31E20 80041620 AA000224 */  addiu      $v0, $zero, 0xAA
    /* 31E24 80041624 1400A2A7 */  sh         $v0, 0x14($sp)
    /* 31E28 80041628 0580023C */  lui        $v0, %hi(menuDefs)
    /* 31E2C 8004162C 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 31E30 80041630 0C000224 */  addiu      $v0, $zero, 0xC
    /* 31E34 80041634 CC00BFAF */  sw         $ra, 0xCC($sp)
    /* 31E38 80041638 C800BEAF */  sw         $fp, 0xC8($sp)
    /* 31E3C 8004163C C000B6AF */  sw         $s6, 0xC0($sp)
    /* 31E40 80041640 BC00B5AF */  sw         $s5, 0xBC($sp)
    /* 31E44 80041644 B800B4AF */  sw         $s4, 0xB8($sp)
    /* 31E48 80041648 B400B3AF */  sw         $s3, 0xB4($sp)
    /* 31E4C 8004164C B000B2AF */  sw         $s2, 0xB0($sp)
    /* 31E50 80041650 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 31E54 80041654 A800B0AF */  sw         $s0, 0xA8($sp)
    /* 31E58 80041658 1600A2A7 */  sh         $v0, 0x16($sp)
    /* 31E5C 8004165C 7587000C */  jal        TextValue__18tListIteratorTrack7tPlayer
    /* 31E60 80041660 880C8424 */   addiu     $a0, $a0, 0xC88
    /* 31E64 80041664 00140200 */  sll        $v0, $v0, 16
    /* 31E68 80041668 03240200 */  sra        $a0, $v0, 16
    /* 31E6C 8004166C 1000A527 */  addiu      $a1, $sp, 0x10
    /* 31E70 80041670 EC2F010C */  jal        DrawShape_NFS4RoundRectangle__FiR4RECTs
    /* 31E74 80041674 21300000 */   addu      $a2, $zero, $zero
    /* 31E78 80041678 1180043C */  lui        $a0, %hi(trackManager)
    /* 31E7C 8004167C 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 31E80 80041680 1180023C */  lui        $v0, %hi(D_80114623)
    /* 31E84 80041684 1800B027 */  addiu      $s0, $sp, 0x18
    /* 31E88 80041688 23464590 */  lbu        $a1, %lo(D_80114623)($v0)
    /* 31E8C 8004168C A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 31E90 80041690 21300002 */   addu      $a2, $s0, $zero
    /* 31E94 80041694 2120E002 */  addu       $a0, $s7, $zero
    /* 31E98 80041698 6607010C */  jal        UpdateBrightness__18tScreenTrackSelectR17tTrackInformation
    /* 31E9C 8004169C 21280002 */   addu      $a1, $s0, $zero
    /* 31EA0 800416A0 2120E002 */  addu       $a0, $s7, $zero
    /* 31EA4 800416A4 A207010C */  jal        UpdateVideoWall__18tScreenTrackSelectR17tTrackInformation
    /* 31EA8 800416A8 21280002 */   addu      $a1, $s0, $zero
    /* 31EAC 800416AC 2120E002 */  addu       $a0, $s7, $zero
    /* 31EB0 800416B0 8397000C */  jal        IsShapeFileLoaded__7tScreenR17tShapeInformation
    /* 31EB4 800416B4 2800E526 */   addiu     $a1, $s7, 0x28
    /* 31EB8 800416B8 2C00E28E */  lw         $v0, 0x2C($s7)
    /* 31EBC 800416BC 00000000 */  nop
    /* 31EC0 800416C0 0D004010 */  beqz       $v0, .L800416F8
    /* 31EC4 800416C4 6002F026 */   addiu     $s0, $s7, 0x260
    /* 31EC8 800416C8 14000386 */  lh         $v1, 0x14($s0)
    /* 31ECC 800416CC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 31ED0 800416D0 09006210 */  beq        $v1, $v0, .L800416F8
    /* 31ED4 800416D4 00000000 */   nop
    /* 31ED8 800416D8 7000E286 */  lh         $v0, 0x70($s7)
    /* 31EDC 800416DC 00000000 */  nop
    /* 31EE0 800416E0 05004014 */  bnez       $v0, .L800416F8
    /* 31EE4 800416E4 2120E002 */   addu      $a0, $s7, $zero
    /* 31EE8 800416E8 F497000C */  jal        UploadSwapShapes__7tScreeni
    /* 31EEC 800416EC 0A000524 */   addiu     $a1, $zero, 0xA
    /* 31EF0 800416F0 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 31EF4 800416F4 21200002 */   addu      $a0, $s0, $zero
  .L800416F8:
    /* 31EF8 800416F8 6800E28E */  lw         $v0, 0x68($s7)
    /* 31EFC 800416FC 6400E48E */  lw         $a0, 0x64($s7)
    /* 31F00 80041700 01004230 */  andi       $v0, $v0, 0x1
    /* 31F04 80041704 0100422C */  sltiu      $v0, $v0, 0x1
    /* 31F08 80041708 C0810200 */  sll        $s0, $v0, 7
    /* 31F0C 8004170C E643010C */  jal        VIDEO_state__Fi
    /* 31F10 80041710 21B00002 */   addu      $s6, $s0, $zero
    /* 31F14 80041714 21184000 */  addu       $v1, $v0, $zero
    /* 31F18 80041718 01000224 */  addiu      $v0, $zero, 0x1
    /* 31F1C 8004171C 15006214 */  bne        $v1, $v0, .L80041774
    /* 31F20 80041720 03000224 */   addiu     $v0, $zero, 0x3
    /* 31F24 80041724 4800A427 */  addiu      $a0, $sp, 0x48
    /* 31F28 80041728 21280000 */  addu       $a1, $zero, $zero
    /* 31F2C 8004172C 2130A000 */  addu       $a2, $a1, $zero
    /* 31F30 80041730 2138A000 */  addu       $a3, $a1, $zero
    /* 31F34 80041734 00020A24 */  addiu      $t2, $zero, 0x200
    /* 31F38 80041738 AA000224 */  addiu      $v0, $zero, 0xAA
    /* 31F3C 8004173C 4C00A2A7 */  sh         $v0, 0x4C($sp)
    /* 31F40 80041740 00010224 */  addiu      $v0, $zero, 0x100
    /* 31F44 80041744 4800AAA7 */  sh         $t2, 0x48($sp)
    /* 31F48 80041748 4A00A0A7 */  sh         $zero, 0x4A($sp)
    /* 31F4C 8004174C 80B6030C */  jal        ClearImage
    /* 31F50 80041750 4E00A2A7 */   sh        $v0, 0x4E($sp)
    /* 31F54 80041754 1FB6030C */  jal        DrawSync
    /* 31F58 80041758 21200000 */   addu      $a0, $zero, $zero
    /* 31F5C 8004175C 1480023C */  lui        $v0, %hi(ticks)
    /* 31F60 80041760 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 31F64 80041764 7000E0A6 */  sh         $zero, 0x70($s7)
    /* 31F68 80041768 ECFF4224 */  addiu      $v0, $v0, -0x14
    /* 31F6C 8004176C 19060108 */  j          .L80041864
    /* 31F70 80041770 7800E2AE */   sw        $v0, 0x78($s7)
  .L80041774:
    /* 31F74 80041774 0F006214 */  bne        $v1, $v0, .L800417B4
    /* 31F78 80041778 00020524 */   addiu     $a1, $zero, 0x200
    /* 31F7C 8004177C 6400E48E */  lw         $a0, 0x64($s7)
    /* 31F80 80041780 00341000 */  sll        $a2, $s0, 16
    /* 31F84 80041784 1044010C */  jal        VIDEO_updateframexy__Fiii
    /* 31F88 80041788 02340600 */   srl       $a2, $a2, 16
    /* 31F8C 8004178C 35004010 */  beqz       $v0, .L80041864
    /* 31F90 80041790 00000000 */   nop
    /* 31F94 80041794 6800E38E */  lw         $v1, 0x68($s7)
    /* 31F98 80041798 00000000 */  nop
    /* 31F9C 8004179C 01006324 */  addiu      $v1, $v1, 0x1
    /* 31FA0 800417A0 01006230 */  andi       $v0, $v1, 0x1
    /* 31FA4 800417A4 0100422C */  sltiu      $v0, $v0, 0x1
    /* 31FA8 800417A8 C0B10200 */  sll        $s6, $v0, 7
    /* 31FAC 800417AC 19060108 */  j          .L80041864
    /* 31FB0 800417B0 6800E3AE */   sw        $v1, 0x68($s7)
  .L800417B4:
    /* 31FB4 800417B4 7C00E28E */  lw         $v0, 0x7C($s7)
    /* 31FB8 800417B8 00000000 */  nop
    /* 31FBC 800417BC 07004014 */  bnez       $v0, .L800417DC
    /* 31FC0 800417C0 1480023C */   lui       $v0, %hi(ticks)
    /* 31FC4 800417C4 7200E286 */  lh         $v0, 0x72($s7)
    /* 31FC8 800417C8 7000E386 */  lh         $v1, 0x70($s7)
    /* 31FCC 800417CC 00000000 */  nop
    /* 31FD0 800417D0 2A104300 */  slt        $v0, $v0, $v1
    /* 31FD4 800417D4 23004010 */  beqz       $v0, .L80041864
    /* 31FD8 800417D8 1480023C */   lui       $v0, %hi(ticks)
  .L800417DC:
    /* 31FDC 800417DC ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* 31FE0 800417E0 9C02E38E */  lw         $v1, 0x29C($s7)
    /* 31FE4 800417E4 00000000 */  nop
    /* 31FE8 800417E8 23104300 */  subu       $v0, $v0, $v1
    /* 31FEC 800417EC 0101422C */  sltiu      $v0, $v0, 0x101
    /* 31FF0 800417F0 1C004014 */  bnez       $v0, .L80041864
    /* 31FF4 800417F4 00000000 */   nop
    /* 31FF8 800417F8 7200E286 */  lh         $v0, 0x72($s7)
    /* 31FFC 800417FC 7000E386 */  lh         $v1, 0x70($s7)
    /* 32000 80041800 00000000 */  nop
    /* 32004 80041804 2A104300 */  slt        $v0, $v0, $v1
    /* 32008 80041808 09004014 */  bnez       $v0, .L80041830
    /* 3200C 8004180C 5000B027 */   addiu     $s0, $sp, 0x50
    /* 32010 80041810 1B00A293 */  lbu        $v0, 0x1B($sp)
    /* 32014 80041814 00000000 */  nop
    /* 32018 80041818 02004010 */  beqz       $v0, .L80041824
    /* 3201C 8004181C 20000524 */   addiu     $a1, $zero, 0x20
    /* 32020 80041820 80000524 */  addiu      $a1, $zero, 0x80
  .L80041824:
    /* 32024 80041824 5A07010C */  jal        SetBrightness__18tScreenTrackSelects
    /* 32028 80041828 2120E002 */   addu      $a0, $s7, $zero
    /* 3202C 8004182C 5000B027 */  addiu      $s0, $sp, 0x50
  .L80041830:
    /* 32030 80041830 21200002 */  addu       $a0, $s0, $zero
    /* 32034 80041834 1180023C */  lui        $v0, %hi(D_8011650C)
    /* 32038 80041838 0180053C */  lui        $a1, %hi(D_80011EEC)
    /* 3203C 8004183C 0C65468C */  lw         $a2, %lo(D_8011650C)($v0)
    /* 32040 80041840 6E00E786 */  lh         $a3, 0x6E($s7)
    /* 32044 80041844 2F91030C */  jal        sprintf
    /* 32048 80041848 EC1EA524 */   addiu     $a1, $a1, %lo(D_80011EEC)
    /* 3204C 8004184C 6400E48E */  lw         $a0, 0x64($s7)
    /* 32050 80041850 A643010C */  jal        VIDEO_spoolfile__FiPc
    /* 32054 80041854 21280002 */   addu      $a1, $s0, $zero
    /* 32058 80041858 6400E48E */  lw         $a0, 0x64($s7)
    /* 3205C 8004185C BD43010C */  jal        VIDEO_startplayback__Fi
    /* 32060 80041860 00000000 */   nop
  .L80041864:
    /* 32064 80041864 7000E286 */  lh         $v0, 0x70($s7)
    /* 32068 80041868 00000000 */  nop
    /* 3206C 8004186C 81004018 */  blez       $v0, .L80041A74
    /* 32070 80041870 801F0A3C */   lui       $t2, (0x1F800004 >> 16)
    /* 32074 80041874 04004A35 */  ori        $t2, $t2, (0x1F800004 & 0xFFFF)
    /* 32078 80041878 FF00103C */  lui        $s0, (0xFFFFFF >> 16)
    /* 3207C 8004187C FFFF1036 */  ori        $s0, $s0, (0xFFFFFF & 0xFFFF)
    /* 32080 80041880 02000424 */  addiu      $a0, $zero, 0x2
    /* 32084 80041884 01000524 */  addiu      $a1, $zero, 0x1
    /* 32088 80041888 C0FF1124 */  addiu      $s1, $zero, -0x40
    /* 3208C 8004188C 00022632 */  andi       $a2, $s1, 0x200
    /* 32090 80041890 00340600 */  sll        $a2, $a2, 16
    /* 32094 80041894 03340600 */  sra        $a2, $a2, 16
    /* 32098 80041898 21A80000 */  addu       $s5, $zero, $zero
    /* 3209C 8004189C 2138A002 */  addu       $a3, $s5, $zero
    /* 320A0 800418A0 A000AAAF */  sw         $t2, 0xA0($sp)
    /* 320A4 800418A4 00005E8D */  lw         $fp, 0x0($t2)
    /* 320A8 800418A8 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* 320AC 800418AC 39011424 */  addiu      $s4, $zero, 0x139
    /* 320B0 800418B0 E8001324 */  addiu      $s3, $zero, 0xE8
    /* 320B4 800418B4 7F00D236 */  ori        $s2, $s6, 0x7F
    /* 320B8 800418B8 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* 320BC 800418BC 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* 320C0 800418C0 0000C38F */  lw         $v1, 0x0($fp)
    /* 320C4 800418C4 0000028D */  lw         $v0, 0x0($t0)
    /* 320C8 800418C8 24186A00 */  and        $v1, $v1, $t2
    /* 320CC 800418CC 24105000 */  and        $v0, $v0, $s0
    /* 320D0 800418D0 25186200 */  or         $v1, $v1, $v0
    /* 320D4 800418D4 0000C3AF */  sw         $v1, 0x0($fp)
    /* 320D8 800418D8 0000028D */  lw         $v0, 0x0($t0)
    /* 320DC 800418DC A000AA8F */  lw         $t2, 0xA0($sp)
    /* 320E0 800418E0 2800C327 */  addiu      $v1, $fp, 0x28
    /* 320E4 800418E4 000043AD */  sw         $v1, 0x0($t2)
    /* 320E8 800418E8 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* 320EC 800418EC 24104A00 */  and        $v0, $v0, $t2
    /* 320F0 800418F0 2418D003 */  and        $v1, $fp, $s0
    /* 320F4 800418F4 25104300 */  or         $v0, $v0, $v1
    /* 320F8 800418F8 000002AD */  sw         $v0, 0x0($t0)
    /* 320FC 800418FC 7000E886 */  lh         $t0, 0x70($s7)
    /* 32100 80041900 09000A24 */  addiu      $t2, $zero, 0x9
    /* 32104 80041904 99000224 */  addiu      $v0, $zero, 0x99
    /* 32108 80041908 0300CAA3 */  sb         $t2, 0x3($fp)
    /* 3210C 8004190C 69000A24 */  addiu      $t2, $zero, 0x69
    /* 32110 80041910 0A00CAA7 */  sh         $t2, 0xA($fp)
    /* 32114 80041914 1200CAA7 */  sh         $t2, 0x12($fp)
    /* 32118 80041918 00020A24 */  addiu      $t2, $zero, 0x200
    /* 3211C 8004191C 0800C2A7 */  sh         $v0, 0x8($fp)
    /* 32120 80041920 1800C2A7 */  sh         $v0, 0x18($fp)
    /* 32124 80041924 3F004231 */  andi       $v0, $t2, 0x3F
    /* 32128 80041928 50004324 */  addiu      $v1, $v0, 0x50
    /* 3212C 8004192C 1000D4A7 */  sh         $s4, 0x10($fp)
    /* 32130 80041930 1A00D3A7 */  sh         $s3, 0x1A($fp)
    /* 32134 80041934 2000D4A7 */  sh         $s4, 0x20($fp)
    /* 32138 80041938 2200D3A7 */  sh         $s3, 0x22($fp)
    /* 3213C 8004193C 0C00C2A3 */  sb         $v0, 0xC($fp)
    /* 32140 80041940 0D00D6A3 */  sb         $s6, 0xD($fp)
    /* 32144 80041944 1400C3A3 */  sb         $v1, 0x14($fp)
    /* 32148 80041948 1500D6A3 */  sb         $s6, 0x15($fp)
    /* 3214C 8004194C 1C00C2A3 */  sb         $v0, 0x1C($fp)
    /* 32150 80041950 1D00D2A3 */  sb         $s2, 0x1D($fp)
    /* 32154 80041954 2400C3A3 */  sb         $v1, 0x24($fp)
    /* 32158 80041958 2500D2A3 */  sb         $s2, 0x25($fp)
    /* 3215C 8004195C 00140800 */  sll        $v0, $t0, 16
    /* 32160 80041960 001A0800 */  sll        $v1, $t0, 8
    /* 32164 80041964 25104300 */  or         $v0, $v0, $v1
    /* 32168 80041968 25104800 */  or         $v0, $v0, $t0
    /* 3216C 8004196C 0400C2AF */  sw         $v0, 0x4($fp)
    /* 32170 80041970 2E000A24 */  addiu      $t2, $zero, 0x2E
    /* 32174 80041974 FFC6030C */  jal        GetTPage
    /* 32178 80041978 0700CAA3 */   sb        $t2, 0x7($fp)
    /* 3217C 8004197C 02000424 */  addiu      $a0, $zero, 0x2
    /* 32180 80041980 01000524 */  addiu      $a1, $zero, 0x1
    /* 32184 80041984 00020A24 */  addiu      $t2, $zero, 0x200
    /* 32188 80041988 50004925 */  addiu      $t1, $t2, 0x50
    /* 3218C 8004198C 24883101 */  and        $s1, $t1, $s1
    /* 32190 80041990 008C1100 */  sll        $s1, $s1, 16
    /* 32194 80041994 03341100 */  sra        $a2, $s1, 16
    /* 32198 80041998 2138A002 */  addu       $a3, $s5, $zero
    /* 3219C 8004199C 3F002931 */  andi       $t1, $t1, 0x3F
    /* 321A0 800419A0 1600C2A7 */  sh         $v0, 0x16($fp)
    /* 321A4 800419A4 0E00C0A7 */  sh         $zero, 0xE($fp)
    /* 321A8 800419A8 A000AA8F */  lw         $t2, 0xA0($sp)
    /* 321AC 800419AC 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* 321B0 800419B0 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* 321B4 800419B4 00005E8D */  lw         $fp, 0x0($t2)
    /* 321B8 800419B8 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* 321BC 800419BC 0000028D */  lw         $v0, 0x0($t0)
    /* 321C0 800419C0 0000C38F */  lw         $v1, 0x0($fp)
    /* 321C4 800419C4 24105000 */  and        $v0, $v0, $s0
    /* 321C8 800419C8 24186A00 */  and        $v1, $v1, $t2
    /* 321CC 800419CC 25186200 */  or         $v1, $v1, $v0
    /* 321D0 800419D0 0000C3AF */  sw         $v1, 0x0($fp)
    /* 321D4 800419D4 0000028D */  lw         $v0, 0x0($t0)
    /* 321D8 800419D8 2480D003 */  and        $s0, $fp, $s0
    /* 321DC 800419DC 24104A00 */  and        $v0, $v0, $t2
    /* 321E0 800419E0 25105000 */  or         $v0, $v0, $s0
    /* 321E4 800419E4 000002AD */  sw         $v0, 0x0($t0)
    /* 321E8 800419E8 7000E886 */  lh         $t0, 0x70($s7)
    /* 321EC 800419EC A000AA8F */  lw         $t2, 0xA0($sp)
    /* 321F0 800419F0 2800C227 */  addiu      $v0, $fp, 0x28
    /* 321F4 800419F4 000042AD */  sw         $v0, 0x0($t2)
    /* 321F8 800419F8 09000A24 */  addiu      $t2, $zero, 0x9
    /* 321FC 800419FC 0300CAA3 */  sb         $t2, 0x3($fp)
    /* 32200 80041A00 69000A24 */  addiu      $t2, $zero, 0x69
    /* 32204 80041A04 D9010224 */  addiu      $v0, $zero, 0x1D9
    /* 32208 80041A08 1000C2A7 */  sh         $v0, 0x10($fp)
    /* 3220C 80041A0C 2000C2A7 */  sh         $v0, 0x20($fp)
    /* 32210 80041A10 50002225 */  addiu      $v0, $t1, 0x50
    /* 32214 80041A14 1400C2A3 */  sb         $v0, 0x14($fp)
    /* 32218 80041A18 2400C2A3 */  sb         $v0, 0x24($fp)
    /* 3221C 80041A1C 00140800 */  sll        $v0, $t0, 16
    /* 32220 80041A20 001A0800 */  sll        $v1, $t0, 8
    /* 32224 80041A24 25104300 */  or         $v0, $v0, $v1
    /* 32228 80041A28 25104800 */  or         $v0, $v0, $t0
    /* 3222C 80041A2C 0A00CAA7 */  sh         $t2, 0xA($fp)
    /* 32230 80041A30 1200CAA7 */  sh         $t2, 0x12($fp)
    /* 32234 80041A34 0400C2AF */  sw         $v0, 0x4($fp)
    /* 32238 80041A38 2E000A24 */  addiu      $t2, $zero, 0x2E
    /* 3223C 80041A3C 0800D4A7 */  sh         $s4, 0x8($fp)
    /* 32240 80041A40 1800D4A7 */  sh         $s4, 0x18($fp)
    /* 32244 80041A44 1A00D3A7 */  sh         $s3, 0x1A($fp)
    /* 32248 80041A48 2200D3A7 */  sh         $s3, 0x22($fp)
    /* 3224C 80041A4C 0C00C9A3 */  sb         $t1, 0xC($fp)
    /* 32250 80041A50 0D00D6A3 */  sb         $s6, 0xD($fp)
    /* 32254 80041A54 1500D6A3 */  sb         $s6, 0x15($fp)
    /* 32258 80041A58 1C00C9A3 */  sb         $t1, 0x1C($fp)
    /* 3225C 80041A5C 1D00D2A3 */  sb         $s2, 0x1D($fp)
    /* 32260 80041A60 2500D2A3 */  sb         $s2, 0x25($fp)
    /* 32264 80041A64 FFC6030C */  jal        GetTPage
    /* 32268 80041A68 0700CAA3 */   sb        $t2, 0x7($fp)
    /* 3226C 80041A6C 1600C2A7 */  sh         $v0, 0x16($fp)
    /* 32270 80041A70 0E00C0A7 */  sh         $zero, 0xE($fp)
  .L80041A74:
    /* 32274 80041A74 BF07010C */  jal        DrawVideoWall__18tScreenTrackSelect
    /* 32278 80041A78 2120E002 */   addu      $a0, $s7, $zero
    /* 3227C 80041A7C CC00BF8F */  lw         $ra, 0xCC($sp)
    /* 32280 80041A80 C800BE8F */  lw         $fp, 0xC8($sp)
    /* 32284 80041A84 C400B78F */  lw         $s7, 0xC4($sp)
    /* 32288 80041A88 C000B68F */  lw         $s6, 0xC0($sp)
    /* 3228C 80041A8C BC00B58F */  lw         $s5, 0xBC($sp)
    /* 32290 80041A90 B800B48F */  lw         $s4, 0xB8($sp)
    /* 32294 80041A94 B400B38F */  lw         $s3, 0xB4($sp)
    /* 32298 80041A98 B000B28F */  lw         $s2, 0xB0($sp)
    /* 3229C 80041A9C AC00B18F */  lw         $s1, 0xAC($sp)
    /* 322A0 80041AA0 A800B08F */  lw         $s0, 0xA8($sp)
    /* 322A4 80041AA4 0800E003 */  jr         $ra
    /* 322A8 80041AA8 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel DrawBackground__18tScreenTrackSelect
