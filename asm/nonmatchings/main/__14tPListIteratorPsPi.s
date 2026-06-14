.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14tPListIteratorPsPi, 0x1C

glabel __14tPListIteratorPsPi
    /* 977F0 800A6FF0 21108000 */  addu       $v0, $a0, $zero
    /* 977F4 800A6FF4 0580033C */  lui        $v1, %hi(_vt_14tPListIterator)
    /* 977F8 800A6FF8 34636324 */  addiu      $v1, $v1, %lo(_vt_14tPListIterator)
    /* 977FC 800A6FFC 080043AC */  sw         $v1, 0x8($v0)
    /* 97800 800A7000 000045AC */  sw         $a1, 0x0($v0)
    /* 97804 800A7004 0800E003 */  jr         $ra
    /* 97808 800A7008 040046AC */   sw        $a2, 0x4($v0)
endlabel __14tPListIteratorPsPi
