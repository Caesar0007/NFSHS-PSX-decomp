.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___16tListIteratorCar, 0x28

glabel ___16tListIteratorCar
    /* 8128 80017928 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 812C 8001792C 0180023C */  lui        $v0, %hi(_vt_16tListIteratorCar)
    /* 8130 80017930 08024224 */  addiu      $v0, $v0, %lo(_vt_16tListIteratorCar)
    /* 8134 80017934 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8138 80017938 7D8F000C */  jal        ___13tListIterator
    /* 813C 8001793C 0C0082AC */   sw        $v0, 0xC($a0)
    /* 8140 80017940 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8144 80017944 00000000 */  nop
    /* 8148 80017948 0800E003 */  jr         $ra
    /* 814C 8001794C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___16tListIteratorCar
