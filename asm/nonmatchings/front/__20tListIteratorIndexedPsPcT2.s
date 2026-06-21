.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __20tListIteratorIndexedPsPcT2, 0x44

glabel __20tListIteratorIndexedPsPcT2
    /* 14760 80023F60 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 14764 80023F64 1000B0AF */  sw         $s0, 0x10($sp)
    /* 14768 80023F68 21808000 */  addu       $s0, $a0, $zero
    /* 1476C 80023F6C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 14770 80023F70 1800BFAF */  sw         $ra, 0x18($sp)
    /* 14774 80023F74 748F000C */  jal        __13tListIteratorPsPc
    /* 14778 80023F78 2188E000 */   addu      $s1, $a3, $zero
    /* 1477C 80023F7C 21100002 */  addu       $v0, $s0, $zero
    /* 14780 80023F80 0180033C */  lui        $v1, %hi(_vt_20tListIteratorIndexed)
    /* 14784 80023F84 98136324 */  addiu      $v1, $v1, %lo(_vt_20tListIteratorIndexed)
    /* 14788 80023F88 0C0043AC */  sw         $v1, 0xC($v0)
    /* 1478C 80023F8C 100051AC */  sw         $s1, 0x10($v0)
    /* 14790 80023F90 1800BF8F */  lw         $ra, 0x18($sp)
    /* 14794 80023F94 1400B18F */  lw         $s1, 0x14($sp)
    /* 14798 80023F98 1000B08F */  lw         $s0, 0x10($sp)
    /* 1479C 80023F9C 0800E003 */  jr         $ra
    /* 147A0 80023FA0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __20tListIteratorIndexedPsPcT2
