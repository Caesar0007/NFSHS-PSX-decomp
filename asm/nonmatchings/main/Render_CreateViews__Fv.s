.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_CreateViews__Fv, 0x38

glabel Render_CreateViews__Fv
    /* A39E4 800B31E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A39E8 800B31E8 1000BFAF */  sw         $ra, 0x10($sp)
    /* A39EC 800B31EC F5F6020C */  jal        Draw_InitViews__Fv
    /* A39F0 800B31F0 00000000 */   nop
    /* A39F4 800B31F4 2BCC020C */  jal        Render_CreatePlayerViews__Fv
    /* A39F8 800B31F8 00000000 */   nop
    /* A39FC 800B31FC A046030C */  jal        Hud_CreateHudViews__Fv
    /* A3A00 800B3200 00000000 */   nop
    /* A3A04 800B3204 66CC020C */  jal        Render_CreatePauseMenuViews__Fv
    /* A3A08 800B3208 00000000 */   nop
    /* A3A0C 800B320C 1000BF8F */  lw         $ra, 0x10($sp)
    /* A3A10 800B3210 00000000 */  nop
    /* A3A14 800B3214 0800E003 */  jr         $ra
    /* A3A18 800B3218 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Render_CreateViews__Fv
