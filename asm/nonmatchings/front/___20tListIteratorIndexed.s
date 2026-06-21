.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___20tListIteratorIndexed, 0x28

glabel ___20tListIteratorIndexed
    /* 147A4 80023FA4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 147A8 80023FA8 0180023C */  lui        $v0, %hi(_vt_20tListIteratorIndexed)
    /* 147AC 80023FAC 98134224 */  addiu      $v0, $v0, %lo(_vt_20tListIteratorIndexed)
    /* 147B0 80023FB0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 147B4 80023FB4 7D8F000C */  jal        ___13tListIterator
    /* 147B8 80023FB8 0C0082AC */   sw        $v0, 0xC($a0)
    /* 147BC 80023FBC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 147C0 80023FC0 00000000 */  nop
    /* 147C4 80023FC4 0800E003 */  jr         $ra
    /* 147C8 80023FC8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___20tListIteratorIndexed
