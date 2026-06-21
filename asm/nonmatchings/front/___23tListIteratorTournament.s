.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tListIteratorTournament, 0x28

glabel ___23tListIteratorTournament
    /* 245EC 80033DEC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 245F0 80033DF0 0180023C */  lui        $v0, %hi(_vt_23tListIteratorTournament)
    /* 245F4 80033DF4 70164224 */  addiu      $v0, $v0, %lo(_vt_23tListIteratorTournament)
    /* 245F8 80033DF8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 245FC 80033DFC 7D8F000C */  jal        ___13tListIterator
    /* 24600 80033E00 0C0082AC */   sw        $v0, 0xC($a0)
    /* 24604 80033E04 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24608 80033E08 00000000 */  nop
    /* 2460C 80033E0C 0800E003 */  jr         $ra
    /* 24610 80033E10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23tListIteratorTournament
