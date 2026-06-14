.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RPause_StopPauseMenu__Fv, 0xAC

glabel RPause_StopPauseMenu__Fv
    /* CD7A4 800DCFA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CD7A8 800DCFA8 1280043C */  lui        $a0, %hi(D_8011F43C)
    /* CD7AC 800DCFAC 1000BFAF */  sw         $ra, 0x10($sp)
    /* CD7B0 800DCFB0 79B7030C */  jal        PutDispEnv
    /* CD7B4 800DCFB4 3CF48424 */   addiu     $a0, $a0, %lo(D_8011F43C)
    /* CD7B8 800DCFB8 1FB6030C */  jal        DrawSync
    /* CD7BC 800DCFBC 21200000 */   addu      $a0, $zero, $zero
    /* CD7C0 800DCFC0 C7C8030C */  jal        VSync
    /* CD7C4 800DCFC4 21200000 */   addu      $a0, $zero, $zero
    /* CD7C8 800DCFC8 B173030C */  jal        RPause_CopyBackToFrontBuffer__Fv
    /* CD7CC 800DCFCC 00000000 */   nop
    /* CD7D0 800DCFD0 1280053C */  lui        $a1, %hi(Draw_gView)
    /* CD7D4 800DCFD4 54ECA524 */  addiu      $a1, $a1, %lo(Draw_gView)
    /* CD7D8 800DCFD8 1480033C */  lui        $v1, %hi(gFlip)
    /* CD7DC 800DCFDC B4D7638C */  lw         $v1, %lo(gFlip)($v1)
    /* CD7E0 800DCFE0 1480043C */  lui        $a0, %hi(Render_gPauseMenuView)
    /* CD7E4 800DCFE4 E8D3848C */  lw         $a0, %lo(Render_gPauseMenuView)($a0)
    /* CD7E8 800DCFE8 80180300 */  sll        $v1, $v1, 2
    /* CD7EC 800DCFEC 40100400 */  sll        $v0, $a0, 1
    /* CD7F0 800DCFF0 21104400 */  addu       $v0, $v0, $a0
    /* CD7F4 800DCFF4 C0100200 */  sll        $v0, $v0, 3
    /* CD7F8 800DCFF8 21104400 */  addu       $v0, $v0, $a0
    /* CD7FC 800DCFFC C0100200 */  sll        $v0, $v0, 3
    /* CD800 800DD000 21186200 */  addu       $v1, $v1, $v0
    /* CD804 800DD004 21186500 */  addu       $v1, $v1, $a1
    /* CD808 800DD008 21104500 */  addu       $v0, $v0, $a1
    /* CD80C 800DD00C 0000428C */  lw         $v0, 0x0($v0)
    /* CD810 800DD010 C000648C */  lw         $a0, 0xC0($v1)
    /* CD814 800DD014 80100200 */  sll        $v0, $v0, 2
    /* CD818 800DD018 21208200 */  addu       $a0, $a0, $v0
    /* CD81C 800DD01C 2DB7030C */  jal        DrawOTag
    /* CD820 800DD020 FCFF8424 */   addiu     $a0, $a0, -0x4
    /* CD824 800DD024 019B030C */  jal        systemtask
    /* CD828 800DD028 21200000 */   addu      $a0, $zero, $zero
    /* CD82C 800DD02C 01000224 */  addiu      $v0, $zero, 0x1
    /* CD830 800DD030 1480033C */  lui        $v1, %hi(gFlip)
    /* CD834 800DD034 B4D7638C */  lw         $v1, %lo(gFlip)($v1)
    /* CD838 800DD038 1000BF8F */  lw         $ra, 0x10($sp)
    /* CD83C 800DD03C 23104300 */  subu       $v0, $v0, $v1
    /* CD840 800DD040 1480013C */  lui        $at, %hi(gFlip)
    /* CD844 800DD044 B4D722AC */  sw         $v0, %lo(gFlip)($at)
    /* CD848 800DD048 0800E003 */  jr         $ra
    /* CD84C 800DD04C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel RPause_StopPauseMenu__Fv
