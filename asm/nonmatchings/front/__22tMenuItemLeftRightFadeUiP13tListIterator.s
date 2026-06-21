.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __22tMenuItemLeftRightFadeUiP13tListIterator, 0x3C

glabel __22tMenuItemLeftRightFadeUiP13tListIterator
    /* CB58 8001C358 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CB5C 8001C35C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CB60 8001C360 1400BFAF */  sw         $ra, 0x14($sp)
    /* CB64 8001C364 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* CB68 8001C368 21808000 */   addu      $s0, $a0, $zero
    /* CB6C 8001C36C 21100002 */  addu       $v0, $s0, $zero
    /* CB70 8001C370 0180033C */  lui        $v1, %hi(_vt_22tMenuItemLeftRightFade)
    /* CB74 8001C374 600F6324 */  addiu      $v1, $v1, %lo(_vt_22tMenuItemLeftRightFade)
    /* CB78 8001C378 180043AC */  sw         $v1, 0x18($v0)
    /* CB7C 8001C37C 280040AC */  sw         $zero, 0x28($v0)
    /* CB80 8001C380 080040A4 */  sh         $zero, 0x8($v0)
    /* CB84 8001C384 1400BF8F */  lw         $ra, 0x14($sp)
    /* CB88 8001C388 1000B08F */  lw         $s0, 0x10($sp)
    /* CB8C 8001C38C 0800E003 */  jr         $ra
    /* CB90 8001C390 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __22tMenuItemLeftRightFadeUiP13tListIterator
