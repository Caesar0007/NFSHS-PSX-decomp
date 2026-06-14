.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TexturesLoadInitial__Fv, 0x1AC

glabel TexturesLoadInitial__Fv
    /* AA030 800B9830 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* AA034 800B9834 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* AA038 800B9838 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* AA03C 800B983C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* AA040 800B9840 1800B0AF */  sw         $s0, 0x18($sp)
    /* AA044 800B9844 5400628C */  lw         $v0, 0x54($v1)
    /* AA048 800B9848 00000000 */  nop
    /* AA04C 800B984C 0B004010 */  beqz       $v0, .L800B987C
    /* AA050 800B9850 00000000 */   nop
    /* AA054 800B9854 4800628C */  lw         $v0, 0x48($v1)
    /* AA058 800B9858 00000000 */  nop
    /* AA05C 800B985C 04004010 */  beqz       $v0, .L800B9870
    /* AA060 800B9860 00000000 */   nop
    /* AA064 800B9864 1480043C */  lui        $a0, %hi(D_8013D468)
    /* AA068 800B9868 27E60208 */  j          .L800B989C
    /* AA06C 800B986C 68D48424 */   addiu     $a0, $a0, %lo(D_8013D468)
  .L800B9870:
    /* AA070 800B9870 1480043C */  lui        $a0, %hi(D_8013D470)
    /* AA074 800B9874 27E60208 */  j          .L800B989C
    /* AA078 800B9878 70D48424 */   addiu     $a0, $a0, %lo(D_8013D470)
  .L800B987C:
    /* AA07C 800B987C 4800628C */  lw         $v0, 0x48($v1)
    /* AA080 800B9880 00000000 */  nop
    /* AA084 800B9884 03004010 */  beqz       $v0, .L800B9894
    /* AA088 800B9888 1480043C */   lui       $a0, %hi(D_8013D478)
    /* AA08C 800B988C 27E60208 */  j          .L800B989C
    /* AA090 800B9890 78D48424 */   addiu     $a0, $a0, %lo(D_8013D478)
  .L800B9894:
    /* AA094 800B9894 1480043C */  lui        $a0, %hi(D_8013D480)
    /* AA098 800B9898 80D48424 */  addiu      $a0, $a0, %lo(D_8013D480)
  .L800B989C:
    /* AA09C 800B989C C2E4020C */  jal        Track_MakeTrackPathName__FPc
    /* AA0A0 800B98A0 00000000 */   nop
    /* AA0A4 800B98A4 21204000 */  addu       $a0, $v0, $zero
    /* AA0A8 800B98A8 0FC7030C */  jal        loadshapeadr
    /* AA0AC 800B98AC 21280000 */   addu      $a1, $zero, $zero
    /* AA0B0 800B98B0 1280033C */  lui        $v1, %hi(D_8011E15C)
    /* AA0B4 800B98B4 2D004010 */  beqz       $v0, .L800B996C
    /* AA0B8 800B98B8 5CE162AC */   sw        $v0, %lo(D_8011E15C)($v1)
    /* AA0BC 800B98BC 9E7D030C */  jal        Texture_ResetPaletteSharing__Fv
    /* AA0C0 800B98C0 1280103C */   lui       $s0, %hi(gInitialArt)
    /* AA0C4 800B98C4 58E11026 */  addiu      $s0, $s0, %lo(gInitialArt)
    /* AA0C8 800B98C8 0400048E */  lw         $a0, 0x4($s0)
    /* AA0CC 800B98CC ABC2030C */  jal        shapecount
    /* AA0D0 800B98D0 00000000 */   nop
    /* AA0D4 800B98D4 40000624 */  addiu      $a2, $zero, 0x40
    /* AA0D8 800B98D8 0400048E */  lw         $a0, 0x4($s0)
    /* AA0DC 800B98DC 0C00058E */  lw         $a1, 0xC($s0)
    /* AA0E0 800B98E0 00010724 */  addiu      $a3, $zero, 0x100
    /* AA0E4 800B98E4 080002AE */  sw         $v0, 0x8($s0)
    /* AA0E8 800B98E8 0BE5020C */  jal        LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii
    /* AA0EC 800B98EC 1000A0AF */   sw        $zero, 0x10($sp)
    /* AA0F0 800B98F0 0800028E */  lw         $v0, 0x8($s0)
    /* AA0F4 800B98F4 0C00038E */  lw         $v1, 0xC($s0)
    /* AA0F8 800B98F8 1480043C */  lui        $a0, %hi(gSpikeBeltPixmap)
    /* AA0FC 800B98FC E0D1848C */  lw         $a0, %lo(gSpikeBeltPixmap)($a0)
    /* AA100 800B9900 00110200 */  sll        $v0, $v0, 4
    /* AA104 800B9904 21104300 */  addu       $v0, $v0, $v1
    /* AA108 800B9908 03008888 */  lwl        $t0, 0x3($a0)
    /* AA10C 800B990C 00008898 */  lwr        $t0, 0x0($a0)
    /* AA110 800B9910 07008988 */  lwl        $t1, 0x7($a0)
    /* AA114 800B9914 04008998 */  lwr        $t1, 0x4($a0)
    /* AA118 800B9918 0B008A88 */  lwl        $t2, 0xB($a0)
    /* AA11C 800B991C 08008A98 */  lwr        $t2, 0x8($a0)
    /* AA120 800B9920 0F008B88 */  lwl        $t3, 0xF($a0)
    /* AA124 800B9924 0C008B98 */  lwr        $t3, 0xC($a0)
    /* AA128 800B9928 030048A8 */  swl        $t0, 0x3($v0)
    /* AA12C 800B992C 000048B8 */  swr        $t0, 0x0($v0)
    /* AA130 800B9930 070049A8 */  swl        $t1, 0x7($v0)
    /* AA134 800B9934 040049B8 */  swr        $t1, 0x4($v0)
    /* AA138 800B9938 0B004AA8 */  swl        $t2, 0xB($v0)
    /* AA13C 800B993C 08004AB8 */  swr        $t2, 0x8($v0)
    /* AA140 800B9940 0F004BA8 */  swl        $t3, 0xF($v0)
    /* AA144 800B9944 0C004BB8 */  swr        $t3, 0xC($v0)
    /* AA148 800B9948 0800028E */  lw         $v0, 0x8($s0)
    /* AA14C 800B994C 0400048E */  lw         $a0, 0x4($s0)
    /* AA150 800B9950 01004224 */  addiu      $v0, $v0, 0x1
    /* AA154 800B9954 080002AE */  sw         $v0, 0x8($s0)
    /* AA158 800B9958 100002AE */  sw         $v0, 0x10($s0)
    /* AA15C 800B995C 5095030C */  jal        purgememadr
    /* AA160 800B9960 140002AE */   sw        $v0, 0x14($s0)
    /* AA164 800B9964 5DE60208 */  j          .L800B9974
    /* AA168 800B9968 1280023C */   lui       $v0, %hi(D_8011E164)
  .L800B996C:
    /* AA16C 800B996C 5BE60208 */  j          .L800B996C
    /* AA170 800B9970 00000000 */   nop
  .L800B9974:
    /* AA174 800B9974 64E1448C */  lw         $a0, %lo(D_8011E164)($v0)
    /* AA178 800B9978 1940030C */  jal        Hrz_GetHorizonPixMap__FP12Draw_tPixMap
    /* AA17C 800B997C 00000000 */   nop
    /* AA180 800B9980 1480043C */  lui        $a0, %hi(D_8013D488)
    /* AA184 800B9984 C2E4020C */  jal        Track_MakeTrackPathName__FPc
    /* AA188 800B9988 88D48424 */   addiu     $a0, $a0, %lo(D_8013D488)
    /* AA18C 800B998C 21204000 */  addu       $a0, $v0, $zero
    /* AA190 800B9990 0FC7030C */  jal        loadshapeadr
    /* AA194 800B9994 21280000 */   addu      $a1, $zero, $zero
    /* AA198 800B9998 21804000 */  addu       $s0, $v0, $zero
    /* AA19C 800B999C 0B000012 */  beqz       $s0, .L800B99CC
    /* AA1A0 800B99A0 00000000 */   nop
    /* AA1A4 800B99A4 9E7D030C */  jal        Texture_ResetPaletteSharing__Fv
    /* AA1A8 800B99A8 00000000 */   nop
    /* AA1AC 800B99AC 21200002 */  addu       $a0, $s0, $zero
    /* AA1B0 800B99B0 1280053C */  lui        $a1, %hi(Track_gReflectionMaps)
    /* AA1B4 800B99B4 70E1A524 */  addiu      $a1, $a1, %lo(Track_gReflectionMaps)
    /* AA1B8 800B99B8 E0030624 */  addiu      $a2, $zero, 0x3E0
    /* AA1BC 800B99BC DEE5020C */  jal        LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii
    /* AA1C0 800B99C0 21380000 */   addu      $a3, $zero, $zero
    /* AA1C4 800B99C4 5095030C */  jal        purgememadr
    /* AA1C8 800B99C8 21200002 */   addu      $a0, $s0, $zero
  .L800B99CC:
    /* AA1CC 800B99CC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* AA1D0 800B99D0 1800B08F */  lw         $s0, 0x18($sp)
    /* AA1D4 800B99D4 0800E003 */  jr         $ra
    /* AA1D8 800B99D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TexturesLoadInitial__Fv
