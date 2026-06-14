.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ClearPlatformPrimitivesBuffer__Fv, 0x5C

glabel ClearPlatformPrimitivesBuffer__Fv
    /* AE804 800BE004 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AE808 800BE008 1000BFAF */  sw         $ra, 0x10($sp)
    /* AE80C 800BE00C 1FB6030C */  jal        DrawSync
    /* AE810 800BE010 21200000 */   addu      $a0, $zero, $zero
    /* AE814 800BE014 1280023C */  lui        $v0, %hi(gEnviro)
    /* AE818 800BE018 24F44224 */  addiu      $v0, $v0, %lo(gEnviro)
    /* AE81C 800BE01C 2C0040AC */  sw         $zero, 0x2C($v0)
    /* AE820 800BE020 140040AC */  sw         $zero, 0x14($v0)
    /* AE824 800BE024 1180023C */  lui        $v0, %hi(D_801131F8)
    /* AE828 800BE028 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* AE82C 800BE02C 01000224 */  addiu      $v0, $zero, 0x1
    /* AE830 800BE030 05006214 */  bne        $v1, $v0, .L800BE048
    /* AE834 800BE034 00000000 */   nop
    /* AE838 800BE038 38F7020C */  jal        Draw_DeInitViews__Fv
    /* AE83C 800BE03C 00000000 */   nop
    /* AE840 800BE040 14F80208 */  j          .L800BE050
    /* AE844 800BE044 00000000 */   nop
  .L800BE048:
    /* AE848 800BE048 5AF7020C */  jal        Draw_DeInitViewsInGame__Fv
    /* AE84C 800BE04C 00000000 */   nop
  .L800BE050:
    /* AE850 800BE050 1000BF8F */  lw         $ra, 0x10($sp)
    /* AE854 800BE054 00000000 */  nop
    /* AE858 800BE058 0800E003 */  jr         $ra
    /* AE85C 800BE05C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ClearPlatformPrimitivesBuffer__Fv
