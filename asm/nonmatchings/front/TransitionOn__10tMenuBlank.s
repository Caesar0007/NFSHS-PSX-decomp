.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__10tMenuBlank, 0x18

glabel TransitionOn__10tMenuBlank
    /* C1F8 8001B9F8 F8FF0224 */  addiu      $v0, $zero, -0x8
    /* C1FC 8001B9FC 760082A0 */  sb         $v0, 0x76($a0)
    /* C200 8001BA00 01000224 */  addiu      $v0, $zero, 0x1
    /* C204 8001BA04 700082AC */  sw         $v0, 0x70($a0)
    /* C208 8001BA08 0800E003 */  jr         $ra
    /* C20C 8001BA0C 740080A4 */   sh        $zero, 0x74($a0)
endlabel TransitionOn__10tMenuBlank
