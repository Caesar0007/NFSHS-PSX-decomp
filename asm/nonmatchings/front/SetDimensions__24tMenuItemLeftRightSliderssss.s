.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDimensions__24tMenuItemLeftRightSliderssss, 0x18

glabel SetDimensions__24tMenuItemLeftRightSliderssss
    /* 15B10 80025310 1000A28F */  lw         $v0, 0x10($sp)
    /* 15B14 80025314 200085A4 */  sh         $a1, 0x20($a0)
    /* 15B18 80025318 220086A4 */  sh         $a2, 0x22($a0)
    /* 15B1C 8002531C 240087A4 */  sh         $a3, 0x24($a0)
    /* 15B20 80025320 0800E003 */  jr         $ra
    /* 15B24 80025324 260082A4 */   sh        $v0, 0x26($a0)
endlabel SetDimensions__24tMenuItemLeftRightSliderssss
