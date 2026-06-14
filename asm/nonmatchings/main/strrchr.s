.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching strrchr, 0xC

glabel strrchr
    /* F3D90 80103590 A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F3D94 80103594 08004001 */  jr         $t2
    /* F3D98 80103598 1F000924 */   addiu     $t1, $zero, 0x1F
endlabel strrchr
    /* F3D9C 8010359C 00000000 */  nop
