.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___24tListIteratorMultiPlayer, 0x28

glabel ___24tListIteratorMultiPlayer
    /* 14B90 80024390 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 14B94 80024394 0180023C */  lui        $v0, %hi(_vt_24tListIteratorMultiPlayer)
    /* 14B98 80024398 38134224 */  addiu      $v0, $v0, %lo(_vt_24tListIteratorMultiPlayer)
    /* 14B9C 8002439C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 14BA0 800243A0 7D8F000C */  jal        ___13tListIterator
    /* 14BA4 800243A4 0C0082AC */   sw        $v0, 0xC($a0)
    /* 14BA8 800243A8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 14BAC 800243AC 00000000 */  nop
    /* 14BB0 800243B0 0800E003 */  jr         $ra
    /* 14BB4 800243B4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___24tListIteratorMultiPlayer
