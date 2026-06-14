.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_CheckSentenceRules, 0x20

glabel iSPCH_CheckSentenceRules
    /* FBD8C 8010B58C 27280500 */  nor        $a1, $zero, $a1
    /* FBD90 8010B590 0100C390 */  lbu        $v1, 0x1($a2)
    /* FBD94 8010B594 0200C290 */  lbu        $v0, 0x2($a2)
    /* FBD98 8010B598 24186500 */  and        $v1, $v1, $a1
    /* FBD9C 8010B59C 26104400 */  xor        $v0, $v0, $a0
    /* FBDA0 8010B5A0 24104300 */  and        $v0, $v0, $v1
    /* FBDA4 8010B5A4 0800E003 */  jr         $ra
    /* FBDA8 8010B5A8 0100422C */   sltiu     $v0, $v0, 0x1
endlabel iSPCH_CheckSentenceRules
