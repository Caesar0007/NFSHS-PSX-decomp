.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Render_CreatePauseMenuViews__Fv, 0x4C

glabel Render_CreatePauseMenuViews__Fv
    /* A3998 800B3198 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* A399C 800B319C 40010224 */  addiu      $v0, $zero, 0x140
    /* A39A0 800B31A0 1000A2AF */  sw         $v0, 0x10($sp)
    /* A39A4 800B31A4 F0000224 */  addiu      $v0, $zero, 0xF0
    /* A39A8 800B31A8 1400A2AF */  sw         $v0, 0x14($sp)
    /* A39AC 800B31AC 01000224 */  addiu      $v0, $zero, 0x1
    /* A39B0 800B31B0 21200000 */  addu       $a0, $zero, $zero
    /* A39B4 800B31B4 00010524 */  addiu      $a1, $zero, 0x100
    /* A39B8 800B31B8 40010624 */  addiu      $a2, $zero, 0x140
    /* A39BC 800B31BC 2138A000 */  addu       $a3, $a1, $zero
    /* A39C0 800B31C0 2800BFAF */  sw         $ra, 0x28($sp)
    /* A39C4 800B31C4 1800A0AF */  sw         $zero, 0x18($sp)
    /* A39C8 800B31C8 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* A39CC 800B31CC B0F6020C */  jal        Draw_SetView__Fiiiiiiiii
    /* A39D0 800B31D0 2000A2AF */   sw        $v0, 0x20($sp)
    /* A39D4 800B31D4 2800BF8F */  lw         $ra, 0x28($sp)
    /* A39D8 800B31D8 9C0E82AF */  sw         $v0, %gp_rel(Render_gPauseMenuView)($gp)
    /* A39DC 800B31DC 0800E003 */  jr         $ra
    /* A39E0 800B31E0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Render_CreatePauseMenuViews__Fv
