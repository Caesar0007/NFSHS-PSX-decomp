.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_RenderPauseMenuView__Fv, 0x58

glabel Render_RenderPauseMenuView__Fv
    /* A3C30 800B3430 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A3C34 800B3434 9C0E848F */  lw         $a0, %gp_rel(Render_gPauseMenuView)($gp)
    /* A3C38 800B3438 1180023C */  lui        $v0, %hi(gCView)
    /* A3C3C 800B343C 1400BFAF */  sw         $ra, 0x14($sp)
    /* A3C40 800B3440 1000B0AF */  sw         $s0, 0x10($sp)
    /* A3C44 800B3444 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* A3C48 800B3448 7C6F44AC */   sw        $a0, %lo(gCView)($v0)
    /* A3C4C 800B344C A87A020C */  jal        MPause_Render__Fv
    /* A3C50 800B3450 00000000 */   nop
    /* A3C54 800B3454 9C0E848F */  lw         $a0, %gp_rel(Render_gPauseMenuView)($gp)
    /* A3C58 800B3458 1480103C */  lui        $s0, %hi(gFlip)
    /* A3C5C 800B345C B4D7108E */  lw         $s0, %lo(gFlip)($s0)
    /* A3C60 800B3460 1480013C */  lui        $at, %hi(gFlip)
    /* A3C64 800B3464 B4D720AC */  sw         $zero, %lo(gFlip)($at)
    /* A3C68 800B3468 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* A3C6C 800B346C 00000000 */   nop
    /* A3C70 800B3470 1400BF8F */  lw         $ra, 0x14($sp)
    /* A3C74 800B3474 1480013C */  lui        $at, %hi(gFlip)
    /* A3C78 800B3478 B4D730AC */  sw         $s0, %lo(gFlip)($at)
    /* A3C7C 800B347C 1000B08F */  lw         $s0, 0x10($sp)
    /* A3C80 800B3480 0800E003 */  jr         $ra
    /* A3C84 800B3484 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_RenderPauseMenuView__Fv
