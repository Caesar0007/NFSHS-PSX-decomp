.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching iSNDinit, 0x2A0

glabel iSNDinit
    /* EFF00 800FF700 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* EFF04 800FF704 801F0A3C */  lui        $t2, (0x1F801014 >> 16)
    /* EFF08 800FF708 14104A35 */  ori        $t2, $t2, (0x1F801014 & 0xFFFF)
    /* EFF0C 800FF70C 801F093C */  lui        $t1, (0x1F8010C0 >> 16)
    /* EFF10 800FF710 C0102935 */  ori        $t1, $t1, (0x1F8010C0 & 0xFFFF)
    /* EFF14 800FF714 801F083C */  lui        $t0, (0x1F8010C4 >> 16)
    /* EFF18 800FF718 C4100835 */  ori        $t0, $t0, (0x1F8010C4 & 0xFFFF)
    /* EFF1C 800FF71C 801F073C */  lui        $a3, (0x1F8010C8 >> 16)
    /* EFF20 800FF720 C810E734 */  ori        $a3, $a3, (0x1F8010C8 & 0xFFFF)
    /* EFF24 800FF724 801F063C */  lui        $a2, (0x1F8010F0 >> 16)
    /* EFF28 800FF728 F010C634 */  ori        $a2, $a2, (0x1F8010F0 & 0xFFFF)
    /* EFF2C 800FF72C 801F053C */  lui        $a1, (0x1F801C00 >> 16)
    /* EFF30 800FF730 001CA534 */  ori        $a1, $a1, (0x1F801C00 & 0xFFFF)
    /* EFF34 800FF734 1480043C */  lui        $a0, %hi(sndpd)
    /* EFF38 800FF738 18798424 */  addiu      $a0, $a0, %lo(sndpd)
    /* EFF3C 800FF73C 41000224 */  addiu      $v0, $zero, 0x41
    /* EFF40 800FF740 2000BFAF */  sw         $ra, 0x20($sp)
    /* EFF44 800FF744 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EFF48 800FF748 1800B0AF */  sw         $s0, 0x18($sp)
    /* EFF4C 800FF74C 1A0582A4 */  sh         $v0, 0x51A($a0)
    /* EFF50 800FF750 0000C28C */  lw         $v0, 0x0($a2)
    /* EFF54 800FF754 0B00033C */  lui        $v1, (0xB0000 >> 16)
    /* EFF58 800FF758 25104300 */  or         $v0, $v0, $v1
    /* EFF5C 800FF75C 0000C2AC */  sw         $v0, 0x0($a2)
    /* EFF60 800FF760 8001A0A4 */  sh         $zero, 0x180($a1)
    /* EFF64 800FF764 8201A0A4 */  sh         $zero, 0x182($a1)
    /* EFF68 800FF768 AA01A0A4 */  sh         $zero, 0x1AA($a1)
    /* EFF6C 800FF76C 8001A0A4 */  sh         $zero, 0x180($a1)
    /* EFF70 800FF770 8201A0A4 */  sh         $zero, 0x182($a1)
    /* EFF74 800FF774 AE01A394 */  lhu        $v1, 0x1AE($a1)
    /* EFF78 800FF778 00200224 */  addiu      $v0, $zero, 0x2000
    /* EFF7C 800FF77C 1C0582A4 */  sh         $v0, 0x51C($a0)
    /* EFF80 800FF780 FC048AAC */  sw         $t2, 0x4FC($a0)
    /* EFF84 800FF784 000589AC */  sw         $t1, 0x500($a0)
    /* EFF88 800FF788 040588AC */  sw         $t0, 0x504($a0)
    /* EFF8C 800FF78C 080587AC */  sw         $a3, 0x508($a0)
    /* EFF90 800FF790 0C0586AC */  sw         $a2, 0x50C($a0)
    /* EFF94 800FF794 100585AC */  sw         $a1, 0x510($a0)
    /* EFF98 800FF798 FF076330 */  andi       $v1, $v1, 0x7FF
    /* EFF9C 800FF79C 08006010 */  beqz       $v1, .L800FF7C0
    /* EFFA0 800FF7A0 140585AC */   sw        $a1, 0x514($a0)
    /* EFFA4 800FF7A4 801F033C */  lui        $v1, (0x1F801C00 >> 16)
    /* EFFA8 800FF7A8 001C6334 */  ori        $v1, $v1, (0x1F801C00 & 0xFFFF)
  .L800FF7AC:
    /* EFFAC 800FF7AC AE016294 */  lhu        $v0, 0x1AE($v1)
    /* EFFB0 800FF7B0 00000000 */  nop
    /* EFFB4 800FF7B4 FF074230 */  andi       $v0, $v0, 0x7FF
    /* EFFB8 800FF7B8 FCFF4014 */  bnez       $v0, .L800FF7AC
    /* EFFBC 800FF7BC 00000000 */   nop
  .L800FF7C0:
    /* EFFC0 800FF7C0 1480023C */  lui        $v0, %hi(sndpd)
    /* EFFC4 800FF7C4 18795124 */  addiu      $s1, $v0, %lo(sndpd)
    /* EFFC8 800FF7C8 1405238E */  lw         $v1, 0x514($s1)
    /* EFFCC 800FF7CC 04000224 */  addiu      $v0, $zero, 0x4
    /* EFFD0 800FF7D0 AC0162A4 */  sh         $v0, 0x1AC($v1)
    /* EFFD4 800FF7D4 1405228E */  lw         $v0, 0x514($s1)
    /* EFFD8 800FF7D8 00000000 */  nop
    /* EFFDC 800FF7DC 900140A4 */  sh         $zero, 0x190($v0)
    /* EFFE0 800FF7E0 1405228E */  lw         $v0, 0x514($s1)
    /* EFFE4 800FF7E4 00000000 */  nop
    /* EFFE8 800FF7E8 920140A4 */  sh         $zero, 0x192($v0)
    /* EFFEC 800FF7EC 1405228E */  lw         $v0, 0x514($s1)
    /* EFFF0 800FF7F0 00000000 */  nop
    /* EFFF4 800FF7F4 940140A4 */  sh         $zero, 0x194($v0)
    /* EFFF8 800FF7F8 1405228E */  lw         $v0, 0x514($s1)
    /* EFFFC 800FF7FC 00000000 */  nop
    /* F0000 800FF800 960140A4 */  sh         $zero, 0x196($v0)
    /* F0004 800FF804 1405228E */  lw         $v0, 0x514($s1)
    /* F0008 800FF808 04000424 */  addiu      $a0, $zero, 0x4
    /* F000C 800FF80C B00140A4 */  sh         $zero, 0x1B0($v0)
    /* F0010 800FF810 1405228E */  lw         $v0, 0x514($s1)
    /* F0014 800FF814 1180053C */  lui        $a1, %hi(iSNDdmcallback)
    /* F0018 800FF818 B20140A4 */  sh         $zero, 0x1B2($v0)
    /* F001C 800FF81C 1405228E */  lw         $v0, 0x514($s1)
    /* F0020 800FF820 64AAA524 */  addiu      $a1, $a1, %lo(iSNDdmcallback)
    /* F0024 800FF824 B40140A4 */  sh         $zero, 0x1B4($v0)
    /* F0028 800FF828 1405228E */  lw         $v0, 0x514($s1)
    /* F002C 800FF82C 00601040 */  mfc0       $s0, $12 /* handwritten instruction */
    /* F0030 800FF830 00000000 */  nop
    /* F0034 800FF834 FEFB0124 */  addiu      $at, $zero, -0x402
    /* F0038 800FF838 24400102 */  and        $t0, $s0, $at
    /* F003C 800FF83C 00608840 */  mtc0       $t0, $12 /* handwritten instruction */
    /* F0040 800FF840 00000000 */  nop
    /* F0044 800FF844 00000000 */  nop
    /* F0048 800FF848 00000000 */  nop
    /* F004C 800FF84C B60140A4 */  sh         $zero, 0x1B6($v0)
    /* F0050 800FF850 1405238E */  lw         $v1, 0x514($s1)
    /* F0054 800FF854 00C00234 */  ori        $v0, $zero, 0xC000
    /* F0058 800FF858 AA0162A4 */  sh         $v0, 0x1AA($v1)
    /* F005C 800FF85C 2BCA030C */  jal        DMACallback
    /* F0060 800FF860 00000000 */   nop
    /* F0064 800FF864 00609040 */  mtc0       $s0, $12 /* handwritten instruction */
    /* F0068 800FF868 1380043C */  lui        $a0, %hi(sndpdsafeloop)
    /* F006C 800FF86C F06D8424 */  addiu      $a0, $a0, %lo(sndpdsafeloop)
    /* F0070 800FF870 00100524 */  addiu      $a1, $zero, 0x1000
    /* F0074 800FF874 10000624 */  addiu      $a2, $zero, 0x10
    /* F0078 800FF878 01000724 */  addiu      $a3, $zero, 0x1
    /* F007C 800FF87C 282B040C */  jal        iSNDdmqueue
    /* F0080 800FF880 1000A0AF */   sw        $zero, 0x10($sp)
    /* F0084 800FF884 1480023C */  lui        $v0, %hi(sndgs)
    /* F0088 800FF888 60784324 */  addiu      $v1, $v0, %lo(sndgs)
    /* F008C 800FF88C 11006290 */  lbu        $v0, 0x11($v1)
    /* F0090 800FF890 00000000 */  nop
    /* F0094 800FF894 17004010 */  beqz       $v0, .L800FF8F4
    /* F0098 800FF898 21200000 */   addu      $a0, $zero, $zero
    /* F009C 800FF89C 00020624 */  addiu      $a2, $zero, 0x200
    /* F00A0 800FF8A0 FFFF0924 */  addiu      $t1, $zero, -0x1
    /* F00A4 800FF8A4 21406000 */  addu       $t0, $v1, $zero
    /* F00A8 800FF8A8 21382002 */  addu       $a3, $s1, $zero
    /* F00AC 800FF8AC 2128E000 */  addu       $a1, $a3, $zero
  .L800FF8B0:
    /* F00B0 800FF8B0 00110400 */  sll        $v0, $a0, 4
    /* F00B4 800FF8B4 1005E38C */  lw         $v1, 0x510($a3)
    /* F00B8 800FF8B8 01008424 */  addiu      $a0, $a0, 0x1
    /* F00BC 800FF8BC 21186200 */  addu       $v1, $v1, $v0
    /* F00C0 800FF8C0 000060A4 */  sh         $zero, 0x0($v1)
    /* F00C4 800FF8C4 020060A4 */  sh         $zero, 0x2($v1)
    /* F00C8 800FF8C8 040060A4 */  sh         $zero, 0x4($v1)
    /* F00CC 800FF8CC 060066A4 */  sh         $a2, 0x6($v1)
    /* F00D0 800FF8D0 0E0066A4 */  sh         $a2, 0xE($v1)
    /* F00D4 800FF8D4 080060A4 */  sh         $zero, 0x8($v1)
    /* F00D8 800FF8D8 0A0060A4 */  sh         $zero, 0xA($v1)
    /* F00DC 800FF8DC FF00A9A0 */  sb         $t1, 0xFF($a1)
    /* F00E0 800FF8E0 11000291 */  lbu        $v0, 0x11($t0)
    /* F00E4 800FF8E4 00000000 */  nop
    /* F00E8 800FF8E8 2A108200 */  slt        $v0, $a0, $v0
    /* F00EC 800FF8EC F0FF4014 */  bnez       $v0, .L800FF8B0
    /* F00F0 800FF8F0 2C00A524 */   addiu     $a1, $a1, 0x2C
  .L800FF8F4:
    /* F00F4 800FF8F4 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* F00F8 800FF8F8 50FC030C */  jal        iSNDpsxkeyon
    /* F00FC 800FF8FC FFFF8434 */   ori       $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* F0100 800FF900 1480113C */  lui        $s1, %hi(sndpd)
    /* F0104 800FF904 18793026 */  addiu      $s0, $s1, %lo(sndpd)
    /* F0108 800FF908 1405038E */  lw         $v1, 0x514($s0)
    /* F010C 800FF90C FEFF0234 */  ori        $v0, $zero, 0xFFFE
    /* F0110 800FF910 A20162A4 */  sh         $v0, 0x1A2($v1)
    /* F0114 800FF914 1405028E */  lw         $v0, 0x514($s0)
    /* F0118 800FF918 FF3F0324 */  addiu      $v1, $zero, 0x3FFF
    /* F011C 800FF91C 800143A4 */  sh         $v1, 0x180($v0)
    /* F0120 800FF920 1405028E */  lw         $v0, 0x514($s0)
    /* F0124 800FF924 00000000 */  nop
    /* F0128 800FF928 820143A4 */  sh         $v1, 0x182($v0)
    /* F012C 800FF92C 1405038E */  lw         $v1, 0x514($s0)
    /* F0130 800FF930 00000000 */  nop
    /* F0134 800FF934 AA016294 */  lhu        $v0, 0x1AA($v1)
    /* F0138 800FF938 00000000 */  nop
    /* F013C 800FF93C 01004234 */  ori        $v0, $v0, 0x1
    /* F0140 800FF940 AA0162A4 */  sh         $v0, 0x1AA($v1)
    /* F0144 800FF944 0400048E */  lw         $a0, 0x4($s0)
    /* F0148 800FF948 8300040C */  jal        iSNDpsxfxinit
    /* F014C 800FF94C 00000000 */   nop
    /* F0150 800FF950 0F80043C */  lui        $a0, %hi(iSNDserver)
    /* F0154 800FF954 38A18424 */  addiu      $a0, $a0, %lo(iSNDserver)
    /* F0158 800FF958 010000A2 */  sb         $zero, 0x1($s0)
    /* F015C 800FF95C FAAB030C */  jal        addtimer
    /* F0160 800FF960 00000000 */   nop
    /* F0164 800FF964 18792292 */  lbu        $v0, %lo(sndpd)($s1)
    /* F0168 800FF968 00000000 */  nop
    /* F016C 800FF96C 06004014 */  bnez       $v0, .L800FF988
    /* F0170 800FF970 00000000 */   nop
    /* F0174 800FF974 0F80043C */  lui        $a0, %hi(SNDSYS_restore)
    /* F0178 800FF978 3EC7030C */  jal        addexit
    /* F017C 800FF97C 4C208424 */   addiu     $a0, $a0, %lo(SNDSYS_restore)
    /* F0180 800FF980 01000224 */  addiu      $v0, $zero, 0x1
    /* F0184 800FF984 187922A2 */  sb         $v0, %lo(sndpd)($s1)
  .L800FF988:
    /* F0188 800FF988 2000BF8F */  lw         $ra, 0x20($sp)
    /* F018C 800FF98C 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F0190 800FF990 1800B08F */  lw         $s0, 0x18($sp)
    /* F0194 800FF994 21100000 */  addu       $v0, $zero, $zero
    /* F0198 800FF998 0800E003 */  jr         $ra
    /* F019C 800FF99C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSNDinit
