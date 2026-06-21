.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__10tMenuBlank, 0x1C

glabel TransitionOff__10tMenuBlank
    /* C1DC 8001B9DC 08000224 */  addiu      $v0, $zero, 0x8
    /* C1E0 8001B9E0 760082A0 */  sb         $v0, 0x76($a0)
    /* C1E4 8001B9E4 01000224 */  addiu      $v0, $zero, 0x1
    /* C1E8 8001B9E8 700082AC */  sw         $v0, 0x70($a0)
    /* C1EC 8001B9EC 90FF0224 */  addiu      $v0, $zero, -0x70
    /* C1F0 8001B9F0 0800E003 */  jr         $ra
    /* C1F4 8001B9F4 740082A4 */   sh        $v0, 0x74($a0)
endlabel TransitionOff__10tMenuBlank
