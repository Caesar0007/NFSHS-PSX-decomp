.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___21tPListIteratorIndexed, 0x28

glabel ___21tPListIteratorIndexed
    /* 979F4 800A71F4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 979F8 800A71F8 0580023C */  lui        $v0, %hi(_vt_21tPListIteratorIndexed)
    /* 979FC 800A71FC 04634224 */  addiu      $v0, $v0, %lo(_vt_21tPListIteratorIndexed)
    /* 97A00 800A7200 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97A04 800A7204 039C020C */  jal        ___14tPListIterator
    /* 97A08 800A7208 080082AC */   sw        $v0, 0x8($a0)
    /* 97A0C 800A720C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97A10 800A7210 00000000 */  nop
    /* 97A14 800A7214 0800E003 */  jr         $ra
    /* 97A18 800A7218 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___21tPListIteratorIndexed
