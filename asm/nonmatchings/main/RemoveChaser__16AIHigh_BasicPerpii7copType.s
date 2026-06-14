.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching RemoveChaser__16AIHigh_BasicPerpii7copType, 0x3C

glabel RemoveChaser__16AIHigh_BasicPerpii7copType
    /* 4C6CC 8005BECC 80280500 */  sll        $a1, $a1, 2
    /* 4C6D0 8005BED0 21288500 */  addu       $a1, $a0, $a1
    /* 4C6D4 8005BED4 70008624 */  addiu      $a2, $a0, 0x70
    /* 4C6D8 8005BED8 80380700 */  sll        $a3, $a3, 2
    /* 4C6DC 8005BEDC 2130C700 */  addu       $a2, $a2, $a3
    /* 4C6E0 8005BEE0 0000C28C */  lw         $v0, 0x0($a2)
    /* 4C6E4 8005BEE4 4C00A38C */  lw         $v1, 0x4C($a1)
    /* 4C6E8 8005BEE8 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 4C6EC 8005BEEC C0180300 */  sll        $v1, $v1, 3
    /* 4C6F0 8005BEF0 21208300 */  addu       $a0, $a0, $v1
    /* 4C6F4 8005BEF4 0000C2AC */  sw         $v0, 0x0($a2)
    /* 4C6F8 8005BEF8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 4C6FC 8005BEFC 1C0082AC */  sw         $v0, 0x1C($a0)
    /* 4C700 8005BF00 0800E003 */  jr         $ra
    /* 4C704 8005BF04 200082AC */   sw        $v0, 0x20($a0)
endlabel RemoveChaser__16AIHigh_BasicPerpii7copType
