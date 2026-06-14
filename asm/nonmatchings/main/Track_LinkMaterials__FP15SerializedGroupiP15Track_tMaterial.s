.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial, 0x3C4

glabel Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
    /* AA698 800B9E98 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* AA69C 800B9E9C 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* AA6A0 800B9EA0 2188C000 */  addu       $s1, $a2, $zero
    /* AA6A4 800B9EA4 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* AA6A8 800B9EA8 4800BEAF */  sw         $fp, 0x48($sp)
    /* AA6AC 800B9EAC 4400B7AF */  sw         $s7, 0x44($sp)
    /* AA6B0 800B9EB0 4000B6AF */  sw         $s6, 0x40($sp)
    /* AA6B4 800B9EB4 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* AA6B8 800B9EB8 3800B4AF */  sw         $s4, 0x38($sp)
    /* AA6BC 800B9EBC 3400B3AF */  sw         $s3, 0x34($sp)
    /* AA6C0 800B9EC0 3000B2AF */  sw         $s2, 0x30($sp)
    /* AA6C4 800B9EC4 D9008010 */  beqz       $a0, .L800BA22C
    /* AA6C8 800B9EC8 2800B0AF */   sw        $s0, 0x28($sp)
    /* AA6CC 800B9ECC CCCC023C */  lui        $v0, (0xCCCCCCCD >> 16)
    /* AA6D0 800B9ED0 CDCC4234 */  ori        $v0, $v0, (0xCCCCCCCD & 0xFFFF)
    /* AA6D4 800B9ED4 1900A200 */  multu      $a1, $v0
    /* AA6D8 800B9ED8 1280023C */  lui        $v0, %hi(gInitialArt)
    /* AA6DC 800B9EDC 58E14224 */  addiu      $v0, $v0, %lo(gInitialArt)
    /* AA6E0 800B9EE0 21B80000 */  addu       $s7, $zero, $zero
    /* AA6E4 800B9EE4 1400438C */  lw         $v1, 0x14($v0)
    /* AA6E8 800B9EE8 10009024 */  addiu      $s0, $a0, 0x10
    /* AA6EC 800B9EEC 980F80AF */  sw         $zero, %gp_rel(Track_gControllerCount)($gp)
    /* AA6F0 800B9EF0 100043AC */  sw         $v1, 0x10($v0)
    /* AA6F4 800B9EF4 10380000 */  mfhi       $a3
    /* AA6F8 800B9EF8 C2380700 */  srl        $a3, $a3, 3
    /* AA6FC 800B9EFC 1000E010 */  beqz       $a3, .L800B9F40
    /* AA700 800B9F00 2000A7AF */   sw        $a3, 0x20($sp)
    /* AA704 800B9F04 21180002 */  addu       $v1, $s0, $zero
  .L800B9F08:
    /* AA708 800B9F08 02006294 */  lhu        $v0, 0x2($v1)
    /* AA70C 800B9F0C 00000000 */  nop
    /* AA710 800B9F10 84004230 */  andi       $v0, $v0, 0x84
    /* AA714 800B9F14 05004010 */  beqz       $v0, .L800B9F2C
    /* AA718 800B9F18 00000000 */   nop
    /* AA71C 800B9F1C 980F828F */  lw         $v0, %gp_rel(Track_gControllerCount)($gp)
    /* AA720 800B9F20 00000000 */  nop
    /* AA724 800B9F24 01004224 */  addiu      $v0, $v0, 0x1
    /* AA728 800B9F28 980F82AF */  sw         $v0, %gp_rel(Track_gControllerCount)($gp)
  .L800B9F2C:
    /* AA72C 800B9F2C 2000A88F */  lw         $t0, 0x20($sp)
    /* AA730 800B9F30 0100F726 */  addiu      $s7, $s7, 0x1
    /* AA734 800B9F34 2A10E802 */  slt        $v0, $s7, $t0
    /* AA738 800B9F38 F3FF4014 */  bnez       $v0, .L800B9F08
    /* AA73C 800B9F3C 0A006324 */   addiu     $v1, $v1, 0xA
  .L800B9F40:
    /* AA740 800B9F40 980F848F */  lw         $a0, %gp_rel(Track_gControllerCount)($gp)
    /* AA744 800B9F44 00000000 */  nop
    /* AA748 800B9F48 05008010 */  beqz       $a0, .L800B9F60
    /* AA74C 800B9F4C 21B80000 */   addu      $s7, $zero, $zero
    /* AA750 800B9F50 FEF8010C */  jal        BWAllocMem__Fl
    /* AA754 800B9F54 00210400 */   sll       $a0, $a0, 4
    /* AA758 800B9F58 9C0F82AF */  sw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA75C 800B9F5C 21B80000 */  addu       $s7, $zero, $zero
  .L800B9F60:
    /* AA760 800B9F60 21F0E002 */  addu       $fp, $s7, $zero
    /* AA764 800B9F64 1280023C */  lui        $v0, %hi(gInitialArt)
    /* AA768 800B9F68 58E15624 */  addiu      $s6, $v0, %lo(gInitialArt)
    /* AA76C 800B9F6C 21A82002 */  addu       $s5, $s1, $zero
    /* AA770 800B9F70 21880002 */  addu       $s1, $s0, $zero
  .L800B9F74:
    /* AA774 800B9F74 2000A98F */  lw         $t1, 0x20($sp)
    /* AA778 800B9F78 00000000 */  nop
    /* AA77C 800B9F7C 2A10E902 */  slt        $v0, $s7, $t1
    /* AA780 800B9F80 9C004010 */  beqz       $v0, .L800BA1F4
    /* AA784 800B9F84 21202002 */   addu      $a0, $s1, $zero
    /* AA788 800B9F88 2128A002 */  addu       $a1, $s5, $zero
    /* AA78C 800B9F8C 4BE7020C */  jal        Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource
    /* AA790 800B9F90 2130C002 */   addu      $a2, $s6, $zero
    /* AA794 800B9F94 02002392 */  lbu        $v1, 0x2($s1)
    /* AA798 800B9F98 00000000 */  nop
    /* AA79C 800B9F9C 04006230 */  andi       $v0, $v1, 0x4
    /* AA7A0 800B9FA0 12004010 */  beqz       $v0, .L800B9FEC
    /* AA7A4 800B9FA4 00211E00 */   sll       $a0, $fp, 4
    /* AA7A8 800B9FA8 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA7AC 800B9FAC FF006330 */  andi       $v1, $v1, 0xFF
    /* AA7B0 800B9FB0 21108200 */  addu       $v0, $a0, $v0
    /* AA7B4 800B9FB4 000043A4 */  sh         $v1, 0x0($v0)
    /* AA7B8 800B9FB8 08002392 */  lbu        $v1, 0x8($s1)
    /* AA7BC 800B9FBC 0100DE27 */  addiu      $fp, $fp, 0x1
    /* AA7C0 800B9FC0 090043A0 */  sb         $v1, 0x9($v0)
    /* AA7C4 800B9FC4 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA7C8 800B9FC8 07002392 */  lbu        $v1, 0x7($s1)
    /* AA7CC 800B9FCC 21108200 */  addu       $v0, $a0, $v0
    /* AA7D0 800B9FD0 080043A0 */  sb         $v1, 0x8($v0)
    /* AA7D4 800B9FD4 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA7D8 800B9FD8 0200A396 */  lhu        $v1, 0x2($s5)
    /* AA7DC 800B9FDC 21208200 */  addu       $a0, $a0, $v0
    /* AA7E0 800B9FE0 0A0083A4 */  sh         $v1, 0xA($a0)
    /* AA7E4 800B9FE4 33E80208 */  j          .L800BA0CC
    /* AA7E8 800B9FE8 0C0095AC */   sw        $s5, 0xC($a0)
  .L800B9FEC:
    /* AA7EC 800B9FEC 80006230 */  andi       $v0, $v1, 0x80
    /* AA7F0 800B9FF0 36004010 */  beqz       $v0, .L800BA0CC
    /* AA7F4 800B9FF4 00291E00 */   sll       $a1, $fp, 4
    /* AA7F8 800B9FF8 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA7FC 800B9FFC 02002392 */  lbu        $v1, 0x2($s1)
    /* AA800 800BA000 2110A200 */  addu       $v0, $a1, $v0
    /* AA804 800BA004 000043A4 */  sh         $v1, 0x0($v0)
    /* AA808 800BA008 08002292 */  lbu        $v0, 0x8($s1)
    /* AA80C 800BA00C 00000000 */  nop
    /* AA810 800BA010 02004014 */  bnez       $v0, .L800BA01C
    /* AA814 800BA014 01000224 */   addiu     $v0, $zero, 0x1
    /* AA818 800BA018 080022A2 */  sb         $v0, 0x8($s1)
  .L800BA01C:
    /* AA81C 800BA01C 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA820 800BA020 08002392 */  lbu        $v1, 0x8($s1)
    /* AA824 800BA024 2110A200 */  addu       $v0, $a1, $v0
    /* AA828 800BA028 090043A0 */  sb         $v1, 0x9($v0)
    /* AA82C 800BA02C 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA830 800BA030 07002392 */  lbu        $v1, 0x7($s1)
    /* AA834 800BA034 2110A200 */  addu       $v0, $a1, $v0
    /* AA838 800BA038 080043A0 */  sb         $v1, 0x8($v0)
    /* AA83C 800BA03C 9C0F848F */  lw         $a0, %gp_rel(Track_gMatController)($gp)
    /* AA840 800BA040 0200A296 */  lhu        $v0, 0x2($s5)
    /* AA844 800BA044 2120A400 */  addu       $a0, $a1, $a0
    /* AA848 800BA048 0A0082A4 */  sh         $v0, 0xA($a0)
    /* AA84C 800BA04C 0C0095AC */  sw         $s5, 0xC($a0)
    /* AA850 800BA050 0200A286 */  lh         $v0, 0x2($s5)
    /* AA854 800BA054 0C00C38E */  lw         $v1, 0xC($s6)
    /* AA858 800BA058 00110200 */  sll        $v0, $v0, 4
    /* AA85C 800BA05C 21186200 */  addu       $v1, $v1, $v0
    /* AA860 800BA060 01006290 */  lbu        $v0, 0x1($v1)
    /* AA864 800BA064 00000000 */  nop
    /* AA868 800BA068 040082A0 */  sb         $v0, 0x4($a0)
    /* AA86C 800BA06C 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA870 800BA070 05006490 */  lbu        $a0, 0x5($v1)
    /* AA874 800BA074 2110A200 */  addu       $v0, $a1, $v0
    /* AA878 800BA078 050044A0 */  sb         $a0, 0x5($v0)
    /* AA87C 800BA07C 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA880 800BA080 09006490 */  lbu        $a0, 0x9($v1)
    /* AA884 800BA084 2110A200 */  addu       $v0, $a1, $v0
    /* AA888 800BA088 060044A0 */  sb         $a0, 0x6($v0)
    /* AA88C 800BA08C 9C0F828F */  lw         $v0, %gp_rel(Track_gMatController)($gp)
    /* AA890 800BA090 0D006490 */  lbu        $a0, 0xD($v1)
    /* AA894 800BA094 2110A200 */  addu       $v0, $a1, $v0
    /* AA898 800BA098 070044A0 */  sb         $a0, 0x7($v0)
    /* AA89C 800BA09C 0D006490 */  lbu        $a0, 0xD($v1)
    /* AA8A0 800BA0A0 01006290 */  lbu        $v0, 0x1($v1)
    /* AA8A4 800BA0A4 00000000 */  nop
    /* AA8A8 800BA0A8 23108200 */  subu       $v0, $a0, $v0
    /* AA8AC 800BA0AC 02004104 */  bgez       $v0, .L800BA0B8
    /* AA8B0 800BA0B0 00000000 */   nop
    /* AA8B4 800BA0B4 23100200 */  negu       $v0, $v0
  .L800BA0B8:
    /* AA8B8 800BA0B8 0100DE27 */  addiu      $fp, $fp, 0x1
    /* AA8BC 800BA0BC 9C0F838F */  lw         $v1, %gp_rel(Track_gMatController)($gp)
    /* AA8C0 800BA0C0 01004224 */  addiu      $v0, $v0, 0x1
    /* AA8C4 800BA0C4 2118A300 */  addu       $v1, $a1, $v1
    /* AA8C8 800BA0C8 020062A0 */  sb         $v0, 0x2($v1)
  .L800BA0CC:
    /* AA8CC 800BA0CC 1280023C */  lui        $v0, %hi(TrackSpec_gSpec)
    /* AA8D0 800BA0D0 7C324284 */  lh         $v0, %lo(TrackSpec_gSpec)($v0)
    /* AA8D4 800BA0D4 00000000 */  nop
    /* AA8D8 800BA0D8 42004010 */  beqz       $v0, .L800BA1E4
    /* AA8DC 800BA0DC 21A00000 */   addu      $s4, $zero, $zero
    /* AA8E0 800BA0E0 21982002 */  addu       $s3, $s1, $zero
    /* AA8E4 800BA0E4 2180A002 */  addu       $s0, $s5, $zero
    /* AA8E8 800BA0E8 21908002 */  addu       $s2, $s4, $zero
  .L800BA0EC:
    /* AA8EC 800BA0EC 2000822A */  slti       $v0, $s4, 0x20
    /* AA8F0 800BA0F0 3C004010 */  beqz       $v0, .L800BA1E4
    /* AA8F4 800BA0F4 00000000 */   nop
    /* AA8F8 800BA0F8 8818828F */  lw         $v0, %gp_rel(D_8013DDD4)($gp)
    /* AA8FC 800BA0FC 00000000 */  nop
    /* AA900 800BA100 21204202 */  addu       $a0, $s2, $v0
    /* AA904 800BA104 0000838C */  lw         $v1, 0x0($a0)
    /* AA908 800BA108 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AA90C 800BA10C 32006210 */  beq        $v1, $v0, .L800BA1D8
    /* AA910 800BA110 00000000 */   nop
    /* AA914 800BA114 0400858C */  lw         $a1, 0x4($a0)
    /* AA918 800BA118 00006286 */  lh         $v0, 0x0($s3)
    /* AA91C 800BA11C 00000000 */  nop
    /* AA920 800BA120 2D00A214 */  bne        $a1, $v0, .L800BA1D8
    /* AA924 800BA124 00000000 */   nop
    /* AA928 800BA128 00000292 */  lbu        $v0, 0x0($s0)
    /* AA92C 800BA12C 0800838C */  lw         $v1, 0x8($a0)
    /* AA930 800BA130 08004234 */  ori        $v0, $v0, 0x8
    /* AA934 800BA134 000002A2 */  sb         $v0, 0x0($s0)
    /* AA938 800BA138 00006486 */  lh         $a0, 0x0($s3)
    /* AA93C 800BA13C 02000286 */  lh         $v0, 0x2($s0)
    /* AA940 800BA140 00000000 */  nop
    /* AA944 800BA144 23008210 */  beq        $a0, $v0, .L800BA1D4
    /* AA948 800BA148 23186500 */   subu      $v1, $v1, $a1
    /* AA94C 800BA14C 1000A527 */  addiu      $a1, $sp, 0x10
    /* AA950 800BA150 21108300 */  addu       $v0, $a0, $v1
    /* AA954 800BA154 0C00C38E */  lw         $v1, 0xC($s6)
    /* AA958 800BA158 00110200 */  sll        $v0, $v0, 4
    /* AA95C 800BA15C 21104300 */  addu       $v0, $v0, $v1
    /* AA960 800BA160 03004A88 */  lwl        $t2, 0x3($v0)
    /* AA964 800BA164 00004A98 */  lwr        $t2, 0x0($v0)
    /* AA968 800BA168 07004788 */  lwl        $a3, 0x7($v0)
    /* AA96C 800BA16C 04004798 */  lwr        $a3, 0x4($v0)
    /* AA970 800BA170 0B004888 */  lwl        $t0, 0xB($v0)
    /* AA974 800BA174 08004898 */  lwr        $t0, 0x8($v0)
    /* AA978 800BA178 0F004988 */  lwl        $t1, 0xF($v0)
    /* AA97C 800BA17C 0C004998 */  lwr        $t1, 0xC($v0)
    /* AA980 800BA180 1300AAAB */  swl        $t2, 0x13($sp)
    /* AA984 800BA184 1000AABB */  swr        $t2, 0x10($sp)
    /* AA988 800BA188 1700A7AB */  swl        $a3, 0x17($sp)
    /* AA98C 800BA18C 1400A7BB */  swr        $a3, 0x14($sp)
    /* AA990 800BA190 1B00A8AB */  swl        $t0, 0x1B($sp)
    /* AA994 800BA194 1800A8BB */  swr        $t0, 0x18($sp)
    /* AA998 800BA198 1F00A9AB */  swl        $t1, 0x1F($sp)
    /* AA99C 800BA19C 1C00A9BB */  swr        $t1, 0x1C($sp)
    /* AA9A0 800BA1A0 03006492 */  lbu        $a0, 0x3($s3)
    /* AA9A4 800BA1A4 1000C68E */  lw         $a2, 0x10($s6)
    /* AA9A8 800BA1A8 0C00C28E */  lw         $v0, 0xC($s6)
    /* AA9AC 800BA1AC 00310600 */  sll        $a2, $a2, 4
    /* AA9B0 800BA1B0 F1E6020C */  jal        Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1
    /* AA9B4 800BA1B4 21304600 */   addu      $a2, $v0, $a2
    /* AA9B8 800BA1B8 1000C28E */  lw         $v0, 0x10($s6)
    /* AA9BC 800BA1BC 00000000 */  nop
    /* AA9C0 800BA1C0 01004224 */  addiu      $v0, $v0, 0x1
    /* AA9C4 800BA1C4 1000C2AE */  sw         $v0, 0x10($s6)
    /* AA9C8 800BA1C8 01000224 */  addiu      $v0, $zero, 0x1
    /* AA9CC 800BA1CC 76E80208 */  j          .L800BA1D8
    /* AA9D0 800BA1D0 010002A2 */   sb        $v0, 0x1($s0)
  .L800BA1D4:
    /* AA9D4 800BA1D4 010003A2 */  sb         $v1, 0x1($s0)
  .L800BA1D8:
    /* AA9D8 800BA1D8 0C005226 */  addiu      $s2, $s2, 0xC
    /* AA9DC 800BA1DC 3BE80208 */  j          .L800BA0EC
    /* AA9E0 800BA1E0 01009426 */   addiu     $s4, $s4, 0x1
  .L800BA1E4:
    /* AA9E4 800BA1E4 0400B526 */  addiu      $s5, $s5, 0x4
    /* AA9E8 800BA1E8 0A003126 */  addiu      $s1, $s1, 0xA
    /* AA9EC 800BA1EC DDE70208 */  j          .L800B9F74
    /* AA9F0 800BA1F0 0100F726 */   addiu     $s7, $s7, 0x1
  .L800BA1F4:
    /* AA9F4 800BA1F4 8818848F */  lw         $a0, %gp_rel(D_8013DDD4)($gp)
    /* AA9F8 800BA1F8 00000000 */  nop
    /* AA9FC 800BA1FC 03008010 */  beqz       $a0, .L800BA20C
    /* AAA00 800BA200 00000000 */   nop
    /* AAA04 800BA204 5095030C */  jal        purgememadr
    /* AAA08 800BA208 00000000 */   nop
  .L800BA20C:
    /* AAA0C 800BA20C 8C18848F */  lw         $a0, %gp_rel(D_8013DDD8)($gp)
    /* AAA10 800BA210 5095030C */  jal        purgememadr
    /* AAA14 800BA214 00000000 */   nop
    /* AAA18 800BA218 1280023C */  lui        $v0, %hi(gInitialArt)
    /* AAA1C 800BA21C 58E14224 */  addiu      $v0, $v0, %lo(gInitialArt)
    /* AAA20 800BA220 0800438C */  lw         $v1, 0x8($v0)
    /* AAA24 800BA224 040040AC */  sw         $zero, 0x4($v0)
    /* AAA28 800BA228 100043AC */  sw         $v1, 0x10($v0)
  .L800BA22C:
    /* AAA2C 800BA22C 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* AAA30 800BA230 4800BE8F */  lw         $fp, 0x48($sp)
    /* AAA34 800BA234 4400B78F */  lw         $s7, 0x44($sp)
    /* AAA38 800BA238 4000B68F */  lw         $s6, 0x40($sp)
    /* AAA3C 800BA23C 3C00B58F */  lw         $s5, 0x3C($sp)
    /* AAA40 800BA240 3800B48F */  lw         $s4, 0x38($sp)
    /* AAA44 800BA244 3400B38F */  lw         $s3, 0x34($sp)
    /* AAA48 800BA248 3000B28F */  lw         $s2, 0x30($sp)
    /* AAA4C 800BA24C 2C00B18F */  lw         $s1, 0x2C($sp)
    /* AAA50 800BA250 2800B08F */  lw         $s0, 0x28($sp)
    /* AAA54 800BA254 0800E003 */  jr         $ra
    /* AAA58 800BA258 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial
