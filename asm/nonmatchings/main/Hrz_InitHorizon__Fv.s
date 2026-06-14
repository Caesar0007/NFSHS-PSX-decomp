.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_InitHorizon__Fv, 0x6C

glabel Hrz_InitHorizon__Fv
    /* C0918 800D0118 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C091C 800D011C 1000B0AF */  sw         $s0, 0x10($sp)
    /* C0920 800D0120 1280103C */  lui        $s0, %hi(D_801232A4)
    /* C0924 800D0124 A4321026 */  addiu      $s0, $s0, %lo(D_801232A4)
    /* C0928 800D0128 30000226 */  addiu      $v0, $s0, 0x30
    /* C092C 800D012C 0580043C */  lui        $a0, %hi(D_800568C0)
    /* C0930 800D0130 C0688424 */  addiu      $a0, $a0, %lo(D_800568C0)
    /* C0934 800D0134 88000524 */  addiu      $a1, $zero, 0x88
    /* C0938 800D0138 1400BFAF */  sw         $ra, 0x14($sp)
    /* C093C 800D013C 3C1390AF */  sw         $s0, %gp_rel(Hrz_gTrackSpec)($gp)
    /* C0940 800D0140 401382AF */  sw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0944 800D0144 CF94030C */  jal        reservememadr
    /* C0948 800D0148 21300000 */   addu      $a2, $zero, $zero
    /* C094C 800D014C 441382AF */  sw         $v0, %gp_rel(gRngCoordTop)($gp)
    /* C0950 800D0150 603F030C */  jal        Hrz_Init2DRing__Fv
    /* C0954 800D0154 00000000 */   nop
    /* C0958 800D0158 3400028E */  lw         $v0, 0x34($s0)
    /* C095C 800D015C 00000000 */  nop
    /* C0960 800D0160 10004230 */  andi       $v0, $v0, 0x10
    /* C0964 800D0164 03004010 */  beqz       $v0, .L800D0174
    /* C0968 800D0168 00000000 */   nop
    /* C096C 800D016C AD3D030C */  jal        Sky_InitStars__Fv
    /* C0970 800D0170 00000000 */   nop
  .L800D0174:
    /* C0974 800D0174 1400BF8F */  lw         $ra, 0x14($sp)
    /* C0978 800D0178 1000B08F */  lw         $s0, 0x10($sp)
    /* C097C 800D017C 0800E003 */  jr         $ra
    /* C0980 800D0180 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hrz_InitHorizon__Fv
