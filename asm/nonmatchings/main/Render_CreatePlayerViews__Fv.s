.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_CreatePlayerViews__Fv, 0xEC

glabel Render_CreatePlayerViews__Fv
    /* A38AC 800B30AC 1180023C */  lui        $v0, %hi(D_801131F8)
    /* A38B0 800B30B0 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* A38B4 800B30B4 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A38B8 800B30B8 3400B3AF */  sw         $s3, 0x34($sp)
    /* A38BC 800B30BC 01001324 */  addiu      $s3, $zero, 0x1
    /* A38C0 800B30C0 3800BFAF */  sw         $ra, 0x38($sp)
    /* A38C4 800B30C4 3000B2AF */  sw         $s2, 0x30($sp)
    /* A38C8 800B30C8 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* A38CC 800B30CC 1B005314 */  bne        $v0, $s3, .L800B313C
    /* A38D0 800B30D0 2800B0AF */   sw        $s0, 0x28($sp)
    /* A38D4 800B30D4 21200000 */  addu       $a0, $zero, $zero
    /* A38D8 800B30D8 00010524 */  addiu      $a1, $zero, 0x100
    /* A38DC 800B30DC 40010624 */  addiu      $a2, $zero, 0x140
    /* A38E0 800B30E0 2138A000 */  addu       $a3, $a1, $zero
    /* A38E4 800B30E4 2190C000 */  addu       $s2, $a2, $zero
    /* A38E8 800B30E8 78001124 */  addiu      $s1, $zero, 0x78
    /* A38EC 800B30EC D0071024 */  addiu      $s0, $zero, 0x7D0
    /* A38F0 800B30F0 1000B2AF */  sw         $s2, 0x10($sp)
    /* A38F4 800B30F4 1400B1AF */  sw         $s1, 0x14($sp)
    /* A38F8 800B30F8 1800A0AF */  sw         $zero, 0x18($sp)
    /* A38FC 800B30FC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A3900 800B3100 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* A3904 800B3104 2000B0AF */   sw        $s0, 0x20($sp)
    /* A3908 800B3108 21200000 */  addu       $a0, $zero, $zero
    /* A390C 800B310C 78010524 */  addiu      $a1, $zero, 0x178
    /* A3910 800B3110 40010624 */  addiu      $a2, $zero, 0x140
    /* A3914 800B3114 2138A000 */  addu       $a3, $a1, $zero
    /* A3918 800B3118 800E82AF */  sw         $v0, %gp_rel(Draw_gPlayer1View)($gp)
    /* A391C 800B311C 1000B2AF */  sw         $s2, 0x10($sp)
    /* A3920 800B3120 1400B1AF */  sw         $s1, 0x14($sp)
    /* A3924 800B3124 1800A0AF */  sw         $zero, 0x18($sp)
    /* A3928 800B3128 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A392C 800B312C B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* A3930 800B3130 2000B0AF */   sw        $s0, 0x20($sp)
    /* A3934 800B3134 5ECC0208 */  j          .L800B3178
    /* A3938 800B3138 00000000 */   nop
  .L800B313C:
    /* A393C 800B313C 21200000 */  addu       $a0, $zero, $zero
    /* A3940 800B3140 00010524 */  addiu      $a1, $zero, 0x100
    /* A3944 800B3144 40010624 */  addiu      $a2, $zero, 0x140
    /* A3948 800B3148 2138A000 */  addu       $a3, $a1, $zero
    /* A394C 800B314C 2110C000 */  addu       $v0, $a2, $zero
    /* A3950 800B3150 1000A2AF */  sw         $v0, 0x10($sp)
    /* A3954 800B3154 F0000224 */  addiu      $v0, $zero, 0xF0
    /* A3958 800B3158 1400A2AF */  sw         $v0, 0x14($sp)
    /* A395C 800B315C B80B0224 */  addiu      $v0, $zero, 0xBB8
    /* A3960 800B3160 1800A0AF */  sw         $zero, 0x18($sp)
    /* A3964 800B3164 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* A3968 800B3168 B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* A396C 800B316C 2000A2AF */   sw        $v0, 0x20($sp)
    /* A3970 800B3170 800E82AF */  sw         $v0, %gp_rel(Draw_gPlayer1View)($gp)
    /* A3974 800B3174 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800B3178:
    /* A3978 800B3178 840E82AF */  sw         $v0, %gp_rel(Draw_gPlayer2View)($gp)
    /* A397C 800B317C 3800BF8F */  lw         $ra, 0x38($sp)
    /* A3980 800B3180 3400B38F */  lw         $s3, 0x34($sp)
    /* A3984 800B3184 3000B28F */  lw         $s2, 0x30($sp)
    /* A3988 800B3188 2C00B18F */  lw         $s1, 0x2C($sp)
    /* A398C 800B318C 2800B08F */  lw         $s0, 0x28($sp)
    /* A3990 800B3190 0800E003 */  jr         $ra
    /* A3994 800B3194 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Render_CreatePlayerViews__Fv
