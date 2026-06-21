.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18tListIteratorRange, 0x28

glabel ___18tListIteratorRange
    /* 14D90 80024590 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14D94 80024594 0180023C */  lui        $v0, %hi(_vt_18tListIteratorRange)
    /* 14D98 80024598 08134224 */  addiu      $v0, $v0, %lo(_vt_18tListIteratorRange)
    /* 14D9C 8002459C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14DA0 800245A0 7D8F000C */  jal        ___13tListIterator
    /* 14DA4 800245A4 0C0082AC */   sw        $v0, 0xC($a0)
    /* 14DA8 800245A8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 14DAC 800245AC 00000000 */  nop
    /* 14DB0 800245B0 0800E003 */  jr         $ra
    /* 14DB4 800245B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18tListIteratorRange
