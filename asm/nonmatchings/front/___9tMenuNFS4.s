.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___9tMenuNFS4, 0x28

glabel ___9tMenuNFS4
    /* B958 8001B158 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* B95C 8001B15C 0180023C */  lui        $v0, %hi(_vt_9tMenuNFS4)
    /* B960 8001B160 A0074224 */  addiu      $v0, $v0, %lo(_vt_9tMenuNFS4)
    /* B964 8001B164 1000BFAF */  sw         $ra, 0x10($sp)
    /* B968 8001B168 2C95000C */  jal        ___5tMenu
    /* B96C 8001B16C 680082AC */   sw        $v0, 0x68($a0)
    /* B970 8001B170 1000BF8F */  lw         $ra, 0x10($sp)
    /* B974 8001B174 00000000 */  nop
    /* B978 8001B178 0800E003 */  jr         $ra
    /* B97C 8001B17C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___9tMenuNFS4
