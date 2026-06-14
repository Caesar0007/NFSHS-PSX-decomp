.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching inittextdraw, 0x14

glabel inittextdraw
    /* D4648 800E3E48 1380033C */  lui        $v1, %hi(D_80135C34)
    /* D464C 800E3E4C 0E80023C */  lui        $v0, %hi(fortext4)
    /* D4650 800E3E50 403E4224 */  addiu      $v0, $v0, %lo(fortext4)
    /* D4654 800E3E54 0800E003 */  jr         $ra
    /* D4658 800E3E58 345C62AC */   sw        $v0, %lo(D_80135C34)($v1)
endlabel inittextdraw
