.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Close, 0x1C

glabel CD_Close
    /* EAE5C 800FA65C 1480023C */  lui        $v0, %hi(D_80146CF8)
    /* EAE60 800FA660 F86C428C */  lw         $v0, %lo(D_80146CF8)($v0)
    /* EAE64 800FA664 80200400 */  sll        $a0, $a0, 2
    /* EAE68 800FA668 21208200 */  addu       $a0, $a0, $v0
    /* EAE6C 800FA66C 21100000 */  addu       $v0, $zero, $zero
    /* EAE70 800FA670 0800E003 */  jr         $ra
    /* EAE74 800FA674 FCFF80AC */   sw        $zero, -0x4($a0)
endlabel CD_Close
