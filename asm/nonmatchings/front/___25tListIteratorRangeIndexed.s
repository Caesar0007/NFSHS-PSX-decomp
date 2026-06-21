.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___25tListIteratorRangeIndexed, 0x28

glabel ___25tListIteratorRangeIndexed
    /* 14E70 80024670 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14E74 80024674 0180023C */  lui        $v0, %hi(_vt_25tListIteratorRangeIndexed)
    /* 14E78 80024678 D8124224 */  addiu      $v0, $v0, %lo(_vt_25tListIteratorRangeIndexed)
    /* 14E7C 8002467C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14E80 80024680 6491000C */  jal        ___18tListIteratorRange
    /* 14E84 80024684 0C0082AC */   sw        $v0, 0xC($a0)
    /* 14E88 80024688 1000BF8F */  lw         $ra, 0x10($sp)
    /* 14E8C 8002468C 00000000 */  nop
    /* 14E90 80024690 0800E003 */  jr         $ra
    /* 14E94 80024694 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___25tListIteratorRangeIndexed
