.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching restoretextdraw, 0xC

glabel restoretextdraw
    /* D465C 800E3E5C 1380023C */  lui        $v0, %hi(D_80135C34)
    /* D4660 800E3E60 0800E003 */  jr         $ra
    /* D4664 800E3E64 345C40AC */   sw        $zero, %lo(D_80135C34)($v0)
endlabel restoretextdraw
