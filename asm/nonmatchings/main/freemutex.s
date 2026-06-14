.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching freemutex, 0x8

glabel freemutex
    /* EEC80 800FE480 0800E003 */  jr         $ra
    /* EEC84 800FE484 000080AC */   sw        $zero, 0x0($a0)
endlabel freemutex
