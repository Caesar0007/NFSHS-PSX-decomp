.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_FBuildFT4__FP13HudPmx_tShapeiiUl, 0x90

glabel Hud_FBuildFT4__FP13HudPmx_tShapeiiUl
    /* C30F4 800D28F4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C30F8 800D28F8 21508000 */  addu       $t2, $a0, $zero
    /* C30FC 800D28FC 2158A000 */  addu       $t3, $a1, $zero
    /* C3100 800D2900 2160C000 */  addu       $t4, $a2, $zero
    /* C3104 800D2904 801F093C */  lui        $t1, (0x1F800004 >> 16)
    /* C3108 800D2908 04002935 */  ori        $t1, $t1, (0x1F800004 & 0xFFFF)
    /* C310C 800D290C FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* C3110 800D2910 FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* C3114 800D2914 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C3118 800D2918 1800BFAF */  sw         $ra, 0x18($sp)
    /* C311C 800D291C 0000248D */  lw         $a0, 0x0($t1)
    /* C3120 800D2920 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* C3124 800D2924 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* C3128 800D2928 0000838C */  lw         $v1, 0x0($a0)
    /* C312C 800D292C 0000C28C */  lw         $v0, 0x0($a2)
    /* C3130 800D2930 24186800 */  and        $v1, $v1, $t0
    /* C3134 800D2934 24104500 */  and        $v0, $v0, $a1
    /* C3138 800D2938 25186200 */  or         $v1, $v1, $v0
    /* C313C 800D293C 000083AC */  sw         $v1, 0x0($a0)
    /* C3140 800D2940 28008324 */  addiu      $v1, $a0, 0x28
    /* C3144 800D2944 0000C28C */  lw         $v0, 0x0($a2)
    /* C3148 800D2948 24288500 */  and        $a1, $a0, $a1
    /* C314C 800D294C 000023AD */  sw         $v1, 0x0($t1)
    /* C3150 800D2950 24104800 */  and        $v0, $v0, $t0
    /* C3154 800D2954 25104500 */  or         $v0, $v0, $a1
    /* C3158 800D2958 21284001 */  addu       $a1, $t2, $zero
    /* C315C 800D295C 0000C2AC */  sw         $v0, 0x0($a2)
    /* C3160 800D2960 21306001 */  addu       $a2, $t3, $zero
    /* C3164 800D2964 1000A7AF */  sw         $a3, 0x10($sp)
    /* C3168 800D2968 21388001 */  addu       $a3, $t4, $zero
    /* C316C 800D296C CD48030C */  jal        Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C3170 800D2970 1400A0AF */   sw        $zero, 0x14($sp)
    /* C3174 800D2974 1800BF8F */  lw         $ra, 0x18($sp)
    /* C3178 800D2978 00000000 */  nop
    /* C317C 800D297C 0800E003 */  jr         $ra
    /* C3180 800D2980 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Hud_FBuildFT4__FP13HudPmx_tShapeiiUl
