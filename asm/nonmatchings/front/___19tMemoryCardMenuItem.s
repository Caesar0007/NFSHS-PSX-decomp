.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___19tMemoryCardMenuItem, 0x20

glabel ___19tMemoryCardMenuItem
    /* 113D8 80020BD8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 113DC 80020BDC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 113E0 80020BE0 DF94000C */  jal        ___23tMenuItemGoToMenuButton
    /* 113E4 80020BE4 00000000 */   nop
    /* 113E8 80020BE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 113EC 80020BEC 00000000 */  nop
    /* 113F0 80020BF0 0800E003 */  jr         $ra
    /* 113F4 80020BF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___19tMemoryCardMenuItem
