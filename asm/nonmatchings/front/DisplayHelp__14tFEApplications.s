.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DisplayHelp__14tFEApplications, 0x24

glabel DisplayHelp__14tFEApplications
    /* 4774 80013F74 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4778 80013F78 58018424 */  addiu      $a0, $a0, 0x158
    /* 477C 80013F7C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4780 80013F80 1062000C */  jal        Display__11tDialogBase
    /* 4784 80013F84 900085A4 */   sh        $a1, 0x90($a0)
    /* 4788 80013F88 1000BF8F */  lw         $ra, 0x10($sp)
    /* 478C 80013F8C 00000000 */  nop
    /* 4790 80013F90 0800E003 */  jr         $ra
    /* 4794 80013F94 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DisplayHelp__14tFEApplications
