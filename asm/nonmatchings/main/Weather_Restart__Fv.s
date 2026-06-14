.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_Restart__Fv, 0x7C

glabel Weather_Restart__Fv
    /* D2CB4 800E24B4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D2CB8 800E24B8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* D2CBC 800E24BC EC314324 */  addiu      $v1, $v0, %lo(GameSetup_gData)
    /* D2CC0 800E24C0 1000BFAF */  sw         $ra, 0x10($sp)
    /* D2CC4 800E24C4 4800628C */  lw         $v0, 0x48($v1)
    /* D2CC8 800E24C8 00000000 */  nop
    /* D2CCC 800E24CC 14004010 */  beqz       $v0, .L800E2520
    /* D2CD0 800E24D0 01000224 */   addiu     $v0, $zero, 0x1
    /* D2CD4 800E24D4 0C00638C */  lw         $v1, 0xC($v1)
    /* D2CD8 800E24D8 00000000 */  nop
    /* D2CDC 800E24DC 04006210 */  beq        $v1, $v0, .L800E24F0
    /* D2CE0 800E24E0 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* D2CE4 800E24E4 FA88030C */  jal        Weather_InitStateControls__Fv
    /* D2CE8 800E24E8 00000000 */   nop
    /* D2CEC 800E24EC 1280023C */  lui        $v0, %hi(D_8011E0B0)
  .L800E24F0:
    /* D2CF0 800E24F0 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* D2CF4 800E24F4 21180000 */  addu       $v1, $zero, $zero
    /* D2CF8 800E24F8 0C1982AF */  sw         $v0, %gp_rel(D_8013DE58)($gp)
    /* D2CFC 800E24FC 081982AF */  sw         $v0, %gp_rel(D_8013DE54)($gp)
  .L800E2500:
    /* D2D00 800E2500 5816828F */  lw         $v0, %gp_rel(Weather_gWasDrawn)($gp)
    /* D2D04 800E2504 00000000 */  nop
    /* D2D08 800E2508 21104300 */  addu       $v0, $v0, $v1
    /* D2D0C 800E250C 01006324 */  addiu      $v1, $v1, 0x1
    /* D2D10 800E2510 000040A0 */  sb         $zero, 0x0($v0)
    /* D2D14 800E2514 98006228 */  slti       $v0, $v1, 0x98
    /* D2D18 800E2518 F9FF4014 */  bnez       $v0, .L800E2500
    /* D2D1C 800E251C 00000000 */   nop
  .L800E2520:
    /* D2D20 800E2520 1000BF8F */  lw         $ra, 0x10($sp)
    /* D2D24 800E2524 00000000 */  nop
    /* D2D28 800E2528 0800E003 */  jr         $ra
    /* D2D2C 800E252C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Weather_Restart__Fv
