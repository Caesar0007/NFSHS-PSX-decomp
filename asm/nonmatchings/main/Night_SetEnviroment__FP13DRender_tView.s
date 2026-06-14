.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_SetEnviroment__FP13DRender_tView, 0x110

glabel Night_SetEnviroment__FP13DRender_tView
    /* CC8A8 800DC0A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CC8AC 800DC0AC 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CC8B0 800DC0B0 EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* CC8B4 800DC0B4 1400BFAF */  sw         $ra, 0x14($sp)
    /* CC8B8 800DC0B8 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC8BC 800DC0BC 5400628C */  lw         $v0, 0x54($v1)
    /* CC8C0 800DC0C0 00000000 */  nop
    /* CC8C4 800DC0C4 38004010 */  beqz       $v0, .L800DC1A8
    /* CC8C8 800DC0C8 21808000 */   addu      $s0, $a0, $zero
    /* CC8CC 800DC0CC 9814828F */  lw         $v0, %gp_rel(Night_gPlayerLightingTable)($gp)
    /* CC8D0 800DC0D0 4800638C */  lw         $v1, 0x48($v1)
    /* CC8D4 800DC0D4 941480A3 */  sb         $zero, %gp_rel(Night_gDrawLightning)($gp)
    /* CC8D8 800DC0D8 FC1482AF */  sw         $v0, %gp_rel(Night_gCurrentNightColor)($gp)
    /* CC8DC 800DC0DC 01000224 */  addiu      $v0, $zero, 0x1
    /* CC8E0 800DC0E0 0B006214 */  bne        $v1, $v0, .L800DC110
    /* CC8E4 800DC0E4 0A000224 */   addiu     $v0, $zero, 0xA
    /* CC8E8 800DC0E8 0400048E */  lw         $a0, 0x4($s0)
    /* CC8EC 800DC0EC 906D030C */  jal        Night_PauseLightningEffect__Fi
    /* CC8F0 800DC0F0 00000000 */   nop
    /* CC8F4 800DC0F4 0400028E */  lw         $v0, 0x4($s0)
    /* CC8F8 800DC0F8 00000000 */  nop
    /* CC8FC 800DC0FC 04004014 */  bnez       $v0, .L800DC110
    /* CC900 800DC100 0A000224 */   addiu     $v0, $zero, 0xA
    /* CC904 800DC104 B16D030C */  jal        Night_DoLightningEffect__FP13DRender_tView
    /* CC908 800DC108 21200002 */   addu      $a0, $s0, $zero
    /* CC90C 800DC10C 0A000224 */  addiu      $v0, $zero, 0xA
  .L800DC110:
    /* CC910 800DC110 EC1482AF */  sw         $v0, %gp_rel(Night_gXDistShift)($gp)
    /* CC914 800DC114 0C000224 */  addiu      $v0, $zero, 0xC
    /* CC918 800DC118 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* CC91C 800DC11C 0400048E */  lw         $a0, 0x4($s0)
    /* CC920 800DC120 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* CC924 800DC124 F01482AF */  sw         $v0, %gp_rel(Night_gZDistShift)($gp)
    /* CC928 800DC128 00110400 */  sll        $v0, $a0, 4
    /* CC92C 800DC12C 21104400 */  addu       $v0, $v0, $a0
    /* CC930 800DC130 00110200 */  sll        $v0, $v0, 4
    /* CC934 800DC134 21104300 */  addu       $v0, $v0, $v1
    /* CC938 800DC138 0400428C */  lw         $v0, 0x4($v0)
    /* CC93C 800DC13C 80000324 */  addiu      $v1, $zero, 0x80
    /* CC940 800DC140 E41483AF */  sw         $v1, %gp_rel(Night_gZNear)($gp)
    /* CC944 800DC144 47044290 */  lbu        $v0, 0x447($v0)
    /* CC948 800DC148 00000000 */  nop
    /* CC94C 800DC14C 04004230 */  andi       $v0, $v0, 0x4
    /* CC950 800DC150 04004010 */  beqz       $v0, .L800DC164
    /* CC954 800DC154 0D000224 */   addiu     $v0, $zero, 0xD
    /* CC958 800DC158 F01482AF */  sw         $v0, %gp_rel(Night_gZDistShift)($gp)
    /* CC95C 800DC15C 0B000224 */  addiu      $v0, $zero, 0xB
    /* CC960 800DC160 EC1482AF */  sw         $v0, %gp_rel(Night_gXDistShift)($gp)
  .L800DC164:
    /* CC964 800DC164 0400048E */  lw         $a0, 0x4($s0)
    /* CC968 800DC168 5A15020C */  jal        Camera_GetMode__Fi
    /* CC96C 800DC16C 00000000 */   nop
    /* CC970 800DC170 03004014 */  bnez       $v0, .L800DC180
    /* CC974 800DC174 01000324 */   addiu     $v1, $zero, 0x1
    /* CC978 800DC178 00FE0224 */  addiu      $v0, $zero, -0x200
    /* CC97C 800DC17C E41482AF */  sw         $v0, %gp_rel(Night_gZNear)($gp)
  .L800DC180:
    /* CC980 800DC180 EC14858F */  lw         $a1, %gp_rel(Night_gXDistShift)($gp)
    /* CC984 800DC184 F014848F */  lw         $a0, %gp_rel(Night_gZDistShift)($gp)
    /* CC988 800DC188 0410A300 */  sllv       $v0, $v1, $a1
    /* CC98C 800DC18C 04188300 */  sllv       $v1, $v1, $a0
    /* CC990 800DC190 FAFF8424 */  addiu      $a0, $a0, -0x6
    /* CC994 800DC194 FBFFA524 */  addiu      $a1, $a1, -0x5
    /* CC998 800DC198 E01482AF */  sw         $v0, %gp_rel(Night_gXDist)($gp)
    /* CC99C 800DC19C E81483AF */  sw         $v1, %gp_rel(Night_gZDist)($gp)
    /* CC9A0 800DC1A0 F01484AF */  sw         $a0, %gp_rel(Night_gZDistShift)($gp)
    /* CC9A4 800DC1A4 EC1485AF */  sw         $a1, %gp_rel(Night_gXDistShift)($gp)
  .L800DC1A8:
    /* CC9A8 800DC1A8 1400BF8F */  lw         $ra, 0x14($sp)
    /* CC9AC 800DC1AC 1000B08F */  lw         $s0, 0x10($sp)
    /* CC9B0 800DC1B0 0800E003 */  jr         $ra
    /* CC9B4 800DC1B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_SetEnviroment__FP13DRender_tView
