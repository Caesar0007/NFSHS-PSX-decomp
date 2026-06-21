.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14tInsideBoxMenu, 0x28

glabel ___14tInsideBoxMenu
    /* D604 8001CE04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D608 8001CE08 0180023C */  lui        $v0, %hi(_vt_14tInsideBoxMenu)
    /* D60C 8001CE0C A80E4224 */  addiu      $v0, $v0, %lo(_vt_14tInsideBoxMenu)
    /* D610 8001CE10 1000BFAF */  sw         $ra, 0x10($sp)
    /* D614 8001CE14 2C95000C */  jal        ___5tMenu
    /* D618 8001CE18 680082AC */   sw        $v0, 0x68($a0)
    /* D61C 8001CE1C 1000BF8F */  lw         $ra, 0x10($sp)
    /* D620 8001CE20 00000000 */  nop
    /* D624 8001CE24 0800E003 */  jr         $ra
    /* D628 8001CE28 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14tInsideBoxMenu
