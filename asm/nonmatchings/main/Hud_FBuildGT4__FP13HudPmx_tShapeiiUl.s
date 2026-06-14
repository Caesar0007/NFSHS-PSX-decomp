.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_FBuildGT4__FP13HudPmx_tShapeiiUl, 0x8C

glabel Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
    /* C3068 800D2868 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C306C 800D286C 21508000 */  addu       $t2, $a0, $zero
    /* C3070 800D2870 2158A000 */  addu       $t3, $a1, $zero
    /* C3074 800D2874 2160C000 */  addu       $t4, $a2, $zero
    /* C3078 800D2878 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* C307C 800D287C 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* C3080 800D2880 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C3084 800D2884 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C3088 800D2888 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C308C 800D288C 1800BFAF */  sw         $ra, 0x18($sp)
    /* C3090 800D2890 0000248D */  lw         $a0, 0x0($t1)
    /* C3094 800D2894 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C3098 800D2898 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C309C 800D289C 0000838C */  lw         $v1, 0x0($a0)
    /* C30A0 800D28A0 0000C28C */  lw         $v0, 0x0($a2)
    /* C30A4 800D28A4 24186800 */  and        $v1, $v1, $t0
    /* C30A8 800D28A8 24104500 */  and        $v0, $v0, $a1
    /* C30AC 800D28AC 25186200 */  or         $v1, $v1, $v0
    /* C30B0 800D28B0 000083AC */  sw         $v1, 0x0($a0)
    /* C30B4 800D28B4 34008324 */  addiu      $v1, $a0, 0x34
    /* C30B8 800D28B8 0000C28C */  lw         $v0, 0x0($a2)
    /* C30BC 800D28BC 24288500 */  and        $a1, $a0, $a1
    /* C30C0 800D28C0 000023AD */  sw         $v1, 0x0($t1)
    /* C30C4 800D28C4 24104800 */  and        $v0, $v0, $t0
    /* C30C8 800D28C8 25104500 */  or         $v0, $v0, $a1
    /* C30CC 800D28CC 21284001 */  addu       $a1, $t2, $zero
    /* C30D0 800D28D0 0000C2AC */  sw         $v0, 0x0($a2)
    /* C30D4 800D28D4 21306001 */  addu       $a2, $t3, $zero
    /* C30D8 800D28D8 1000A7AF */  sw         $a3, 0x10($sp)
    /* C30DC 800D28DC A248030C */  jal        Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl
    /* C30E0 800D28E0 21388001 */   addu      $a3, $t4, $zero
    /* C30E4 800D28E4 1800BF8F */  lw         $ra, 0x18($sp)
    /* C30E8 800D28E8 00000000 */  nop
    /* C30EC 800D28EC 0800E003 */  jr         $ra
    /* C30F0 800D28F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_FBuildGT4__FP13HudPmx_tShapeiiUl
