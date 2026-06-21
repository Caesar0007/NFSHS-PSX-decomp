.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___24tMenuItemLeftRightChoice, 0x28

glabel ___24tMenuItemLeftRightChoice
    /* 15154 80024954 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 15158 80024958 0180023C */  lui        $v0, %hi(_vt_24tMenuItemLeftRightChoice)
    /* 1515C 8002495C D0114224 */  addiu      $v0, $v0, %lo(_vt_24tMenuItemLeftRightChoice)
    /* 15160 80024960 1000BFAF */  sw         $ra, 0x10($sp)
    /* 15164 80024964 3792000C */  jal        ___20tMenuItemInteractive
    /* 15168 80024968 180082AC */   sw        $v0, 0x18($a0)
    /* 1516C 8002496C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 15170 80024970 00000000 */  nop
    /* 15174 80024974 0800E003 */  jr         $ra
    /* 15178 80024978 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___24tMenuItemLeftRightChoice
