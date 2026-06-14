.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Init0__Fv, 0x58

glabel Hud_Init0__Fv
    /* C32F4 800D2AF4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C32F8 800D2AF8 1480043C */  lui        $a0, %hi(D_8013D8CC)
    /* C32FC 800D2AFC CCD88424 */  addiu      $a0, $a0, %lo(D_8013D8CC)
    /* C3300 800D2B00 0C080524 */  addiu      $a1, $zero, 0x80C
    /* C3304 800D2B04 1000BFAF */  sw         $ra, 0x10($sp)
    /* C3308 800D2B08 CF94030C */  jal        reservememadr
    /* C330C 800D2B0C 21300000 */   addu      $a2, $zero, $zero
    /* C3310 800D2B10 BC1882AF */  sw         $v0, %gp_rel(D_8013DE08)($gp)
    /* C3314 800D2B14 1180023C */  lui        $v0, %hi(D_801131F8)
    /* C3318 800D2B18 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* C331C 800D2B1C 01000224 */  addiu      $v0, $zero, 0x1
    /* C3320 800D2B20 06006214 */  bne        $v1, $v0, .L800D2B3C
    /* C3324 800D2B24 1480043C */   lui       $a0, %hi(D_8013D8D4)
    /* C3328 800D2B28 D4D88424 */  addiu      $a0, $a0, %lo(D_8013D8D4)
    /* C332C 800D2B2C 0C080524 */  addiu      $a1, $zero, 0x80C
    /* C3330 800D2B30 CF94030C */  jal        reservememadr
    /* C3334 800D2B34 21300000 */   addu      $a2, $zero, $zero
    /* C3338 800D2B38 C01882AF */  sw         $v0, %gp_rel(D_8013DE0C)($gp)
  .L800D2B3C:
    /* C333C 800D2B3C 1000BF8F */  lw         $ra, 0x10($sp)
    /* C3340 800D2B40 00000000 */  nop
    /* C3344 800D2B44 0800E003 */  jr         $ra
    /* C3348 800D2B48 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hud_Init0__Fv
