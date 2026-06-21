.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18tListIteratorTrack, 0x28

glabel ___18tListIteratorTrack
    /* 125AC 80021DAC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 125B0 80021DB0 0180023C */  lui        $v0, %hi(_vt_18tListIteratorTrack)
    /* 125B4 80021DB4 E80F4224 */  addiu      $v0, $v0, %lo(_vt_18tListIteratorTrack)
    /* 125B8 80021DB8 1000BFAF */  sw         $ra, 0x10($sp)
    /* 125BC 80021DBC E98F000C */  jal        ___20tListIteratorIndexed
    /* 125C0 80021DC0 0C0082AC */   sw        $v0, 0xC($a0)
    /* 125C4 80021DC4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 125C8 80021DC8 00000000 */  nop
    /* 125CC 80021DCC 0800E003 */  jr         $ra
    /* 125D0 80021DD0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18tListIteratorTrack
