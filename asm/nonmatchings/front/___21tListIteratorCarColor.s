.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___21tListIteratorCarColor, 0x28

glabel ___21tListIteratorCarColor
    /* 8D20 80018520 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8D24 80018524 0180023C */  lui        $v0, %hi(_vt_21tListIteratorCarColor)
    /* 8D28 80018528 D8014224 */  addiu      $v0, $v0, %lo(_vt_21tListIteratorCarColor)
    /* 8D2C 8001852C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8D30 80018530 7D8F000C */  jal        ___13tListIterator
    /* 8D34 80018534 0C0082AC */   sw        $v0, 0xC($a0)
    /* 8D38 80018538 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8D3C 8001853C 00000000 */  nop
    /* 8D40 80018540 0800E003 */  jr         $ra
    /* 8D44 80018544 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___21tListIteratorCarColor
