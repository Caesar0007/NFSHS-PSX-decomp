.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_RenderPlayerView__Fii, 0x4C

glabel Render_RenderPlayerView__Fii
    /* A3B5C 800B335C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* A3B60 800B3360 1400B1AF */  sw         $s1, 0x14($sp)
    /* A3B64 800B3364 21888000 */  addu       $s1, $a0, $zero
    /* A3B68 800B3368 1000B0AF */  sw         $s0, 0x10($sp)
    /* A3B6C 800B336C 1180103C */  lui        $s0, %hi(gCView)
    /* A3B70 800B3370 7C6F11AE */  sw         $s1, %lo(gCView)($s0)
    /* A3B74 800B3374 7C6F1026 */  addiu      $s0, $s0, %lo(gCView)
    /* A3B78 800B3378 1800BFAF */  sw         $ra, 0x18($sp)
    /* A3B7C 800B337C 87CC020C */  jal        Render_StartRenderingWorldView__Fi
    /* A3B80 800B3380 040005AE */   sw        $a1, 0x4($s0)
    /* A3B84 800B3384 AECC020C */  jal        Render_RenderWorld__FP13DRender_tView
    /* A3B88 800B3388 21200002 */   addu      $a0, $s0, $zero
    /* A3B8C 800B338C A6CC020C */  jal        Render_StopRenderingWorldView__Fi
    /* A3B90 800B3390 21202002 */   addu      $a0, $s1, $zero
    /* A3B94 800B3394 1800BF8F */  lw         $ra, 0x18($sp)
    /* A3B98 800B3398 1400B18F */  lw         $s1, 0x14($sp)
    /* A3B9C 800B339C 1000B08F */  lw         $s0, 0x10($sp)
    /* A3BA0 800B33A0 0800E003 */  jr         $ra
    /* A3BA4 800B33A4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Render_RenderPlayerView__Fii
