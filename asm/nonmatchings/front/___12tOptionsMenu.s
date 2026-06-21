.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12tOptionsMenu, 0x28

glabel ___12tOptionsMenu
    /* CD44 8001C544 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CD48 8001C548 0180023C */  lui        $v0, %hi(_vt_12tOptionsMenu)
    /* CD4C 8001C54C 080F4224 */  addiu      $v0, $v0, %lo(_vt_12tOptionsMenu)
    /* CD50 8001C550 1000BFAF */  sw         $ra, 0x10($sp)
    /* CD54 8001C554 2C95000C */  jal        ___5tMenu
    /* CD58 8001C558 680082AC */   sw        $v0, 0x68($a0)
    /* CD5C 8001C55C 1000BF8F */  lw         $ra, 0x10($sp)
    /* CD60 8001C560 00000000 */  nop
    /* CD64 8001C564 0800E003 */  jr         $ra
    /* CD68 8001C568 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12tOptionsMenu
