.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching puts, 0xC

glabel puts
    /* D88CC 800E80CC B0000A24 */  addiu      $t2, $zero, 0xB0
    /* D88D0 800E80D0 08004001 */  jr         $t2
    /* D88D4 800E80D4 3F000924 */   addiu     $t1, $zero, 0x3F
endlabel puts
    /* D88D8 800E80D8 00000000 */  nop
    /* D88DC 800E80DC 00000000 */  nop
    /* D88E0 800E80E0 00000000 */  nop
