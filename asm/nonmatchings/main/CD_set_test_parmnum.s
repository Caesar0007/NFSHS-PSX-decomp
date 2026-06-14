.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_set_test_parmnum, 0xC

glabel CD_set_test_parmnum
    /* F8E74 80108674 1480013C */  lui        $at, %hi(D_8013C1F0)
    /* F8E78 80108678 0800E003 */  jr         $ra
    /* F8E7C 8010867C F0C124AC */   sw        $a0, %lo(D_8013C1F0)($at)
endlabel CD_set_test_parmnum
