.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___10tMenuBlank, 0x28

glabel ___10tMenuBlank
    /* C0FC 8001B8FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C100 8001B900 0180023C */  lui        $v0, %hi(_vt_10tMenuBlank)
    /* C104 8001B904 80064224 */  addiu      $v0, $v0, %lo(_vt_10tMenuBlank)
    /* C108 8001B908 1000BFAF */  sw         $ra, 0x10($sp)
    /* C10C 8001B90C 566C000C */  jal        ___9tMenuNFS4
    /* C110 8001B910 680082AC */   sw        $v0, 0x68($a0)
    /* C114 8001B914 1000BF8F */  lw         $ra, 0x10($sp)
    /* C118 8001B918 00000000 */  nop
    /* C11C 8001B91C 0800E003 */  jr         $ra
    /* C120 8001B920 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___10tMenuBlank
