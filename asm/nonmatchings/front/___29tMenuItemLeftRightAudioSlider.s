.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___29tMenuItemLeftRightAudioSlider, 0x28

glabel ___29tMenuItemLeftRightAudioSlider
    /* ED48 8001E548 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* ED4C 8001E54C 0180023C */  lui        $v0, %hi(_vt_29tMenuItemLeftRightAudioSlider)
    /* ED50 8001E550 E00C4224 */  addiu      $v0, $v0, %lo(_vt_29tMenuItemLeftRightAudioSlider)
    /* ED54 8001E554 1000BFAF */  sw         $ra, 0x10($sp)
    /* ED58 8001E558 D592000C */  jal        ___24tMenuItemLeftRightSlider
    /* ED5C 8001E55C 180082AC */   sw        $v0, 0x18($a0)
    /* ED60 8001E560 1000BF8F */  lw         $ra, 0x10($sp)
    /* ED64 8001E564 00000000 */  nop
    /* ED68 8001E568 0800E003 */  jr         $ra
    /* ED6C 8001E56C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___29tMenuItemLeftRightAudioSlider
