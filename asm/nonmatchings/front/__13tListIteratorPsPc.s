.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __13tListIteratorPsPc, 0x24

glabel __13tListIteratorPsPc
    /* 145D0 80023DD0 21108000 */  addu       $v0, $a0, $zero
    /* 145D4 80023DD4 0180033C */  lui        $v1, %hi(_vt_13tListIterator)
    /* 145D8 80023DD8 C8136324 */  addiu      $v1, $v1, %lo(_vt_13tListIterator)
    /* 145DC 80023DDC 0C0043AC */  sw         $v1, 0xC($v0)
    /* 145E0 80023DE0 000045AC */  sw         $a1, 0x0($v0)
    /* 145E4 80023DE4 040046AC */  sw         $a2, 0x4($v0)
    /* 145E8 80023DE8 090040A0 */  sb         $zero, 0x9($v0)
    /* 145EC 80023DEC 0800E003 */  jr         $ra
    /* 145F0 80023DF0 080040A0 */   sb        $zero, 0x8($v0)
endlabel __13tListIteratorPsPc
