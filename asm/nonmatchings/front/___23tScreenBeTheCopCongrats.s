.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23tScreenBeTheCopCongrats, 0x20

glabel ___23tScreenBeTheCopCongrats
    /* 39FC0 800497C0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39FC4 800497C4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 39FC8 800497C8 1E98000C */  jal        ___7tScreen
    /* 39FCC 800497CC 00000000 */   nop
    /* 39FD0 800497D0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 39FD4 800497D4 00000000 */  nop
    /* 39FD8 800497D8 0800E003 */  jr         $ra
    /* 39FDC 800497DC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23tScreenBeTheCopCongrats
