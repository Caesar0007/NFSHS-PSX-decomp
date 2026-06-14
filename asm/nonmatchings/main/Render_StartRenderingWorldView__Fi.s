.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_StartRenderingWorldView__Fi, 0x7C

glabel Render_StartRenderingWorldView__Fi
    /* A3A1C 800B321C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A3A20 800B3220 1400B1AF */  sw         $s1, 0x14($sp)
    /* A3A24 800B3224 21888000 */  addu       $s1, $a0, $zero
    /* A3A28 800B3228 1000B0AF */  sw         $s0, 0x10($sp)
    /* A3A2C 800B322C 1180103C */  lui        $s0, %hi(gCView)
    /* A3A30 800B3230 7C6F1026 */  addiu      $s0, $s0, %lo(gCView)
    /* A3A34 800B3234 1800BFAF */  sw         $ra, 0x18($sp)
    /* A3A38 800B3238 C101020C */  jal        Camera_SetCamera__FP13DRender_tView
    /* A3A3C 800B323C 21200002 */   addu      $a0, $s0, $zero
    /* A3A40 800B3240 52EB020C */  jal        Track_AnimateTrackLighting__Fv
    /* A3A44 800B3244 00000000 */   nop
    /* A3A48 800B3248 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* A3A4C 800B324C 21202002 */   addu      $a0, $s1, $zero
    /* A3A50 800B3250 1180023C */  lui        $v0, %hi(D_80113218)
    /* A3A54 800B3254 1832428C */  lw         $v0, %lo(D_80113218)($v0)
    /* A3A58 800B3258 0400048E */  lw         $a0, 0x4($s0)
    /* A3A5C 800B325C 801F013C */  lui        $at, (0x1F80000C >> 16)
    /* A3A60 800B3260 0C0022AC */  sw         $v0, (0x1F80000C & 0xFFFF)($at)
    /* A3A64 800B3264 6083030C */  jal        Fog_Update__Fi
    /* A3A68 800B3268 00000000 */   nop
    /* A3A6C 800B326C BAF9020C */  jal        DrawC_SetEnviroment__Fv
    /* A3A70 800B3270 00000000 */   nop
    /* A3A74 800B3274 4E86030C */  jal        TrsProj_ResetTransPrecision__Fv
    /* A3A78 800B3278 00000000 */   nop
    /* A3A7C 800B327C 2A70030C */  jal        Night_SetEnviroment__FP13DRender_tView
    /* A3A80 800B3280 21200002 */   addu      $a0, $s0, $zero
    /* A3A84 800B3284 1800BF8F */  lw         $ra, 0x18($sp)
    /* A3A88 800B3288 1400B18F */  lw         $s1, 0x14($sp)
    /* A3A8C 800B328C 1000B08F */  lw         $s0, 0x10($sp)
    /* A3A90 800B3290 0800E003 */  jr         $ra
    /* A3A94 800B3294 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Render_StartRenderingWorldView__Fi
