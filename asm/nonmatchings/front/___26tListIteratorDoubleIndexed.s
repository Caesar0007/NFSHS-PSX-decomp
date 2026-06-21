.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___26tListIteratorDoubleIndexed, 0x28

glabel ___26tListIteratorDoubleIndexed
    /* 14954 80024154 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14958 80024158 0180023C */  lui        $v0, %hi(_vt_26tListIteratorDoubleIndexed)
    /* 1495C 8002415C 68134224 */  addiu      $v0, $v0, %lo(_vt_26tListIteratorDoubleIndexed)
    /* 14960 80024160 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14964 80024164 7D8F000C */  jal        ___13tListIterator
    /* 14968 80024168 0C0082AC */   sw        $v0, 0xC($a0)
    /* 1496C 8002416C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 14970 80024170 00000000 */  nop
    /* 14974 80024174 0800E003 */  jr         $ra
    /* 14978 80024178 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___26tListIteratorDoubleIndexed
