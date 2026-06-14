.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Loading_DrawLoadingScreen__Fv, 0x148

glabel Loading_DrawLoadingScreen__Fv
    /* CB8B8 800DB0B8 D0FEBD27 */  addiu      $sp, $sp, -0x130
    /* CB8BC 800DB0BC 2000A427 */  addiu      $a0, $sp, 0x20
    /* CB8C0 800DB0C0 0580053C */  lui        $a1, %hi(D_80056938)
    /* CB8C4 800DB0C4 2001B0AF */  sw         $s0, 0x120($sp)
    /* CB8C8 800DB0C8 1180103C */  lui        $s0, %hi(Paths_Paths)
    /* CB8CC 800DB0CC 68641026 */  addiu      $s0, $s0, %lo(Paths_Paths)
    /* CB8D0 800DB0D0 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* CB8D4 800DB0D4 EC316324 */  addiu      $v1, $v1, %lo(GameSetup_gData)
    /* CB8D8 800DB0D8 2C01BFAF */  sw         $ra, 0x12C($sp)
    /* CB8DC 800DB0DC 2801B2AF */  sw         $s2, 0x128($sp)
    /* CB8E0 800DB0E0 2401B1AF */  sw         $s1, 0x124($sp)
    /* CB8E4 800DB0E4 6400068E */  lw         $a2, 0x64($s0)
    /* CB8E8 800DB0E8 2C00628C */  lw         $v0, 0x2C($v1)
    /* CB8EC 800DB0EC 3C00678C */  lw         $a3, 0x3C($v1)
    /* CB8F0 800DB0F0 61004224 */  addiu      $v0, $v0, 0x61
    /* CB8F4 800DB0F4 1000A2AF */  sw         $v0, 0x10($sp)
    /* CB8F8 800DB0F8 E000718C */  lw         $s1, 0xE0($v1)
    /* CB8FC 800DB0FC 2F91030C */  jal        sprintf
    /* CB900 800DB100 3869A524 */   addiu     $a1, $a1, %lo(D_80056938)
    /* CB904 800DB104 2000A427 */  addiu      $a0, $sp, 0x20
    /* CB908 800DB108 0FC7030C */  jal        loadshapeadr
    /* CB90C 800DB10C 21280000 */   addu      $a1, $zero, $zero
    /* CB910 800DB110 2000A427 */  addiu      $a0, $sp, 0x20
    /* CB914 800DB114 0580053C */  lui        $a1, %hi(D_80056948)
    /* CB918 800DB118 4869A524 */  addiu      $a1, $a1, %lo(D_80056948)
    /* CB91C 800DB11C 6400068E */  lw         $a2, 0x64($s0)
    /* CB920 800DB120 2F91030C */  jal        sprintf
    /* CB924 800DB124 21904000 */   addu      $s2, $v0, $zero
    /* CB928 800DB128 2000A427 */  addiu      $a0, $sp, 0x20
    /* CB92C 800DB12C 0FC7030C */  jal        loadshapeadr
    /* CB930 800DB130 21280000 */   addu      $a1, $zero, $zero
    /* CB934 800DB134 00020424 */  addiu      $a0, $zero, 0x200
    /* CB938 800DB138 F0000524 */  addiu      $a1, $zero, 0xF0
    /* CB93C 800DB13C 01000624 */  addiu      $a2, $zero, 0x1
    /* CB940 800DB140 21380000 */  addu       $a3, $zero, $zero
    /* CB944 800DB144 2118C000 */  addu       $v1, $a2, $zero
    /* CB948 800DB148 21804000 */  addu       $s0, $v0, $zero
    /* CB94C 800DB14C 1000A3AF */  sw         $v1, 0x10($sp)
    /* CB950 800DB150 1400A0AF */  sw         $zero, 0x14($sp)
    /* CB954 800DB154 1800A0AF */  sw         $zero, 0x18($sp)
    /* CB958 800DB158 5FF9020C */  jal        Draw_SetEnvironment__Fiiiiiiii
    /* CB95C 800DB15C 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CB960 800DB160 21204002 */  addu       $a0, $s2, $zero
    /* CB964 800DB164 AEC2030C */  jal        shapepointer
    /* CB968 800DB168 21280000 */   addu      $a1, $zero, $zero
    /* CB96C 800DB16C 21204000 */  addu       $a0, $v0, $zero
    /* CB970 800DB170 21280000 */  addu       $a1, $zero, $zero
    /* CB974 800DB174 14F9020C */  jal        Draw_DrawDirectScreen__FP8shapetblii
    /* CB978 800DB178 2130A000 */   addu      $a2, $a1, $zero
    /* CB97C 800DB17C 1280023C */  lui        $v0, %hi(D_80120D00)
    /* CB980 800DB180 000D4224 */  addiu      $v0, $v0, %lo(D_80120D00)
    /* CB984 800DB184 80881100 */  sll        $s1, $s1, 2
    /* CB988 800DB188 21882202 */  addu       $s1, $s1, $v0
    /* CB98C 800DB18C 0000258E */  lw         $a1, 0x0($s1)
    /* CB990 800DB190 5CAC030C */  jal        locateshapez
    /* CB994 800DB194 21200002 */   addu      $a0, $s0, $zero
    /* CB998 800DB198 0C00468C */  lw         $a2, 0xC($v0)
    /* CB99C 800DB19C 21204000 */  addu       $a0, $v0, $zero
    /* CB9A0 800DB1A0 002D0600 */  sll        $a1, $a2, 20
    /* CB9A4 800DB1A4 032D0500 */  sra        $a1, $a1, 20
    /* CB9A8 800DB1A8 00310600 */  sll        $a2, $a2, 4
    /* CB9AC 800DB1AC 14F9020C */  jal        Draw_DrawDirectScreen__FP8shapetblii
    /* CB9B0 800DB1B0 03350600 */   sra       $a2, $a2, 20
    /* CB9B4 800DB1B4 5095030C */  jal        purgememadr
    /* CB9B8 800DB1B8 21204002 */   addu      $a0, $s2, $zero
    /* CB9BC 800DB1BC 5095030C */  jal        purgememadr
    /* CB9C0 800DB1C0 21200002 */   addu      $a0, $s0, $zero
    /* CB9C4 800DB1C4 00020424 */  addiu      $a0, $zero, 0x200
    /* CB9C8 800DB1C8 F0000524 */  addiu      $a1, $zero, 0xF0
    /* CB9CC 800DB1CC 21300000 */  addu       $a2, $zero, $zero
    /* CB9D0 800DB1D0 01000724 */  addiu      $a3, $zero, 0x1
    /* CB9D4 800DB1D4 1000A0AF */  sw         $zero, 0x10($sp)
    /* CB9D8 800DB1D8 1400A0AF */  sw         $zero, 0x14($sp)
    /* CB9DC 800DB1DC 1800A0AF */  sw         $zero, 0x18($sp)
    /* CB9E0 800DB1E0 5FF9020C */  jal        Draw_SetEnvironment__Fiiiiiiii
    /* CB9E4 800DB1E4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* CB9E8 800DB1E8 2C01BF8F */  lw         $ra, 0x12C($sp)
    /* CB9EC 800DB1EC 2801B28F */  lw         $s2, 0x128($sp)
    /* CB9F0 800DB1F0 2401B18F */  lw         $s1, 0x124($sp)
    /* CB9F4 800DB1F4 2001B08F */  lw         $s0, 0x120($sp)
    /* CB9F8 800DB1F8 0800E003 */  jr         $ra
    /* CB9FC 800DB1FC 3001BD27 */   addiu     $sp, $sp, 0x130
endlabel Loading_DrawLoadingScreen__Fv
